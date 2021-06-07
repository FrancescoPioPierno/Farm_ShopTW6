from flask import render_template, session, request, redirect, url_for, flash
from shop import app, db, bcrypt
from .models import User
from .forms import RegistrationForm, LoginForm
from shop.products.models import Addproduct, Brand, Category
import os

#Creazione della route URL per la pagina principale dell'admin con all'interno una funzione che mostra i prodotti registrati.

@app.route('/admin')
def admin():
    #l'oggetto session non fa altro che gestire la sessione da parte dell'admin, se l'email non entra in "sessione"
    #genererà un'errore, dicendo di effettuare prima il login
    if 'email' not in session:
        flash('Per favore effettua l accesso', 'danger')
        return redirect(url_for('login'))
    #Il metodo query.all() seleziona tutti gli elementi all'interno della tabella Addproduct (come il SELECT * FROM di SQL)

    products = Addproduct.query.all()
    #render_template genera il template passato come parametro
    return render_template('admin/index.html', title='Admin Page', products=products)

#Creazione della route per i marchi del prodotto
@app.route('/brands')
def brands():
    if 'email' not in session:
        flash('Per favore effettua l accesso', 'danger')
        return redirect(url_for('login'))
    brands = Brand.query.order_by(Brand.id.desc()).all()
    return render_template('admin/brand.html', title="Brand page", brands=brands)

#Definisce l'URL per le categorie dei prodotti
@app.route('/category')
def category():
    if 'email' not in session:
        flash('Per favore effettua l accesso', 'danger')
        return redirect(url_for('login'))
    categories = Category.query.order_by(Category.id.desc()).all()
    return render_template('admin/brand.html', title='Category page', categories=categories)



#Decorator che definisce l'URL per la registrazione dell'admin, con i metodi GET E POST.
@app.route('/register', methods=['GET', 'POST'])
def register():
    #Si salva la form per la registrazione dell'admin in una variabile form
    form = RegistrationForm(request.form)
    #Il codice all'interno dell'if verrà eseguito solo se la richiesta inviata è di tipo POST e i dati inseriti siano validi.
    #bcrypt non fa altro che "criptare" e rendere sicura la password inserita e renderla ignota.

    if request.method == 'POST' and form.validate():
        hash_password = bcrypt.generate_password_hash(form.password.data)
        user = User(name=form.name.data, username=form.username.data, email=form.email.data,
                    password=hash_password)
        #session.add() i dati inseriti nella tabella User
        db.session.add(user)
        #session.commit() salva i dati inseriti
        db.session.commit()
        flash(f'Benvenuto {form.name.data} Grazie per esserti registrato', 'success')
        return redirect(url_for('home'))
    return render_template('admin/register.html', form=form, title="Registeration Page")

#Route per l'URL del login dell'admin, sempre con metodi GET e POST

@app.route('/login', methods=['GET', 'POST'])
def login():
    form = LoginForm(request.form)
    if request.method == "POST" and form.validate():
       #query.filter_by non fa altro che andare a "filtare" i vari risultati eseguiti dalla query, in questo con l'attributo email.

        user = User.query.filter_by(email=form.email.data).first()
        if user and bcrypt.check_password_hash(user.password, form.password.data):
            session['email'] = form.email.data
            flash(f'Benvenuto {form.email.data} Sei connesso', 'success')
            return redirect(request.args.get('next') or url_for('admin'))
        else:
            flash('Password errata, riprova ancora', 'danger')

    return render_template('admin/login.html', form=form, title='Login Page')