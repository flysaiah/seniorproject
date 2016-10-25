#######################################################
#################     DESCRIPTION    ##################
#######################################################
#                                                     #
#              Initalizes The aplication              #
#                                                     #
#######################################################


from flask import Flask, request, Blueprint, render_template, \
                  flash, g, session, redirect, url_for
from flask_sqlalchemy import SQLAlchemy

app = Flask(__name__)
app.config.from_object('ProjectApp.flaskconfig')
db = SQLAlchemy(app)

from ProjectApp import models

# db.drop_all()
db.create_all()
