import requests
import json
import sys
import xml.etree.ElementTree

pickup_location_1 = "35 W 33rd St, Chicago, IL 60616"
pickup_location_2 = "3241 S Federal St, Chicago, IL 60616"

class PublicSafety():
    def __init__(self, name):
        self.home = "199 E 33rd Blvd, Chicago, IL 60616"
        with open("properties.json") as f:
            self.properties = json.loads(f.read())
        self.name = name

    def car_location(self):
        base_url = "http://geocoder.cit.api.here.com/6.2/geocode.xml"
        pad_app_id = "?app_id="+self.properties['app-id']
        pad_app_code = "&app_code="+self.properties['app-code']
        pad_gen = "&gen=9"
        pad_searchtext = "&searchtext="+self.home
        url = base_url + pad_app_id + pad_app_code + pad_gen + pad_searchtext
        response = (requests.get(url)).content
        e = xml.etree.ElementTree.fromstring(response)
        position = e.findall("./Response/View/Result/Location/DisplayPosition")
        for child in position:
            self.latitude = child.find('Latitude').text
            self.longitude = child.find('Longitude').text
            print self.latitude
            print self.longitude

    def obtain_route(self):
        base_url = "http://route.cit.api.here.com/routing/7.2/calculateroute.json"
        pad_app_id = "?app_id="+self.properties['app-id']
        pad_app_code = "&app_code="+self.properties['app-code']
        self.car_location()
        pad_waypoint0 = "&waypoint0=geo!"+self.latitude+","+self.longitude
        pad_waypoint1 = "&waypoint1=geo!"
