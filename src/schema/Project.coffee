mongoose = require 'mongoose'

customerSchema = require './Customer'
repositorySchema = require './Repository'
stageSchema = require './Stage'

projectSchema = mongoose.Schema
    _creator:
        type: mongoose.Schema.Types.ObjectId
        ref: customerSchema
    name: type: String, crater: suggestions: true
    defaultProject: Boolean
    repositories: [repositorySchema]
    stages: [stageSchema]
    notes: type: String, crater: multiLine: true
    state: String # project, live, archived
    hostedByJadu: Boolean
    platform: type: String, crater: suggestions: true # LAMP, WISP, WINS
    goLiveDate: Date
    slackChannel: String
    projectManager: type: String, crater: suggestions: true

    # exact IDs/names used in different data sources
    # These are used when re-importing data, to match to
    # existing records
    _mappingId_isoSpreadsheet: String
    _mappingId_goLivesSheet: String
    _mappingId_jira: String


# Virtuals

projectSchema.virtual('repos', _jiri_aliasTarget: 'repositories').get -> @repositories
projectSchema.virtual('repository', _jiri_aliasTarget: 'repositories').get -> @getDefault 'repositories'
projectSchema.virtual('repo', _jiri_aliasTarget: 'repositories').get -> @getDefault 'repositories'

projectSchema.virtual('stage', _jiri_aliasTarget: 'stages').get -> @getDefault 'stages'
projectSchema.virtual('site', _jiri_aliasTarget: 'stages').get -> @getDefault 'stages'
projectSchema.virtual('sites', _jiri_aliasTarget: 'stages').get -> @stages

projectSchema.virtual('goLive', _jiri_aliasTarget: 'goLiveDate')
    .get -> @goLiveDate
    .set (value) -> @goLiveDate = value

projectSchema.virtual('hostedAtJadu', _jiri_aliasTarget: 'hostedByJadu')
    .get -> @hostedByJadu
    .set (value) -> @hostedByJadu = value

projectSchema.virtual('hostedByUs', _jiri_aliasTarget: 'hostedByJadu')
    .get -> @hostedByJadu
    .set (value) -> @hostedByJadu = value

projectSchema.virtual('pm', _jiri_aliasTarget: 'projectManager')
    .get -> @projectManager
    .set (value) ->
        @projectManager = value
        @markModified 'projectManager'

# apply methods
require('./methods/static/Base') projectSchema
require('./methods/instance/Base') projectSchema
require('./methods/instance/Project') projectSchema

module.exports = projectSchema