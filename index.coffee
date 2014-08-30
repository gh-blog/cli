Resolver = require './lib/resolver'

resolver = new Resolver './test/samples'

for type in ['required', 'installed', 'recommended', 'missing']
    console.log "#{type}:", Object.keys(resolver.features type).join ', '