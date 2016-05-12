mongojs = require 'mongojs'

class MongoModel
  onMessage: ({message, forwarderConfig}, callback) =>
    {connectionString, collection, options} = forwarderConfig
    db = mongojs connectionString, [collection], options
    db.collection(collection).insert message, (error, data) =>
      callback(error, data)
      db.close()

module.exports = MongoModel
