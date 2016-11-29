
import os
import datetime
import time
import json
from wsgiref.handlers import format_date_time

from flask import Flask, request, Response, session
from flask import render_template, url_for, redirect, send_from_directory
from flask import send_file, make_response, abort, jsonify


from sqlalchemy import text, func

from ProjectApp import app, db, models, google

@app.after_request
def add_header(response):
	response.cache_control.max_age = 0
	now = datetime.datetime.now()
	expires_time = now + datetime.timedelta(seconds=1)
	response.headers['Cache-Control'] = 'public'
	response.headers['Expires'] = format_date_time(time.mktime(expires_time.timetuple()))
	return response

@app.route('/')
def view_of_test():
	response = make_response(open('ProjectApp/static/index.html').read())
	response.cache_control.max_age = 0
	now = datetime.datetime.now()
	expires_time = now + datetime.timedelta(seconds=1)
	response.headers['Cache-Control'] = 'public'
	response.headers['Expires'] = format_date_time(time.mktime(expires_time.timetuple()))
	return response

@app.route('/getUserLogin', methods=['GET'])
def getUserLogin():
	if 'google_token' in session:
		me = google.get('userinfo')
		return jsonify({"userInfo": me.data})
	return jsonify({"userInfo": ""})


@app.route('/acceptGroupRequest', methods=['POST'])
def acceptRequest():
	req = request.get_json()
	uID = req['userID']
	db.engine.execute(text('update Users set isPending=0 where userName="'+str(uID)+'";'))
	return ""

@app.route('/rejectGroupRequest', methods=['POST'])
def rejectRequest():
	req = request.get_json()
	uID = req['userID']
	db.engine.execute(text('update Users set isPending=0, gID=NULL where userName="'+str(uID)+'";'))
	return ""

@app.route('/sendGroupRequest', methods=['POST'])
def SendUserRequest():
	req = request.get_json()
	req_uID = req['sendingUserID']
	rec_uID = req['receivingUserID']
	group_id_query = db.engine.execute(text('select gId from Users where userName="'+ str(rec_uID) +'";'))
	for row in group_id_query:
		group_id = row.gId
	db.engine.execute(text('update Users set isPending=1, gId="'+str(group_id)+'" where userName="'+str(req_uID)+'";'))
	return ""

@app.route('/leaveGroup', methods=['POST'])
def leaveGroup():
	req = request.get_json()
	uID = req['userID']
	db.engine.execute(text('update Users set isPending=0, gId=NULL where userName="'+str(uID)+'";'))
	return ""


@app.route('/getGroupMembers', methods=['POST'])
def getGroupMembers():
	user_List = []
	pending_user_List = []

	req = request.get_json()
	uID = req['userID']

	group_id_query = db.engine.execute(text('select gId from Users where ' + ' userName="'+str(uID)+'";'))

	for row in group_id_query:
		group_id = row.gId

	query = db.engine.execute(text('select firstName, lastName, userName, isPending from Users where ' + ' gId="'+str(group_id) +'";'))

	for row in query:
		if row.isPending == 0:
			user_List.append(dict(FirstName=row.firstName, LastName=row.lastName, userID=row.userName))
		elif row.userName != uID:
			pending_user_List.append(dict(FirstName=row.firstName, LastName=row.lastName, userID=row.userName))

	return jsonify(groupMembers=user_List, requestingMembers=pending_user_List)

@app.route('/isUserInGroup', methods=['POST'])
def isUserInGroup():
	req = request.get_json()
	uID = req['userID']
	query = db.engine.execute(text('select gId, isPending from Users where userName="' +str(uID)+'";'))
	ans = False
	for row in query:
		if row.isPending != 1 and row.gId !=None:
			ans = True
	return jsonify(hasGroup=ans)

@app.route('/createGroup', methods=['POST'])
def createGroup():
	req = request.get_json()
	uID = req['userID']
	group = db.engine.execute(text(('INSERT INTO Groups() VALUES ();')))
	query = db.engine.execute(text('select * from Groups;'))
	groupID=0
	for row in query:
		if row.groupId > groupID:
			groupID = row.groupId
	db.engine.execute(text('update Users set isPending=0, gId='+str(groupID)+' where userName="'+str(uID)+'";'))
	return ''


@app.route('/getAllGroupUsers', methods=['GET'])
def getAllUsers():
	user_List = []
	query = db.engine.execute(text('select firstName, lastName, userName, isPending, gId from Users;'))
	for row in query:
		print(row.userName,row.gId)
		if row.gId != None and row.isPending == 0:
			user_List.append(dict(firstName=row.firstName, lastName=row.lastName, userID=row.userName))
	return jsonify(allGroupUsers=user_List)


@app.route('/getFloorInfo', methods=['POST'])
def getFloorInfo():
	floor_List = []
	req = request.get_json()
	build = req['buildingName'].capitalize()
	query = db.engine.execute(text('select numFloors, hasBasement from Buildings where name="' +str(build)+'";'))
	for row in query:
		nFloors = row.numFloors
		hBasement = row.hasBasement
	if hBasement == 1:
		floor_List.append('B')

	for i in range(1,int(nFloors)):

		floor_List.append(str(i))
		if i == int(nFloors)-1 and hBasement == 0:
					floor_List.append(str(i+1))

	return jsonify(floorList=floor_List)

@app.route('/getRoomOccupants', methods=['POST'])
def getRoomOccupants():
	user_List = []
	req = request.get_json()
	build = req['buildingName'].capitalize()
	roomNum = req['roomNumber']
	query = db.engine.execute(text('select firstName, lastName, userID from Rooms, Users where roomNum="'+str(roomNum)+'" and building="'+str(build)+'" and Users.gId=Rooms.gId;'))
	for row in query:
		x = dict(firstName=row.firstName, lastName=row.lastName, userID=row.userName)
		user_List.append(x)
	return jsonify(roomOccupants=user_List)


@app.route('/login')
def login():
    return google.authorize(callback=url_for('authorized', _external=True))

@app.route('/logout')
def logout():
    session.pop('google_token', None)
    return redirect('/')

@app.route('/login/authorized')
def authorized():
    resp = google.authorized_response()
    if resp is None:
        return 'Access denied: reason=%s error=%s' % (
            request.args['error_reason'],
            request.args['error_description']
        )

    session['google_token'] = (resp['access_token'], '')
    # me = google.get('userinfo')
    # print("======================")
    # print(me.data['email'])
    # if me.data['email'].split('@')[-1] != 'luther.edu':
    #     # session.revoke(httplib2.Http())
    #     session.pop('google_token', None)
    #     return redirect(url_for('index'))
    # print("======================")
    return redirect('/')



@google.tokengetter
def get_google_oauth_token():
    return session.get('google_token')
