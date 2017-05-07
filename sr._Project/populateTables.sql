#######################################################
#################     DESCRIPTION    ##################
#######################################################
#                                                     #
#  This section will populate the databse tables      #
#             with dummy  information                 #
#                                                     #
#######################################################

USE projectdb

########################################
## creatiing Groups for users to join ##
########################################

# The first 5 groups are reserved for deadline preferences
INSERT INTO Groups(drawDate,timeInterval) VALUES('2017-02-04 18:00:00', 5); # stores group deadline and interval between available room draw times
INSERT INTO Groups(drawDate) VALUES('2017-03-04 18:00:00'); # stores the starting registration date
INSERT INTO Groups(drawDate) VALUES('2017-05-15 18:00:00'); # stores the final registration date
INSERT INTO Groups(drawDate) VALUES('1111-11-11 18:00:00'); # stores start time
INSERT INTO Groups(drawDate) VALUES('1111-11-11 22:00:00'); # stores end time


# Creating Test Groups for test users
INSERT INTO Groups(drawDate) VALUES ('2017-05-03 06:00:00');
INSERT INTO Groups() VALUES();
INSERT INTO Groups() VALUES();
INSERT INTO Groups() VALUES();
INSERT INTO Groups() VALUES();
INSERT INTO Groups() VALUES();
INSERT INTO Groups() VALUES();
INSERT INTO Groups() VALUES();

########################################
##        creatiing Test Users        ##
########################################
INSERT INTO Users (userName, firstName, lastName, role, gId, sex, credits, roomDrawNum) VALUES ("smitze01","Zechariah","Smith", "student", 6, "M", 65, 20);
INSERT INTO Users (userName, firstName, lastName, role, gId, sex, credits, roomDrawNum) VALUES ("mayeis01","Isaiah","Mayerchak", "student", 6, "M", 120, 1);
INSERT INTO Users (userName, firstName, lastName, role, sex, credits, roomDrawNum) VALUES ("saudih01","Ihab","Saud", "admin", "M", 85, 2);
INSERT INTO Users (userName, firstName, lastName, role, gId, sex, credits, roomDrawNum, isPending) VALUES ("test01","Adam","Larsen", "student", 7, "M", 1, 4, true);
INSERT INTO Users (userName, firstName, lastName, role, gId, sex, credits, roomDrawNum, isPending) VALUES ("vangca01","Carl","Van Gogh", "student", 6, "M", 2, 5, true);
INSERT INTO Users (userName, firstName, lastName, role, gId, sex, credits, roomDrawNum) VALUES ("yasiro01","Ro-Dog","Yasinovskyy", "student", 10, "M", 3, 6);
INSERT INTO Users (userName, firstName, lastName, role, gId, sex, credits, roomDrawNum) VALUES ("leeke01","Kent","Lee", "student", 8, "M", 4, 7);
INSERT INTO Users (userName, firstName, lastName, role, gId, sex, credits, roomDrawNum) VALUES ("millbr01","Brad","Miller", "student", 8, "M", 5, 8);
INSERT INTO Users (userName, firstName, lastName, role, gId, sex, credits, roomDrawNum) VALUES ("provto01","Tomi","Provo", "student", 12, "M", 6, 9);
INSERT INTO Users (userName, firstName, lastName, role, sex, credits, roomDrawNum) VALUES ("lariga02","Gary","Larimore", "student", "M", 7, 10);
INSERT INTO Users (userName, firstName, lastName, role, gId, sex, credits, roomDrawNum) VALUES ("test08","Elane","Cheadle", "student", 7, "F", 8, 11);
INSERT INTO Users (userName, firstName, lastName, role, gId, sex, credits, roomDrawNum, isPending) VALUES ("leja01","Jack","Le", "student", 6, "M", 9, 12, true);
INSERT INTO Users (userName, firstName, lastName, role, sex, credits, roomDrawNum) VALUES ("gileis03","Isaac","Giles", "student", "M", 10, 13);
INSERT INTO Users (userName, firstName, lastName, role, gId, sex, credits, roomDrawNum) VALUES ("webbfa02","Fatima","Webb", "student", 9, "F", 11, 14);
INSERT INTO Users (userName, firstName, lastName, role, sex, credits, roomDrawNum) VALUES ("pottka06","Kaitlynn","Potter", "student", "F", 12, 15);
INSERT INTO Users (userName, firstName, lastName, role, gId, sex, credits, roomDrawNum) VALUES ("bradda02","Daisy","Bradley", "student", 10, "F", 13, 16);

########################################
##        Inserting Building          ##
########################################
INSERT INTO Buildings(name, numFloors) VALUES("Miller", 8);
INSERT INTO Buildings(name, numFloors) VALUES("Dieseth", 8);
INSERT INTO Buildings(name, numFloors, hasBasement) VALUES("Larsen",3, true);
INSERT INTO Buildings(name, numFloors) VALUES("Olson",3);

INSERT INTO Rooms(roomNum, building, capacity, sex) VALUES(302, "Olson", 2, "M");


#######################################################
#######################################################
##                                                   ##
##                Adding Miller's Rooms              ##
##                                                   ##
#######################################################
#######################################################

####################################
##        Miller Floor 1          ##
####################################
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(101, "Miller", 2,"M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(102, "Miller", 2,"M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(103, "Miller", 2,"M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(104, "Miller", 2,"M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(105, "Miller", 2,"M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(106, "Miller", 2,"M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(107, "Miller", 2,"M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(108, "Miller", 2,"M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(109, "Miller", 2,"M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(110, "Miller", 2,"M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(111, "Miller", 2,"M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(112, "Miller", 2,"M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(113, "Miller", 2,"M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(114, "Miller", 2,"M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(115, "Miller", 2,"M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(116, "Miller", 2,"M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(117, "Miller", 2,"M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(118, "Miller", 2,"M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(119, "Miller", 2,"M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(120, "Miller", 2,"M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(121, "Miller", 2,"M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(122, "Miller", 2,"M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(123, "Miller", 2,"M");

####################################
##        Miller Floor 2          ##
####################################
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(201, "Miller", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(202, "Miller", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(203, "Miller", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(204, "Miller", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(205, "Miller", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(206, "Miller", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(207, "Miller", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(208, "Miller", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(209, "Miller", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(210, "Miller", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(211, "Miller", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(212, "Miller", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(213, "Miller", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(214, "Miller", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(215, "Miller", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(216, "Miller", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(217, "Miller", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(218, "Miller", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(219, "Miller", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(220, "Miller", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(221, "Miller", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(222, "Miller", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(223, "Miller", 2, "F");

####################################
##        Miller Floor 3          ##
####################################

INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(301, "Miller", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(302, "Miller", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity,sex, isTaken, gId) VALUES(303, "Miller", 2, "M", true, 8);
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(304, "Miller", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(305, "Miller", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(306, "Miller", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(307, "Miller", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(308, "Miller", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(309, "Miller", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(310, "Miller", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(311, "Miller", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(312, "Miller", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(313, "Miller", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(314, "Miller", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(315, "Miller", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(316, "Miller", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(317, "Miller", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(318, "Miller", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(319, "Miller", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity,sex, isTaken, gId) VALUES(320, "Miller", 2, "M", true, 7);
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(321, "Miller", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(322, "Miller", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(323, "Miller", 2, "M");


####################################
##        Miller Floor 4          ##
####################################
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(401, "Miller", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(402, "Miller", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(403, "Miller", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(404, "Miller", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(405, "Miller", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(406, "Miller", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(407, "Miller", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(408, "Miller", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(409, "Miller", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(410, "Miller", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(411, "Miller", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(412, "Miller", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(413, "Miller", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(414, "Miller", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(415, "Miller", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(416, "Miller", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(417, "Miller", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(418, "Miller", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(419, "Miller", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(420, "Miller", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(421, "Miller", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(422, "Miller", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(423, "Miller", 2, "F");

####################################
##        Miller Floor 5          ##
####################################
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(501, "Miller", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(502, "Miller", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(503, "Miller", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(504, "Miller", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(505, "Miller", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(506, "Miller", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(507, "Miller", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(508, "Miller", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(509, "Miller", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(510, "Miller", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(511, "Miller", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(512, "Miller", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(513, "Miller", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(514, "Miller", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(515, "Miller", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(516, "Miller", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(517, "Miller", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(518, "Miller", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(519, "Miller", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(520, "Miller", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(521, "Miller", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(522, "Miller", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(523, "Miller", 2, "M");

####################################
##        Miller Floor 6          ##
####################################
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(601, "Miller", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(602, "Miller", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(603, "Miller", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(604, "Miller", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(605, "Miller", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(606, "Miller", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(607, "Miller", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(608, "Miller", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(609, "Miller", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(610, "Miller", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(611, "Miller", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(612, "Miller", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(613, "Miller", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(614, "Miller", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(615, "Miller", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(616, "Miller", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(617, "Miller", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(618, "Miller", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(619, "Miller", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(620, "Miller", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(621, "Miller", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(622, "Miller", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(623, "Miller", 2, "F");

####################################
##        Miller Floor 7          ##
####################################
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(701, "Miller", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(702, "Miller", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(703, "Miller", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(704, "Miller", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(705, "Miller", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(706, "Miller", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(707, "Miller", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(708, "Miller", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(709, "Miller", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(710, "Miller", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(711, "Miller", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(712, "Miller", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(713, "Miller", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(714, "Miller", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(715, "Miller", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(716, "Miller", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(717, "Miller", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(718, "Miller", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(719, "Miller", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(720, "Miller", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(721, "Miller", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(722, "Miller", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(723, "Miller", 2, "M");

####################################
##        Miller Floor 8          ##
####################################
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(801, "Miller", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(802, "Miller", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(803, "Miller", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(804, "Miller", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(805, "Miller", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(806, "Miller", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(807, "Miller", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(808, "Miller", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(809, "Miller", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(810, "Miller", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(811, "Miller", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(812, "Miller", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(813, "Miller", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(814, "Miller", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(815, "Miller", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(816, "Miller", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(817, "Miller", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(818, "Miller", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(819, "Miller", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(820, "Miller", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(821, "Miller", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(822, "Miller", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(823, "Miller", 2, "F");


#######################################################
#######################################################
##                                                   ##
##                Adding Dieseth's Rooms             ##
##                                                   ##
#######################################################
#######################################################

####################################
##        Dieseth Floor 1         ##
####################################
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(101, "Dieseth", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(102, "Dieseth", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(103, "Dieseth", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(104, "Dieseth", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(105, "Dieseth", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(106, "Dieseth", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(107, "Dieseth", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(108, "Dieseth", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(109, "Dieseth", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(110, "Dieseth", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(112, "Dieseth", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(111, "Dieseth", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(114, "Dieseth", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(115, "Dieseth", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(116, "Dieseth", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(117, "Dieseth", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(118, "Dieseth", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(119, "Dieseth", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(120, "Dieseth", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(121, "Dieseth", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(122, "Dieseth", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(123, "Dieseth", 2, "M");

####################################
##        Dieseth Floor 2         ##
####################################
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(201, "Dieseth", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(202, "Dieseth", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(203, "Dieseth", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(204, "Dieseth", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(205, "Dieseth", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(206, "Dieseth", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(207, "Dieseth", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(208, "Dieseth", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(209, "Dieseth", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(210, "Dieseth", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(212, "Dieseth", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(211, "Dieseth", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(214, "Dieseth", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(215, "Dieseth", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(216, "Dieseth", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(217, "Dieseth", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(218, "Dieseth", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(219, "Dieseth", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(220, "Dieseth", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(221, "Dieseth", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(222, "Dieseth", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(223, "Dieseth", 2, "F");

####################################
##        Dieseth Floor 3         ##
####################################
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(301, "Dieseth", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(302, "Dieseth", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(303, "Dieseth", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(304, "Dieseth", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(305, "Dieseth", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(306, "Dieseth", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(307, "Dieseth", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(308, "Dieseth", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(309, "Dieseth", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(310, "Dieseth", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(312, "Dieseth", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(311, "Dieseth", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(314, "Dieseth", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(315, "Dieseth", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(316, "Dieseth", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(317, "Dieseth", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(318, "Dieseth", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(319, "Dieseth", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(320, "Dieseth", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(321, "Dieseth", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(322, "Dieseth", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(323, "Dieseth", 2, "M");

####################################
##        Dieseth Floor 4         ##
####################################
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(401, "Dieseth", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(402, "Dieseth", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(403, "Dieseth", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(404, "Dieseth", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(405, "Dieseth", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(406, "Dieseth", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(407, "Dieseth", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(408, "Dieseth", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(409, "Dieseth", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(410, "Dieseth", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(412, "Dieseth", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(411, "Dieseth", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(414, "Dieseth", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(415, "Dieseth", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(416, "Dieseth", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(417, "Dieseth", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(418, "Dieseth", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(419, "Dieseth", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(420, "Dieseth", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(421, "Dieseth", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(422, "Dieseth", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(423, "Dieseth", 2, "F");

####################################
##        Dieseth Floor 5         ##
####################################
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(501, "Dieseth", 2, "B");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(502, "Dieseth", 2, "B");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(503, "Dieseth", 2, "B");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(504, "Dieseth", 2, "B");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(505, "Dieseth", 2, "B");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(506, "Dieseth", 2, "B");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(507, "Dieseth", 2, "B");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(508, "Dieseth", 2, "B");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(509, "Dieseth", 2, "B");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(510, "Dieseth", 2, "B");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(512, "Dieseth", 2, "B");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(511, "Dieseth", 2, "B");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(514, "Dieseth", 2, "B");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(515, "Dieseth", 2, "B");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(516, "Dieseth", 2, "B");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(517, "Dieseth", 2, "B");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(518, "Dieseth", 2, "B");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(519, "Dieseth", 2, "B");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(520, "Dieseth", 2, "B");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(521, "Dieseth", 2, "B");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(522, "Dieseth", 2, "B");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(523, "Dieseth", 2, "B");

####################################
##        Dieseth Floor 6         ##
####################################
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(601, "Dieseth", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(602, "Dieseth", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(603, "Dieseth", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(604, "Dieseth", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(605, "Dieseth", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(606, "Dieseth", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(607, "Dieseth", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(608, "Dieseth", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(609, "Dieseth", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(610, "Dieseth", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(612, "Dieseth", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(611, "Dieseth", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(614, "Dieseth", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(615, "Dieseth", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(616, "Dieseth", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(617, "Dieseth", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(618, "Dieseth", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(619, "Dieseth", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(620, "Dieseth", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(621, "Dieseth", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(622, "Dieseth", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(623, "Dieseth", 2, "M");

####################################
##        Dieseth Floor 7         ##
####################################
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(701, "Dieseth", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(702, "Dieseth", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(703, "Dieseth", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(704, "Dieseth", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(705, "Dieseth", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(706, "Dieseth", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(707, "Dieseth", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(708, "Dieseth", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(709, "Dieseth", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(710, "Dieseth", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(712, "Dieseth", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(711, "Dieseth", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(714, "Dieseth", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(715, "Dieseth", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(716, "Dieseth", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(717, "Dieseth", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(718, "Dieseth", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(719, "Dieseth", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(720, "Dieseth", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(721, "Dieseth", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(722, "Dieseth", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(723, "Dieseth", 2, "F");

####################################
##        Dieseth Floor 8         ##
####################################
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(801, "Dieseth", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(802, "Dieseth", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(803, "Dieseth", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(804, "Dieseth", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(805, "Dieseth", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(806, "Dieseth", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(807, "Dieseth", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(808, "Dieseth", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(809, "Dieseth", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(810, "Dieseth", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(812, "Dieseth", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(811, "Dieseth", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(814, "Dieseth", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(815, "Dieseth", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(816, "Dieseth", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(817, "Dieseth", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(818, "Dieseth", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(819, "Dieseth", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(820, "Dieseth", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(821, "Dieseth", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(822, "Dieseth", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(823, "Dieseth", 2, "M");

#######################################################
#######################################################
##                                                   ##
##                Adding Larsen's Rooms              ##
##                                                   ##
#######################################################
#######################################################

####################################
##        Larsen basement         ##
####################################
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(005, "Larsen", 3, "F");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(006, "Larsen", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(007, "Larsen", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(008, "Larsen", 2, "F");

####################################
##        Larsen Floor 1          ##
####################################

INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(101, "Larsen", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(102, "Larsen", 3, "M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(103, "Larsen", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(104, "Larsen", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(105, "Larsen", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(106, "Larsen", 1, "M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(107, "Larsen", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(112, "Larsen", 1, "M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(113, "Larsen", 1, "M");
INSERT INTO Rooms(roomNum, building, capacity,sex) VALUES(116, "Larsen", 1, "M");


####################################
##        Larsen Floor 2          ##
####################################
INSERT INTO Rooms(roomNum, building, capacity, sex) VALUES(200, "Larsen", 1, "F");
INSERT INTO Rooms(roomNum, building, capacity, sex) VALUES(201, "Larsen", 1, "F");
INSERT INTO Rooms(roomNum, building, capacity, sex) VALUES(202, "Larsen", 3, "F");
INSERT INTO Rooms(roomNum, building, capacity, sex) VALUES(203, "Larsen", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity, sex) VALUES(204, "Larsen", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity, sex) VALUES(205, "Larsen", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity, sex) VALUES(606, "Larsen", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity, sex) VALUES(207, "Larsen", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity, sex) VALUES(208, "Larsen", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity, sex) VALUES(209, "Larsen", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity, sex) VALUES(210, "Larsen", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity, sex) VALUES(211, "Larsen", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity, sex) VALUES(212, "Larsen", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity, sex) VALUES(213, "Larsen", 1, "F");
INSERT INTO Rooms(roomNum, building, capacity, sex) VALUES(216, "Larsen", 1, "F");
INSERT INTO Rooms(roomNum, building, capacity, sex) VALUES(217, "Larsen", 1, "F");
INSERT INTO Rooms(roomNum, building, capacity, sex) VALUES(218, "Larsen", 1, "F");
INSERT INTO Rooms(roomNum, building, capacity, sex) VALUES(219, "Larsen", 1, "F");
INSERT INTO Rooms(roomNum, building, capacity, sex) VALUES(220, "Larsen", 1, "F");
INSERT INTO Rooms(roomNum, building, capacity, sex) VALUES(223, "Larsen", 1, "F");
INSERT INTO Rooms(roomNum, building, capacity, sex) VALUES(224, "Larsen", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity, sex) VALUES(225, "Larsen", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity, sex) VALUES(226, "Larsen", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity, sex) VALUES(227, "Larsen", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity, sex) VALUES(228, "Larsen", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity, sex) VALUES(229, "Larsen", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity, sex) VALUES(230, "Larsen", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity, sex) VALUES(231, "Larsen", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity, sex) VALUES(232, "Larsen", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity, sex) VALUES(233, "Larsen", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity, sex) VALUES(234, "Larsen", 3, "F");
INSERT INTO Rooms(roomNum, building, capacity, sex) VALUES(235, "Larsen", 1, "F");
INSERT INTO Rooms(roomNum, building, capacity, sex) VALUES(236, "Larsen", 1, "F");
INSERT INTO Rooms(roomNum, building, capacity, sex) VALUES(237, "Larsen", 1, "F");


####################################
##        Larsen Floor 3          ##
####################################
INSERT INTO Rooms(roomNum, building, capacity, sex) VALUES(300, "Larsen", 1, "M");
INSERT INTO Rooms(roomNum, building, capacity, sex) VALUES(301, "Larsen", 1, "M");
INSERT INTO Rooms(roomNum, building, capacity, sex) VALUES(302, "Larsen", 3, "M");
INSERT INTO Rooms(roomNum, building, capacity, sex) VALUES(303, "Larsen", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity, sex) VALUES(304, "Larsen", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity, sex) VALUES(305, "Larsen", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity, sex) VALUES(306, "Larsen", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity, sex) VALUES(307, "Larsen", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity, sex) VALUES(308, "Larsen", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity, sex) VALUES(309, "Larsen", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity, sex) VALUES(310, "Larsen", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity, sex) VALUES(311, "Larsen", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity, sex) VALUES(312, "Larsen", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity, sex) VALUES(313, "Larsen", 1, "M");
INSERT INTO Rooms(roomNum, building, capacity, sex) VALUES(316, "Larsen", 1, "M");
INSERT INTO Rooms(roomNum, building, capacity, sex) VALUES(317, "Larsen", 1, "M");
INSERT INTO Rooms(roomNum, building, capacity, sex) VALUES(318, "Larsen", 1, "M");
INSERT INTO Rooms(roomNum, building, capacity, sex) VALUES(319, "Larsen", 1, "M");
INSERT INTO Rooms(roomNum, building, capacity, sex) VALUES(320, "Larsen", 1, "M");
INSERT INTO Rooms(roomNum, building, capacity, sex) VALUES(323, "Larsen", 1, "M");
INSERT INTO Rooms(roomNum, building, capacity, sex) VALUES(324, "Larsen", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity, sex) VALUES(325, "Larsen", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity, sex) VALUES(326, "Larsen", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity, sex) VALUES(327, "Larsen", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity, sex) VALUES(328, "Larsen", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity, sex) VALUES(329, "Larsen", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity, sex) VALUES(330, "Larsen", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity, sex) VALUES(331, "Larsen", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity, sex) VALUES(332, "Larsen", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity, sex) VALUES(333, "Larsen", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity, sex) VALUES(334, "Larsen", 3, "M");
INSERT INTO Rooms(roomNum, building, capacity, sex) VALUES(335, "Larsen", 1, "M");
INSERT INTO Rooms(roomNum, building, capacity, sex) VALUES(336, "Larsen", 1, "M");
INSERT INTO Rooms(roomNum, building, capacity, sex) VALUES(337, "Larsen", 1, "M");


#######################################################
#######################################################
##                                                   ##
##                Adding Olson's Rooms               ##
##                                                   ##
#######################################################
#######################################################

####################################
##        Olson Floor 1          ##
####################################
INSERT INTO Rooms(roomNum, building, capacity, sex) VALUES(101, "Olson", 4, "F");
INSERT INTO Rooms(roomNum, building, capacity, sex) VALUES(102, "Olson", 1, "F");
INSERT INTO Rooms(roomNum, building, capacity, sex) VALUES(104, "Olson", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity, sex) VALUES(105, "Olson", 4, "F");
INSERT INTO Rooms(roomNum, building, capacity, sex) VALUES(106, "Olson", 4, "F");
INSERT INTO Rooms(roomNum, building, capacity, sex) VALUES(107, "Olson", 4, "F");
INSERT INTO Rooms(roomNum, building, capacity, sex) VALUES(108, "Olson", 4, "F");
INSERT INTO Rooms(roomNum, building, capacity, sex) VALUES(109, "Olson", 3, "F");
INSERT INTO Rooms(roomNum, building, capacity, sex) VALUES(110, "Olson", 4, "F");



####################################
##        Olson Floor 2          ##
####################################
INSERT INTO Rooms(roomNum, building, capacity, sex) VALUES(201, "Olson", 4, "M");
INSERT INTO Rooms(roomNum, building, capacity, sex) VALUES(202, "Olson", 1, "M");
INSERT INTO Rooms(roomNum, building, capacity, sex) VALUES(204, "Olson", 2, "M");
INSERT INTO Rooms(roomNum, building, capacity, sex) VALUES(205, "Olson", 4, "M");
INSERT INTO Rooms(roomNum, building, capacity, sex) VALUES(206, "Olson", 4, "M");
INSERT INTO Rooms(roomNum, building, capacity, sex) VALUES(207, "Olson", 4, "M");
INSERT INTO Rooms(roomNum, building, capacity, sex) VALUES(208, "Olson", 4, "M");
INSERT INTO Rooms(roomNum, building, capacity, sex) VALUES(209, "Olson", 3, "M");
INSERT INTO Rooms(roomNum, building, capacity, sex) VALUES(210, "Olson", 4, "M");


####################################
##        Olson Floor 3          ##
####################################
INSERT INTO Rooms(roomNum, building, capacity, sex) VALUES(332, "Olson", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity, sex) VALUES(334, "Olson", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity, sex) VALUES(335, "Olson", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity, sex) VALUES(336, "Olson", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity, sex) VALUES(337, "Olson", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity, sex) VALUES(338, "Olson", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity, sex) VALUES(339, "Olson", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity, sex) VALUES(340, "Olson", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity, sex) VALUES(341, "Olson", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity, sex) VALUES(342, "Olson", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity, sex) VALUES(343, "Olson", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity, sex) VALUES(344, "Olson", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity, sex) VALUES(345, "Olson", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity, sex) VALUES(346, "Olson", 2, "F");
INSERT INTO Rooms(roomNum, building, capacity, sex) VALUES(348, "Olson", 2, "F");











####################################
##        Preference Test         ##
####################################

INSERT INTO Preferences(enabled, roomNum, building, gId, prefNum) VALUES(true, 101, "Miller", 1, 1);
INSERT INTO Preferences(enabled, roomNum, building, gId, prefNum) VALUES(true, 102, "Miller", 1, 2);
INSERT INTO Preferences(enabled, roomNum, building, gId, prefNum) VALUES(true, 103, "Miller", 1, 3);
INSERT INTO Preferences(enabled, roomNum, building, gId, prefNum) VALUES(true, 104, "Miller", 1, 4);
