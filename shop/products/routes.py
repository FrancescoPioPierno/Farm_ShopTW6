from flask import redirect, render_template, url_for, flash, request, session, current_app
from shop import db, app, photos
from .forms import Addproducts
from .models import Brand, Category, Addproduct
import secrets, os

@app.route('/')
def home():
    products = Addproduct.query.filter(Addproduct.stock > 0)
    barnds = Brand.query.join(Addproduct, (Brand.id == Addproduct.brand_id)).all()
    categories = Category.query.join(Addproduct, (Category.id == Addproduct.category_id)).all()
    return render_template('products/index.html', products=products, barnds=barnds, categories=categories)

@app.route('/product/<int:id>')
def single_page(id):
    product = Addproduct.query.get_or_404(id)
    barnds = Brand.query.join(Addproduct, (Brand.id == Addproduct.brand_id)).all()
    categories = Category.query.join(Addproduct, (Category.id == Addproduct.category_id)).all()
    return render_template('products/single_page.html', product=product, categories=categories, barnds=barnds)

@app.route('/categories/<int:id>')
def get_category(id):
    get_cat_prod = Addproduct.query.filter_by(category_id=id)
    categories = Category.query.join(Addproduct, (Category.id == Addproduct.category_id)).all()
    barnds = Brand.query.join(Addproduct, (Brand.id == Addproduct.brand_id)).all()
    return render_template('products/index.html', get_cat_prod=get_cat_prod, categories=categories, barnds=barnds)

@app.route('/brand/<int:id>')
def get_brand(id):
    brand = Addproduct.query.filter_by(brand_id=id)
    barnds = Brand.query.join(Addproduct, (Brand.id == Addproduct.brand_id)).all()
    categories = Category.query.join(Addproduct, (Category.id == Addproduct.category_id)).all()
    return render_template('products/index.html', brand=brand, barnds=barnds, categories=categories)




@app.route('/addbrand', methods=['GET', 'POST'])
def addbrand():
    if 'email' not in session:
        flash('Per favore effettua l accesso', 'danger')
        return redirect(url_for('login'))
    if request.method =="POST":
        getbrand = request.form.get('brand')
        brand = Brand(name=getbrand)
        db.session.add(brand)
        flash(f'La marca {getbrand} è stata aggiunta al tuo database', 'success')
        db.session.commit()
        return redirect(url_for('addbrand'))

    return render_template('products/addbrand.html', brands='brands')

@app.route('/updatebrand/<int:id>', methods=['GET', 'POST'])
def updatebrand(id):
    if 'email' not in session:
        flash("Per favore effettua l accesso", 'danger')

    updatebrand = Brand.query.get_or_404(id)
    brand = request.form.get('brand')
    if request.method == "POST":
        updatebrand.name = brand
        flash(f'La tua marca è stata modificata!', 'success')
        db.session.commit()
        return redirect(url_for('brands'))

    return render_template('products/updatebrand.html', title='Update brand page', updatebrand=updatebrand)

@app.route('/deletebrand/<int:id>', methods=['POST'])
def deletebrand(id):
    brand = Brand.query.get_or_404(id)
    if request.method == "POST":
        db.session.delete(brand)
        db.session.commit()
        flash(f'La marca {brand.name} è stato eliminato dal tuo database', 'success')
        return redirect(url_for('admin'))
    flash(f'La marca {brand.name} non può essere eliminata', 'warning')
    return redirect(url_for('admin'))




@app.route('/addcat', methods=['GET', 'POST'])
def addcat():
    if 'email' not in session:
        flash('Per favore effettua l accesso', 'danger')
        return redirect(url_for('login'))
    if request.method =="POST":
        getcat = request.form.get('category')
        cat = Category(name=getcat)
        db.session.add(cat)
        flash(f'La Categoria {getcat} è stata aggiunta al tuo database', 'success')
        db.session.commit()
        return redirect(url_for('addcat'))

    return render_template('products/addbrand.html')

@app.route('/updatecat/<int:id>', methods=['GET', 'POST'])
def updatecat(id):
    if 'email' not in session:
        flash("Per favore effettua l accesso", 'danger')

    updatecat = Category.query.get_or_404(id)
    category = request.form.get('category')
    if request.method == "POST":
        updatecat.name = category
        flash(f'La tua categoria è stata modificata!', 'success')
        db.session.commit()
        return redirect(url_for('category'))

    return render_template('products/updatebrand.html', title='Update category page', updatecat=updatecat)

@app.route('/deletecategory/<int:id>', methods=['POST'])
def deletecategory(id):
    category = Category.query.get_or_404(id)
    if request.method == "POST":
        db.session.delete(category)
        db.session.commit()
        flash(f'La categoria {category.name} è stato eliminato dal tuo database', 'success')
        return redirect(url_for('admin'))
    flash(f'La categoria {category.name} non può essere eliminata', 'warning')
    return redirect(url_for('admin'))



@app.route('/Addproduct', methods=['POST', 'GET'])
def addproduct():
    if 'email' not in session:
        flash('Per favore effettua l accesso', 'danger')
        return redirect(url_for('login'))
    brands = Brand.query.all()
    categories = Category.query.all()
    form = Addproducts(request.form)
    if request.method == 'POST':
        name = form.name.data
        price = form.price.data
        discount = form.discount.data
        stock = form.stock.data
        desc = form.description.data
        brand = request.form.get('brand')
        category = request.form.get('category')
        image_1 = photos.save(request.files.get('image_1'), name=secrets.token_hex(10) + ".")

        addpro = Addproduct(name=name, price=price, discount=discount, stock=stock,
                             desc=desc, brand_id=brand, category_id=category, image_1=image_1)

        db.session.add(addpro)
        flash(f"Il prodotto {name} è stato aggiunto al tuo database", 'success')
        db.session.commit()
        return redirect(url_for('admin'))


    return render_template('products/addproduct.html', title='Add Product Page', form=form, brands=brands
                           , categories=categories)

@app.route('/updateproduct/<int:id>', methods=['GET', 'POST'])
def updateproduct(id):
    brands = Brand.query.all()
    categories = Category.query.all()
    product = Addproduct.query.get_or_404(id)
    brand = request.form.get('brand')
    category = request.form.get('category')
    form = Addproducts(request.form)
    if request.method == 'POST':
        product.name = form.name.data
        product.price = form.price.data
        product.desc = form.description.data
        product.discount = form.discount.data
        product.stock = form.stock.data
        product.brand_id = brand
        product.category_id = category
        if request.files.get('image_1'):
            try:
                os.unlink(os.path.join(current_app.root_path, "static/images/" + product.image_1))
                product.image_1 = photos.save(request.files.get('image_1'), name=secrets.token_hex(10) + ".")
            except:
                product.image_1 = photos.save(request.files.get('image_1'), name=secrets.token_hex(10) + ".")


        db.session.commit()
        flash(f'Il tuo prodotto è stato modificato!', 'success')
        return redirect(url_for('admin'))

    form.name.data = product.name
    form.price.data = product.price
    form.description.data = product.desc
    form.discount.data = product.discount
    form.stock.data = product.stock

    return render_template('products/updateproduct.html', form=form, brands=brands, categories=categories,
                           product=product)

@app.route('/deleteproduct/<int:id>', methods=['POST'])
def deleteproduct(id):
    product = Addproduct.query.get_or_404(id)
    if request.method == 'POST':
        if request.files.get('image_1'):
            try:
                os.unlink(os.path.join(current_app.root_path, "static/images/" + product.image_1))

            except Exception as e:
                print(e)

        db.session.delete(product)
        db.session.commit()
        flash(f'Il prodotto {product.name} è stato eliminato dal tuo registro', 'success')
        return redirect(url_for('admin'))

    flash(f'Non si può eliminare il prodotto', 'danger')
    return redirect(url_for('admin'))