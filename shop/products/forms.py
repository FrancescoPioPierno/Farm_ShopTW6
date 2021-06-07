from flask_wtf.file import FileAllowed, FileField, FileRequired
from wtforms import Form, IntegerField, StringField, BooleanField, TextAreaField, validators, DecimalField

#class Form che permette di definire i campi per l'aggiunta del prodotto da parte dell'admin.

class Addproducts(Form):
    name = StringField("Nome", [validators.DataRequired()])
    price = DecimalField("Prezzo", [validators.DataRequired()])
    discount = IntegerField('Sconto', default=0)
    description = TextAreaField('Descrizione', [validators.DataRequired()])
    stock = IntegerField("Quantità", [validators.DataRequired()])
    image_1 = FileField('Immagine', validators=[FileAllowed(['jpg', 'png', 'gif' ,'jpeg']), 'solo immagini'])
