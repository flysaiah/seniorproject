#######################################################
#################     DESCRIPTION    ##################
#######################################################
#                                                     #
#              Initalizes The aplication              #
#                                                     #
#######################################################


from flask import Flask, request, Blueprint, render_template, \
                  flash, g, redirect, url_for, jsonify
from flask_sqlalchemy import SQLAlchemy
import json
from flask_oauthlib.client import OAuth

app = Flask(__name__)
app.config.from_object('ProjectApp.flaskconfig')
app.config['GOOGLE_ID'] = "939208226876-tq27jm9fuoga0iqlu4u1m5a8k4reg1os.apps.googleusercontent.com"
app.config['GOOGLE_SECRET'] = "yc0GgVovPebsgDK2SakWtd_I"
app.debug = True
app.secret_key = 'development'
oauth = OAuth(app)

google = oauth.remote_app(
    'google',
    consumer_key=app.config.get('GOOGLE_ID'),
    consumer_secret=app.config.get('GOOGLE_SECRET'),
    request_token_params={
        'scope': 'email',
        'hd': 'luther.edu',
    },
    base_url='https://www.googleapis.com/oauth2/v1/',
    request_token_url=None,
    access_token_method='POST',
    access_token_url='https://accounts.google.com/o/oauth2/token',
    authorize_url='https://accounts.google.com/o/oauth2/auth',
)
db = SQLAlchemy(app)

from ProjectApp import models

# db.drop_all()
db.create_all()
import ProjectApp.controllers


