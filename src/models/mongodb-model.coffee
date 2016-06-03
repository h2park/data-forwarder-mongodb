_       = require 'lodash'
mongojs = require 'mongojs'

class MongoModel
  onMessage: ({message, forwarderConfig}, callback) =>
    callback = _.once callback

    {connectionString, collection, options} = forwarderConfig

    db = mongojs connectionString, [collection], options
    db.on 'error', (error) => db.close()
    db.collection(collection).insert message, (error, data) => db.close()

    callback()


module.exports = MongoModel
