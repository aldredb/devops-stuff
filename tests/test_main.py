import pytest
from main import app

@pytest.fixture
def client():
    app.config['TESTING'] = True
    with app.test_client() as client:
        yield client

def test_get_data(client):
    response = client.get('/api')
    assert response.status_code == 200
    assert response.json == {'version': '3.1'}

def test_post_data(client):
    test_data = {'key': 'value'}
    response = client.post('/api', json=test_data)
    assert response.status_code == 200
    assert response.json == {'received_data': test_data}