mongojs = require 'mongojs'

class MongoModel
  onMessage: ({message, device}, callback) =>
    {connectionString, collection, options} = device
    db = mongojs connectionString, [collection], options
    db.collection(collection).insert message, (error, data) =>
      db.close()
      callback(error, data)

module.exports = MongoModel
