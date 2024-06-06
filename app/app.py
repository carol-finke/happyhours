from flask import Flask, render_template, request, jsonify
import sqlite3
import requests

app = Flask(__name__)

# Initialize the database
def init_db():
    conn = sqlite3.connect('restaurants.db')
    cursor = conn.cursor()
    cursor.execute('''
        CREATE TABLE IF NOT EXISTS restaurants (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            address TEXT,
            neighborhood TEXT,
            link TEXT,
            deal TEXT,
            monday TEXT,
            tuesday TEXT,
            wednesday TEXT,
            thursday TEXT,
            friday TEXT,
            saturday TEXT,
            sunday TEXT,
            price TEXT
        )
    ''')
    conn.commit()
    conn.close()

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/upload', methods=['POST'])
def upload():
    file = request.files['file']
    # Process file and insert into database
    # ...

@app.route('/restaurants', methods=['GET'])
def get_restaurants():
    conn = sqlite3.connect('restaurants.db')
    cursor = conn.cursor()
    cursor.execute("SELECT * FROM restaurants")
    restaurants = cursor.fetchall()
    conn.close()
    return jsonify(restaurants)

@app.route('/yelp/<name>', methods=['GET'])
def yelp(name):
    api_key = 'YOUR_YELP_API_KEY'
    headers = {'Authorization': f'Bearer {api_key}'}
    url = f'https://api.yelp.com/v3/businesses/search?term={name}&location=Chicago'
    response = requests.get(url, headers=headers)
    return jsonify(response.json())

if __name__ == '__main__':
    init_db()
    app.run(debug=True)
