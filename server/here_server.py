import requests
import sys
from flask import Flask
app = Flask(__name__)

pickup_location_1 = "35 W 33rd St, Chicago, IL 60616"
pickup_location_2 = "3241 S Federal St, Chicago, IL 60616"

class PublicSafety():
    def __init__(self):
        self.home = "199 E 33rd Blvd, Chicago, IL 60616"

    def start_patrol():


@app.route('/')
def hello_world():
    return 'Hello World!'

@app.route('/car_location')
def car_location():
    return "car location"

if __name__ == '__main__':
    """
    Main method
    """
    app.run(host="0.0.0.0", port=int("2000"), debug=True)


__author__ = 'arihant'
