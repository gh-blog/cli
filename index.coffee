Resolver = require './lib/resolver'

resolver = new Resolver '/home/f/git/gh-blog/plugins'

for type in ['required', 'installed', 'recommended', 'missing']
    console.log "#{type}:", Object.keys(resolver.features type).length