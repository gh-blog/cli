fs = require 'fs'
path = require 'path'
glob = require 'glob'
_ = require 'lodash'

Errors = require './errors'

class Resolver
    _types = ['requires', 'recommends', 'provides']
    @ENUM_TYPES = ENUM_TYPES = {
        required: 'requires'
        recommended: 'recommends'
        installed: 'provides'
        available: 'provides'
        missing: 'missing'
    }

    constructor: (@cwd) ->
        # Get manifest files
        @files =
            glob.sync "./*/package.json", { cwd }
            .map (file) -> path.resolve cwd, file

        # Read manifests and assign
        @manifests = { }
        for filename in @files
            manifest = require filename
            @manifests[manifest.name] = manifest["gh-blog"]

    features: (type) ->
        if not ENUM_TYPES[type]
            throw new Errors.UnknownFeatureType type

        type = ENUM_TYPES[type]

        results = { }
        if type is 'missing'
            available = @features 'available'
            required = @features 'required'
            for feature, plugin of required
                if not available[feature]
                    results[feature] = plugin
        else
            for name, props of @manifests
                if props[type]
                    for feature in props[type]
                        results[feature] = Array::concat (results[feature] || []), name
        return results

module.exports = Resolver