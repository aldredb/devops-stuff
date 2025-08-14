from flask import Flask, jsonify, request

app = Flask(__name__)

@app.route('/api', methods=['GET'])
def get_data():
    return jsonify({'version': '2'})

@app.route('/api', methods=['POST'])
def post_data():
    data = request.json
    return jsonify({'received_data': data})

if __name__ == '__main__':
    app.run(port=18080,debug=True)
