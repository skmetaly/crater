
module.exports =
    getCarRegRegex: ->
        /\b([A-Z]{2}[0-9]{2}[A-Z]{3})|([A-Z][0-9]{1,3}[A-Z]{3})|([A-Z]{3}[0-9]{1,3}[A-Z])|([0-9]{1,4}[A-Z]{1,2})|([0-9]{1,3}[A-Z]{1,3})|([A-Z]{1,2}[0-9]{1,4})|([A-Z]{1,3}[0-9]{1,3})\b/i