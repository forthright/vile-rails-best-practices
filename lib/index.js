"use strict";

var path = require("path");
var fs = require("fs");
var Promise = require("bluebird");
var _ = require("lodash");
var vile = require("vile");

Promise.promisifyAll(fs);
// TODO: break up this into smaller modules

var CWD = ".";
var RBP = "rails_best_practices";
var RBP_REPORT = "./rails_best_practices_output.json";

var to_json = function to_json(string) {
  return _.attempt(JSON.parse.bind(null, string));
};

var relative_path = function relative_path(file) {
  return path.relative(process.cwd(), file);
};

var remove_report = function remove_report() {
  return fs.unlinkAsync(RBP_REPORT);
};

var read_report = function read_report() {
  return fs.readFileAsync(RBP_REPORT).then(function (data) {
    return remove_report().then(function () {
      return data ? to_json(data) : [];
    });
  });
};

var set_path = function set_path(data, opts) {
  return opts.push(_.get(data, "config.path", CWD));
};

var set_exclude = function set_exclude(data, opts) {
  var exclude = _.get(data, "ignore", _.get(data, "config.exclude", []));
  if (_.isEmpty(exclude)) return;
  if (exclude.join) exclude = exclude.join(",");
  opts.push("--exclude", exclude);
};

var set_only = function set_only(data, opts) {
  var only = _.get(data, "allow", _.get(data, "config.only", []));
  if (_.isEmpty(only)) return;
  if (only.join) only = only.join(",");
  opts.push("--only", only);
};

var set_flag = function set_flag(key, data, opts) {
  return _.has(data, "config." + key) ? opts.push("--" + key) : undefined;
};

var rbp_args = function rbp_args(data) {
  var args = ["--silent", "--format", "json"];
  set_only(data, args);
  set_exclude(data, args);
  set_flag("vendor", data, args);
  set_flag("spec", data, args);
  set_flag("test", data, args);
  set_flag("features", data, args);
  set_path(data, args);
  return args;
};

var rbp = function rbp(data) {
  return vile.spawn(RBP, { args: rbp_args(data) }).then(read_report);
};

var start_line = function start_line(file) {
  return _.has(file, "line_number") ? { line: Number(file.line_number) } : undefined;
};

var into_vile_issues = function into_vile_issues(rbp_files) {
  return _.map(rbp_files, function (file) {
    return vile.issue({
      type: vile.MAIN,
      path: relative_path(file.filename),
      title: file.message,
      message: file.message,
      signature: "rbp::" + file.message,
      where: { start: start_line(file) }
    });
  });
};

var punish = function punish(plugin_data) {
  return rbp(plugin_data).then(into_vile_issues);
};

module.exports = {
  punish: punish
};