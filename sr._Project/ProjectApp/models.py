#######################################################
#################     DESCRIPTION    ##################
#######################################################
#                                                     #
# This section contains the models for all the tables # 
#    in the database in the form of python classes    #
#                                                     #
#######################################################


from ProjectApp import db
from sqlalchemy.sql import text, func

from sqlalchemy.dialects.mysql import \
		BIGINT, BINARY, BIT, BLOB, BOOLEAN, CHAR, DATE, \
		DATETIME, DECIMAL, DECIMAL, DOUBLE, ENUM, FLOAT, INTEGER, \
		LONGBLOB, LONGTEXT, MEDIUMBLOB, MEDIUMINT, MEDIUMTEXT, NCHAR, \
		NUMERIC, NVARCHAR, REAL, SET, SMALLINT, TEXT, TIME, TIMESTAMP, \
		TINYBLOB, TINYINT, TINYTEXT, VARBINARY, VARCHAR, YEAR



class Groups(db.Model):
	__tablename__ = 'Groups'
	groupId = db.Column(INTEGER, nullable=False, primary_key=True, autoincrement=True)
	isRegistered = db.Column(BOOLEAN, nullable=False, server_default=('0'))
	drawDate = db.Column(DATETIME)
	timeInterval = db.Column(INTEGER)

	def __repr__(self):
		# formats/manually creates the JSON object
		return {c.name: getattr(self, c.name) for c in self.__table__.columns}

class Users(db.Model):
	__tablename__ = 'Users'
	studentId = db.Column(INTEGER, nullable=False)
	userName = db.Column(VARCHAR(30), nullable=False, primary_key=True)
	firstName = db.Column(VARCHAR(30), nullable=False)
	lastName = db.Column(VARCHAR(30), nullable=False)
	role = db.Column(VARCHAR(30), nullable=False)
	gId = db.Column(INTEGER, db.ForeignKey(Groups.groupId))
	sex = db.Column(VARCHAR(30), nullable=False)
	roomDrawNum = db.Column(INTEGER, nullable=False)
	isPending = db.Column(BOOLEAN, nullable=False, server_default=('0'))

	def __repr__(self):
		# formats/manually creates the JSON object
		return {c.name: getattr(self, c.name) for c in self.__table__.columns}

class Buildings(db.Model):
	__tablename__ = 'Buildings'
	name = db.Column(VARCHAR(30), nullable=False, primary_key=True)
	numFloors = db.Column(INTEGER, nullable=False)
	hasBasement = db.Column(BOOLEAN, nullable=False, server_default=('0'))

	def __repr__(self):
		# formats/manually creates the JSON object
		return {c.name: getattr(self, c.name) for c in self.__table__.columns}

class Rooms(db.Model):
	__tablename__ = 'Rooms'
	roomNum = db.Column(INTEGER, nullable=False, primary_key=True)
	building = db.Column(VARCHAR(30), db.ForeignKey(Buildings.name), nullable=False, primary_key=True)
	capacity = db.Column(INTEGER, nullable=False)
	sex = db.Column(VARCHAR(30), nullable=False)
	gId = db.Column(INTEGER, db.ForeignKey(Groups.groupId))
	isTaken = db.Column(BOOLEAN, nullable=False, server_default=('0'))
	available = db.Column(BOOLEAN, nullable=False, server_default=('0'))

	def __repr__(self):
		# formats/manually creates the JSON object
		return {c.name: getattr(self, c.name) for c in self.__table__.columns}

class Preferences(db.Model):
	__tablename__ = 'Preferences'
	enabled = db.Column(BOOLEAN, nullable=False, server_default=('0'))
	defaultPref = db.Column(BOOLEAN, nullable=False, server_default=('0'))
	roomNum = db.Column(INTEGER, nullable=False, primary_key=True)
	building = db.Column(VARCHAR(30), db.ForeignKey(Buildings.name), nullable=False, primary_key=True)
	gId = db.Column(INTEGER, db.ForeignKey(Groups.groupId), nullable=False, primary_key=True)
	prefNum = db.Column(INTEGER, nullable=False)

	def __repr__(self):
		# formats/manually creates the JSON object
		return {c.name: getattr(self, c.name) for c in self.__table__.columns}

