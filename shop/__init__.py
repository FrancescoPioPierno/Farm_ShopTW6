from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from flask_bcrypt import Bcrypt
from flask_uploads import IMAGES, UploadSet, configure_uploads, patch_request_class
import os
from flask_login import LoginManager

basedir = os.path.abspath(os.path.dirname(__file__))
app = Flask(__name__)

#Definizione della URI del mio dabatase
app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql://root:root@localhost/flask_db'
app.config['SECRET_KEY']='hfouewhfoiwefoquw'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
#Inizializzazione del database
db = SQLAlchemy(app)
bcrypt = Bcrypt(app)
#Le immagini dei prodotti verranno salvate nella cartella images.
app.config['UPLOADED_PHOTOS_DEST'] = os.path.join(basedir, 'static/images')

#Il metodo LoginManager() permette l'applicazione di gestire il login dell'utente.
login_manager = LoginManager()
login_manager.init_app(app)
login_manager.login_view='customerLogin'
login_manager.needs_refresh_message_category='danger'
login_manager.login_message=u"Per favore effettua prima il login"



photos = UploadSet('photos', IMAGES)
configure_uploads(app, photos)
patch_request_class(app)



#Importazioni dei moduli.

from shop.admin import routes
from shop.products import routes
from shop.carts import carts
from shop.customers import routes

