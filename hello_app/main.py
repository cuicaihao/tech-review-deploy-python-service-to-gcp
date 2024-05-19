import os
from datetime import datetime
from flask import Flask, render_template

app = Flask(__name__)


@app.route("/")
def home():
    return render_template("home.html")


# @app.route("/")
# def hello_world():
#     """Example Hello World route."""
#     name = os.environ.get("NAME", "World")
#     return f"Hello {name}!"


@app.route("/about/")
def about():
    return render_template("about.html")


@app.route("/contact/")
def contact():
    return render_template("contact.html")


@app.route("/hello/")
@app.route("/hello/<name>")
def hello_there(name=None):
    return render_template("hello_there.html", name=name, date=datetime.now())


@app.route("/api/data")
def get_data():
    return app.send_static_file("data.json")


if __name__ == "__main__":
    app.run(debug=False, host="0.0.0.0", port=int(os.environ.get("PORT", 8080)))
