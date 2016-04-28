// Generated by CoffeeScript 1.10.0
(function() {
  var customerSchema, extend, mongoose, projectSchema;

  mongoose = require('mongoose');

  projectSchema = require('./Project');

  extend = require('lodash.assignin');

  customerSchema = mongoose.Schema({
    name: String,
    aliases: [String],
    projects: [projectSchema],
    slackChannel: String
  }, {
    crater: {
      name: 'Customer'
    }
  });

  customerSchema.virtual('project', {
    _jiri_aliasTarget: 'projects'
  }).get(function() {
    return this.getProject();
  });

  customerSchema.virtual('alias', {
    _jiri_aliasTarget: 'aliases'
  }).get(function() {
    return this.aliases;
  });

  extend(customerSchema.statics, require('./methods/static/Base'), require('./methods/static/Customer'));

  extend(customerSchema.methods, require('./methods/instance/Base'), require('./methods/instance/Customer'));

  customerSchema.post('save', (function(_this) {
    return function(doc) {
      return customerSchema.statics.getAllNameRegexString(true);
    };
  })(this));

  module.exports = customerSchema;

}).call(this);