import requests
import sys
from flask import Flask
app = Flask(__name__)

pickup_location_1 = "35 W 33rd St, Chicago, IL 60616"
pickup_location_2 = "3241 S Federal St, Chicago, IL 60616"

@app.route('/')
def hello_world():
    return 'Hello World!'

if __name__ == '__main__':
    """
    Main method
    """
    app.run()


__author__ = 'arihant'