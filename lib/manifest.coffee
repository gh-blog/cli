expect = require 'expect.js'

module.exports.validate = (manifest) ->   

    # Must be valid JSON
    expect(JSON.stringify).withArgs(manifest).to.not.throwException() # 'MALFORMED_JSON'
    expect(JSON.parse JSON.stringify manifest).to.eql manifest # 'MALFORMED_JSON'

    expect(manifest).to.be.ok() # 'MALFORMED_MANIFEST_ROOT'
    
    expect(root = manifest['gh-blog']).to.be.an 'object' # 'MALFORMED_MANIFEST_ROOT'

    expect(root).to.have.property 'provides' # 'MISSING_MANIFEST_ENTRY'
    expect(root.provides).to.be.an 'array' # 'MALFORMED_MANIFEST_ENTRY'
    expect(root.provides).to.not.be.empty() # 'MALFORMED_MANIFEST_ENTRY'

    if root.requires
        expect(root.requires).to.be.an 'array' # 'MALFORMED_MANIFEST_ENTRY'
        expect(root.requires).to.not.be.empty() # 'MALFORMED_MANIFEST_ENTRY'
        
        # Plugins should not require features they already provide
        for feature in root.provides
            expect(root.requires).to.not.contain feature # 'CIRCULAR_DEPENDENCY'

    if root.recommends
        expect(root.recommends).to.be.an 'array' # 'MALFORMED_MANIFEST_ENTRY'
        expect(root.recommends).to.not.be.empty() # 'MALFORMED_MANIFEST_ENTRY'
        
        # Plugins should not recommend features they already provide or require
        for feature in Array::concat root.provides, root.requires
            expect(root.recommends).to.not.contain feature # 'CIRCULAR_DEPENDENCY'

    yes