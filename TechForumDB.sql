/*
DROP DATABASE IF EXISTS TechForumDB; 
CREATE DATABASE TechForumDB;
USE TechForumDB 
*/

/* DROP Table. If needed, maintain the order to avoid conflict. */
DROP table ChallengesSolutions; 
DROP table ChallengeTags;
DROP table Tags; 
DROP table Challenges; 
DROP table Solutions;
DROP table User;
DROP table UserRoles;

/* Display Data */
select * from UserRoles;
select * from User;
select * from Challenges;
select * from ChallengeTags;
select * from Solutions; 
select * from ChallengesSolutions;
SELECT * FROM Tags;


/* Create Tables */
CREATE TABLE `User`
(
UserId int auto_increment,
UserEmail varchar(200) UNIQUE NOT NULL,
UserPassword varchar(200) NOT NULL,
UserFirstName varchar(200) NOT NULL,
UserLastName varchar(200) NOT NULL,
RoleId int NOT NULL,
RewardPoints int,
CreatedBy varchar(50) NOT NULL,
CreatedDate date NOT NULL,
UpdatedBy varchar(50),
UpdatedDate date,
primary key (UserId),
foreign key (RoleId) references UserRoles(RoleId) 
ON UPDATE CASCADE 
ON DELETE CASCADE
);

CREATE TABLE `UserRoles`
(
RoleId int,
RoleName varchar(100) NOT NULL,
primary key (RoleId),
CreatedDate date NOT NULL,
UpdatedDate date
);

CREATE TABLE `Challenges`
(
ChallengeId int auto_increment,
ChallengeTitle varchar(200) NOT NULL,
ChallengeContent varchar(200) NOT NULL,
CreatedBy varchar(50) NOT NULL,
CreatedDate date NOT NULL,
UpdatedBy varchar(50),
UpdatedDate date,
UserId int,
UpVote int,
Downvote int,
RewardPoints int,
Comment varchar(300),
UserName varchar(200),
status int NOT NULL,
primary key (ChallengeId),
foreign key (UserId) references User(UserId) 
);

CREATE TABLE `Solutions`
(
SolutionId int auto_increment,
SolutionContent varchar(500) NOT NULL,
CreatedBy varchar(50) NOT NULL,
CreatedDate date NOT NULL,
UpdatedBy varchar(50),
UpdatedDate date,
UserId int,
UpVote int,
Downvote int,
RewardPoints int,
Comment varchar(300),
UserName varchar(200),
status int NOT NULL,
primary key (SolutionId),
foreign key (UserId) references User(UserId) 
ON UPDATE CASCADE 
ON DELETE CASCADE
);

CREATE TABLE `ChallengesSolutions`
(
Id int auto_increment,
ChallengeId int,
SolutionId int,
CreatedBy varchar(50) NOT NULL,
CreatedDate date NOT NULL,
UpdatedBy varchar(50),
UpdatedDate date,
primary key (Id),
foreign key (ChallengeId) references Challenges(ChallengeId), 
foreign key (SolutionId) references Solutions(SolutionId) 
ON UPDATE CASCADE 
ON DELETE CASCADE
);

CREATE TABLE `Tags`   /* Tags to be selected while creating post to be fectched from here */
(
TagId int,
TagName varchar(200),
TagColor varchar(100),
CreatedBy varchar(50) NOT NULL,
CreatedDate date NOT NULL,
UpdatedBy varchar(50),
UpdatedDate date,
primary key (TagId)
);

CREATE TABLE `ChallengeTags`
(
Id int auto_increment,
TagId int,
ChallengeId int,
CreatedBy varchar(50) NOT NULL,
CreatedDate date NOT NULL,
UpdatedBy varchar(50),
UpdatedDate date,
primary key (Id),
foreign key (ChallengeId) references Challenges(ChallengeId), 
foreign key (TagId) references Tags(TagId) 
ON UPDATE CASCADE 
ON DELETE CASCADE
);


/* Insert Data */

/* ------- UserRole Data -------- */
Insert into UserRoles(RoleId, RoleName, CreatedDate, UpdatedDate)
Values(1, "Moderator", "2017-06-16", null);
Insert into UserRoles(RoleId, RoleName, CreatedDate, UpdatedDate)
Values(2, "User", "2017-06-16", null);

/* --------- Moderator Data -------- */
Insert into User(UserEmail, UserPassword, UserFirstName, UserLastName, CreatedBy, CreatedDate, UpdatedBy, UpdatedDate, RewardPoints, RoleId)
Values("Gateway@1234","gate1234","Gateway", "", "gateway", "2017-06-15", "gateway", "2017-06-16", null, 1);

/* --------- User Data -------- */
Insert into User(UserEmail, UserPassword, UserFirstName, UserLastName, CreatedBy, CreatedDate, UpdatedBy, UpdatedDate, RewardPoints, RoleId)
Values("Raj@1234","raj1234","Raj", "Patel", "Raj", "2017-06-17", "gateway", "2017-06-18", null, 2);

Insert into User(UserEmail, UserPassword, UserFirstName, UserLastName, CreatedBy, CreatedDate, UpdatedBy, UpdatedDate, RewardPoints, RoleId)
Values("Hemant@1234","Hemnant1234","Hemant", "Patel", "Hemant", "2017-06-27", "Hemant", "2017-06-18", null, 2);

Insert into User(UserEmail, UserPassword, UserFirstName, UserLastName, CreatedBy, CreatedDate, UpdatedBy, UpdatedDate, RewardPoints, RoleId)
Values("Jatan@1234","Jatan1234","Jatan", "Shah", "Jatan", "2017-06-29", "Jatan", "2017-06-29", null, 2);

/* --------- Challenges Data -------- */
Insert into Challenges(ChallengeTitle, ChallengeContent, CreatedBy, CreatedDate, UpdatedBy, UpdatedDate, UserId, UpVote, Downvote, RewardPoints, UserName, status)
Values("Node Not Working after installation", "Installed but not working. Intsallation steps carried out correctly", "user","2017-06-17", null ,"2017-06-17", 3, null, null, null, "Raj", 0);

Insert into Challenges(ChallengeTitle, ChallengeContent, CreatedBy, CreatedDate, UpdatedBy, UpdatedDate, UserId, UpVote, Downvote, RewardPoints, UserName, status)
Values("React Not Working after installation", "Installed but not working. Intsallation steps carried out correctly", "user","2017-06-17", null ,"2017-06-17", 4, null, null, null, "Jatan", 0);
/* --------- Solutions Data -------- */
Insert into Solutions(SolutionContent, CreatedBy, CreatedDate, UpdatedBy, UpdatedDate, UserId, UpVote, Downvote, RewardPoints, Comment, UserName, status)
Values("Cant understand problem. Upload steps to reproduce problem", "user","2017-06-30", null ,"2017-06-30", 4, null, null, null, null, "Hemant", 0);

Insert into Solutions(SolutionContent, CreatedBy, CreatedDate, UpdatedBy, UpdatedDate, UserId, UpVote, Downvote, RewardPoints, Comment, UserName, status)
Values("Try reinstalling.", "user","2017-06-30", null ,"2017-06-30", 5, null, null, null, null, "Jatan", 0);

/* --------- ChallengesSolutions Data -------- */
Insert into ChallengesSolutions(ChallengeId, SolutionId, CreatedBy, CreatedDate, UpdatedBy, UpdatedDate)
Values(3, 1, "", "2017-06-30", null ,"2017-06-30");
Insert into ChallengesSolutions(ChallengeId, SolutionId, CreatedBy, CreatedDate, UpdatedBy, UpdatedDate)
Values(3, 2, "", "2017-06-30", null ,"2017-06-30");

/* --------- Tag Data -------- */
Insert into Tags(TagId, TagName, TagColor, CreatedBy, CreatedDate, UpdatedBy, UpdatedDate)
Values(1, "JS", "#FFFF00", "user", "2017-06-30", null, null);
Insert into Tags(TagId, TagName, TagColor, CreatedBy, CreatedDate, UpdatedBy, UpdatedDate)
Values(2, "MongoDB", "#32CD32", "user", "2017-06-30", null, null);
Insert into Tags(TagId, TagName, TagColor, CreatedBy, CreatedDate, UpdatedBy, UpdatedDate)
Values(3, ".NET", "#9370DB", "user", "2017-06-30", null, null);
Insert into Tags(TagId, TagName, TagColor, CreatedBy, CreatedDate, UpdatedBy, UpdatedDate)
Values(4, "ReactJS", "#87CEFA", "user", "2017-06-30", null, null);
Insert into Tags(TagId, TagName, TagColor, CreatedBy, CreatedDate, UpdatedBy, UpdatedDate)
Values(5, "AngularJS", "#FF0000", "user", "2017-06-30", null, null);

/* --------- ChallengesTag Data -------- */
Insert into ChallengeTags(TagId, ChallengeId, CreatedBy, CreatedDate, UpdatedBy, UpdatedDate)
Values(1, 1, "user", "2017-06-30", null, null);


/* Update Tables */

/* ---- User Profile Updates (Change Password) ----*/
UPDATE User
SET User.UserPassword = "new"
where User.UserId = 2; 

/* ------ User Challenge Table Related Updates ----- */
Update Challenges
SET Challenges.ChallengeContent = ""
where Challenges.ChallengeId = 1;

Update Challenges
SET Challenges.Comment = ""
where Challenges.ChallengeId = 1;

Update Challenges
SET Challenges.RewardPoints = 4
where Challenges.ChallengeId = 1;

Update Challenges
SET Challenges.UpVote = 1
where Challenges.ChallengeId = 1;

/* ---- Moderator Challenge Table Related Updates ----- */
Update Challenges
SET Challenges.RewardPoints = 4
where Challenges.ChallengeId = 1;

Update Challenges
SET Challenges.UpVote = 1
where Challenges.ChallengeId = 1;

Update Challenges
SET Challenges.Downvote = 1
where Challenges.ChallengeId = 1;

Update Challenges
SET Challenges.Comment = ""
where Challenges.ChallengeId = 1;

Update Challenges   /* Moderator Approves Challenge  when status = 1 and declines when status = 2 */
SET Challenges.status = 1
where Challenges.ChallengeId = 1;

/* ----- User Solutions Table Related Updates ------ */
Update Solutions
SET Solutions.Comment = ""
where Solutions.SolutionId = 1;

Update Solutions
SET Challenges.RewardPoints = 4
where Solutions.SolutionId = 1;

Update Solutions
SET Solutions.UpVote = 1
where Solutions.SolutionId = 1;

Update Solutions
SET Solutions.Downvote = 1
where Solutions.SolutionId = 1;

Update Solutions  /* User Approves Solutions when status = 1 and declines when status = 2 */
SET Solutions.status = 1
where Solutions.SolutionsId = 1;

/* -----  Moderator Solutions Table Related Updates ----- */
Update Solutions
SET Solutions.Comment = ""
where Solutions.SolutionId = 1;

Update Solutions
SET Challenges.RewardPoints = 4
where Solutions.SolutionId = 1;

Update Solutions
SET Solutions.UpVote = 1
where Solutions.SolutionId = 1;

Update Solutions
SET Solutions.Downvote = 1
where Solutions.SolutionId = 1;

Update Solutions  /* Moderator Approves Solutions when status = 1 and declines when status = 2 */
SET Solutions.status = 1
where Solutions.SolutionsId = 1;


/* Important Joins To Display Data */

/* -----  Query Used To Display All Challenges (with or without solution) for end users on home page load. ----- */
select ChallengeTitle, Challenges.UpVote, Challenges.Downvote, Challenges.RewardPoints, Challenges.UserName, SolutionContent, Solutions.UserName, Solutions.UpVote, Solutions.Downvote, Solutions.Comment 
from Challenges
LEFT JOIN
ChallengesSolutions on Challenges.ChallengeId = ChallengesSolutions.ChallengeId
LEFT JOIN
Solutions on Solutions.SolutionId = ChallengesSolutions.SolutionId;

/* -----  Query Used To Display All Challenges (with or without solution) related to signed in user on challenges page load. ----- */
select ChallengeTitle, Challenges.UpVote, Challenges.Downvote, Challenges.RewardPoints, Challenges.UserName, SolutionContent, Solutions.UserName, Solutions.UpVote, Solutions.Downvote, Solutions.Comment 
from Challenges
LEFT JOIN
ChallengesSolutions on Challenges.ChallengeId = ChallengesSolutions.ChallengeId
LEFT JOIN
Solutions on Solutions.SolutionId = ChallengesSolutions.SolutionId
WHERE Challenges.UserId = 3;


/* If searching of Challenges to be performed from backend */
SELECT * FROM Challenges where Challenges.ChallengeTitle = "Search Text";

/* If searching of User to be performed from backend */
SELECT * FROM User where User.UserFirstName = "First Name" and User.UserLastName = "Last Name";

/* If sorting of Challenges to be performed from backend */

SELECT * FROM Challenges where Challenges.UpdatedDate = "filter_Selected_date";  /* Sorting by last updated date. */

select ChallengeTitle, Tags.TagName, Tags.TagColor  /* Sorting by Tags */
from Challenges
LEFT JOIN
ChallengeTags on Challenges.ChallengeId = ChallengeTags.ChallengeId
LEFT JOIN
Tags on ChallengeTags.TagId = Tags.TagId
