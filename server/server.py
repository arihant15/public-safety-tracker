from flask import Flask, request
app = Flask(__name__)

@app.route('/')
def hello_world():
    return 'Hello World!'

@app.route('/car_location')
def car_location():
    return "car location"


@app.route('/get_route/', methods=['GET'])
def get_route():
    print request.args.get('x')
    print request.args.get('y')
    return "route"

if __name__ == '__main__':
    """
    Main method
    """
    app.run(host="0.0.0.0", port=int("2000"), debug=True)
