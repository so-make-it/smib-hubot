# Description:
#   Link to wiki page/search wiki
#
# Commands:
#   hubot wiki page - respond with wiki url for page

querystring = require 'querystring'

getWikiPage = (msg) ->
  count = 0
  lastLocation = null
  gotURL = (err, res, body) ->
    if [301, 302].indexOf(res.statusCode) isnt -1
      if count++ > 5
        msg.send "Redirect loop?"
        return
      lastLocation = res.headers.location
      return msg.http(res.headers.location).get() gotURL
    else
      return msg.send lastLocation

  data =
    search: msg.match[1]
    #go: "Go"
    #fulltext: "Search"
    title: "Special:Search"

  lastLocation = 'https://wiki.somakeit.org.uk/index.php5?'+querystring.stringify(data).replace(/%20/, "+")
  msg.http(lastLocation)
    .get() gotURL

module.exports = (robot) ->
  robot.respond /^wiki (.*)$/i, getWikiPage

if require.main is module
  HttpClient = require 'scoped-http-client'
  searchTerm = process.argv[2] ? "Opening Hours"
  getWikiPage {
    match: ["wiki #{searchTerm}", searchTerm]
    send: (text) ->
      console.log text
    http: (url) ->
      HttpClient.create(url).header('User-Agent', "TESTING")
  }
