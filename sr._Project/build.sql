#######################################################
#################     DESCRIPTION    ##################
#######################################################
# This code will check to see if the mysql database   #
#     and user exist and delete them if they do       #
#                                                     #
#    next, it will create the database and tables     # 
#                                                     #
#      finaly, it will call populateTables.sql        #
#         to insert data into the database            #
#######################################################


#######################################################
#################	  INSTRUCTIONS	 ####################
#######################################################
#      from within directory containing build.sql     # 
#        and populateTables.sql enter command         #
#                                                     #
#                 mysql -u root -p                    #
#      (-u defines user and -p specifies password)    #
#                                                     #
#    now while in in mysql> run build.sql by typing   #
#                  source build.sql                   #
#######################################################


####################################
##   Deleting Database and User   ##
####################################

DROP DATABASE IF EXISTS projectdb;

DROP USER master;

####################################
##   Creating Database and User   ##
####################################

CREATE USER master IDENTIFIED BY 'qwerty'; # creating user master with password qwerty

GRANT ALL PRIVILEGES ON *.* TO master;
FLUSH PRIVILEGES;

CREATE DATABASE projectdb;
USE projectdb;

####################################
##        Creating Tables         ##
####################################


CREATE TABLE Groups (
  groupId INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  isRegistered BOOLEAN NOT NULL DEFAULT false,
  drawDate DATETIME,
  timeInterval INT)
ENGINE = InnoDB;

CREATE TABLE Users (
  userName VARCHAR(30) NOT NULL PRIMARY KEY,
  firstName VARCHAR(30) NOT NULL,
  lastName VARCHAR(30) NOT NULL,
  gId INT,
  sex VARCHAR(30) NOT NULL,
  role VARCHAR(20) NOT NULL,
  credits INT NOT NULL,
  roomDrawNum INT NOT NULL,
  isPending BOOLEAN NOT NULL DEFAULT false,
    FOREIGN KEY (gId)
    REFERENCES Groups (groupId)
    ON DELETE NO ACTION            # can be used to specify action on foreign key deletion
    ON UPDATE NO ACTION)           # can be used to specify action on updating of foreign key
ENGINE = InnoDB;

CREATE TABLE Buildings (
  name VARCHAR(30) NOT NULL PRIMARY KEY,
  numFloors INT NOT NULL, 
  hasBasement BOOLEAN NOT NULL DEFAULT false)
ENGINE = InnoDB;

CREATE TABLE Rooms (
  roomNum INT NOT NULL,
  building VARCHAR(30) NOT NULL,
  capacity INT NOT NULL,
  sex VARCHAR(30) NOT NULL,
  gId INT,
  isTaken BOOLEAN NOT NULL DEFAULT false,
  available BOOLEAN NOT NULL DEFAULT false,
  	PRIMARY KEY(roomNum,building),
    FOREIGN KEY (building)
    REFERENCES Buildings (name)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    FOREIGN KEY (gId)
    REFERENCES Groups (groupId)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE Preferences (
  enabled BOOLEAN NOT NULL DEFAULT false,
  defaultPref BOOLEAN NOT NULL DEFAULT false,
  roomNum INT NOT NULL,
  building VARCHAR(30) NOT NULL,
  gId INT NOT NULL,
  prefNum INT NOT NULL,
    PRIMARY KEY(roomNum,building,gId),
    FOREIGN KEY (building)
    REFERENCES Buildings (name)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    FOREIGN KEY (gId)
    REFERENCES Groups (groupId)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE VIEW groupsWithAverage AS
select groupID, isRegistered, drawDate, AVG(Users.roomDrawNum) groupRoomDraw from Users, Groups where Users.gId = Groups.groupId group by groupId;

####################################
##   Calling populateTables.sql   ##
####################################

source populateTables.sql;