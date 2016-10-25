#######################################################
#################     DESCRIPTION    ##################
#######################################################
#                                                     #
#  This section will populate the databse tables      #
#             with dummy  information                 #
#                                                     #
#######################################################

USE projectdb

INSERT INTO Groups() VALUES ();
INSERT INTO Groups() VALUES();

INSERT INTO Users (userName, firstName, lastName, gId, credits, roomDrawNum) VALUES ("smitze01","Zechariah","Smith", 1, 65, 3);
INSERT INTO Users (userName, firstName, lastName, gId, credits, roomDrawNum) VALUES ("mayeis01","Isaiah","Mayerchak", 2, 120, 1);
INSERT INTO Users (userName, firstName, lastName, gId, credits, roomDrawNum) VALUES ("saudih01","Ihab","Saud",2, 85, 2);

INSERT INTO Buildings(name, numFloors, hasBasement) VALUES("Miller", 9, true);
INSERT INTO Buildings(name, numFloors, hasBasement) VALUES("Dieseth", 9, true);
INSERT INTO Buildings(name, numFloors) VALUES("Larsen",3);
INSERT INTO Buildings(name, numFloors) VALUES("Olson",3);

INSERT INTO Rooms(roomNum, building, capacity) VALUES(302, "Olson", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(302, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(302, "Dieseth", 2);
