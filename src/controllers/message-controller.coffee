debug       = require('debug')('data-forwarder:data-forwarder-mongodb')
_           = require 'lodash'
MeshbluHttp = require 'meshblu-http'
MongoModel  = require '../models/mongodb-model'

class MessageController

  message: (req, res) =>
    message = req.body
    meshblu = new MeshbluHttp req.meshbluAuth
    @getDeviceConfig meshblu, (error, device) =>
      return res.sendError(error) if error?
      mongoModel = new MongoModel
      mongoModel.onMessage {message, device}, (error) =>
        return res.sendError error if error?
        res.sendStatus 201

  getDeviceConfig: (meshblu, callback) =>
    meshblu.whoami (error, device) =>
      return callback error if error?
      callback null, device

module.exports = MessageController
