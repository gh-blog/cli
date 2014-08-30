expect = require 'expect.js'

module.exports.validate = (file) ->
    try manifest = require file
    catch err
        throw err #@TODO
    
    expect(manifest).to.be.ok()
    
    expect(manifest['gh-blog']).to.be.an 'object'

    expect(manifest['gh-blog']).to.have.property 'provides'
    expect(manifest['gh-blog'].provides).to.be.an 'array'
    expect(manifest['gh-blog'].provides).to.not.be.empty()

    if manifest['gh-blog'].hasOwnProperty 'requires'
        expect(manifest['gh-blog'].requires).to.be.an 'array'
        
        # Plugins should not require features they already provide
        for feature in manifest['gh-blog'].provides
            expect(manifest['gh-blog'].requires).to.not.contain feature

    if manifest['gh-blog'].hasOwnProperty 'recommends'
        expect(manifest['gh-blog'].recommends).to.be.an 'array'
        
        # Plugins should not recommend features they already provide or require
        for feature in Array::concat manifest['gh-blog'].provides, manifest['gh-blog'].requires
            expect(manifest['gh-blog'].recommends).to.not.contain feature

    yes