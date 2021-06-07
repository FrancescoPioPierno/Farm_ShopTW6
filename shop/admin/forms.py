#Importazione dei package per la creazione dei form

from wtforms import Form, BooleanField, StringField, PasswordField, validators
import email_validator

#Dichiarazione del form per la registrazione dell'admin, si farà utilizzo di tre campi String e uno di tipo Password
#I validators servono se l'utente inserisce correttamente i dati input all'interno del form.
class RegistrationForm(Form):
    name = StringField('Nome', [validators.Length(min=4, max=25)])
    username = StringField('Username', [validators.Length(min=4, max=25)])
    email = StringField('Indirizzo Email', [validators.Length(min=6, max=35), validators.Email()])
    password = PasswordField('Nuova Password', [
        validators.DataRequired(),
        validators.EqualTo('confirm', message='Passwords devono corrispondere')
    ])
    confirm = PasswordField('Ripeti Password')

#Definizione del form per il login dell'admin. Per effettuare il login si utilizzerà solo l'email e la password.
class LoginForm(Form):
    email = StringField('Indirizzo Email', [validators.Length(min=6, max=35), validators.Email()])
    password = PasswordField('Password', [
        validators.DataRequired(),

    ])