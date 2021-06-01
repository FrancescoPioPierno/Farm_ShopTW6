from wtforms import Form, BooleanField, StringField, PasswordField, validators
import email_validator


class RegistrationForm(Form):
    name = StringField('Nome', [validators.Length(min=4, max=25)])
    username = StringField('Username', [validators.Length(min=4, max=25)])
    email = StringField('Indirizzo Email', [validators.Length(min=6, max=35), validators.Email()])
    password = PasswordField('Nuova Password', [
        validators.DataRequired(),
        validators.EqualTo('confirm', message='Passwords devono corrispondere')
    ])
    confirm = PasswordField('Ripeti Password')

class LoginForm(Form):
    email = StringField('Indirizzo Email', [validators.Length(min=6, max=35), validators.Email()])
    password = PasswordField('Password', [
        validators.DataRequired(),

    ])