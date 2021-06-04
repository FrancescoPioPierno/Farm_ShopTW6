from wtforms import Form, StringField, TextAreaField, PasswordField, SubmitField, validators, ValidationError
from flask_wtf.file import FileRequired, FileAllowed, FileField
from flask_wtf import FlaskForm
from .models import Register

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

    def validate_username(self, username):
        if Register.query.filter_by(username=username.data).first():
            raise ValidationError("Questo username è già in uso")


    def validate_email(self, email):
        if Register.query.filter_by(email=email.data).first():
            raise ValidationError("Questa email è già in uso")



class CustomerLoginForm(FlaskForm):
    email = StringField('Email : ', [validators.Email(), validators.DataRequired()])
    password = PasswordField('Password: ', [validators.DataRequired()])



