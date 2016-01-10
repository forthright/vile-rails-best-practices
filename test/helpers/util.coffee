Promise = require "bluebird"
mimus = require "mimus"
fs = require "fs"
rbp_output_file = require "./../fixtures/rails_best_practices_output"

Promise.promisifyAll fs

setup = (vile) ->
  mimus.stub(fs, "readFileAsync").returns(
    new Promise((resolve, reject) -> resolve(rbp_output_file)))

  mimus.stub(fs, "unlinkAsync").returns(
    new Promise((resolve, reject) -> resolve()))

  vile.spawn.returns new Promise (resolve) -> resolve()

issues = [
  {
    file: "app/db/schema.rb",
    msg: "always add db index (auth_tokens => [project_id])",
    type: "warn",
    where: { start: { line: 19 }, end: {} },
    data: {}
  },
  {
    file: "app/views/projects/_overview.html.slim",
    msg: "replace instance variable with local variable",
    type: "warn",
    where: { start: {}, end: {} },
    data: {}
  }
]

module.exports =
  issues: issues
  setup: setup
