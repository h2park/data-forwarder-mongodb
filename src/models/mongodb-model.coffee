_       = require 'lodash'
mongojs = require 'mongojs'

class MongoModel
  onMessage: ({message, forwarderConfig}, callback) =>
    callback = _.once callback

    {connectionString, collection, options} = forwarderConfig

    db = mongojs connectionString, [collection], options
    
    db.on 'error', (error) =>
      db.close()
      callback(error)

    db.collection(collection).insert message, (error, data) =>
      db.close()
      callback(error, data)


module.exports = MongoModel
