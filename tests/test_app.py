from app import app

client = app.test_client()


def test_home():

    response = client.get("/")

    assert response.status_code == 200


def test_add():

    response = client.post(
        "/calculate",
        json={
            "num1": 10,
            "num2": 20,
            "operation": "add"
        }
    )

    assert response.status_code == 200

    assert response.get_json()["result"] == 30