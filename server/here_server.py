import requests
import json
import sys


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
        response = requests.get(url)
        return response.content
        #self.x_cordinate
        #self.y_cordinate
        

