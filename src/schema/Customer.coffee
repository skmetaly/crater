mongoose = require 'mongoose'
projectSchema = require './Project'
extend = require 'lodash.assignin'

customerSchema = mongoose.Schema
    # Full name of the Customer
    name: String
    # Other names the customer may be known by
    aliases: [String]
    # A customer's site
    projects: [projectSchema]
    slackChannel: String

################################################

# Virtual properties
customerSchema.virtual('project', _jiri_aliasTarget: 'projects')
    .get -> @getProject()
customerSchema.virtual('alias', _jiri_aliasTarget: 'aliases')
    .get -> @aliases

# apply methods
# load the 'all name regex string' on connect
mongoose.connection.once 'open', (callback) -> customerSchema.statics.getAllNameRegexString(true)
extend customerSchema.statics,
    require('./methods/static/Base'),
    require('./methods/static/Customer')
extend customerSchema.methods,
    require('./methods/instance/Base'),
    require('./methods/instance/Customer')

# Refresh cached regex string if data is changed
customerSchema.post 'save', (doc) => customerSchema.statics.getAllNameRegexString(true)

module.exports = customerSchema
