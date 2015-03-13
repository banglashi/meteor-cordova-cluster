@SearchConn = Cluster.discoverConnection('search')
@Objects = new Mongo.Collection('objects', SearchConn)

SearchConn.onReconnect = () ->
  loginToken = Meteor._localStorage.getItem('Meteor.loginToken')
  @call('authenticate', loginToken)

Tracker.autorun () ->
  userId = Meteor.userId()
  SearchConn.onReconnect()


SearchConn.call "searchObjects", "object", (err, objects) ->
  throw err if(err)
  console.log "here is list of", objects
  _.each objects, (num) ->
  	console.log num
  	$('.js-results').append("<div>added #{num.title}</div>")