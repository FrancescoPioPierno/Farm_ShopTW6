from shop import db, login_manager
from datetime import datetime
from flask_login import UserMixin
import json

#Il decorator @login_manager.user_loader non fa altro che "caricare" l'utente registrato datogli un ID.

@login_manager.user_loader
def user_loader(user_id):
    return Register.query.get(user_id)

#Classe di creazione dell'utente all'interno l'oggetto UserMixin. UserMixin non fa altro che andare a "soddisfare" alcuni metodi del tipo
#se l'utente è connesso, se è valido o se è un utente anonimo.

class Register(db.Model, UserMixin):
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(50), unique=False)
    username = db.Column(db.String(50), unique=True)
    email = db.Column(db.String(50), unique=True)
    password = db.Column(db.String(200), unique=False)
    country = db.Column(db.String(50), unique=False)
    #state = db.Column(db.String(50), unique=False)
    city = db.Column(db.String(50), unique=False)
    contact = db.Column(db.String(50), unique=False)
    address = db.Column(db.String(50), unique=False)
    zipcode = db.Column(db.String(50), unique=False)
    profile = db.Column(db.String(200), unique=False, default='profile.jpg')
    date_created = db.Column(db.DateTime, nullable=False, default=datetime.utcnow)

    def __repr__(self):
        return '<Register %r>' % self.name

#La seguente classe trasforma i dati inseriti all'interno del mio carrello, in questo caso l'ordine e li restituisce in formato JSON

class JsonEcodedDict(db.TypeDecorator):
    impl = db.Text

    def process_bind_param(self, value, dialect):
        if value is None:
            return '{}'
        else:
            return json.dumps(value)

    def process_result_value(self, value, dialect):
        if value is None:
            return {}
        else:
            return json.loads(value)

#Creazione dell'ordine da parte dell'utente. Come si vuol notare come la variabile orders contenga la classe JsonEcodedDict.
#Infatti se andiamo ad interrogare il database con una query, ci restituirà l'ordine in un dizionario (formato JSON)

class CustomerOrder(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    invoice = db.Column(db.String(30), unique=True, nullable=False)
    status = db.Column(db.String(30), default='In pagamento', nullable=False)
    customer_id = db.Column(db.Integer, unique=False, nullable=False)
    date_created = db.Column(db.DateTime, default=datetime.utcnow, nullable=False)
    orders = db.Column(JsonEcodedDict)

    def __repr__(self):
        return '<CustomerOrder %r>' % self.invoice


db.create_all()