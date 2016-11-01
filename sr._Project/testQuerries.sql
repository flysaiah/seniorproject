#######################################################
#################     DESCRIPTION    ##################
#######################################################
# This code will check to see if the mysql database   #
#         will be useful for the project              #
#######################################################


USE projectdb

select * from Users;
#expected output
-- +----------+-----------+-----------+------+---------+-------------+----------+
-- | userName | firstName | lastName  | gId  | credits | roomDrawNum | drawDate |
-- +----------+-----------+-----------+------+---------+-------------+----------+
-- | mayeis01 | Isaiah    | Mayerchak |    2 |     120 |           1 | NULL     |
-- | saudih01 | Ihab      | Saud      |    2 |      85 |           2 | NULL     |
-- | smitze01 | Zechariah | Smith     |    1 |      65 |           3 | NULL     |
-- +----------+-----------+-----------+------+---------+-------------+----------+

select userName, isRegistered from Users, Groups where Users.gID=Groups.groupId;
#expected output
-- +----------+--------------+
-- | userName | isRegistered |
-- +----------+--------------+
-- | smitze01 |            0 |
-- | mayeis01 |            0 |
-- | saudih01 |            0 |
-- +----------+--------------+

update Groups set drawDate=NOW() where groupId=2;
select * from Groups;
#expected output
-- +---------+--------------+---------------------+
-- | groupId | isRegistered | drawDate            |
-- +---------+--------------+---------------------+
-- |       1 |            0 | NULL                |
-- |       2 |            0 | 2016-10-27 13:08:02 |
-- +---------+--------------+---------------------+

select AVG(roomDrawNum)from Users where gId=2;
#expected output
-- +------------------+
-- | AVG(roomDrawNum) |
-- +------------------+
-- |           1.5000 |
-- +------------------+
select * from groupsWithAverage;
