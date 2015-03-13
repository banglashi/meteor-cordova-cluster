Cluster.allowPublicAccess 'search'
Meteor.methods 'getUserByToken': (loginToken) ->
  hashedToken = loginToken and Accounts._hashLoginToken(loginToken)
  selector = 'services.resume.loginTokens.hashedToken': hashedToken
  options = fields: _id: 1
  user = Meteor.users.findOne(selector, options)
  if user then user._id else null