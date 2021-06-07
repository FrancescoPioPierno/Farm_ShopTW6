from flask import redirect, render_template, url_for, flash, request, session, current_app
from shop import db, app
from shop.products.models import Addproduct
from shop.products.routes import brands, categories
import json

#la funzione MagerDicts non fa altro che accettare come parametri due "dizionari" o "liste" ed inserire un tot di quantità
#di prodotti all'interno del tuo carrello.

def MagerDicts(dict1, dict2):
    if isinstance(dict1, list) and isinstance(dict2, list):
        return dict1+dict2
    if isinstance(dict1, dict) and isinstance(dict2, dict):
        return dict(list(dict1.items()) + list(dict2.items()))


#Route che crea il mio carrello, la request di questa route sarà esclusivamente di tipo "POST"

@app.route('/addcart', methods=['POST'])
def AddCart():

    #Tutta la funzione AddCart() (creazione del carrello) viene eseguita all'interno di un blocco try-except.
    #Il blocco try crea il prodotto inserito nel carrello, la request è esclusivamente di tipo "POST"
    #Si crea un dizionario che di conseguenza sarà il nostro documento JSON per lo scambio di dati dal client-side al server-side


    try:
        product_id = request.form.get('product_id')
        quantity = int(request.form.get('quantity'))
        product = Addproduct.query.filter_by(id=product_id).first()

        if product_id and quantity and request.method == 'POST':
            DictItems = {product_id: {'name': product.name, 'price': float(product.price), 'discount': product.discount,'quantity': quantity, 'image': product.image_1}}
            if 'Shoppingcart' in session:
                print(session['Shoppingcart'])
                if product_id in session['Shoppingcart']:
                    for key, item in session['Shoppingcart'].items():
                        if int(key) == int(product_id):
                            session.modified = True
                            item['quantity'] += 1
                else:
                    session['Shoppingcart'] = MagerDicts(session['Shoppingcart'], DictItems)
                    return redirect(request.referrer)
            else:
                session['Shoppingcart'] = DictItems
                return redirect(request.referrer)

    #Se il codice eseguito all'interno del blocco try non va a buon fine, si genererà un errore.
    except Exception as e:
        print(e)
    #request.referrer contiene l'URL da dove viene la richiesta
    finally:
        return redirect(request.referrer)

#Route e funzione getCart() che permettono la visualizzazione dei prodotti all'interno del tuo carrello.
@app.route('/carts')
def getCart():
    #Se non viene creato una sessione di acquisto, si ritorna alla home page

    if 'Shoppingcart' not in session or len(session['Shoppingcart']) <=0:
        return redirect(url_for('home'))
    #In questa parte di codice si calcolare la tassa effettiva ed il prezzo totale dei prodotti inseriti nel carrello.
    subtotal = 0
    grandtotal = 0
    for key, product in session['Shoppingcart'].items():
        discount = (product['discount']/100) * float(product['price'])
        subtotal += float(product['price']) * int(product['quantity'])
        subtotal -= discount
        tax = "%.2f" % (.06 * float(subtotal))
        grandtotal = float("%.2f" % (1.06 * subtotal))

    return render_template('products/carts.html', tax=tax, grandtotal=grandtotal, subtotal=subtotal, categories=categories(), barnds=brands())


#Route e funzione updatecart() che prende come parametro l'id del prodotto, e quest'ultimo verrà modificato
#(in questo caso solo la quantità dello stesso tipo di prodotto


@app.route('/updatecart/<int:code>', methods=['POST'])
def updatecart(code):
    if 'Shoppingcart' not in session or len(session['Shoppingcart']) <=0:
        return redirect(url_for('home'))

    if request.method == 'POST':
        quantity = request.form.get('quantity')
        try:
            session.modified = True
            for key, item in session['Shoppingcart'].items():
                if int(key) == code:
                    item['quantity'] = quantity
                    flash('Il prodotto è aggiornato')
                    return redirect(url_for('getCart'))
        except Exception as e:
            print(e)
            return redirect(url_for('getCart'))


#Route e funzione che definiscono l'eliminazione del prodotto all'interno del tuo carrello.
@app.route('/deleteitem/<int:id>')
def deleteitem(id):
    if 'Shoppingcart' not in session or len(session['Shoppingcart']) <= 0:
        return redirect(url_for('home'))
    #All'interno del blocco try verrà eseguito il blocco di codice che permette quest'ultima operazione.
    try:
        session.modified = True
        for key, item in session['Shoppingcart'].items():
            if int(key) == id:
                #Il metodo pop() seleziona il prodotto interessato e lo elimina dal carrello, prendendo come parametro la chiave
                #del prodotto(sarebbe l'id).
                session['Shoppingcart'].pop(key, None)
                return redirect(url_for('getCart'))
        return redirect(url_for('getCart'))
    except Exception as e:
        return redirect(url_for('getCart'))

#route che permette di pulire tutto il tuo carrello.
@app.route('/clearcart')
def clearcart():
    try:
        #Se si usa session.clear() verrà pulita tutta "la sessione", compreso login da parte dell'utente.
        #Soluzione del problema, si utilizza sempre il metodo pop() che "pulisce" tutto il tuo carrello creato.
        session.pop('Shoppingcart', None)
        return redirect(url_for('home'))
    except Exception as e:
        print(e)