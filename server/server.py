from flask import Flask
app = Flask(__name__)

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
