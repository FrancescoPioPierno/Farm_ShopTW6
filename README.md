# Progetto Tecnologie Web 6 CFU "Università degli Studi di Napoli Parthenope" corso di laurea "Informatica"
# FarmShop
# Pierno Francesco Pio 
La web app è stata implementata con le seguenti tecnologie:

- Lato Client: HTML e JavaScript, JQuery con supporto di Bootstrap
- Lato Server: Linguaggio di programmazione Python, Flask, e SQLAlchemy

# Esecuzione della web application

Se si è in possesso di un IDE come PyCharm, si crea automaticamente una virtual environment se no utilizzare i seguenti comandi da terminale:
Creare la virtual environment:

`py -3 -m venv venv`

Attivare la virtual environment:

`venv\Scripts\activate`

Una volta attivata la virtual environment, installare i requirements:

`pip install -r requirements.txt`

Alcuni package sono installati in delle versioni precedenti in modo da impedire che alcuni di essi vadano in conflitto.
Si inserisce nella variabile d'ambiente FLASK_APP il file che avvia la web app.

`set FLASK_APP=run.py`

Attivare il debug

`set FLASK_DEBUG=1`

Avviare il programma

`flask run`
