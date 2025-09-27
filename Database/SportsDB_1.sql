CREATE TABLE Users (
UserID   INTEGER AUTO_INCREMENT PRIMARY KEY,
UserName TEXT NOT NULL,
UserPassword  TEXT NOT NULL,
UserFirstName TEXT NOT NULL,
UserLastName TEXT, 
UserRole TEXT,
Email TEXT,
Mobile TEXT
);

CREATE TABLE TeamInfo (
TeamID   INTEGER AUTO_INCREMENT PRIMARY KEY,
TeamName TEXT NOT NULL,
Country  TEXT NOT NULL,
NumOfMatchesPlayed INTEGER NOT NULL,
MatchesWon INTEGER, 
MatchesLost INTEGER,
MatchesTie INTEGER,
TotalGoalsScored INTEGER,
ManagerID INTEGER,
CONSTRAINT FK_ManagerID FOREIGN KEY (ManagerID)
    REFERENCES Users(UserID)
);

CREATE TABLE MatchInfo (
MatchID  INTEGER AUTO_INCREMENT PRIMARY KEY,
MatchName TEXT NOT NULL,
Venue TEXT NOT NULL,
MatchDate DATE 
);

CREATE TABLE MatchHistory (
ID INTEGER AUTO_INCREMENT PRIMARY KEY,
MatchID  INTEGER, 
TeamID INTEGER,
PlayedAgainst INTEGER,
MatchResult TEXT,
CONSTRAINT FK_MatchID FOREIGN KEY (MatchID)
    REFERENCES MatchInfo(MatchID),
    CONSTRAINT FK_TeamID FOREIGN KEY (TeamID)
    REFERENCES TeamInfo(TeamID),
       CONSTRAINT FK_PlayedAgainst FOREIGN KEY (PlayedAgainst)
    REFERENCES TeamInfo(TeamID)
);

CREATE TABLE PlayerInfo (
PlayerID INTEGER AUTO_INCREMENT PRIMARY KEY,
PlayerName  TEXT, 
Age INTEGER,
DOB Date,
Gender TEXT,
TotalGoalsScored INTEGER
);

CREATE TABLE TeamPlayers (
ID INTEGER AUTO_INCREMENT PRIMARY KEY,
TeamID INTEGER,
PlayerID  INTEGER, 
 CONSTRAINT FK_TeamID_TeamPlayers FOREIGN KEY (TeamID)
    REFERENCES TeamInfo(TeamID),
 CONSTRAINT FK_PlayerID_TeamPlayers FOREIGN KEY (PlayerID)
    REFERENCES PlayerInfo(PlayerID)
);


CREATE TABLE TeamAwards (
ID INTEGER AUTO_INCREMENT PRIMARY KEY,
TeamID INTEGER,
MatchID INTEGER,
PlayerID  INTEGER,
AwardName TEXT,
DateofAward DATE,
 CONSTRAINT FK_MatchID_TeamAwards FOREIGN KEY (MatchID)
    REFERENCES MatchInfo(MatchID),
 CONSTRAINT FK_PlayerID_TeamAwards FOREIGN KEY (PlayerID)
    REFERENCES PlayerInfo(PlayerID),
CONSTRAINT FK_TeamID_TeamAwards FOREIGN KEY (TeamID)
    REFERENCES TeamInfo(TeamID)
);

CREATE TABLE PlayerAwards (
ID INTEGER AUTO_INCREMENT PRIMARY KEY,
MatchID INTEGER,
PlayerID  INTEGER,
TeamID INTEGER,
AwardName TEXT,
DateofAward DATE,
 CONSTRAINT FK_MatchID_PlayerAwards FOREIGN KEY (MatchID)
    REFERENCES MatchInfo(MatchID),
 CONSTRAINT FK_PlayerID_PlayerAwards FOREIGN KEY (PlayerID)
    REFERENCES PlayerInfo(PlayerID),
 CONSTRAINT FK_TeamID_PlayerAwards FOREIGN KEY (TeamID)
    REFERENCES TeamInfo(TeamID)
);


CREATE TABLE TeamHistory (
ID INTEGER AUTO_INCREMENT PRIMARY KEY,
MatchID INTEGER,
TeamID INTEGER,
PlayedAgainst INTEGER,
MatchDate DATE,
MatchResult TEXT,
GoalsScored INTEGER,
 CONSTRAINT FK_MatchID_TeamHistory FOREIGN KEY (MatchID)
    REFERENCES MatchInfo(MatchID),
 CONSTRAINT FK_PlayedAgainst_TeamHistory FOREIGN KEY (PlayedAgainst)
    REFERENCES TeamInfo(TeamID),
 CONSTRAINT FK_TeamID_TeamHistory FOREIGN KEY (TeamID)
    REFERENCES TeamInfo(TeamID)
);


CREATE TABLE PlayerHistory (
ID INTEGER AUTO_INCREMENT PRIMARY KEY,
PlayerID INTEGER,
MatchID INTEGER,
TeamID INTEGER,
PlayedAgainst INTEGER,
MatchDate DATE,
MatchResult TEXT,
GoalsScored INTEGER,
 CONSTRAINT FK_MatchID_PlayerHistory FOREIGN KEY (MatchID)
    REFERENCES MatchInfo(MatchID),
 CONSTRAINT FK_PlayedAgainst_PlayerHistory FOREIGN KEY (PlayedAgainst)
    REFERENCES TeamInfo(TeamID),
 CONSTRAINT FK_TeamID_PlayerHistory FOREIGN KEY (TeamID)
    REFERENCES TeamInfo(TeamID),
 CONSTRAINT FK_PlayerID_PlayerHistory FOREIGN KEY (PlayerID)
    REFERENCES PlayerInfo(PlayerID)
);

INSERT INTO PlayerInfo (PlayerID, PlayerName, Age, DOB, Gender, TotalGoalsScored) VALUES
(1, 'Cristiano Ronaldo', 39, '1985-02-05', 'Male', 128),         -- as of March 2025
(2, 'Lionel Messi', 37, '1987-06-24', 'Male', 106),				 -- Winger / Forward
(3, 'Neymar Jr', 33, '1992-02-05', 'Male', 79),					 -- Winger / Forward
(4, 'Kylian Mbappé', 26, '1998-12-20', 'Male', 46),				 -- Winger / Forward
(5, 'Robert Lewandowski', 36, '1988-08-21', 'Male', 82),		 -- Winger / Forward
(6, 'Harry Kane', 31, '1993-07-28', 'Male', 63),				 -- Winger / Forward
(7, 'Erling Haaland', 24, '2000-07-21', 'Male', 31),			 -- Winger / Forward
(8, 'Mohamed Salah', 32, '1992-06-15', 'Male', 55),				 -- Winger / Forward
(9, 'Kevin De Bruyne', 33, '1991-06-28', 'Male', 27),			 -- AM (Attacking Midfield)
(10, 'Luka Modrić', 39, '1985-09-09', 'Male', 25),				 -- Midfield
(11, 'Sergio Ramos', 38, '1986-03-30', 'Male', 23),				 -- CB (Centre Back)
(12, 'Virgil van Dijk', 33, '1991-07-08', 'Male', 9),			 -- CB
(13, 'Karim Benzema', 37, '1987-12-19', 'Male', 37),			 -- Winger / Forward	
(14, 'Antoine Griezmann', 34, '1991-03-21', 'Male', 44),		 -- Winger / Forward
(15, 'Toni Kroos', 35, '1990-01-04', 'Male', 17),				 -- Midfield
(16, 'Eden Hazard', 34, '1991-01-07', 'Male', 33),				 -- Winger / Forward
(17, 'Raheem Sterling', 30, '1995-12-08', 'Male', 20),			 -- Winger / Forward
(18, 'Paulo Dybala', 31, '1993-11-15', 'Male', 9),				 -- Winger / Forward
(19, 'Zlatan Ibrahimović', 43, '1981-10-03', 'Male', 62),		 -- Winger / Forward
(20, 'Manuel Neuer', 39, '1986-03-27', 'Male', 0),  -- Goalkeeper
(21, 'Bukayo Saka', 23, '2001-09-05', 'Male', 12),				 -- Winger / Forward
(22, 'Phil Foden', 24, '2000-05-28', 'Male', 10),				 -- Winger / Forward
(23, 'Jude Bellingham', 21, '2003-06-29', 'Male', 10),			 -- AM
(24, 'João Félix', 25, '1999-11-10', 'Male', 7),				 -- Winger / Forward
(25, 'Kai Havertz', 25, '1999-06-11', 'Male', 13),				 -- Winger / Forward
(26, 'Mason Mount', 26, '1999-01-10', 'Male', 7),				 -- Winger / Forward
(27, 'Pedri', 22, '2002-11-25', 'Male', 5),						 -- Midfield
(28, 'Gavi', 20, '2004-08-05', 'Male', 3),						 -- Midfield
(29, 'Rodri', 28, '1997-06-22', 'Male', 7),						 -- Midfield
(30, 'Declan Rice', 26, '1999-01-14', 'Male', 4),				 -- Midfield
(31, 'Joshua Kimmich', 30, '1995-02-08', 'Male', 6),			 -- Midfield
(32, 'Federico Valverde', 26, '1998-07-22', 'Male', 5),			 -- AM
(33, 'Aurélien Tchouaméni', 25, '2000-01-27', 'Male', 2),		 -- Midfield
(34, 'Alphonso Davies', 24, '2000-11-02', 'Male', 12),			 -- Defense
(35, 'Achraf Hakimi', 26, '1998-11-04', 'Male', 9),				 -- Defense
(36, 'Theo Hernández', 27, '1997-10-06', 'Male', 7),			 -- Defense
(37, 'Trent Alexander-Arnold', 26, '1998-10-07', 'Male', 4),	 -- Defense
(38, 'Reece James', 25, '1999-12-08', 'Male', 3),				 -- Defense / Midefield
(39, 'Rúben Dias', 27, '1997-05-14', 'Male', 2),				 -- CB
(40, 'Marquinhos', 30, '1994-05-14', 'Male', 7),				 -- CB
(41, 'Aymeric Laporte', 30, '1994-05-27', 'Male', 3),			 -- CB
(42, 'Alisson Becker', 32, '1992-10-02', 'Male', 0),	   -- Goalie
(43, 'Thibaut Courtois', 32, '1992-05-11', 'Male', 0),	   -- Goalie
(44, 'Gianluigi Donnarumma', 26, '1999-02-25', 'Male', 0), -- Goalie
(45, 'Marc-André ter Stegen', 33, '1992-04-30', 'Male', 0), -- Goalie
(46, 'Ederson Moraes', 31, '1993-08-17', 'Male', 0),	-- Goalie
(47, 'Lautaro Martínez', 27, '1997-08-22', 'Male', 22), -- Winger / Forward
(48, 'Olivier Giroud', 38, '1986-09-30', 'Male', 57),	-- Winger / Forward
(49, 'Álvaro Morata', 32, '1992-10-23', 'Male', 34),	-- Winger / Forward
(50, 'Christian Pulisic', 26, '1998-09-18', 'Male', 28); -- Winger / Forward

INSERT INTO PlayerInfo (PlayerID, PlayerName, Age, DOB, Gender, TotalGoalsScored) VALUES 
(51, 'Heung-Min Son', 32, '1992-07-08', 'Male', 41),
(52, 'Christian Eriksen', 33, '1992-02-14', 'Male', 39),
(53, 'Luka Jović', 27, '1997-12-23', 'Male', 15),
(54, 'Hirving Lozano', 29, '1995-07-30', 'Male', 18),
(55, 'Keylor Navas', 38, '1986-12-15', 'Male', 0),
(56, 'Takumi Minamino', 30, '1995-01-16', 'Male', 19),
(57, 'Sardar Azmoun', 30, '1995-01-01', 'Male', 44),
(58, 'Teemu Pukki', 35, '1990-03-29', 'Male', 38),
(59, 'Jan Oblak', 32, '1992-01-07', 'Male', 0),
(60, 'Ermir Lenjani', 35, '1989-08-05', 'Male', 5);

select * from playerinfo;


select * from TeamInfo;


SET SQL_SAFE_UPDATES = 0;
delete from Users;

INSERT INTO Users (UserID, UserName, UserPassword, UserFirstName, UserLastName, UserRole, Email, Mobile)
VALUES (1, 'user1', 'pass1@2025', 'Roberto', 'Martínez', 'Manager', 'user1@example.com', '+10000000001');
INSERT INTO Users (UserID, UserName, UserPassword, UserFirstName, UserLastName, UserRole, Email, Mobile)
VALUES (2, 'user2', 'pass2@2025', 'Lionel', 'Scaloni', 'Manager', 'user2@example.com', '+10000000002');
INSERT INTO Users (UserID, UserName, UserPassword, UserFirstName, UserLastName, UserRole, Email, Mobile)
VALUES (3, 'user3', 'pass3@2025', 'Dorival', 'Júnior', 'Manager', 'user3@example.com', '+10000000003');
INSERT INTO Users (UserID, UserName, UserPassword, UserFirstName, UserLastName, UserRole, Email, Mobile)
VALUES (4, 'user4', 'pass4@2025', 'Didier', 'Deschamps', 'Manager', 'user4@example.com', '+10000000004');
INSERT INTO Users (UserID, UserName, UserPassword, UserFirstName, UserLastName, UserRole, Email, Mobile)
VALUES (5, 'user5', 'pass5@2025', 'Michał', 'Probierz', 'Manager', 'user5@example.com', '+10000000005');
INSERT INTO Users (UserID, UserName, UserPassword, UserFirstName, UserLastName, UserRole, Email, Mobile)
VALUES (6, 'user6', 'pass6@2025', 'Gareth', 'Southgate', 'Manager', 'user6@example.com', '+10000000006');
INSERT INTO Users (UserID, UserName, UserPassword, UserFirstName, UserLastName, UserRole, Email, Mobile)
VALUES (7, 'user7', 'pass7@2025', 'Ståle', 'Solbakken', 'Manager', 'user7@example.com', '+10000000007');
INSERT INTO Users (UserID, UserName, UserPassword, UserFirstName, UserLastName, UserRole, Email, Mobile)
VALUES (8, 'user8', 'pass8@2025', 'Rui', 'Vitória', 'Manager', 'user8@example.com', '+10000000008');
INSERT INTO Users (UserID, UserName, UserPassword, UserFirstName, UserLastName, UserRole, Email, Mobile)
VALUES (9, 'user9', 'pass9@2025', 'Domenico', 'Tedesco', 'Manager', 'user9@example.com', '+10000000009');
INSERT INTO Users (UserID, UserName, UserPassword, UserFirstName, UserLastName, UserRole, Email, Mobile)
VALUES (10, 'user10', 'pass10@2025', 'Zlatko', 'Dalić', 'Manager', 'user10@example.com', '+10000000010');
INSERT INTO Users (UserID, UserName, UserPassword, UserFirstName, UserLastName, UserRole, Email, Mobile)
VALUES (11, 'user11', 'pass11@2025', 'Luis', 'de la Fuente', 'Manager', 'user11@example.com', '+10000000011');
INSERT INTO Users (UserID, UserName, UserPassword, UserFirstName, UserLastName, UserRole, Email, Mobile)
VALUES (12, 'user12', 'pass12@2025', 'Julian', 'Nagelsmann', 'Manager', 'user12@example.com', '+10000000012');
INSERT INTO Users (UserID, UserName, UserPassword, UserFirstName, UserLastName, UserRole, Email, Mobile)
VALUES (13, 'user13', 'pass13@2025', 'Ronald', 'Koeman', 'Manager', 'user13@example.com', '+10000000013');
INSERT INTO Users (UserID, UserName, UserPassword, UserFirstName, UserLastName, UserRole, Email, Mobile)
VALUES (14, 'user14', 'pass14@2025', 'Mauro', 'Biello', 'Manager', 'user14@example.com', '+10000000014');
INSERT INTO Users (UserID, UserName, UserPassword, UserFirstName, UserLastName, UserRole, Email, Mobile)
VALUES (15, 'user15', 'pass15@2025', 'Walid', 'Regragui', 'Manager', 'user15@example.com', '+10000000015');
INSERT INTO Users (UserID, UserName, UserPassword, UserFirstName, UserLastName, UserRole, Email, Mobile)
VALUES (16, 'user16', 'pass16@2025', 'Luciano', 'Spalletti', 'Manager', 'user16@example.com', '+10000000016');
INSERT INTO Users (UserID, UserName, UserPassword, UserFirstName, UserLastName, UserRole, Email, Mobile)
VALUES (17, 'user17', 'pass17@2025', 'Gregg', 'Berhalter', 'Manager', 'user17@example.com', '+10000000017');
INSERT INTO Users (UserID, UserName, UserPassword, UserFirstName, UserLastName, UserRole, Email, Mobile)
VALUES (18, 'user18', 'pass18@2025', 'Marcelo', 'Bielsa', 'Manager', 'user18@example.com', '+10000000018');
INSERT INTO Users (UserID, UserName, UserPassword, UserFirstName, UserLastName, UserRole, Email, Mobile)
VALUES (19, 'user19', 'pass19@2025', 'Janne', 'Andersson', 'Manager', 'user19@example.com', '+10000000019');
INSERT INTO Users (UserID, UserName, UserPassword, UserFirstName, UserLastName, UserRole, Email, Mobile)
VALUES (20, 'user20', 'pass20@2025', 'Thibaut', 'Petit', 'Manager', 'user20@example.com', '+10000000020');
INSERT INTO Users (UserID, UserName, UserPassword, UserFirstName, UserLastName, UserRole, Email, Mobile)
VALUES (21, 'user21', 'pass21@2025', 'Jean', 'Martin', 'Manager', 'user21@example.com', '+10000000021');
INSERT INTO Users (UserID, UserName, UserPassword, UserFirstName, UserLastName, UserRole, Email, Mobile)
VALUES (22, 'user22', 'pass22@2025', 'Jürgen', 'Klinsmann', 'Manager', 'user22@example.com', '+10000000022');
INSERT INTO Users (UserID, UserName, UserPassword, UserFirstName, UserLastName, UserRole, Email, Mobile)
VALUES (23, 'user23', 'pass23@2025', 'Kasper', 'Hjulmand', 'Manager', 'user23@example.com', '+10000000023');
INSERT INTO Users (UserID, UserName, UserPassword, UserFirstName, UserLastName, UserRole, Email, Mobile)
VALUES (24, 'user24', 'pass24@2025', 'Dragan', 'Stojković', 'Manager', 'user24@example.com', '+10000000024');
INSERT INTO Users (UserID, UserName, UserPassword, UserFirstName, UserLastName, UserRole, Email, Mobile)
VALUES (25, 'user25', 'pass25@2025', 'Jaime', 'Lozano', 'Manager', 'user25@example.com', '+10000000025');
INSERT INTO Users (UserID, UserName, UserPassword, UserFirstName, UserLastName, UserRole, Email, Mobile)
VALUES (26, 'user26', 'pass26@2025', 'Luis', 'Fernando', 'Manager', 'user26@example.com', '+10000000026');
INSERT INTO Users (UserID, UserName, UserPassword, UserFirstName, UserLastName, UserRole, Email, Mobile)
VALUES (27, 'user27', 'pass27@2025', 'Hajime', 'Moriyasu', 'Manager', 'user27@example.com', '+10000000027');
INSERT INTO Users (UserID, UserName, UserPassword, UserFirstName, UserLastName, UserRole, Email, Mobile)
VALUES (28, 'user28', 'pass28@2025', 'Amir', 'Ghalenoei', 'Manager', 'user28@example.com', '+10000000028');
INSERT INTO Users (UserID, UserName, UserPassword, UserFirstName, UserLastName, UserRole, Email, Mobile)
VALUES (29, 'user29', 'pass29@2025', 'Markku', 'Kanerva', 'Manager', 'user29@example.com', '+10000000029');
INSERT INTO Users (UserID, UserName, UserPassword, UserFirstName, UserLastName, UserRole, Email, Mobile)
VALUES (30, 'user30', 'pass30@2025', 'Matjaž', 'Kek', 'Manager', 'user30@example.com', '+10000000030');
INSERT INTO Users (UserID, UserName, UserPassword, UserFirstName, UserLastName, UserRole, Email, Mobile)
VALUES (31, 'user31', 'pass31@2025', 'Sylvinho', 'Barbosa', 'Manager', 'user31@example.com', '+10000000031');

select * from Users;

select * from PlayerInfo;


-- Start a transaction to ensure all updates succeed or none do.
START TRANSACTION;

-- Temporarily disable the foreign key checks.
SET FOREIGN_KEY_CHECKS=0;

-- First, update the child table (TeamInfo) so the managers point to their future IDs.
UPDATE TeamInfo
SET ManagerID = ManagerID + 66
WHERE ManagerID BETWEEN 1 AND 31;

-- Now, update the parent table (Users) with the new primary key IDs.
UPDATE Users
SET
    UserName = CONCAT('user', UserID + 66),
    UserPassword = CONCAT('pass', UserID + 66, '@2025'),
    Email = CONCAT('user', UserID + 66, '@example.com'),
    Mobile = CONCAT('+100000000', UserID + 66),
    UserID = UserID + 66
WHERE
    UserID BETWEEN 1 AND 31;

-- Re-enable the foreign key checks.
SET FOREIGN_KEY_CHECKS=1;

-- Commit the changes to make them permanent. If any step failed, you would use ROLLBACK.
COMMIT;

select * from playerinfo;
select * from teaminfo;
select * from users;

delete from Users where UserID > 97;

INSERT INTO Users (UserID, UserFirstName, UserLastName, UserName, UserPassword, UserRole, Email, Mobile)
SELECT
	PlayerID,
    -- Extracts the first word as the first name
    SUBSTRING_INDEX(PlayerName, ' ', 1) AS UserFirstName,
    
    -- Extracts the last word as the last name, or NULL if there's only one word
    IF(LOCATE(' ', PlayerName) > 0, SUBSTRING_INDEX(PlayerName, ' ', -1), NULL) AS UserLastName,
    
    -- Creates a username, e.g., 'cristianoronaldo'
    LOWER(REPLACE(PlayerName, ' ', '')) AS UserName,
    
    -- Creates a placeholder password, e.g., 'pass_cristianoronaldo'
    CONCAT('pass_', PlayerID) AS UserPassword,
    
    -- Assigns a default role of 'Player'
    'Player' AS UserRole,
    
    -- Creates a placeholder email, e.g., 'cristianoronaldo@example.com'
    CONCAT(LOWER(REPLACE(PlayerName, ' ', '')), '@example.com') AS Email,
    
    -- Creates a placeholder mobile number
    CONCAT('+199900', LPAD(PlayerID, 4, '0')) AS Mobile
FROM
    PlayerInfo;

UPDATE TeamInfo
SET
ManagerID = 67
WHERE ManagerID = 1;

UPDATE Users
SET
    UserName = CONCAT('user', UserID + 66),
    UserPassword = CONCAT('pass', UserID + 66, '@2025'),
    Email = CONCAT('user', UserID + 66, '@example.com'),
    Mobile = CONCAT('+100000000', UserID + 66),
    UserID = UserID + 66
WHERE
    UserID BETWEEN 1 AND 31;

UPDATE TeamInfo SET ManagerID = 1 WHERE TeamID = 1;   -- Roberto Martínez (Portugal FC)
UPDATE TeamInfo SET ManagerID = 2 WHERE TeamID = 2;   -- Lionel Scaloni (Argentina FC)
UPDATE TeamInfo SET ManagerID = 3 WHERE TeamID = 3;   -- Dorival Júnior (Brazil FC)
UPDATE TeamInfo SET ManagerID = 4 WHERE TeamID = 4;   -- Didier Deschamps (France FC)
UPDATE TeamInfo SET ManagerID = 5 WHERE TeamID = 5;   -- Michał Probierz (Poland FC)
UPDATE TeamInfo SET ManagerID = 6 WHERE TeamID = 6;   -- Gareth Southgate (England FC)
UPDATE TeamInfo SET ManagerID = 7 WHERE TeamID = 7;   -- Ståle Solbakken (Norway FC)
UPDATE TeamInfo SET ManagerID = 8 WHERE TeamID = 8;   -- Rui Vitória (Egypt FC)
UPDATE TeamInfo SET ManagerID = 9 WHERE TeamID = 9;   -- Domenico Tedesco (Belgium FC)
UPDATE TeamInfo SET ManagerID = 10 WHERE TeamID = 10; -- Zlatko Dalić (Croatia FC)
UPDATE TeamInfo SET ManagerID = 11 WHERE TeamID = 11; -- Luis de la Fuente (Spain FC)
UPDATE TeamInfo SET ManagerID = 12 WHERE TeamID = 12; -- Julian Nagelsmann (Germany FC)
UPDATE TeamInfo SET ManagerID = 13 WHERE TeamID = 13; -- Ronald Koeman (Netherlands FC)
UPDATE TeamInfo SET ManagerID = 14 WHERE TeamID = 14; -- Mauro Biello (Canada FC)
UPDATE TeamInfo SET ManagerID = 15 WHERE TeamID = 15; -- Walid Regragui (Morocco FC)
UPDATE TeamInfo SET ManagerID = 16 WHERE TeamID = 16; -- Luciano Spalletti (Italy FC)
UPDATE TeamInfo SET ManagerID = 17 WHERE TeamID = 17; -- Gregg Berhalter (USA FC)
UPDATE TeamInfo SET ManagerID = 18 WHERE TeamID = 18; -- Marcelo Bielsa (Uruguay FC)
UPDATE TeamInfo SET ManagerID = 19 WHERE TeamID = 19; -- Janne Andersson (Sweden FC)
UPDATE TeamInfo SET ManagerID = 20 WHERE TeamID = 20; -- Thibaut Petit (Belgium B FC)
UPDATE TeamInfo SET ManagerID = 21 WHERE TeamID = 21; -- Jean Martin (France B FC)
UPDATE TeamInfo SET ManagerID = 22 WHERE TeamID = 22; -- Jürgen Klinsmann (South Korea FC)
UPDATE TeamInfo SET ManagerID = 23 WHERE TeamID = 23; -- Kasper Hjulmand (Denmark FC)
UPDATE TeamInfo SET ManagerID = 24 WHERE TeamID = 24; -- Dragan Stojković (Serbia FC)
UPDATE TeamInfo SET ManagerID = 25 WHERE TeamID = 25; -- Jaime Lozano (Mexico FC)
UPDATE TeamInfo SET ManagerID = 26 WHERE TeamID = 26; -- Luis Fernando (Costa Rica FC)
UPDATE TeamInfo SET ManagerID = 27 WHERE TeamID = 27; -- Hajime Moriyasu (Japan FC)
UPDATE TeamInfo SET ManagerID = 28 WHERE TeamID = 28; -- Amir Ghalenoei (Iran FC)
UPDATE TeamInfo SET ManagerID = 29 WHERE TeamID = 29; -- Markku Kanerva (Finland FC)
UPDATE TeamInfo SET ManagerID = 30 WHERE TeamID = 30; -- Matjaž Kek (Slovenia FC)
UPDATE TeamInfo SET ManagerID = 31 WHERE TeamID = 31; -- Sylvinho Barbosa (Albania FC)



UPDATE TeamInfo SET ManagerID = 1 WHERE TeamID = 1;   -- Roberto Martínez (Portugal FC)
UPDATE TeamInfo SET ManagerID = 2 WHERE TeamID = 2;   -- Lionel Scaloni (Argentina FC)
UPDATE TeamInfo SET ManagerID = 3 WHERE TeamID = 3;   -- Dorival Júnior (Brazil FC)
UPDATE TeamInfo SET ManagerID = 4 WHERE TeamID = 4;   -- Didier Deschamps (France FC)
UPDATE TeamInfo SET ManagerID = 5 WHERE TeamID = 5;   -- Michał Probierz (Poland FC)
UPDATE TeamInfo SET ManagerID = 6 WHERE TeamID = 6;   -- Gareth Southgate (England FC)
UPDATE TeamInfo SET ManagerID = 7 WHERE TeamID = 7;   -- Ståle Solbakken (Norway FC)
UPDATE TeamInfo SET ManagerID = 8 WHERE TeamID = 8;   -- Rui Vitória (Egypt FC)
UPDATE TeamInfo SET ManagerID = 9 WHERE TeamID = 9;   -- Domenico Tedesco (Belgium FC)
UPDATE TeamInfo SET ManagerID = 10 WHERE TeamID = 10; -- Zlatko Dalić (Croatia FC)
UPDATE TeamInfo SET ManagerID = 11 WHERE TeamID = 11; -- Luis de la Fuente (Spain FC)
UPDATE TeamInfo SET ManagerID = 12 WHERE TeamID = 12; -- Julian Nagelsmann (Germany FC)
UPDATE TeamInfo SET ManagerID = 13 WHERE TeamID = 13; -- Ronald Koeman (Netherlands FC)
UPDATE TeamInfo SET ManagerID = 14 WHERE TeamID = 14; -- Mauro Biello (Canada FC)
UPDATE TeamInfo SET ManagerID = 15 WHERE TeamID = 15; -- Walid Regragui (Morocco FC)
UPDATE TeamInfo SET ManagerID = 16 WHERE TeamID = 16; -- Luciano Spalletti (Italy FC)
UPDATE TeamInfo SET ManagerID = 17 WHERE TeamID = 17; -- Gregg Berhalter (USA FC)
UPDATE TeamInfo SET ManagerID = 18 WHERE TeamID = 18; -- Marcelo Bielsa (Uruguay FC)
UPDATE TeamInfo SET ManagerID = 19 WHERE TeamID = 19; -- Janne Andersson (Sweden FC)
UPDATE TeamInfo SET ManagerID = 20 WHERE TeamID = 20; -- Thibaut Petit (Belgium B FC)
UPDATE TeamInfo SET ManagerID = 21 WHERE TeamID = 21; -- Jean Martin (France B FC)
UPDATE TeamInfo SET ManagerID = 22 WHERE TeamID = 22; -- Jürgen Klinsmann (South Korea FC)
UPDATE TeamInfo SET ManagerID = 23 WHERE TeamID = 23; -- Kasper Hjulmand (Denmark FC)
UPDATE TeamInfo SET ManagerID = 24 WHERE TeamID = 24; -- Dragan Stojković (Serbia FC)
UPDATE TeamInfo SET ManagerID = 25 WHERE TeamID = 25; -- Jaime Lozano (Mexico FC)
UPDATE TeamInfo SET ManagerID = 26 WHERE TeamID = 26; -- Luis Fernando (Costa Rica FC)
UPDATE TeamInfo SET ManagerID = 27 WHERE TeamID = 27; -- Hajime Moriyasu (Japan FC)
UPDATE TeamInfo SET ManagerID = 28 WHERE TeamID = 28; -- Amir Ghalenoei (Iran FC)
UPDATE TeamInfo SET ManagerID = 29 WHERE TeamID = 29; -- Markku Kanerva (Finland FC)
UPDATE TeamInfo SET ManagerID = 30 WHERE TeamID = 30; -- Matjaž Kek (Slovenia FC)
UPDATE TeamInfo SET ManagerID = 31 WHERE TeamID = 31; -- Sylvinho Barbosa (Albania FC)

select * from TeamInfo;

INSERT INTO TeamPlayers (ID, TeamID, PlayerID) VALUES (1, 1, 1);
INSERT INTO TeamPlayers (ID, TeamID, PlayerID) VALUES (2, 2, 2);
INSERT INTO TeamPlayers (ID, TeamID, PlayerID) VALUES (3, 3, 3);
INSERT INTO TeamPlayers (ID, TeamID, PlayerID) VALUES (4, 4, 4);
INSERT INTO TeamPlayers (ID, TeamID, PlayerID) VALUES (5, 5, 5);
INSERT INTO TeamPlayers (ID, TeamID, PlayerID) VALUES (6, 6, 6);
INSERT INTO TeamPlayers (ID, TeamID, PlayerID) VALUES (7, 7, 7);
INSERT INTO TeamPlayers (ID, TeamID, PlayerID) VALUES (8, 8, 8);
INSERT INTO TeamPlayers (ID, TeamID, PlayerID) VALUES (9, 9, 9);
INSERT INTO TeamPlayers (ID, TeamID, PlayerID) VALUES (10, 10, 10);
INSERT INTO TeamPlayers (ID, TeamID, PlayerID) VALUES (11, 11, 11);
INSERT INTO TeamPlayers (ID, TeamID, PlayerID) VALUES (12, 12, 12);
INSERT INTO TeamPlayers (ID, TeamID, PlayerID) VALUES (13, 13, 13);
INSERT INTO TeamPlayers (ID, TeamID, PlayerID) VALUES (14, 14, 14);
INSERT INTO TeamPlayers (ID, TeamID, PlayerID) VALUES (15, 15, 15);
INSERT INTO TeamPlayers (ID, TeamID, PlayerID) VALUES (16, 16, 16);
INSERT INTO TeamPlayers (ID, TeamID, PlayerID) VALUES (17, 17, 17);
INSERT INTO TeamPlayers (ID, TeamID, PlayerID) VALUES (18, 18, 18);
INSERT INTO TeamPlayers (ID, TeamID, PlayerID) VALUES (19, 19, 19);
INSERT INTO TeamPlayers (ID, TeamID, PlayerID) VALUES (20, 20, 20);
INSERT INTO TeamPlayers (ID, TeamID, PlayerID) VALUES (21, 21, 21);
INSERT INTO TeamPlayers (ID, TeamID, PlayerID) VALUES (22, 1, 22);
INSERT INTO TeamPlayers (ID, TeamID, PlayerID) VALUES (23, 2, 23);
INSERT INTO TeamPlayers (ID, TeamID, PlayerID) VALUES (24, 3, 24);
INSERT INTO TeamPlayers (ID, TeamID, PlayerID) VALUES (25, 4, 25);
INSERT INTO TeamPlayers (ID, TeamID, PlayerID) VALUES (26, 5, 26);
INSERT INTO TeamPlayers (ID, TeamID, PlayerID) VALUES (27, 6, 27);
INSERT INTO TeamPlayers (ID, TeamID, PlayerID) VALUES (28, 7, 28);
INSERT INTO TeamPlayers (ID, TeamID, PlayerID) VALUES (29, 8, 29);
INSERT INTO TeamPlayers (ID, TeamID, PlayerID) VALUES (30, 9, 30);
INSERT INTO TeamPlayers (ID, TeamID, PlayerID) VALUES (31, 10, 31);
INSERT INTO TeamPlayers (ID, TeamID, PlayerID) VALUES (32, 11, 32);
INSERT INTO TeamPlayers (ID, TeamID, PlayerID) VALUES (33, 12, 33);
INSERT INTO TeamPlayers (ID, TeamID, PlayerID) VALUES (34, 13, 34);
INSERT INTO TeamPlayers (ID, TeamID, PlayerID) VALUES (35, 14, 35);
INSERT INTO TeamPlayers (ID, TeamID, PlayerID) VALUES (36, 15, 36);
INSERT INTO TeamPlayers (ID, TeamID, PlayerID) VALUES (37, 16, 37);
INSERT INTO TeamPlayers (ID, TeamID, PlayerID) VALUES (38, 17, 38);
INSERT INTO TeamPlayers (ID, TeamID, PlayerID) VALUES (39, 18, 39);
INSERT INTO TeamPlayers (ID, TeamID, PlayerID) VALUES (40, 19, 40);
INSERT INTO TeamPlayers (ID, TeamID, PlayerID) VALUES (41, 20, 41);
INSERT INTO TeamPlayers (ID, TeamID, PlayerID) VALUES (42, 21, 42);
INSERT INTO TeamPlayers (ID, TeamID, PlayerID) VALUES (43, 1, 43);
INSERT INTO TeamPlayers (ID, TeamID, PlayerID) VALUES (44, 2, 44);
INSERT INTO TeamPlayers (ID, TeamID, PlayerID) VALUES (45, 3, 45);
INSERT INTO TeamPlayers (ID, TeamID, PlayerID) VALUES (46, 4, 46);
INSERT INTO TeamPlayers (ID, TeamID, PlayerID) VALUES (47, 5, 47);
INSERT INTO TeamPlayers (ID, TeamID, PlayerID) VALUES (48, 6, 48);
INSERT INTO TeamPlayers (ID, TeamID, PlayerID) VALUES (49, 7, 49);
INSERT INTO TeamPlayers (ID, TeamID, PlayerID) VALUES (50, 8, 50);

-- New players (PlayerID 51–60) → TeamID 22–31
INSERT INTO TeamPlayers (ID, TeamID, PlayerID) VALUES (51, 22, 51);
INSERT INTO TeamPlayers (ID, TeamID, PlayerID) VALUES (52, 23, 52);
INSERT INTO TeamPlayers (ID, TeamID, PlayerID) VALUES (53, 24, 53);
INSERT INTO TeamPlayers (ID, TeamID, PlayerID) VALUES (54, 25, 54);
INSERT INTO TeamPlayers (ID, TeamID, PlayerID) VALUES (55, 26, 55);
INSERT INTO TeamPlayers (ID, TeamID, PlayerID) VALUES (56, 27, 56);
INSERT INTO TeamPlayers (ID, TeamID, PlayerID) VALUES (57, 28, 57);
INSERT INTO TeamPlayers (ID, TeamID, PlayerID) VALUES (58, 29, 58);
INSERT INTO TeamPlayers (ID, TeamID, PlayerID) VALUES (59, 30, 59);
INSERT INTO TeamPlayers (ID, TeamID, PlayerID) VALUES (60, 31, 60);

select * from TeamPlayers;
select * from playerinfo;
select * from teaminfo;
select * from users;
select * from playerinfo;


INSERT INTO TeamInfo (TeamID, TeamName, Country, NumOfMatchesPlayed, MatchesWon, MatchesLost, MatchesTie, TotalGoalsScored, ManagerID) VALUES (1, 'Portugal FC', 'Portugal', 195, 117, 45, 33, 360, 1);
INSERT INTO TeamInfo (TeamID, TeamName, Country, NumOfMatchesPlayed, MatchesWon, MatchesLost, MatchesTie, TotalGoalsScored, ManagerID) VALUES (2, 'Argentina FC', 'Argentina', 225, 135, 50, 40, 420, 2);
INSERT INTO TeamInfo (TeamID, TeamName, Country, NumOfMatchesPlayed, MatchesWon, MatchesLost, MatchesTie, TotalGoalsScored, ManagerID) VALUES (3, 'Brazil FC', 'Brazil', 250, 160, 45, 45, 500, 3);
INSERT INTO TeamInfo (TeamID, TeamName, Country, NumOfMatchesPlayed, MatchesWon, MatchesLost, MatchesTie, TotalGoalsScored, ManagerID) VALUES (4, 'France FC', 'France', 230, 145, 50, 35, 460, 4);
INSERT INTO TeamInfo (TeamID, TeamName, Country, NumOfMatchesPlayed, MatchesWon, MatchesLost, MatchesTie, TotalGoalsScored, ManagerID) VALUES (5, 'Poland FC', 'Poland', 180, 95, 55, 30, 290, 5);
INSERT INTO TeamInfo (TeamID, TeamName, Country, NumOfMatchesPlayed, MatchesWon, MatchesLost, MatchesTie, TotalGoalsScored, ManagerID) VALUES (6, 'England FC', 'England', 240, 150, 50, 40, 470, 6);
INSERT INTO TeamInfo (TeamID, TeamName, Country, NumOfMatchesPlayed, MatchesWon, MatchesLost, MatchesTie, TotalGoalsScored, ManagerID) VALUES (7, 'Norway FC', 'Norway', 160, 85, 50, 25, 220, 7);
INSERT INTO TeamInfo (TeamID, TeamName, Country, NumOfMatchesPlayed, MatchesWon, MatchesLost, MatchesTie, TotalGoalsScored, ManagerID) VALUES (8, 'Egypt FC', 'Egypt', 210, 125, 55, 30, 350, 8);
INSERT INTO TeamInfo (TeamID, TeamName, Country, NumOfMatchesPlayed, MatchesWon, MatchesLost, MatchesTie, TotalGoalsScored, ManagerID) VALUES (9, 'Belgium FC', 'Belgium', 220, 140, 45, 35, 440, 9);
INSERT INTO TeamInfo (TeamID, TeamName, Country, NumOfMatchesPlayed, MatchesWon, MatchesLost, MatchesTie, TotalGoalsScored, ManagerID) VALUES (10, 'Croatia FC', 'Croatia', 190, 110, 45, 35, 320, 10);
INSERT INTO TeamInfo (TeamID, TeamName, Country, NumOfMatchesPlayed, MatchesWon, MatchesLost, MatchesTie, TotalGoalsScored, ManagerID) VALUES (11, 'Spain FC', 'Spain', 235, 145, 50, 40, 460, 11);
INSERT INTO TeamInfo (TeamID, TeamName, Country, NumOfMatchesPlayed, MatchesWon, MatchesLost, MatchesTie, TotalGoalsScored, ManagerID) VALUES (12, 'Germany FC', 'Germany', 260, 165, 55, 40, 510, 12);
INSERT INTO TeamInfo (TeamID, TeamName, Country, NumOfMatchesPlayed, MatchesWon, MatchesLost, MatchesTie, TotalGoalsScored, ManagerID) VALUES (13, 'Netherlands FC', 'Netherlands', 210, 130, 50, 30, 390, 13);
INSERT INTO TeamInfo (TeamID, TeamName, Country, NumOfMatchesPlayed, MatchesWon, MatchesLost, MatchesTie, TotalGoalsScored, ManagerID) VALUES (14, 'Canada FC', 'Canada', 140, 80, 40, 20, 200, 14);
INSERT INTO TeamInfo (TeamID, TeamName, Country, NumOfMatchesPlayed, MatchesWon, MatchesLost, MatchesTie, TotalGoalsScored, ManagerID) VALUES (15, 'Morocco FC', 'Morocco', 190, 110, 50, 30, 310, 15);
INSERT INTO TeamInfo (TeamID, TeamName, Country, NumOfMatchesPlayed, MatchesWon, MatchesLost, MatchesTie, TotalGoalsScored, ManagerID) VALUES (16, 'Italy FC', 'Italy', 250, 155, 55, 40, 480, 16);
INSERT INTO TeamInfo (TeamID, TeamName, Country, NumOfMatchesPlayed, MatchesWon, MatchesLost, MatchesTie, TotalGoalsScored, ManagerID) VALUES (17, 'USA FC', 'USA', 200, 120, 50, 30, 340, 17);
INSERT INTO TeamInfo (TeamID, TeamName, Country, NumOfMatchesPlayed, MatchesWon, MatchesLost, MatchesTie, TotalGoalsScored, ManagerID) VALUES (18, 'Uruguay FC', 'Uruguay', 215, 130, 55, 30, 370, 18);
INSERT INTO TeamInfo (TeamID, TeamName, Country, NumOfMatchesPlayed, MatchesWon, MatchesLost, MatchesTie, TotalGoalsScored, ManagerID) VALUES (19, 'Sweden FC', 'Sweden', 195, 115, 50, 30, 330, 19);
INSERT INTO TeamInfo (TeamID, TeamName, Country, NumOfMatchesPlayed, MatchesWon, MatchesLost, MatchesTie, TotalGoalsScored, ManagerID) VALUES (20, 'Belgium FC', 'Belgium', 85, 50, 20, 15, 125, 20);
INSERT INTO TeamInfo (TeamID, TeamName, Country, NumOfMatchesPlayed, MatchesWon, MatchesLost, MatchesTie, TotalGoalsScored, ManagerID) VALUES (21, 'France FC', 'France', 95, 55, 25, 15, 130, 21);
INSERT INTO TeamInfo (TeamID, TeamName, Country, NumOfMatchesPlayed, MatchesWon, MatchesLost, MatchesTie, TotalGoalsScored, ManagerID) VALUES (22, 'South Korea FC', 'South Korea', 210, 120, 60, 30, 350, 22);
INSERT INTO TeamInfo (TeamID, TeamName, Country, NumOfMatchesPlayed, MatchesWon, MatchesLost, MatchesTie, TotalGoalsScored, ManagerID) VALUES (23, 'Denmark FC', 'Denmark', 205, 115, 55, 35, 340, 23);
INSERT INTO TeamInfo (TeamID, TeamName, Country, NumOfMatchesPlayed, MatchesWon, MatchesLost, MatchesTie, TotalGoalsScored, ManagerID) VALUES (24, 'Serbia FC', 'Serbia', 180, 95, 60, 25, 310, 24);
INSERT INTO TeamInfo (TeamID, TeamName, Country, NumOfMatchesPlayed, MatchesWon, MatchesLost, MatchesTie, TotalGoalsScored, ManagerID) VALUES (25, 'Mexico FC', 'Mexico', 225, 135, 55, 35, 400, 25);
INSERT INTO TeamInfo (TeamID, TeamName, Country, NumOfMatchesPlayed, MatchesWon, MatchesLost, MatchesTie, TotalGoalsScored, ManagerID) VALUES (26, 'Costa Rica FC', 'Costa Rica', 175, 100, 50, 25, 280, 26);
INSERT INTO TeamInfo (TeamID, TeamName, Country, NumOfMatchesPlayed, MatchesWon, MatchesLost, MatchesTie, TotalGoalsScored, ManagerID) VALUES (27, 'Japan FC', 'Japan', 230, 140, 60, 30, 390, 27);
INSERT INTO TeamInfo (TeamID, TeamName, Country, NumOfMatchesPlayed, MatchesWon, MatchesLost, MatchesTie, TotalGoalsScored, ManagerID) VALUES (28, 'Iran FC', 'Iran', 190, 105, 60, 25, 320, 28);
INSERT INTO TeamInfo (TeamID, TeamName, Country, NumOfMatchesPlayed, MatchesWon, MatchesLost, MatchesTie, TotalGoalsScored, ManagerID) VALUES (29, 'Finland FC', 'Finland', 160, 85, 50, 25, 240, 29);
INSERT INTO TeamInfo (TeamID, TeamName, Country, NumOfMatchesPlayed, MatchesWon, MatchesLost, MatchesTie, TotalGoalsScored, ManagerID) VALUES (30, 'Slovenia FC', 'Slovenia', 150, 80, 45, 25, 220, 30);
INSERT INTO TeamInfo (TeamID, TeamName, Country, NumOfMatchesPlayed, MatchesWon, MatchesLost, MatchesTie, TotalGoalsScored, ManagerID) VALUES (31, 'Albania FC', 'Albania', 140, 75, 45, 20, 210, 31);

-- checking for duplicates if at all you executed insertion statements twice by mistake
-- Tip: replace table name and table attributes in the from and group by clauses.
SELECT *, COUNT(*)
FROM users
GROUP BY UserID, UserName, UserPassword, UserFirstName, UserLastName, UserRole, Email, Mobile
HAVING COUNT(*) > 1;

select *  from teaminfo;

INSERT INTO MatchInfo (MatchID, MatchName, Venue, MatchDate) VALUES (1, 'Portugal FC vs Argentina FC', 'Old Trafford, Manchester', '2014-11-18');
INSERT INTO MatchInfo (MatchID, MatchName, Venue, MatchDate) VALUES (2, 'Portugal FC vs Brazil FC', 'Moses Mabhida Stadium, Durban', '2010-06-25');
INSERT INTO MatchInfo (MatchID, MatchName, Venue, MatchDate) VALUES (3, 'Portugal FC vs France FC', 'Stade de France, Saint-Denis', '2016-07-10');
INSERT INTO MatchInfo (MatchID, MatchName, Venue, MatchDate) VALUES (4, 'Portugal FC vs Poland FC', 'Silesian Stadium, Chorzów', '2018-10-11');
INSERT INTO MatchInfo (MatchID, MatchName, Venue, MatchDate) VALUES (5, 'Portugal FC vs England FC', 'Gelsenkirchen', '2006-07-01');
INSERT INTO MatchInfo (MatchID, MatchName, Venue, MatchDate) VALUES (6, 'Portugal FC vs Norway FC', 'Estádio da Luz, Lisbon', '2011-06-04');
INSERT INTO MatchInfo (MatchID, MatchName, Venue, MatchDate) VALUES (7, 'Portugal FC vs Egypt FC', 'Letzigrund, Zurich', '2018-03-23');
INSERT INTO MatchInfo (MatchID, MatchName, Venue, MatchDate) VALUES (8, 'Portugal FC vs Belgium FC', 'La Cartuja, Seville', '2021-06-27');
INSERT INTO MatchInfo (MatchID, MatchName, Venue, MatchDate) VALUES (9, 'Portugal FC vs Croatia FC', 'Poljud Stadium, Split', '2020-11-17');
INSERT INTO MatchInfo (MatchID, MatchName, Venue, MatchDate) VALUES (10, 'Portugal FC vs Spain FC', 'Fisht Olympic Stadium, Sochi', '2018-06-15');
INSERT INTO MatchInfo (MatchID, MatchName, Venue, MatchDate) VALUES (11, 'Portugal FC vs Germany FC', 'Allianz Arena, Munich', '2021-06-19');

INSERT INTO MatchInfo (MatchID, MatchName, Venue, MatchDate) VALUES (12, 'Portugal FC vs Croatia FC', 'Estádio do SL Benfica, Lisbon', '2024-09-05');
INSERT INTO MatchInfo (MatchID, MatchName, Venue, MatchDate) VALUES (13, 'Portugal FC vs Scotland FC', 'Estádio do SL Benfica, Lisbon', '2024-09-08');
INSERT INTO MatchInfo (MatchID, MatchName, Venue, MatchDate) VALUES (14, 'Portugal FC vs Poland FC', 'PGE Narodowy, Warsaw', '2024-10-12');
INSERT INTO MatchInfo (MatchID, MatchName, Venue, MatchDate) VALUES (15, 'Portugal FC vs Slovenia FC', 'Waldstadion, Frankfurt', '2024-07-01');
INSERT INTO MatchInfo (MatchID, MatchName, Venue, MatchDate) VALUES (16, 'Portugal FC vs France FC', 'Volksparkstadion, Hamburg', '2024-07-05');
INSERT INTO MatchInfo (MatchID, MatchName, Venue, MatchDate) VALUES (17, 'Portugal FC vs Ghana FC', 'Stadium 974, Doha', '2022-11-24');
INSERT INTO MatchInfo (MatchID, MatchName, Venue, MatchDate) VALUES (18, 'Portugal FC vs Uruguay FC', 'Lusail Stadium, Lusail', '2022-11-28');
INSERT INTO MatchInfo (MatchID, MatchName, Venue, MatchDate) VALUES (19, 'Portugal FC vs Switzerland FC', 'Lusail Stadium, Lusail', '2022-12-06');
INSERT INTO MatchInfo (MatchID, MatchName, Venue, MatchDate) VALUES (20, 'Portugal FC vs Morocco FC', 'Al Thumama Stadium, Doha', '2022-12-10');
INSERT INTO MatchInfo (MatchID, MatchName, Venue, MatchDate) VALUES (21, 'Portugal FC vs Spain FC', 'Estádio Municipal de Braga, Braga', '2022-09-27');
INSERT INTO MatchInfo (MatchID, MatchName, Venue, MatchDate) VALUES (22, 'Portugal FC vs Czech Republic FC', 'Estádio José Alvalade, Lisbon', '2022-06-09');
INSERT INTO MatchInfo (MatchID, MatchName, Venue, MatchDate) VALUES (23, 'Portugal FC vs Switzerland FC', 'Estádio José Alvalade, Lisbon', '2022-06-05');
INSERT INTO MatchInfo (MatchID, MatchName, Venue, MatchDate) VALUES (24, 'Portugal FC vs Turkey FC', 'Estádio do Dragão, Porto', '2022-03-24');
INSERT INTO MatchInfo (MatchID, MatchName, Venue, MatchDate) VALUES (25, 'Portugal FC vs North Macedonia FC', 'Estádio do Dragão, Porto', '2022-03-29');
INSERT INTO MatchInfo (MatchID, MatchName, Venue, MatchDate) VALUES (26, 'Portugal FC vs Ireland FC', 'Aviva Stadium, Dublin', '2021-11-11');

select * from matchinfo; 

INSERT INTO MatchHistory (ID, MatchID, TeamID, PlayedAgainst, MatchResult) VALUES (1, 1, 1, 2, '1-0 - Win');
INSERT INTO MatchHistory (ID, MatchID, TeamID, PlayedAgainst, MatchResult) VALUES (2, 2, 1, 3, '0-0 - Draw');
INSERT INTO MatchHistory (ID, MatchID, TeamID, PlayedAgainst, MatchResult) VALUES (3, 3, 1, 4, '1-0 - Win');
INSERT INTO MatchHistory (ID, MatchID, TeamID, PlayedAgainst, MatchResult) VALUES (4, 4, 1, 5, '3-2 - Win');
INSERT INTO MatchHistory (ID, MatchID, TeamID, PlayedAgainst, MatchResult) VALUES (5, 5, 1, 6, '0-0 (3-1 pens) - Draw');
INSERT INTO MatchHistory (ID, MatchID, TeamID, PlayedAgainst, MatchResult) VALUES (6, 6, 1, 7, '1-0 - Win');
INSERT INTO MatchHistory (ID, MatchID, TeamID, PlayedAgainst, MatchResult) VALUES (7, 7, 1, 8, '2-1 - Win');
INSERT INTO MatchHistory (ID, MatchID, TeamID, PlayedAgainst, MatchResult) VALUES (8, 8, 1, 9, '0-1 - Loss');
INSERT INTO MatchHistory (ID, MatchID, TeamID, PlayedAgainst, MatchResult) VALUES (9, 9, 1, 10, '3-2 - Win');
INSERT INTO MatchHistory (ID, MatchID, TeamID, PlayedAgainst, MatchResult) VALUES (10, 10, 1, 11, '3-3 - Draw');
INSERT INTO MatchHistory (ID, MatchID, TeamID, PlayedAgainst, MatchResult) VALUES (11, 11, 1, 12, '2-4 - Loss');
INSERT INTO MatchHistory (ID, MatchID, TeamID, PlayedAgainst, MatchResult) VALUES (12, 12, 1, 10, '2-1 - Win');
INSERT INTO MatchHistory (ID, MatchID, TeamID, PlayedAgainst, MatchResult) VALUES (13, 13, 1, 23, '2-1 - Win');
INSERT INTO MatchHistory (ID, MatchID, TeamID, PlayedAgainst, MatchResult) VALUES (14, 14, 1, 5, '3-1 - Win');
INSERT INTO MatchHistory (ID, MatchID, TeamID, PlayedAgainst, MatchResult) VALUES (15, 15, 1, 30, '0-0 (5-3 pens) - Draw');
INSERT INTO MatchHistory (ID, MatchID, TeamID, PlayedAgainst, MatchResult) VALUES (16, 16, 1, 4, '0-1 - Loss');
INSERT INTO MatchHistory (ID, MatchID, TeamID, PlayedAgainst, MatchResult) VALUES (17, 17, 1, 15, '3-2 - Win');
INSERT INTO MatchHistory (ID, MatchID, TeamID, PlayedAgainst, MatchResult) VALUES (18, 18, 1, 18, '2-0 - Win');
INSERT INTO MatchHistory (ID, MatchID, TeamID, PlayedAgainst, MatchResult) VALUES (19, 19, 1, 9, '6-1 - Win');
INSERT INTO MatchHistory (ID, MatchID, TeamID, PlayedAgainst, MatchResult) VALUES (20, 20, 1, 15, '0-1 - Loss');
INSERT INTO MatchHistory (ID, MatchID, TeamID, PlayedAgainst, MatchResult) VALUES (21, 21, 1, 11, '0-1 - Loss');
INSERT INTO MatchHistory (ID, MatchID, TeamID, PlayedAgainst, MatchResult) VALUES (22, 22, 1, 23, '2-0 - Win');
INSERT INTO MatchHistory (ID, MatchID, TeamID, PlayedAgainst, MatchResult) VALUES (23, 23, 1, 9, '4-0 - Win');
INSERT INTO MatchHistory (ID, MatchID, TeamID, PlayedAgainst, MatchResult) VALUES (24, 24, 1, 24, '3-1 - Win');
INSERT INTO MatchHistory (ID, MatchID, TeamID, PlayedAgainst, MatchResult) VALUES (25, 25, 1, 31, '2-0 - Win');
INSERT INTO MatchHistory (ID, MatchID, TeamID, PlayedAgainst, MatchResult) VALUES (26, 26, 1, 17, '0-0 - Draw');

select * from matchhistory;


-- delete from matchhistory;

INSERT INTO PlayerHistory (ID, PlayerID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored) VALUES (1, 1, 1, 1, 2, '2014-01-01', '0-0 - Draw', 0);
INSERT INTO PlayerHistory (ID, PlayerID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored) VALUES (2, 2, 1, 1, 2, '2014-01-01', '0-0 - Draw', 0);
INSERT INTO PlayerHistory (ID, PlayerID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored) VALUES (3, 2, 2, 1, 3, '2014-06-30', '2-3 - Loss', 2);
INSERT INTO PlayerHistory (ID, PlayerID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored) VALUES (4, 3, 2, 1, 3, '2014-06-30', '2-3 - Loss', 3);
INSERT INTO PlayerHistory (ID, PlayerID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored) VALUES (5, 3, 3, 1, 4, '2014-12-27', '0-2 - Loss', 0);
INSERT INTO PlayerHistory (ID, PlayerID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored) VALUES (6, 4, 3, 1, 4, '2014-12-27', '0-2 - Loss', 2);
INSERT INTO PlayerHistory (ID, PlayerID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored) VALUES (7, 4, 4, 1, 5, '2015-06-25', '2-1 - Win', 2);
INSERT INTO PlayerHistory (ID, PlayerID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored) VALUES (8, 5, 4, 1, 5, '2015-06-25', '2-1 - Win', 1);
INSERT INTO PlayerHistory (ID, PlayerID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored) VALUES (9, 5, 5, 1, 6, '2015-12-22', '0-0 - Draw', 0);
INSERT INTO PlayerHistory (ID, PlayerID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored) VALUES (10, 6, 5, 1, 6, '2015-12-22', '0-0 - Draw', 0);
INSERT INTO PlayerHistory (ID, PlayerID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored) VALUES (11, 6, 6, 1, 7, '2016-06-19', '2-3 - Loss', 2);
INSERT INTO PlayerHistory (ID, PlayerID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored) VALUES (12, 7, 6, 1, 7, '2016-06-19', '2-3 - Loss', 3);
INSERT INTO PlayerHistory (ID, PlayerID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored) VALUES (13, 7, 7, 1, 8, '2016-12-16', '0-2 - Loss', 0);
INSERT INTO PlayerHistory (ID, PlayerID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored) VALUES (14, 8, 7, 1, 8, '2016-12-16', '0-2 - Loss', 2);
INSERT INTO PlayerHistory (ID, PlayerID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored) VALUES (15, 8, 8, 1, 9, '2017-06-14', '2-1 - Win', 2);
INSERT INTO PlayerHistory (ID, PlayerID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored) VALUES (16, 9, 8, 1, 9, '2017-06-14', '2-1 - Win', 1);
INSERT INTO PlayerHistory (ID, PlayerID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored) VALUES (17, 9, 9, 1, 10, '2017-12-11', '0-0 - Draw', 0);
INSERT INTO PlayerHistory (ID, PlayerID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored) VALUES (18, 10, 9, 1, 10, '2017-12-11', '0-0 - Draw', 0);
INSERT INTO PlayerHistory (ID, PlayerID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored) VALUES (19, 10, 10, 1, 11, '2018-06-09', '2-3 - Loss', 2);
INSERT INTO PlayerHistory (ID, PlayerID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored) VALUES (20, 11, 10, 1, 11, '2018-06-09', '2-3 - Loss', 3);
INSERT INTO PlayerHistory (ID, PlayerID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored) VALUES (21, 11, 11, 1, 12, '2018-12-06', '0-2 - Loss', 0);
INSERT INTO PlayerHistory (ID, PlayerID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored) VALUES (22, 12, 11, 1, 12, '2018-12-06', '0-2 - Loss', 2);
INSERT INTO PlayerHistory (ID, PlayerID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored) VALUES (23, 12, 12, 1, 13, '2019-06-04', '2-1 - Win', 2);
INSERT INTO PlayerHistory (ID, PlayerID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored) VALUES (24, 13, 12, 1, 13, '2019-06-04', '2-1 - Win', 1);
INSERT INTO PlayerHistory (ID, PlayerID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored) VALUES (25, 13, 13, 1, 14, '2019-12-01', '0-0 - Draw', 0);
INSERT INTO PlayerHistory (ID, PlayerID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored) VALUES (26, 14, 13, 1, 14, '2019-12-01', '0-0 - Draw', 0);
INSERT INTO PlayerHistory (ID, PlayerID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored) VALUES (27, 14, 14, 1, 15, '2020-05-29', '2-3 - Loss', 2);
INSERT INTO PlayerHistory (ID, PlayerID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored) VALUES (28, 15, 14, 1, 15, '2020-05-29', '2-3 - Loss', 3);
INSERT INTO PlayerHistory (ID, PlayerID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored) VALUES (29, 15, 15, 1, 16, '2020-11-25', '0-2 - Loss', 0);
INSERT INTO PlayerHistory (ID, PlayerID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored) VALUES (30, 16, 15, 1, 16, '2020-11-25', '0-2 - Loss', 2);
INSERT INTO PlayerHistory (ID, PlayerID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored) VALUES (31, 16, 16, 1, 17, '2021-05-24', '2-1 - Win', 2);
INSERT INTO PlayerHistory (ID, PlayerID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored) VALUES (32, 17, 16, 1, 17, '2021-05-24', '2-1 - Win', 1);
INSERT INTO PlayerHistory (ID, PlayerID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored) VALUES (33, 17, 17, 1, 18, '2021-11-20', '0-0 - Draw', 0);
INSERT INTO PlayerHistory (ID, PlayerID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored) VALUES (34, 18, 17, 1, 18, '2021-11-20', '0-0 - Draw', 0);
INSERT INTO PlayerHistory (ID, PlayerID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored) VALUES (35, 18, 18, 1, 19, '2022-05-19', '2-3 - Loss', 2);
INSERT INTO PlayerHistory (ID, PlayerID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored) VALUES (36, 19, 18, 1, 19, '2022-05-19', '2-3 - Loss', 3);
INSERT INTO PlayerHistory (ID, PlayerID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored) VALUES (37, 19, 19, 1, 20, '2022-11-15', '0-2 - Loss', 0);
INSERT INTO PlayerHistory (ID, PlayerID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored) VALUES (38, 20, 19, 1, 20, '2022-11-15', '0-2 - Loss', 2);
INSERT INTO PlayerHistory (ID, PlayerID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored) VALUES (39, 20, 20, 1, 21, '2023-05-14', '2-1 - Win', 2);
INSERT INTO PlayerHistory (ID, PlayerID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored) VALUES (40, 21, 20, 1, 21, '2023-05-14', '2-1 - Win', 1);
INSERT INTO PlayerHistory (ID, PlayerID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored) VALUES (41, 21, 21, 1, 22, '2023-11-10', '0-0 - Draw', 0);
INSERT INTO PlayerHistory (ID, PlayerID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored) VALUES (42, 22, 21, 1, 22, '2023-11-10', '0-0 - Draw', 0);
INSERT INTO PlayerHistory (ID, PlayerID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored) VALUES (43, 22, 22, 1, 23, '2024-05-08', '2-3 - Loss', 2);
INSERT INTO PlayerHistory (ID, PlayerID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored) VALUES (44, 23, 22, 1, 23, '2024-05-08', '2-3 - Loss', 3);
INSERT INTO PlayerHistory (ID, PlayerID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored) VALUES (45, 23, 23, 1, 24, '2024-11-04', '0-2 - Loss', 0);
INSERT INTO PlayerHistory (ID, PlayerID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored) VALUES (46, 24, 23, 1, 24, '2024-11-04', '0-2 - Loss', 2);
INSERT INTO PlayerHistory (ID, PlayerID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored) VALUES (47, 24, 24, 1, 25, '2025-05-03', '2-1 - Win', 2);
INSERT INTO PlayerHistory (ID, PlayerID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored) VALUES (48, 25, 24, 1, 25, '2025-05-03', '2-1 - Win', 1);
INSERT INTO PlayerHistory (ID, PlayerID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored) VALUES (49, 25, 25, 1, 26, '2025-10-30', '0-0 - Draw', 0);
INSERT INTO PlayerHistory (ID, PlayerID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored) VALUES (50, 26, 25, 1, 26, '2025-10-30', '0-0 - Draw', 0);
INSERT INTO PlayerHistory (ID, PlayerID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored) VALUES (51, 26, 26, 1, 27, '2026-04-28', '2-3 - Loss', 2);
INSERT INTO PlayerHistory (ID, PlayerID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored) VALUES (52, 27, 26, 1, 27, '2026-04-28', '2-3 - Loss', 3);

select * from playerhistory;

INSERT INTO TeamHistory (ID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored) VALUES (1, 1, 1, 2, '2014-01-01', 'Draw', 0);
INSERT INTO TeamHistory (ID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored) VALUES (2, 2, 1, 3, '2014-06-30', 'Loss', 2);
INSERT INTO TeamHistory (ID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored) VALUES (3, 3, 1, 4, '2014-12-27', 'Loss', 0);
INSERT INTO TeamHistory (ID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored) VALUES (4, 4, 1, 5, '2015-06-25', 'Win', 2);
INSERT INTO TeamHistory (ID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored) VALUES (5, 5, 1, 6, '2015-12-22', 'Draw', 0);
INSERT INTO TeamHistory (ID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored) VALUES (6, 6, 1, 7, '2016-06-19', 'Loss', 2);
INSERT INTO TeamHistory (ID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored) VALUES (7, 7, 1, 8, '2016-12-16', 'Loss', 0);
INSERT INTO TeamHistory (ID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored) VALUES (8, 8, 1, 9, '2017-06-14', 'Win', 2);
INSERT INTO TeamHistory (ID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored) VALUES (9, 9, 1, 10, '2017-12-11', 'Draw', 0);
INSERT INTO TeamHistory (ID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored) VALUES (10, 10, 1, 11, '2018-06-09', 'Loss', 2);
INSERT INTO TeamHistory (ID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored) VALUES (11, 11, 1, 12, '2018-12-06', 'Loss', 0);
INSERT INTO TeamHistory (ID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored) VALUES (12, 12, 1, 13, '2019-06-04', 'Win', 2);
INSERT INTO TeamHistory (ID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored) VALUES (13, 13, 1, 14, '2019-12-01', 'Draw', 0);
INSERT INTO TeamHistory (ID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored) VALUES (14, 14, 1, 15, '2020-05-29', 'Loss', 2);
INSERT INTO TeamHistory (ID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored) VALUES (15, 15, 1, 16, '2020-11-25', 'Loss', 0);
INSERT INTO TeamHistory (ID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored) VALUES (16, 16, 1, 17, '2021-05-24', 'Win', 2);
INSERT INTO TeamHistory (ID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored) VALUES (17, 17, 1, 18, '2021-11-20', 'Draw', 0);
INSERT INTO TeamHistory (ID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored) VALUES (18, 18, 1, 19, '2022-05-19', 'Loss', 2);
INSERT INTO TeamHistory (ID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored) VALUES (19, 19, 1, 20, '2022-11-15', 'Loss', 0);
INSERT INTO TeamHistory (ID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored) VALUES (20, 20, 1, 21, '2023-05-14', 'Win', 2);
INSERT INTO TeamHistory (ID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored) VALUES (21, 21, 1, 22, '2023-11-10', 'Draw', 0);
INSERT INTO TeamHistory (ID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored) VALUES (22, 22, 1, 23, '2024-05-08', 'Loss', 2);
INSERT INTO TeamHistory (ID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored) VALUES (23, 23, 1, 24, '2024-11-04', 'Loss', 0);
INSERT INTO TeamHistory (ID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored) VALUES (24, 24, 1, 25, '2025-05-03', 'Win', 2);
INSERT INTO TeamHistory (ID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored) VALUES (25, 25, 1, 26, '2025-10-30', 'Draw', 0);
INSERT INTO TeamHistory (ID, MatchID, TeamID, PlayedAgainst, MatchDate, MatchResult, GoalsScored) VALUES (26, 26, 1, 27, '2026-04-28', 'Loss', 2);

select * from teamhistory;

INSERT INTO TeamAwards (ID, TeamID, MatchID, PlayerID, AwardName, DateofAward) VALUES (1, 1, 1, 1, 'Best Team Performance', '2015-01-01');
INSERT INTO TeamAwards (ID, TeamID, MatchID, PlayerID, AwardName, DateofAward) VALUES (2, 1, 2, 4, 'Most Disciplined', '2015-08-29');
INSERT INTO TeamAwards (ID, TeamID, MatchID, PlayerID, AwardName, DateofAward) VALUES (3, 1, 3, 7, 'Best Strategy', '2016-04-25');
INSERT INTO TeamAwards (ID, TeamID, MatchID, PlayerID, AwardName, DateofAward) VALUES (4, 1, 4, 10, 'Team Spirit', '2016-12-21');
INSERT INTO TeamAwards (ID, TeamID, MatchID, PlayerID, AwardName, DateofAward) VALUES (5, 1, 5, 13, 'Fair Play', '2017-08-18');
INSERT INTO TeamAwards (ID, TeamID, MatchID, PlayerID, AwardName, DateofAward) VALUES (6, 1, 6, 16, 'Strongest Defense', '2018-04-15');
INSERT INTO TeamAwards (ID, TeamID, MatchID, PlayerID, AwardName, DateofAward) VALUES (7, 1, 7, 19, 'Most Aggressive', '2018-12-11');
INSERT INTO TeamAwards (ID, TeamID, MatchID, PlayerID, AwardName, DateofAward) VALUES (8, 1, 8, 22, 'Crowd Favorite', '2019-08-08');
INSERT INTO TeamAwards (ID, TeamID, MatchID, PlayerID, AwardName, DateofAward) VALUES (9, 1, 9, 25, 'Top Scoring Team', '2020-04-04');
INSERT INTO TeamAwards (ID, TeamID, MatchID, PlayerID, AwardName, DateofAward) VALUES (10, 1, 10, 28, 'Comeback Kings', '2020-11-30');
INSERT INTO TeamAwards (ID, TeamID, MatchID, PlayerID, AwardName, DateofAward) VALUES (11, 1, 11, 31, 'Best Passing Accuracy', '2021-07-28');
INSERT INTO TeamAwards (ID, TeamID, MatchID, PlayerID, AwardName, DateofAward) VALUES (12, 1, 12, 34, 'Most Possession', '2022-03-25');
INSERT INTO TeamAwards (ID, TeamID, MatchID, PlayerID, AwardName, DateofAward) VALUES (13, 1, 13, 37, 'Best Pressing', '2022-11-20');
INSERT INTO TeamAwards (ID, TeamID, MatchID, PlayerID, AwardName, DateofAward) VALUES (14, 1, 14, 40, 'Most Goals in a Match', '2023-07-18');
INSERT INTO TeamAwards (ID, TeamID, MatchID, PlayerID, AwardName, DateofAward) VALUES (15, 1, 15, 43, 'Flawless Win', '2024-03-14');
INSERT INTO TeamAwards (ID, TeamID, MatchID, PlayerID, AwardName, DateofAward) VALUES (16, 1, 6, 6, 'Historic Win', '2022-01-01');
INSERT INTO TeamAwards (ID, TeamID, MatchID, PlayerID, AwardName, DateofAward) VALUES (17, 1, 7, 13, 'Strong Second Half', '2022-04-01');
INSERT INTO TeamAwards (ID, TeamID, MatchID, PlayerID, AwardName, DateofAward) VALUES (18, 1, 8, 20, 'Clean Sheet', '2022-06-30');
INSERT INTO TeamAwards (ID, TeamID, MatchID, PlayerID, AwardName, DateofAward) VALUES (19, 1, 9, 27, 'Dominant Midfield', '2022-09-28');
INSERT INTO TeamAwards (ID, TeamID, MatchID, PlayerID, AwardName, DateofAward) VALUES (20, 1, 10, 34, 'Captain’s Leadership', '2022-12-27');
INSERT INTO TeamAwards (ID, TeamID, MatchID, PlayerID, AwardName, DateofAward) VALUES (21, 1, 11, 41, 'Smart Substitutions', '2023-03-27');
INSERT INTO TeamAwards (ID, TeamID, MatchID, PlayerID, AwardName, DateofAward) VALUES (22, 1, 12, 48, 'Solid Finishing', '2023-06-25');
INSERT INTO TeamAwards (ID, TeamID, MatchID, PlayerID, AwardName, DateofAward) VALUES (23, 1, 13, 55, 'Most Fouls Drawn', '2023-09-23');
INSERT INTO TeamAwards (ID, TeamID, MatchID, PlayerID, AwardName, DateofAward) VALUES (24, 1, 14, 2, 'Fan Favorite Squad', '2023-12-22');
INSERT INTO TeamAwards (ID, TeamID, MatchID, PlayerID, AwardName, DateofAward) VALUES (25, 1, 15, 9, 'Highest Pass Completion', '2024-03-21');

select * from teamawards;

INSERT INTO PlayerAwards (ID, MatchID, PlayerID, TeamID, AwardName, DateofAward) VALUES (1, 1, 4, 1, 'Man of the Match', '2016-01-01');
INSERT INTO PlayerAwards (ID, MatchID, PlayerID, TeamID, AwardName, DateofAward) VALUES (2, 2, 8, 1, 'Golden Boot', '2016-06-29');
INSERT INTO PlayerAwards (ID, MatchID, PlayerID, TeamID, AwardName, DateofAward) VALUES (3, 3, 12, 1, 'Assist King', '2016-12-26');
INSERT INTO PlayerAwards (ID, MatchID, PlayerID, TeamID, AwardName, DateofAward) VALUES (4, 4, 16, 1, 'Match Saver', '2017-06-24');
INSERT INTO PlayerAwards (ID, MatchID, PlayerID, TeamID, AwardName, DateofAward) VALUES (5, 5, 20, 1, 'Top Sprinter', '2017-12-21');
INSERT INTO PlayerAwards (ID, MatchID, PlayerID, TeamID, AwardName, DateofAward) VALUES (6, 6, 24, 1, 'Smartest Play', '2018-06-19');
INSERT INTO PlayerAwards (ID, MatchID, PlayerID, TeamID, AwardName, DateofAward) VALUES (7, 7, 28, 1, 'Finisher Extraordinaire', '2018-12-16');
INSERT INTO PlayerAwards (ID, MatchID, PlayerID, TeamID, AwardName, DateofAward) VALUES (8, 8, 32, 1, 'Game Changer', '2019-06-14');
INSERT INTO PlayerAwards (ID, MatchID, PlayerID, TeamID, AwardName, DateofAward) VALUES (9, 9, 36, 1, 'Defensive Wall', '2019-12-11');
INSERT INTO PlayerAwards (ID, MatchID, PlayerID, TeamID, AwardName, DateofAward) VALUES (10, 10, 40, 1, 'Midfield Maestro', '2020-06-08');
INSERT INTO PlayerAwards (ID, MatchID, PlayerID, TeamID, AwardName, DateofAward) VALUES (11, 11, 44, 1, 'Fan Favorite', '2020-12-05');
INSERT INTO PlayerAwards (ID, MatchID, PlayerID, TeamID, AwardName, DateofAward) VALUES (12, 12, 48, 1, 'Best Dribbler', '2021-06-03');
INSERT INTO PlayerAwards (ID, MatchID, PlayerID, TeamID, AwardName, DateofAward) VALUES (13, 13, 52, 1, 'Most Valuable Player', '2021-11-30');
INSERT INTO PlayerAwards (ID, MatchID, PlayerID, TeamID, AwardName, DateofAward) VALUES (14, 14, 56, 1, 'Clutch Performer', '2022-05-29');
INSERT INTO PlayerAwards (ID, MatchID, PlayerID, TeamID, AwardName, DateofAward) VALUES (15, 15, 60, 1, 'Breakthrough Star', '2022-11-25');
INSERT INTO PlayerAwards (ID, MatchID, PlayerID, TeamID, AwardName, DateofAward) VALUES (16, 11, 8, 1, 'Sharp Shooter', '2021-01-01');
INSERT INTO PlayerAwards (ID, MatchID, PlayerID, TeamID, AwardName, DateofAward) VALUES (17, 12, 13, 1, 'Best Captain', '2021-05-01');
INSERT INTO PlayerAwards (ID, MatchID, PlayerID, TeamID, AwardName, DateofAward) VALUES (18, 13, 18, 1, 'Penalty Specialist', '2021-08-29');
INSERT INTO PlayerAwards (ID, MatchID, PlayerID, TeamID, AwardName, DateofAward) VALUES (19, 14, 23, 1, 'First Goal Scorer', '2021-12-27');
INSERT INTO PlayerAwards (ID, MatchID, PlayerID, TeamID, AwardName, DateofAward) VALUES (20, 15, 28, 1, 'Energy Tank', '2022-04-26');
INSERT INTO PlayerAwards (ID, MatchID, PlayerID, TeamID, AwardName, DateofAward) VALUES (21, 16, 33, 1, 'Veteran Performance', '2022-08-24');
INSERT INTO PlayerAwards (ID, MatchID, PlayerID, TeamID, AwardName, DateofAward) VALUES (22, 17, 38, 1, 'Young Star', '2022-12-22');
INSERT INTO PlayerAwards (ID, MatchID, PlayerID, TeamID, AwardName, DateofAward) VALUES (23, 18, 43, 1, 'Tactical Genius', '2023-04-21');
INSERT INTO PlayerAwards (ID, MatchID, PlayerID, TeamID, AwardName, DateofAward) VALUES (24, 19, 48, 1, 'Wall of Steel', '2023-08-19');
INSERT INTO PlayerAwards (ID, MatchID, PlayerID, TeamID, AwardName, DateofAward) VALUES (25, 20, 53, 1, 'Clutch Goal', '2023-12-17');

select * from playerawards;

select * from playerinfo;
select * from playerhistory;
select * from playerawards;
select * from users;
select * from teaminfo;
select * from teamplayers;
select * from teamhistory;
select * from teamawards;
select * from matchinfo;
select * from matchhistory;

-- Usecases (Subqueries, Stored Procedures)

-- Players Who Scored More Goals Than Average
SELECT PlayerName, TotalGoalsScored
FROM PlayerInfo
WHERE TotalGoalsScored > (
    SELECT AVG(TotalGoalsScored)
    FROM PlayerInfo
);

-- Teams Who Have Won More Than Their Average Matches
SELECT TeamName, MatchesWon
FROM TeamInfo
WHERE MatchesWon > (
    SELECT AVG(MatchesWon)
    FROM TeamInfo
);

-- Players Who Won an Award Named "Man of the Match"
SELECT PlayerName
FROM PlayerInfo
WHERE PlayerID IN (
    SELECT PlayerID
    FROM PlayerAwards
    WHERE AwardName = 'Man of the Match'
);

-- Teams That Had a Match in the Same Venue as 'Old Trafford, Manchester'
SELECT DISTINCT TeamName
FROM TeamInfo
WHERE TeamID IN (
    SELECT TeamID
    FROM MatchHistory
    WHERE MatchID IN (
        SELECT MatchID
        FROM MatchInfo
        WHERE Venue = 'Old Trafford, Manchester'));

-- Stored Procedures (SP)

-- SP to Find All Awards Won by a Player
DELIMITER //
CREATE PROCEDURE GetPlayerAwards(IN player_name TEXT)
BEGIN
    SELECT pa.AwardName, pa.DateofAward
    FROM PlayerAwards pa
    JOIN PlayerInfo pi ON pa.PlayerID = pi.PlayerID
    WHERE pi.PlayerName = player_name;
END //
DELIMITER ;
CALL GetPlayerAwards('Kylian Mbappe');

-- SP to List Matches a Team Played

DELIMITER // CREATE PROCEDURE GetTeamMatches(IN team_name TEXT)
BEGIN
    SELECT mi.MatchName, mi.Venue, mi.MatchDate
    FROM MatchInfo mi
    JOIN MatchHistory mh ON mi.MatchID = mh.MatchID
    JOIN TeamInfo ti ON mh.TeamID = ti.TeamID
    WHERE ti.TeamName = team_name;
END //
DELIMITER ;
CALL GetTeamMatches('Portugal FC');

-- SP to Get Top 'N' Players by Goals
DELIMITER //
CREATE PROCEDURE GetTopPlayers(IN top_n INT)
BEGIN
    SELECT PlayerName, TotalGoalsScored
    FROM PlayerInfo
    ORDER BY TotalGoalsScored DESC
    LIMIT top_n;
END //
DELIMITER ;
CALL GetTopPlayers(5);

-- SP to Get All Players of a Team

DELIMITER // CREATE PROCEDURE GetTeamPlayers(IN team_name TEXT)
BEGIN SELECT pi.PlayerName, pi.Age
    FROM PlayerInfo pi
    JOIN TeamPlayers tp ON pi.PlayerID = tp.PlayerID
    JOIN TeamInfo ti ON tp.TeamID = ti.TeamID
    WHERE ti.TeamName = team_name;
END // DELIMITER ;
CALL GetTeamPlayers('Brazil FC');


show databases;

SELECT * FROM playerinfo where PlayerName LIKE '%Yashas%';


