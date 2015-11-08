from flask import Flask, request
from here_server import PublicSafety
import json
import xml.etree.ElementTree



app = Flask(__name__)

car = PublicSafety("John Doe")
car2 = PublicSafety("Gandalf")

@app.route('/')
def hello_world():
    return 'Hello World!'

@app.route('/car_location')
def car_location():
    latitude, longitude = car.car_location()
    return latitude + ", " + longitude

@app.route('/get_route', methods=['GET'])
def get_route():
    location = request.args.get('location')
    return car.get_route(request.args.get('location')).content

@app.route('/request_publicsafety', methods=['GET'])
def request_publicsafety():
    location = request.args.get('location')
    return car.request_publicsafety(location)

if __name__ == '__main__':
    """
    Main method
    """
    app.run(host="0.0.0.0", port=int("2000"), debug=True)
