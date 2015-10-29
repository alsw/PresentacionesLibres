#!/usr/bin/python

import json 
import facebook
##data = urllib2.urlopen('http://graph.facebook.com/alswblog/').read()
access_token = 'CAAMzCQes4NkBAORJ93mpnXb3cjwbaFOuN5xiUU87enAdOZC9v4agnF4yZBN9bw6QaM6xjnYb3cuMIE8wBZBqDL3vDeHYBAjNrpJFzAzi1kBX7GHBel4NIh1Cqvkazqpjv0o5J6GrTtzWKnkZADehk3P16nwxEwioLCgOVRCpaj6njqyTrydim70G875gGUSKppMZAuqKt9dgzzszc1kbB'
getalsw = '755321211189697'

graph = facebook.GraphAPI(access_token)
data = graph.get_object(getalsw)
print data['likes']['data']['id']
#json_data = json.loads(data)
#print ('%s') % (json_data['hours']['mon_1_open'])
