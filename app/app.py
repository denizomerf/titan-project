from flask import Flask, jsonify

app = Flask(__name__)


@app.route("/")
def hello():
    return jsonify(message="Hello, AWS!")


@app.route("/healthz")
def healthz():
    return jsonify(status="ok")


if __name__ == "__main__":
    # Local development only; in the container gunicorn serves the app
    app.run(host="0.0.0.0", port=5000)
