// Generated by CoffeeScript 1.10.0
(function() {
  var extend, moduleSchema, mongoose;

  mongoose = require('mongoose');

  extend = require('lodash.assignin');

  moduleSchema = mongoose.Schema({
    name: {
      type: String,
      crater: {
        suggestions: true
      }
    },
    version: String
  }, {
    crater: {
      name: 'Module'
    }
  });

  extend(moduleSchema.statics, require('./methods/static/Base'));

  extend(moduleSchema.methods, require('./methods/instance/Base'));

  module.exports = moduleSchema;

}).call(this);