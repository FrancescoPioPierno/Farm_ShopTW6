
#Importazione del modulo db
from shop import db

#Definizione della tabella User(in questo caso Admin). Per la creazione delle tabelle si farà utilizzo di SQLAlchemy.
#La classe User prenderà in parametro db.Model. Esso è la classe base di tutti i modelli definito dal database.
#Il metodo db.Column non fa altro che creare le varie colonne; primary_key definisce la chiave primaria, unique se il valore
#inserito dovrà essere unico o no, e nullable se dovrà essere vuoto o no.


class User(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(80), unique=False, nullable=False)
    username = db.Column(db.String(80), unique=True, nullable=False)
    email = db.Column(db.String(120), unique=True, nullable=False)
    password = db.Column(db.String(180), unique=False, nullable=False)
    profile = db.Column(db.String(180), unique=False, nullable=False, default='profile.jpg')

    def __repr__(self):
        return '<User %r>' % self.username

#Metodo che crea "fisicamente" la tabella e la inserisce nel database.

db.create_all()