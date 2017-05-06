#######################################################
#################     DESCRIPTION    ##################
#######################################################
#                                                     #
#    This section will store api calls between the    #
#                 front end and database              #
#                                                     #
#######################################################

import os
import datetime
import time
import json
import datetime
from wsgiref.handlers import format_date_time

from flask import Flask, request, Response, session
from flask import render_template, url_for, redirect, send_from_directory
from flask import send_file, make_response, abort, jsonify

import flask_excel as excel


from sqlalchemy import text, func

from ProjectApp import app, db, models, google


from apscheduler.schedulers.background import BackgroundScheduler
sched = BackgroundScheduler()
sched.start()

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
##         Authentication         ##
####################################

@app.route('/login')
def login():
    return google.authorize(callback=url_for('authorized', _external=True))

@app.route('/logout')
def logout():
    session.pop('google_token', None)
    return redirect('/')

# ensures our app works with HTML5 mode for angularjs
@app.route('/groupInfo')
@app.route('/adminPanel')
@app.route('/importExport')
def html5ModeFix():
    return app.send_static_file('index.html')

@app.route('/login/authorized')
def authorized():
    resp = google.authorized_response()
    if resp is None:
        return 'Access denied: reason=%s error=%s' % (
            request.args['error_reason'],
            request.args['error_description']
        )

    session['google_token'] = (resp['access_token'], '')
    me = google.get('userinfo')
    if me.data['email'].split('@')[-1] != 'luther.edu':
        # credentials.revoke(httplib2.Http())
		# TODO: Make this a nice HTML page
        session.pop('google_token', None)
        return 'Access denied: reason=%s error=%s' % (
			"Invalid User",
			"This is not a valid Luther account"
		)

	# User is authorized only if they exist in our database
    user = me.data['email'].split('@')[0]
    query = db.engine.execute(text('select * from Users where userName="' + str(user) + '";'))
    if query.rowcount < 1:
	    # TODO: Make this a nice HTML page
	    # credentials.revoke(httplib2.Http())
	    session.pop('google_token', None)

	    return 'Access denied: reason=%s error=%s' % (
			"Invalid User",
			"You are not in Res Life's records"
		)

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


####################################
##         Group Requests         ##
####################################

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

####################################
##       Group Information        ##
####################################

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

	query = db.engine.execute(text('select firstName, lastName, userName, isPending, sex from Users where ' + ' gId="'+str(group_id) +'";'))

	for row in query:
		if row.isPending == 0:
			user_List.append(dict(FirstName=row.firstName, LastName=row.lastName, userID=row.userName, sex=row.sex))
		elif row.userName != uID:
			pending_user_List.append(dict(FirstName=row.firstName, LastName=row.lastName, userID=row.userName, sex=row.sex))

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


@app.route('/getAllGroupUsers', methods=['GET'])
def getAllGroupUsers():
	user_List = []
	query = db.engine.execute(text('select firstName, lastName, role, userName, isPending, gId from Users;'))
	for row in query:
		if row.role == 'admin':
			continue
		if row.gId != None and row.isPending == 0:
			user_List.append(dict(firstName=row.firstName, lastName=row.lastName, userID=row.userName))
	return jsonify(allGroupUsers=user_List)

@app.route('/getAllUsers', methods=['GET'])
def getAllUsers():
	user_List = []
	query = db.engine.execute(text('select firstName, lastName, role, userName from Users;'))
	for row in query:
		if row.role == 'admin':
			continue
		user_List.append(dict(firstName=row.firstName, lastName=row.lastName, userID=row.userName))
	return jsonify(allUsers=user_List)

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
	query2 = db.engine.execute(text('select drawDate from Groups where groupId="'+str(groupID)+'" and groupId>5;'))
	for row in query:
		if row.isTaken == 1:
			return jsonify(wasSuccessful=False, reason='taken')
	for row in query2:
		if row.drawDate is None or row.drawDate > now:
			return jsonify(wasSuccessful=False, reason='time')
	db.engine.execute(text('update Rooms set isTaken=1, gId="'+str(groupID)+'" where roomNum="'+str(roomNum)+'" and building="'+str(build)+'";'))
	db.engine.execute(text('update Groups set isRegistered=1 where groupId="'+str(groupID)+'";'))
	return jsonify(wasSuccessful=True)

@app.route('/getRoomOccupantsDict', methods=['POST'])
def getRoomOccupantsDict():
	req = request.get_json()
	roomDict = {}
	build = req["buildingName"]
	roomList = req["roomArray"]
	isAdmin = req["isAdmin"]
	if isAdmin:
		# If this is being used in the admin panel, we need to check if the selected room is valid first
		query = db.engine.execute(text('select available from Rooms where roomNum="' + str(roomList[0]) + '" and building="' + str(build) + '";'))
		if query.rowcount < 1:
			return jsonify(wasSuccessful=False)
	for room in roomList:
		capacity = None
		personList = []
		check = db.engine.execute(text('select gId from Rooms where roomNum="'+str(room)+ '"and building="'+str(build)+'";'))
		availability = 0
		isTaken = 0
		gender = ""
		if check == None:
			roomDict[room] = []

		else:
			query = db.engine.execute(text('select firstName, lastName, userName, isPending from Rooms, Users where Rooms.gId = Users.gId and roomNum ="' +str(room)+ '"and building="'+str(build)+'";'))
			query2 = db.engine.execute(text('select isTaken, available, capacity, sex from Rooms where roomNum ="' +str(room)+ '"and building="'+str(build)+'";'))
			# BUG: if availability or isTaken are undefined, this block fails on line 320

			for row in query2:
				availability = row.available
				isTaken = row.isTaken
				capacity = row.capacity
				gender = row.sex

			for row in query:
				isPending = row.isPending
				if isPending == False:
					x = dict(firstName=row.firstName, lastName=row.lastName, userID=row.userName)
					personList.append(x)

			if personList == []:
				db.engine.execute(text('update Rooms set isTaken=0, gId=NULL where roomNum="'+str(room)+'" and building="'+str(build)+'";'))


			availability = availability | isTaken
			roomDict[room] = dict(roomOccupants=personList, isTaken=availability, capacity=capacity, gender=gender)

	return jsonify(wasSuccessful=True, occupantsDict=roomDict)

@app.route('/getAllRoomNumbers', methods=['GET'])
def getAllRooms():
	allRoomsDict = {}
	query= db.engine.execute(text('select name from Buildings;'))
	for row in query:
		build = row.name
		allRoomsDict[build] = []

	query2 = db.engine.execute(text('select roomNum, building from Rooms;'))
	for row in query2:
		buildName = row.building
		roomNum = row.roomNum
		allRoomsDict[buildName].append(roomNum)

	return(jsonify(allRoomsDict=allRoomsDict))


####################################
##    Registration Time/Status    ##
####################################


@app.route('/getRegistrationStatus', methods=['POST'])
def getRegistrationStatus():
	req = request.get_json()
	groupID = req['groupID']
	query = db.engine.execute(text('select drawDate, isRegistered from Groups where groupId="'+str(groupID)+'";'))
	query2 = db.engine.execute(text('select roomNum, building from Rooms where gId="'+str(groupID)+'";'))
	regTime = isRegistered = roomNum = buildingName = None
	for row in query:
		regTime = row.drawDate
		isRegistered = row.isRegistered
	for row in query2:
		roomNum = row.roomNum
		buildingName = row.building
	return jsonify(registrationTime=regTime, hasRegistered=isRegistered, roomNumber=roomNum, buildingName=buildingName)

def assignRoomDrawTimes():
	dlp = fetchDeadlinesPreferences(True)
	query = db.engine.execute(text('select gId, AVG(roomDrawNum) from Users where gId group by gId order by AVG(roomDrawNum) DESC;'))
	dt = dlp['firstRegistrationDate']
	startTime= dlp['startTime']
	inc = dlp['timeInterval']
	for row in query:
		gId = row.gId
		if dt > dlp['lastRegistrationDate']:
			dlp['lastRegistrationDate']

		db.engine.execute(text('update Groups set drawDate="'+str(dt)+'" where groupID="'+str(gId)+'";'))

		if dt == dlp['lastRegistrationDate']:
			dlp['lastRegistrationDate']

		elif dt.weekday() == 4 and dt.time() >= dlp['endTime'].time():
			dt = dt.combine(dt.date(), startTime.time())
			dt = dt + datetime.timedelta(days=3)

		elif dt.time() >= dlp['endTime'].time():
			dt = dt.combine(dt.date(), startTime.time())
			dt = dt + datetime.timedelta(days=1)

		else:
			dt = dt + datetime.timedelta(minutes=inc)


####################################
##        Admin Functions         ##
####################################


@app.route('/switchRoomAvailability', methods=['POST'])
def switchRoomAvailablility():
	req = request.get_json()
	try:
		build = req["buildingName"].lower()
		roomNum = req['roomNumber']
		query = db.engine.execute(text('select available from Rooms where roomNum='+str(roomNum)+' and building="'+str(build) +'";'))
		for row in query:
			available = row.available
			available = available^1
		db.engine.execute(text('update Rooms set available="'+str(available)+'" where roomNum='+str(roomNum)+' and building="'+str(build)+'";'))
		return(jsonify(wasSuccessful=True, isTaken=available))

	except:
		return(jsonify(wasSuccessful=False))


@app.route('/manuallyAssignStudentsToRoom', methods=['POST'])
def manuallyAssignRoom():
	req = request.get_json()
	build = req['buildingName']
	roomNum = req['roomNumber']
	userList = req['userList']
	# First we need to check if the room number is valid 
	query = db.engine.execute(text('select available from Rooms where roomNum="' + str(roomNum) + '" and building="' + str(build) + '";'))
	if query.rowcount < 1:
		return jsonify(wasSuccessful=False)
	gId = None
	check = db.engine.execute(text('select gId from Rooms where roomNum="'+str(roomNum)+'" and building="'+str(build)+'";'))
	if check == None:
		return(jsonify(wasSuccessful=False, reason="RB"))
	for row in check:
		gId = row.gId

	if gId == None:
		db.engine.execute(text('INSERT INTO Groups() VALUES();'))
		# query = db.engine.execute(text('SELECT LAST_INSERT_ID();'))
		query = db.engine.execute('select MAX(groupID) from Groups;')
		for row in query:
		 	gId = row[0]

	for user in userList:
		db.engine.execute(text('update Users set isPending=0, gId="'+str(gId)+'" where userName="'+str(user)+'";'))

	db.engine.execute(text('update Rooms set isTaken=1, gId="'+str(gId)+'" where roomNum="'+str(roomNum)+'" and building="'+str(build)+'";'))
	db.engine.execute(text('update Groups set isRegistered=1 where groupId="'+str(gId)+'";'))
	return(jsonify(wasSuccessful=True))


@app.route('/manuallyRemoveStudentsFromRoom', methods=['POST'])
def manuallyRemoveFromRoom():
	try:
		req = request.get_json()
		build = req['buildingName']
		roomNum = req['roomNumber']
		userList = req['userList']
		personList = []

		for person in userList:
			db.engine.execute(text('update Users set gId=NULL where userName="'+str(person)+'";'))


		query = db.engine.execute(text('select firstName, lastName, userName from Rooms, Users where Rooms.gId = Users.gId and roomNum ="' +str(roomNum)+ '"and building="'+str(build)+'";'))
		for row in query:
			x = dict(firstName=row.firstName, lastName=row.lastName, userID=row.userName)
			personList.append(x)

		if personList == []:
			db.engine.execute(text('update Rooms set isTaken=0, gId=NULL where roomNum="'+str(roomNum)+'" and building="'+str(build)+'";'))

		return(jsonify(wasSuccessful=True))

	except:
		return(jsonify(wasSuccessful=False))


####################################
##             AutoReg            ##
####################################

@app.route('/getAutoRegPref', methods=['POST'])
def getAutoRegPref():
	req = request.get_json()
	gId = req["groupID"]
	roomList = []
	query = db.engine.execute(text('select enabled, building, defaultPref, roomNum, prefNum from Preferences where Preferences.gId = "'+str(gId)+'" order by prefNum;'))
	for row in query:
		defPref = row.defaultPref
		if row.enabled == False:
			return jsonify(autoRegEnabled=False)


		roomList.append(dict(buildingName=row.building, defaultPref=defPref, roomNumber=row.roomNum))

	return jsonify(autoRegEnabled=True,autoRegPref=roomList)


def autoReg():
	query = db.engine.execute(text('select * from Groups where drawDate and groupID>5;'))
	for row in query:
		isReg = row.isRegistered
		gId =row.groupId
		drawDate = row.drawDate
		if isReg == True:
			continue
		query2 = db.engine.execute(text('select enabled, building, defaultPref, roomNum from Preferences where Preferences.gId = "'+str(gId)+'";'))
		for row2 in query2:
			args = []
			if row2.enabled == False:
				break
			args.append(gId)
			args.append(row2.building)
			args.append(row2.roomNum)
			sched.add_date_job(registerForRoom, drawDate, args)

def registerForRoom(args):
	gId = args[0]
	build = args[1]
	room = args[2]
	query = db.engine.execute(text('select isTaken, isRegistered from Rooms, Groups where groupId="'+str(gId)+'" and roomNum="'+str(roomNum)+'";'))
	db.engine.execute(text('update Rooms set isTaken=1, gId="'+str(gId)+'" where roomNum="'+str(roomNum)+'" and building="'+str(build)+'";'))

@app.route('/saveAutoRegPref', methods=['POST'])
def saveAutoRegPref():
	req = request.get_json()
	gId = req["groupID"]
	enabled = req["autoRegEnabled"]
	prefs = req["autoRegPref"]
	# before we do anything, we need to validate the room selections
	prefStatusArr = []
	valid = True
	for pref in prefs:
		if pref['defaultPref']:
			continue
		building = pref['buildingName']
		num = pref['roomNumber']
		query = db.engine.execute(text('select roomNum from Rooms where building="' + str(building) + '" and roomNum="' + str(num) + '";'))
		if query.rowcount < 1:
			prefStatusArr.append(False)
			valid = False
		else:
			prefStatusArr.append(True)
	if not valid:
		return(jsonify(wasSuccessful=False, prefStatusArr=prefStatusArr))
	db.engine.execute(text('DELETE from Preferences where gId='+str(gId)+';'))
	inc = 0
	for dic in prefs:
		inc += 1
		building = dic['buildingName']
		num = dic['roomNumber']
		isPref = dic['defaultPref']

		db.engine.execute(text('INSERT INTO Preferences(enabled, roomNum, building, defaultPref, gId, prefNum) VALUES('+str(enabled)+', '+str(num)+', "'+str(building)+'", '+str(isPref)+', '+str(gId)+', '+str(inc)+');'))

	return(jsonify(wasSuccessful=True))

####################################
##        Group Deadlines         ##
####################################

@app.route("/uploadStudentRecords", methods=['POST'])
def uploadStudentRecords():
    print("----------\n\n", request.get_array(field_name='file'), "\n\n---------------")
    return redirect("/importExport")

@app.route("/uploadRoomRecords", methods=['POST'])
def uploadRoomRecords():
    print("----------\n\n", request.get_array(field_name='file'), "\n\n---------------")
    return redirect("/importExport")


@app.route('/saveDeadlinePreferences', methods=['POST'])
def saveDeadlinePreferences():
	req = request.get_json()


	gd = req['groupsDeadline']
	gdt = datetime.datetime(gd['year'], gd['month'], gd['day'])
	interval = req['timeInterval']

	st = req['startTime']
	stt = datetime.datetime(1111, 1, 1, st['hour'], st['minute'])

	et = req['endTime']
	ett = datetime.datetime(1111, 1, 1, et['hour'], et['minute'])

	frd = req['firstRegistrationDate']
	frdt = datetime.datetime(frd['year'], frd['month'], frd['day'], st['hour'], st['minute'])

	lrd = req['lastRegistrationDate']
	lrdt = datetime.datetime(lrd['year'], lrd['month'], lrd['day'], et['hour'], et['minute'])


	db.engine.execute(text('update Groups set drawDate="'+str(gdt)+'", timeInterval="'+str(interval)+'" where groupId=1;'))
	db.engine.execute(text('update Groups set drawDate="'+str(frdt)+'" where groupId=2;'))
	db.engine.execute(text('update Groups set drawDate="'+str(lrdt)+'" where groupId=3;'))
	db.engine.execute(text('update Groups set drawDate="'+str(stt)+'" where groupId=4;'))
	db.engine.execute(text('update Groups set drawDate="'+str(ett)+'" where groupId=5;'))

	return(jsonify(''))

@app.route('/fetchDeadlinesPreferences', methods=['GET'])
def fetchDeadlinesPreferences(fromPy=False):
	query = db.engine.execute(text('select * from Groups where groupId<6;'))
	for row in query:
		groupId = row.groupId
		if groupId == 1:
			interval = row.timeInterval
			gd = row.drawDate
		if groupId == 2:
			frd = row.drawDate
		if groupId == 3:
			lrd = row.drawDate
		if groupId == 4:
			st = row.drawDate
		if groupId == 5:
			et = row.drawDate

	deadlinePrefs = dict(groupsDeadline=gd, firstRegistrationDate=frd,lastRegistrationDate=lrd,startTime=st, endTime=et, timeInterval=interval)
	if fromPy:
		return deadlinePrefs

	return jsonify(deadlinePrefs=deadlinePrefs)
