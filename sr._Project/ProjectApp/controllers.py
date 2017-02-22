
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

####################################
##         Group Requests         ##
####################################

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
	group_id = ''
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
		gID = row.gId
		if row.isPending != 1 and gID !=None:
			ans = True
	if ans == True:
		return jsonify(hasGroup=ans, groupID=gID)
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
	query = db.engine.execute(text('select firstName, lastName, role, userName, isPending, gId from Users;'))
	for row in query:
		if row.role == 'admin':
			continue
		if row.gId != None and row.isPending == 0:
			user_List.append(dict(firstName=row.firstName, lastName=row.lastName, userID=row.userName))
	return jsonify(allGroupUsers=user_List)

####################################
##      Buildings and Rooms       ##
####################################

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

	for i in range(1,int(nFloors)+1):
		floor_List.append(str(i))

	return jsonify(floorList=floor_List)


@app.route('/registerForRoom', methods=['POST'])
def registerForRoom():
	now = datetime.datetime.now()
	req = request.get_json()
	groupID = req['groupID']
	build = req['buildingName'].capitalize()
	roomNum = req['roomNumber']
	query = db.engine.execute(text('select isTaken from Rooms where roomNum="'+str(roomNum)+'" and building="'+str(build)+'";'))
	query2 = db.engine.execute(text('select drawDate from Groups where groupId="'+str(groupID)+'";'))
	for row in query:
		if row.isTaken == 1:
			return jsonify(wasSuccessful=False, reason='taken')
	for row in query2:
		if row.drawDate > now:
			return jsonify(wasSuccessful=False, reason='time')
	db.engine.execute(text('update Rooms set isTaken=1, gId="'+str(groupID)+'" where roomNum="'+str(roomNum)+'" and building="'+str(build)+'";'))
	db.engine.execute(text('update Groups set isRegistered=1 where groupId="'+str(groupID)+'";'))
	return jsonify(wasSuccessful=True)


@app.route('/getRoomOccupants', methods=['POST'])
def getRoomOccupants():
	user_List = []
	req = request.get_json()
	build = req['buildingName'].capitalize()
	roomNum = req['roomNumber']
	query = db.engine.execute(text('select firstName, lastName, userName from Rooms, Users where roomNum="'+str(roomNum)+'" and building="'+str(build)+'" and Users.gId=Rooms.gId;'))
	for row in query:
		x = dict(firstName=row.firstName, lastName=row.lastName, userID=row.userName)
		user_List.append(x)
	return jsonify(roomOccupants=user_List)


@app.route('/getRoomOccupantsDict', methods=['POST'])
def getRoomOccupantsDict():
	req = request.get_json()
	roomDict = {}
	build = req["buildingName"]
	roomList = req["roomArray"]
	for room in roomList:
		availability = None
		capacity = None
		personList = []
		check = db.engine.execute(text('select gId from Rooms where roomNum="'+str(room)+ '"and building="'+str(build)+'";'))
		if check == None:
			roomDict[room] = []

		else:
			query = db.engine.execute(text('select firstName, isTaken, lastName, userName from Rooms, Users where Rooms.gId = Users.gId and roomNum ="' +str(room)+ '"and building="'+str(build)+'";'))
			query2 = db.engine.execute(text('select isTaken, capacity from Rooms where roomNum ="' +str(room)+ '"and building="'+str(build)+'";'))

			for row in query2:
				availability = row.isTaken
				capacity = row.capacity
			for row in query:
				x = dict(firstName=row.firstName, lastName=row.lastName, userID=row.userName)
				personList.append(x)
			roomDict[room] = dict(roomOccupants=personList, isTaken=availability, capacity=capacity)
	return jsonify(occupantsDict=roomDict)


####################################
##       Registration Time        ##
####################################


@app.route('/getRegistrationTime', methods=['POST'])
def getRegistrationTime():
	req = request.get_json()
	groupID = req['groupID']
	query = db.engine.execute(text('select drawDate from Groups where groupId="'+str(groupID)+'";'))
	for row in query:
		regTime = row.drawDate
	return jsonify(registrationTime=regTime)


####################################
##        Admin Functions         ##
####################################


@app.route('/switchRoomAvailability', methods=['POST'])
def switchRoomAvailablility():
	req = request.get_json()
	try:
		build = req["buildingName"]
		roomNum = req['roomNumber']
		query = db.engine.execute(text('select isTaken from Rooms where roomNum="'+str(roomNum)+'" and building="'+str(build)+'";'))
		for row in query:
			isTaken = row.isTaken
			isTaken = isTaken^1
		db.engine.execute(text('update Rooms set isTaken="'+str(isTaken)+'" where roomNum="'+str(roomNum)+'" and building="'+str(build)+'";'))
		return(jsonify(wasSuccessful=True, isTaken=isTaken))

	except:
		return(jsonify(wasSuccessful=False))

# def manualyAssignRoom():
# 	req = request.get_json()
# 	build = req['buildingName']
# 	roomNum = req['roomNumber']
# 	userList = req['userList']
# 	gId = None
# 	for user in userList:
# 		if gId == None
# 			check = db.engine.execute(text('select gId from Users where userName="'+str(user)+';'))
# 			for row in check:
# 				use = row.gId

# 		if gId == None and usergId == None:
# 			gId 


####################################
##         Authentication         ##
####################################


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
    #     credentials.revoke(httplib2.Http())
    #     session.pop('google_token', None)
    #     return redirect(url_for('index'))
    # print("======================")
    return redirect('/')


@app.route('/getUserLogin', methods=['GET'])
def getUserLogin():
	role = None
	if 'google_token' in session:
		me = google.get('userinfo')
		if 'email' in me.data:
			email = me.data['email']
			un = email.split('@')
			userName = un[0]
			query = db.engine.execute(text('select role from Users where userName="'+ str(userName)+'";'))
			for row in query:
				role = row.role

			return jsonify({"userInfo": me.data, "role": role})
	return jsonify({"userInfo": "", "role": role})

@google.tokengetter
def get_google_oauth_token():
    return session.get('google_token')
