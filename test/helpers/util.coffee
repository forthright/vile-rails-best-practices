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
    path: "app/db/schema.rb",
    title: "always add db index (auth_tokens => [project_id])",
    message: "always add db index (auth_tokens => [project_id])",
    type: "style",
    signature: "rbp::always add db index (auth_tokens => [project_id])",
    where: { start: { line: 19 } },
  },
  {
    path: "app/views/projects/_overview.html.slim",
    title: "replace instance variable with local variable",
    message: "replace instance variable with local variable",
    signature: "rbp::replace instance variable with local variable",
    type: "style"
    where: { start: undefined },
  }
]

module.exports =
  issues: issues
  setup: setup
