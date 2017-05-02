let path = require("path")
let fs = require("fs")
let Promise = require("bluebird")
let _ = require("lodash")
let vile = require("vile")

Promise.promisifyAll(fs)
// TODO: break up this into smaller modules

const CWD = "."
const RBP = "rails_best_practices"
const RBP_REPORT = "./rails_best_practices_output.json"

let to_json = (string) =>
  _.attempt(JSON.parse.bind(null, string))

let relative_path = (file) =>
  path.relative(process.cwd(), file)

let remove_report = () =>
  fs.unlinkAsync(RBP_REPORT)

let read_report = () =>
  fs.readFileAsync(RBP_REPORT)
    .then((data) =>
      remove_report().then(() =>
        data ? to_json(data) : []))

let set_path = (data, opts) =>
  opts.push(_.get(data, "config.path", CWD))

let set_exclude = (data, opts) => {
  let exclude = _.get(data, "ignore",
    _.get(data, "config.exclude", []))
  if (_.isEmpty(exclude)) return
  if (exclude.join) exclude = exclude.join(",")
  opts.push("--exclude", exclude)
}

let set_only = (data, opts) => {
  let only = _.get(data, "allow",
    _.get(data, "config.only", []))
  if (_.isEmpty(only)) return
  if (only.join) only = only.join(",")
  opts.push("--only", only)
}

let set_flag = (key, data, opts) =>
  _.has(data, `config.${key}`) ?
    opts.push(`--${key}`) : undefined

let rbp_args = (data) => {
  let args = [ "--silent", "--format", "json" ]
  set_only(data, args)
  set_exclude(data, args)
  set_flag("vendor", data, args)
  set_flag("spec", data, args)
  set_flag("test", data, args)
  set_flag("features", data, args)
  set_path(data, args)
  return args
}

let rbp = (data) =>
  vile
    .spawn(RBP, { args: rbp_args(data) })
    .then(read_report)

let start_line = (file) =>
  _.has(file, "line_number") ?
    { line: Number(file.line_number) } : undefined

let into_vile_issues = (rbp_files) =>
  _.map(rbp_files, (file) =>
    vile.issue({
      type: vile.MAIN,
      path: relative_path(file.filename),
      title: file.message,
      message: file.message,
      signature: `rbp::${file.message}`,
      where: { start: start_line(file) }
    }))

let punish = (plugin_data) =>
  rbp(plugin_data)
    .then(into_vile_issues)

module.exports = {
  punish: punish
}
