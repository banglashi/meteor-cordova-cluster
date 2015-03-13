webConn = Cluster.discoverConnection('web')

Meteor.methods 'authenticate': (loginToken) ->
  userId = webConn.call('getUserByToken', loginToken)
  @setUserId userId
  userId

@Objects = new Mongo.Collection('objects')

if Objects.find().count() < 1
	_.each [1..20], (num) ->
		Objects.insert
			title: "object#{num}"

buildRegExp = (searchText) ->
  # this is a dumb implementation
  parts = searchText.trim().split(/[ \-\:]+/)
  new RegExp('(' + parts.join('|') + ')', 'ig')

Meteor.methods
  "searchObjects": (searchText) ->
    Objects.find(title: buildRegExp(searchText)).fetch()