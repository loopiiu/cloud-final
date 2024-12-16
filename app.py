from flask import Flask, request, jsonify
from flask_sqlalchemy import SQLAlchemy
import os

app = Flask(__name__)

# Configure Cloud SQL connection
app.config['SQLALCHEMY_DATABASE_URI'] = (
    "postgresql+psycopg2://postgres:hello200399@/inventory_db"
    "?host=/cloudsql/final-cloud-alua:us-central1:instance1"        #instance connection name
)
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

db = SQLAlchemy(app)

# Example Model
class Product(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(100), nullable=False)
    quantity = db.Column(db.Integer, nullable=False)

# Routes
@app.route('/products', methods=['POST'])
def add_product():
    data = request.get_json()
    product = Product(name=data['name'], quantity=data['quantity'])
    db.session.add(product)
    db.session.commit()
    return jsonify({"message": "Product added", "id": product.id}), 201

if __name__ == '__main__':
    app.run(debug=True)

# to render insex.html
@app.route('/')
def index():
    return render_template('index.html')


#with app.app_context():
    #db.create_all()
