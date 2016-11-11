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
INSERT INTO Users (userName, firstName, lastName, credits, roomDrawNum) VALUES ("test01","Testy","McTest", 1, 4);
INSERT INTO Users (userName, firstName, lastName, credits, roomDrawNum) VALUES ("test02","Testy","Test", 2, 5);
INSERT INTO Users (userName, firstName, lastName, credits, roomDrawNum) VALUES ("test03","Testy","MacTest", 3, 6);
INSERT INTO Users (userName, firstName, lastName, credits, roomDrawNum) VALUES ("test04","Testy","Testerson", 4, 7);
INSERT INTO Users (userName, firstName, lastName, credits, roomDrawNum) VALUES ("test05","Testy","Testus", 5, 8);
INSERT INTO Users (userName, firstName, lastName, credits, roomDrawNum) VALUES ("test06","Testy","Tester", 6, 9);
INSERT INTO Users (userName, firstName, lastName, credits, roomDrawNum) VALUES ("test07","Testy","Testin", 7, 10);
INSERT INTO Users (userName, firstName, lastName, credits, roomDrawNum) VALUES ("test08","Testy","Testenheimer", 8, 11);
INSERT INTO Users (userName, firstName, lastName, credits, roomDrawNum) VALUES ("test09","Testy","Testbuscus", 9, 12);
INSERT INTO Users (userName, firstName, lastName, credits, roomDrawNum) VALUES ("test10","Testy","Testicule", 10, 13);
INSERT INTO Users (userName, firstName, lastName, credits, roomDrawNum) VALUES ("test11","Testy","McT", 11, 14);
INSERT INTO Users (userName, firstName, lastName, credits, roomDrawNum) VALUES ("test12","Testy","Testeese", 12, 15);
INSERT INTO Users (userName, firstName, lastName, credits, roomDrawNum) VALUES ("test13","Testy","Testington", 13, 16);

INSERT INTO Buildings(name, numFloors, hasBasement) VALUES("Miller", 9, true);
INSERT INTO Buildings(name, numFloors, hasBasement) VALUES("Dieseth", 9, true);
INSERT INTO Buildings(name, numFloors) VALUES("Larsen",3);
INSERT INTO Buildings(name, numFloors) VALUES("Olson",3);

INSERT INTO Rooms(roomNum, building, capacity) VALUES(302, "Olson", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(302, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(302, "Dieseth", 2);
