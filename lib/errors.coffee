module.exports.MissingPlugin = class MissingPlugin extends Error
    constructor: (@feature, @requiredBy, args...) -> super args...
    requiredBy: []
    toString: ->
        "Feature #{@feature} is required by #{@requiredBy.join ', '}
        but is not provided by any plugin."

module.exports.UnknownFeatureType = class UnknownFeatureType extends TypeError
    constructor: (@type, args...) -> super args...
    toString: ->
        "Features of type #{@type} are unrecognizable."