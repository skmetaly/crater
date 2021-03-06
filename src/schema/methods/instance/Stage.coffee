regexEscape = require 'escape-string-regexp'

module.exports =
    getName: (forceNoun = false) ->
        unless @name
            return if forceNoun then 'a stage' else ''

        switch @name.toLowerCase()
            when 'qa' then name = 'QA'
            when 'uat' then name = 'UAT'
            else name = @name.toLowerCase()

        if forceNoun then "#{name} stage" else name

    getServer: (role) ->
        regex = new RegExp "^#{role}$", "i"
        return s for s in @servers when s.role?.match regex

    getSoftware: (name) ->
        regex = new RegExp "^#{name}$", "i"
        return m for m in @software when m.name?.match regex

    # allow names to be aliased
    getNameRegexString: ->
        names = [regexEscape(@name)]
        switch @name.toLowerCase()
            when 'production'
                names.push '(pre-?)?prod(uction)?'
            when 'qa'
                names.push 'q[\.\-]?a\.?'
            when 'uat'
                names.push 'u[\.\-]?a[\.\-]?t\.?'

        return "(#{names.join('|')})(?: (?:website|site|stage))?"
