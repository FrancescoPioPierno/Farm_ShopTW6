from wtforms import Form, StringField, TextAreaField, PasswordField, SubmitField, validators, ValidationError
from flask_wtf.file import FileRequired, FileAllowed, FileField
from flask_wtf import FlaskForm
from .models import Register

#Classe che definisce la form per la registrazione dell'utente che effettuerà gli acquisti, si faranno utilizzo dei dati
#che vengono di soliti inseriti all'interno di una pagina di registrazione di un e-commerce. Cosa importante, i form
#verranno creati tramite documenti HTML.

class CustomerRegisterForm(FlaskForm):
    name = StringField('Nome: ')
    username = StringField('Username: ', [validators.DataRequired()])
    email = StringField('Email : ', [validators.Email(), validators.DataRequired()])
    password = PasswordField('Password: ', [validators.DataRequired(), validators.EqualTo('confirm', message='Entrambe le password devono combaciare')])
    confirm = PasswordField('Ripeti Password: ', [validators.DataRequired()])
    country = StringField('Paese: ', [validators.DataRequired()])
    #state = StringField('Stato: ', [validators.DataRequired()])
    city = StringField('Città: ', [validators.DataRequired()])
    contact = StringField('Contatto: ', [validators.DataRequired()])
    address = StringField('Indirizzo: ', [validators.DataRequired()])
    zipcode = StringField('CAP: ', [validators.DataRequired()])

    profile = FileField('Profilo', validators=[FileAllowed(['jpg', 'png', 'jpeg', 'gif'], 'Immagine solo ')])

    submit = SubmitField('Registrati')

    #Se un username è stato già preso, verrà lanciata questa funzione seguita da un blocco if.
    def validate_username(self, username):
        if Register.query.filter_by(username=username.data).first():
            raise ValidationError("Questo username è già in uso")

    # Se una email è stata già inserita, verrà lanciata questa funzione seguita da un blocco if.
    def validate_email(self, email):
        if Register.query.filter_by(email=email.data).first():
            raise ValidationError("Questa email è già in uso")


#Definizione del form del login dell'utente
class CustomerLoginForm(FlaskForm):
    email = StringField('Email : ', [validators.Email(), validators.DataRequired()])
    password = PasswordField('Password: ', [validators.DataRequired()])



