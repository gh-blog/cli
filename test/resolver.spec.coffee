expect = require 'expect.js'
# fs = require 'fs'
_ = require 'lodash'

Resolver = require '../lib/resolver'

plugins = {
    dir: "#{__dirname}/samples"
}

describe 'Resolver', ->
    beforeEach ->
        @resolver = new Resolver plugins.dir

    it 'should detect missing features', ->
        result = @resolver.features 'missing'
        expect(_.keys result).to.eql ['markdown']