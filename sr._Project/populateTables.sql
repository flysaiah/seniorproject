#######################################################
#################     DESCRIPTION    ##################
#######################################################
#                                                     #
#  This section will populate the databse tables      #
#             with dummy  information                 #
#                                                     #
#######################################################

USE projectdb

INSERT INTO Groups(drawDate) VALUES ('2016-03-04 18:00:00');
INSERT INTO Groups() VALUES();
INSERT INTO Groups() VALUES();
INSERT INTO Groups() VALUES();
INSERT INTO Groups() VALUES();
INSERT INTO Groups() VALUES();
INSERT INTO Groups() VALUES();
INSERT INTO Groups() VALUES();

INSERT INTO Users (userName, firstName, lastName, role, gId, credits, roomDrawNum) VALUES ("smitze01","Zechariah","Smith", "student", 1, 65, 3);
INSERT INTO Users (userName, firstName, lastName, role, gId, credits, roomDrawNum) VALUES ("mayeis01","Isaiah","Mayerchak", "admin", 1, 120, 1);
INSERT INTO Users (userName, firstName, lastName, role, credits, roomDrawNum) VALUES ("saudih01","Ihab","Saud", "admin", 85, 2);
INSERT INTO Users (userName, firstName, lastName, role, gId, credits, roomDrawNum, isPending) VALUES ("test01","Testy","McTest", "student", 1, 1, 4, true);
INSERT INTO Users (userName, firstName, lastName, role, gId, credits, roomDrawNum) VALUES ("test02","Testy","Test", "student", 3, 2, 5);
INSERT INTO Users (userName, firstName, lastName, role, gId, credits, roomDrawNum) VALUES ("test03","Testy","MacTest", "student", 3, 3, 6);
INSERT INTO Users (userName, firstName, lastName, role, gId, credits, roomDrawNum) VALUES ("test04","Testy","Testerson", "student", 4, 4, 7);
INSERT INTO Users (userName, firstName, lastName, role, gId, credits, roomDrawNum) VALUES ("test05","Testy","Testus", "student", 4, 5, 8);
INSERT INTO Users (userName, firstName, lastName, role, gId, credits, roomDrawNum) VALUES ("test06","Testy","Tester", "student", 8, 6, 9);
INSERT INTO Users (userName, firstName, lastName, role, credits, roomDrawNum) VALUES ("test07","Testy","Testin", "student", 7, 10);
INSERT INTO Users (userName, firstName, lastName, role, gId, credits, roomDrawNum) VALUES ("test08","Testy","Testenheimer", "student", 7, 8, 11);
INSERT INTO Users (userName, firstName, lastName, role, gId, credits, roomDrawNum) VALUES ("test09","Testy","Testbuscus", "student", 6, 9, 12);
INSERT INTO Users (userName, firstName, lastName, role, credits, roomDrawNum) VALUES ("test10","Testy","Testicule", "student", 10, 13);
INSERT INTO Users (userName, firstName, lastName, role, gId, credits, roomDrawNum) VALUES ("test11","Testy","McT", "student", 2, 11, 14);
INSERT INTO Users (userName, firstName, lastName, role, credits, roomDrawNum) VALUES ("test12","Testy","Testeese", "student", 12, 15);
INSERT INTO Users (userName, firstName, lastName, role, gId, credits, roomDrawNum) VALUES ("test13","Testy","Testington", "student", 5, 13, 16);

INSERT INTO Buildings(name, numFloors) VALUES("Miller", 8);
INSERT INTO Buildings(name, numFloors) VALUES("Dieseth", 8);
INSERT INTO Buildings(name, numFloors, hasBasement) VALUES("Larsen",3, true);
INSERT INTO Buildings(name, numFloors) VALUES("Olson",3);

INSERT INTO Rooms(roomNum, building, capacity) VALUES(302, "Olson", 2);


######################################################
#######################################################
##                                                   ##
##                Adding Miller's Rooms              ##
##                                                   ##
#######################################################
#######################################################

####################################
##        Miller Floor 1          ##
####################################
INSERT INTO Rooms(roomNum, building, capacity, isTaken, gId) VALUES(101, "Miller", 2, true, 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(102, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(103, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(104, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(105, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(106, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(107, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(108, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(109, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(110, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(112, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(113, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(114, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(115, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(116, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(117, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(118, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(119, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(120, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(121, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(122, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(123, "Miller", 2);

####################################
##        Miller Floor 2          ##
####################################
INSERT INTO Rooms(roomNum, building, capacity) VALUES(201, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(202, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(203, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(204, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(205, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(206, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(207, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(208, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(209, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(210, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(212, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(213, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(214, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(215, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(216, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(217, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(218, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(219, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(220, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(221, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(222, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(223, "Miller", 2);

####################################
##        Miller Floor 3          ##
####################################
INSERT INTO Rooms(roomNum, building, capacity) VALUES(301, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(302, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity, isTaken, gId) VALUES(303, "Miller", 2, true, 8);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(304, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(305, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity, isTaken, gId) VALUES(306, "Miller", 2, true, 6);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(307, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(308, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(309, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity, isTaken, gId) VALUES(310, "Miller", 2, true, 3);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(312, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(313, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(314, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(315, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity, isTaken, gId) VALUES(316, "Miller", 2, true, 4);
INSERT INTO Rooms(roomNum, building, capacity, isTaken, gId) VALUES(317, "Miller", 2, true, 5);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(318, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(319, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity, isTaken, gId) VALUES(320, "Miller", 2, true, 7);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(321, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(322, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(323, "Miller", 2);

####################################
##        Miller Floor 4          ##
####################################
INSERT INTO Rooms(roomNum, building, capacity) VALUES(401, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(402, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(403, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(404, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(405, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(406, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(407, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(408, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(409, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(410, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(412, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(413, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(414, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(415, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(416, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(417, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(418, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(419, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(420, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(421, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(422, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(423, "Miller", 2);

####################################
##        Miller Floor 5          ##
####################################
INSERT INTO Rooms(roomNum, building, capacity) VALUES(501, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(502, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(503, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(504, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(505, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(506, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(507, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(508, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(509, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(510, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(512, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(513, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(514, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(515, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(516, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(517, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(518, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(519, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(520, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(521, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(522, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(523, "Miller", 2);

####################################
##        Miller Floor 6          ##
####################################
INSERT INTO Rooms(roomNum, building, capacity) VALUES(601, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(602, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(603, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(604, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(605, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(606, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(607, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(608, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(609, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(610, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(612, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(613, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(614, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(615, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(616, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(617, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(618, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(619, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(620, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(621, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(622, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(623, "Miller", 2);

####################################
##        Miller Floor 7          ##
####################################
INSERT INTO Rooms(roomNum, building, capacity) VALUES(701, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(702, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(703, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(704, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(705, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(706, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(707, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(708, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(709, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(710, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(712, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(713, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(714, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(715, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(716, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(717, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(718, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(719, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(720, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(721, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(722, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(723, "Miller", 2);

####################################
##        Miller Floor 8          ##
####################################
INSERT INTO Rooms(roomNum, building, capacity) VALUES(801, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(802, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(803, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(804, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(805, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(806, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(807, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(808, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(809, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(810, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(812, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(813, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(814, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(815, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(816, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(817, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(818, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(819, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(820, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(821, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(822, "Miller", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(823, "Miller", 2);


#######################################################
#######################################################
##                                                   ##
##                Adding Dieseth's Rooms             ##
##                                                   ##
#######################################################
#######################################################

####################################
##        Dieseth Floor 1          ##
####################################
INSERT INTO Rooms(roomNum, building, capacity) VALUES(101, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(102, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(103, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(104, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(105, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(106, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(107, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(108, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(109, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(110, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(112, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(111, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(114, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(115, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(116, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(117, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(118, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(119, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(120, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(121, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(122, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(123, "Dieseth", 2);

####################################
##        Dieseth Floor 2          ##
####################################
INSERT INTO Rooms(roomNum, building, capacity) VALUES(201, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(202, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(203, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(204, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(205, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(206, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(207, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(208, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(209, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(210, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(212, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(211, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(214, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(215, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(216, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(217, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(218, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(219, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(220, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(221, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(222, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(223, "Dieseth", 2);

####################################
##        Dieseth Floor 3          ##
####################################
INSERT INTO Rooms(roomNum, building, capacity) VALUES(301, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(302, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(303, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(304, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(305, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(306, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(307, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(308, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(309, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(310, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(312, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(311, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(314, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(315, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(316, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(317, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(318, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(319, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(320, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(321, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(322, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(323, "Dieseth", 2);

####################################
##        Dieseth Floor 4          ##
####################################
INSERT INTO Rooms(roomNum, building, capacity) VALUES(401, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(402, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(403, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(404, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(405, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(406, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(407, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(408, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(409, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(410, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(412, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(411, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(414, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(415, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(416, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(417, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(418, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(419, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(420, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(421, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(422, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(423, "Dieseth", 2);

####################################
##        Dieseth Floor 5          ##
####################################
INSERT INTO Rooms(roomNum, building, capacity) VALUES(501, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(502, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(503, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(504, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(505, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(506, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(507, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(508, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(509, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(510, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(512, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(511, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(514, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(515, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(516, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(517, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(518, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(519, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(520, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(521, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(522, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(523, "Dieseth", 2);

####################################
##        Dieseth Floor 6          ##
####################################
INSERT INTO Rooms(roomNum, building, capacity) VALUES(601, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(602, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(603, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(604, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(605, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(606, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(607, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(608, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(609, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(610, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(612, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(611, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(614, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(615, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(616, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(617, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(618, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(619, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(620, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(621, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(622, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(623, "Dieseth", 2);

####################################
##        Dieseth Floor 7          ##
####################################
INSERT INTO Rooms(roomNum, building, capacity) VALUES(701, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(702, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(703, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(704, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(705, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(706, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(707, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(708, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(709, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(710, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(712, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(711, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(714, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(715, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(716, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(717, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(718, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(719, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(720, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(721, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(722, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(723, "Dieseth", 2);

####################################
##        Dieseth Floor 8          ##
####################################
INSERT INTO Rooms(roomNum, building, capacity) VALUES(801, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(802, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(803, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(804, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(805, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(806, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(807, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(808, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(809, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(810, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(812, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(811, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(814, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(815, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(816, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(817, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(818, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(819, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(820, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(821, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(822, "Dieseth", 2);
INSERT INTO Rooms(roomNum, building, capacity) VALUES(823, "Dieseth", 2);


####################################
##        Preference Test         ##
####################################

INSERT INTO Preferences(enabled, roomNum, building, gId, prefNum) VALUES(true, 101, "Miller", 1, 1);
INSERT INTO Preferences(enabled, roomNum, building, gId, prefNum) VALUES(true, 102, "Miller", 1, 2);
INSERT INTO Preferences(enabled, roomNum, building, gId, prefNum) VALUES(true, 103, "Miller", 1, 3);
INSERT INTO Preferences(enabled, roomNum, building, gId, prefNum) VALUES(true, 104, "Miller", 1, 4);
