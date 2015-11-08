from flask import Flask, request, jsonify
import here_server

app = Flask(__name__)

car = here_server.PublicSafety("John Doe")

@app.route('/')
def hello_world():
    return 'Hello World!'

@app.route('/car_location')
def car_location():
    location = car.car_location()
    return jsonify({"result" : location})
    #return str(location[0]) + "," + str(location[1])

@app.route('/start_operation')
def start_operation():
    car.start_operation()
    return 'Start operation'

@app.route('/get_route', methods=['GET'])
def get_route():
    location = request.args.get('location')
    return car.get_route(location).json

@app.route('/request_publicsafety', methods=['GET'])
def request_publicsafety():
    location = request.args.get('location')
    return car.request_publicsafety(location)

if __name__ == '__main__':
    app.run(host="0.0.0.0", port=int("2000"), debug=True)



