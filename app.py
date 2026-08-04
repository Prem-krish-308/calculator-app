print("Starting Flask application...")
from flask import Flask, render_template, request, jsonify
from calculator import Calculator

app = Flask(__name__)

calculator = Calculator()


@app.route("/")
def home():
    return render_template("index.html")


@app.route("/calculate", methods=["POST"])
def calculate():

    data = request.get_json()

    num1 = float(data["num1"])
    num2 = float(data["num2"])
    operation = data["operation"]

    try:

        if operation == "add":
            result = calculator.add(num1, num2)

        elif operation == "subtract":
            result = calculator.subtract(num1, num2)

        elif operation == "multiply":
            result = calculator.multiply(num1, num2)

        elif operation == "divide":
            result = calculator.divide(num1, num2)

        else:
            return jsonify({"error": "Invalid operation"}), 400

        return jsonify({"result": result})

    except Exception as e:

        return jsonify({"error": str(e)}), 400


if __name__ == "__main__":
    app.run(debug=True)