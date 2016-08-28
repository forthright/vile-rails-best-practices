fs = require "fs"
mimus = require "mimus"
Promise = require "bluebird"
rails_best_practices = mimus.require "./../lib", __dirname, []
chai = require "./helpers/sinon_chai"
util = require "./helpers/util"
vile = mimus.get rails_best_practices, "vile"
expect = chai.expect

Promise.promisifyAll fs

RBP_REPORT = "./rails_best_practices_output.json"
DEFAULT_ARGS = [ "--silent", "--format", "json" ]

# TODO: write integration tests for spawn -> cli
# TODO: don't use setTimeout everywhere (for proper exception throwing)

expect_to_set_args = (done, spawn_args, plugin_data) ->
  rails_best_practices
    .punish plugin_data || {}
    .should.be.fulfilled.notify ->
      setTimeout ->
        vile.spawn.should.have.been
          .calledWith "rails_best_practices", spawn_args
          done()
  return

describe "rails_best_practices", ->
  afterEach mimus.reset
  after mimus.restore
  beforeEach ->
    mimus.stub vile, "spawn"
    util.setup vile

  describe "#punish", ->
    it "converts rails_best_practices json to issues", ->
      rails_best_practices
        .punish {}
        .should.eventually.eql util.issues

    it "handles an empty response", ->
      fs.readFileAsync.reset()
      fs.readFileAsync.returns new Promise (resolve) -> resolve ""

      rails_best_practices
        .punish {}
        .should.eventually.eql []

    it "reads the report file", (done) ->
      rails_best_practices
        .punish {}
        .should.be.fulfilled.notify ->
          setTimeout ->
            fs.readFileAsync.should.have.been
              .calledWith RBP_REPORT
            done()
      return

    it "removes the report file", (done) ->
      rails_best_practices
        .punish {}
        .should.be.fulfilled.notify ->
          setTimeout ->
            fs.unlinkAsync.should.have.been
              .calledWith RBP_REPORT
            done()
      return

    [ "vendor", "spec", "test", "features" ].forEach (flag) ->
      describe "#{flag} option", ->
        it "sets the relative flag when set", (done) ->
          expect_to_set_args(
            done,
            { args: DEFAULT_ARGS.concat [ "--#{flag}", "." ] },
            { config: "#{flag}": "ab" })

    describe "allow list", ->
      describe "when given a single pattern", ->
        it "sets the related option", (done) ->
          expect_to_set_args(
            done,
            { args: DEFAULT_ARGS.concat [ "--only", "ab", "." ] },
            { allow: "ab" })

      describe "when given multiple patterns", ->
        it "sets the related option", (done) ->
          expect_to_set_args(
            done,
            { args: DEFAULT_ARGS.concat [ "--only", "ab,cd", "." ] },
            { allow: [ "ab", "cd" ] })

    describe "only option", ->
      describe "when given a single pattern", ->
        it "sets the related option", (done) ->
          expect_to_set_args(
            done,
            { args: DEFAULT_ARGS.concat [ "--only", "ab", "." ] },
            { config: only: "ab" })

      describe "when given multiple patterns", ->
        it "sets the related option", (done) ->
          expect_to_set_args(
            done,
            { args: DEFAULT_ARGS.concat [ "--only", "ab,cd", "." ] },
            { config: only: [ "ab", "cd" ] })

    describe "ignore list", ->
      describe "when given a single pattern", ->
        it "sets the related option", (done) ->
          expect_to_set_args(
            done,
            { args: DEFAULT_ARGS.concat [ "--exclude", "ab", "." ] },
            { ignore: "ab" })

      describe "when given multiple patterns", ->
        it "sets the related option", (done) ->
          expect_to_set_args(
            done,
            { args: DEFAULT_ARGS.concat [ "--exclude", "ab,cd", "." ] },
            { ignore: [ "ab", "cd" ] })

    describe "exclude option", ->
      describe "when given a single pattern", ->
        it "sets the related option", (done) ->
          expect_to_set_args(
            done,
            { args: DEFAULT_ARGS.concat [ "--exclude", "ab", "." ] },
            { config: exclude: "ab" })

      describe "when given multiple patterns", ->
        it "sets the related option", (done) ->
          expect_to_set_args(
            done,
            { args: DEFAULT_ARGS.concat [ "--exclude", "ab,cd", "." ] },
            { config: exclude: [ "ab", "cd" ] })

    describe "path to operate on", ->
      describe "when given a single path", ->
        it "sets the related option", (done) ->
          expect_to_set_args(
            done, { args: DEFAULT_ARGS.concat [ "ab" ] },
            { config: path: "ab" })

      describe "when given none", ->
        it "sets the related option to all files", (done) ->
          expect_to_set_args(
            done, { args: DEFAULT_ARGS.concat [ "." ] })
