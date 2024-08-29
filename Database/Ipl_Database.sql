set search_path to public;
show search_path;

--Creation

-- Create Teams table
CREATE TABLE Teams (
    team_id SERIAL PRIMARY KEY,
    team_name VARCHAR(50) UNIQUE NOT NULL,
    coach VARCHAR(50) NOT NULL,
    home_ground VARCHAR(100) NOT NULL,
    founded_year INTEGER NOT NULL,
    owner VARCHAR(50) NOT NULL
);

SELECT * from Teams;


-- Create Players table
CREATE TABLE Players (
    player_id SERIAL PRIMARY KEY,
    player_name VARCHAR(50) NOT NULL,
    team_id INTEGER REFERENCES Teams(team_id),
    role VARCHAR(30) NOT NULL,
    age INTEGER NOT NULL,
    matches_played INTEGER NOT NULL
);

SELECT * from Players;


-- Create Matches table
CREATE TABLE Matches (
    match_id SERIAL PRIMARY KEY,
    match_date DATE NOT NULL,
    venue VARCHAR(100) NOT NULL,
    team1_id INTEGER REFERENCES Teams(team_id),
    team2_id INTEGER REFERENCES Teams(team_id),
    winner_team_id INTEGER REFERENCES Teams(team_id)
);

SELECT * from Matches;


-- Create Fan_Engagement table
CREATE TABLE Fan_Engagement (
    engagement_id SERIAL PRIMARY KEY,
    match_id INTEGER REFERENCES Matches(match_id),
    fan_id INTEGER NOT NULL,
    engagement_type VARCHAR(50) NOT NULL,
    engagement_time TIMESTAMP NOT NULL
);

SELECT * from Fan_Engagement;



---Insertion---
-- Insert into Teams
INSERT INTO Teams (team_name, coach, home_ground, founded_year, owner)
VALUES
('Mumbai Indians', 'Mahela Jayawardene', 'Wankhede Stadium', 2008, 'Reliance Industries'),
('Chennai Super Kings', 'Stephen Fleming', 'M. A. Chidambaram Stadium', 2008, 'India Cements'),
('Royal Challengers Bangalore', 'Sanjay Bangar', 'M. Chinnaswamy Stadium', 2008, 'United Spirits'),
('Kolkata Knight Riders', 'Brendon McCullum', 'Eden Gardens', 2008, 'Red Chillies Entertainment'),
('Delhi Capitals', 'Ricky Ponting', 'Arun Jaitley Stadium', 2008, 'GMR Group & JSW Group');

Select * from Teams

	
-- Insert into Players
INSERT INTO Players (player_name, team_id, role, age, matches_played)
VALUES
('Rohit Sharma', 1, 'Batsman', 36, 227),
('Jasprit Bumrah', 1, 'Bowler', 30, 120),
('MS Dhoni', 2, 'Wicketkeeper-Batsman', 42, 234),
('Ravindra Jadeja', 2, 'All-Rounder', 35, 210),
('Virat Kohli', 3, 'Batsman', 35, 237),
('AB de Villiers', 3, 'Batsman', 40, 184),
('Andre Russell', 4, 'All-Rounder', 36, 140),
('Sunil Narine', 4, 'Bowler', 35, 144),
('Rishabh Pant', 5, 'Wicketkeeper-Batsman', 26, 98),
('Shikhar Dhawan', 5, 'Batsman', 38, 206);

Select * from Players


-- Insert into Matches
INSERT INTO Matches (match_date, venue, team1_id, team2_id, winner_team_id)
VALUES
('2024-04-01', 'Wankhede Stadium', 1, 2, 1),
('2024-04-05', 'M. A. Chidambaram Stadium', 2, 3, 3),
('2024-04-10', 'M. Chinnaswamy Stadium', 3, 4, 4),
('2024-04-15', 'Eden Gardens', 4, 5, 4),
('2024-04-20', 'Arun Jaitley Stadium', 5, 1, 1),

('2024-04-25', 'Wankhede Stadium', 1, 3, 3),
('2024-05-01', 'M. A. Chidambaram Stadium', 2, 5, 2),
('2024-05-05', 'M. Chinnaswamy Stadium', 3, 1, 1),
('2024-05-10', 'Eden Gardens', 4, 2, 2),
('2024-05-15', 'Arun Jaitley Stadium', 5, 4, 4);

Select * from Matches;


-- Insert into Fan_Engagemet
INSERT INTO Fan_Engagement (match_id, fan_id, engagement_type, engagement_time)
VALUES
(1, 101, 'Tweet', '2024-04-01 18:30:00'),
(1, 102, 'Like', '2024-04-01 18:35:00'),
(2, 103, 'Comment', '2024-04-05 20:00:00'),
(2, 104, 'Share', '2024-04-05 20:05:00'),
(3, 105, 'Tweet', '2024-04-10 16:00:00'),
(3, 106, 'Like', '2024-04-10 16:05:00'),
(4, 107, 'Comment', '2024-04-15 21:00:00'),
(4, 108, 'Share', '2024-04-15 21:10:00'),
(5, 109, 'Tweet', '2024-04-20 19:00:00'),
(5, 110, 'Like', '2024-04-20 19:05:00'),
(6, 111, 'Comment', '2024-04-25 20:00:00'),
(6, 112, 'Share', '2024-04-25 20:10:00'),
(7, 113, 'Tweet', '2024-05-01 18:00:00'),
(7, 114, 'Like', '2024-05-01 18:05:00'),
(8, 115, 'Comment', '2024-05-05 19:30:00'),
(8, 116, 'Share', '2024-05-05 19:35:00'),
(9, 117, 'Tweet', '2024-05-10 20:30:00'),
(9, 118, 'Like', '2024-05-10 20:35:00'),
(10, 119, 'Comment', '2024-05-15 21:45:00'),
(10, 120, 'Share', '2024-05-15 21:50:00');

Select * from Fan_Engagement;


-----Phase 2: SQL Queries----
-- Retrieve the Details of All Matches Played at a Specific Venue 'WankhedeStadium';
--Objective: Get details of all matches played at a specific venue (e.g. 'Wankhede Stadium';).

SELECT * from Matches
where venue = 'Wankhede Stadium';


SELECT m.match_id, m.match_date, m.venue, t.team_name as winner_team, t1.team_name as team1, t2.team_name as team2
    FROM matches as m
    join teams as t on m.winner_team_id = t.team_id
    join teams t1 on m.team1_id = t1.team_id
    join teams t2 on m.team2_id = t2.team_id
    WHERE venue = 'Wankhede Stadium';


-- List the Playerw Who are Older than 30 years and have played more than 200 Matches
-- Objective: List players older than 30 years who have played more than 200 matches.

SELECT player_name, age, matches_played from Players
where age > 30 AND matches_played > 200;


-- Display the Number of Matches Played with title 'Number of Matches' at Each Venue
-- Objective : Display the Number of Matches Played and along with Venue

SELECT venue, count(match_id) as "Number of Matches"
from Matches group by venue;


--FInd the match dates and venues for matches where the winner was Mumbai Indians
-- Objective : Display the match_date, venue along the team_name where the winner is Mumbai Indians

SELECT M.match_date, M.venue, T.team_name
from Matches M join Teams T on M.winner_team_id = T.team_id
where T.team_name = 'Mumbai Indians';


-- Retrieve details of all matches played by Mumbai Indians and the match was won by a team other than Mumbai Indians.
-- Objective :Display the SELECT match_id, match_date, venue , winner team and the participating team

SELECT M.match_id, M.match_date, M.venue, T_winner.team_name as winner_team, 
	T1.team_name as participating_team from Matches M
join Teams T1 ON M.team1_id = T1.team_id
join Teams T2 ON M.team2_id = T2.team_id
join Teams T_winner ON M.winner_team_id = T_winner.team_id
where (T1.team_name = 'Mumbai Indians' or T2.team_name = 'Mumbai Indians')
  and T_winner.team_name != 'Mumbai Indians';


-- SELECT M.match_id, M.match_date, M.venue, T_winner.team_name as winner_team, 
-- 	T1.team_name as participating_team from Matches M
-- join Teams T1 ON M.team1_id = T1.team_id
-- join Teams T2 ON M.team2_id = T2.team_id
-- join Teams T_winner ON M.winner_team_id = T_winner.team_id
-- where (T1.team_name = 'Chennai Super Kings' or T2.team_name = 'Royal Challengers Bangalore')
--   and T_winner.team_name != 'Chennai Super Kings';



--Advanced queries
-- Find the player who participated in the highest number of winning matches. 
-- Display the Player Name along with the total number of winning matches .

SELECT p.player_name, COUNT(*) AS winning_matches from Players p
join Matches m ON (p.team_id = m.team1_id OR p.team_id = m.team2_id)
where m.winner_team_id = p.team_id
group by p.player_name
order by winning_matches desc
LIMIT 1;


-- Determine the venue with the highest number of matches played and the total fan engagements at that venue. 
-- 	Display the Venue , Total Matches , Total Fan Engagements.

SELECT m.venue, count(*) AS total_matches, coalesce(sum(e.engagement_id), 0) as total_fan_engagements
from Matches m
left JOIN Fan_Engagement e ON m.match_id = e.match_id
group by m.venue
order by total_matches DESC
LIMIT 1;


-- Find the player who has the most fan engagements across all matches.
-- 	Display the player name and the count of fan engagements .

SELECT p.player_name, count(e.engagement_id) AS total_engagements from Players p
join Matches m ON p.team_id = m.team1_id or p.team_id = m.team2_id
join Fan_Engagement e ON m.match_id = e.match_id
group by p.player_name
order by total_engagements desc, p.player_name 
-- LIMIT 1;


 -- Write an SQL query to find out which stadium and match had the highest fan engagement. 
--  The query should return the stadium name, match date, and the total number of fan engagements for that match, ordered by the latest match date .

SELECT m.venue AS stadium, m.match_date, count(e.engagement_id) as total_fan_engagements from Matches m
join Fan_Engagement e on m.match_id = e.match_id
group by m.venue, m.match_date
order by total_fan_engagements desc, m.match_date desc
LIMIT 1;


-- Generate a report for the "Mumbai Indians" that includes details for each match they played:
-- a.  Match date.
-- b.  Opposing team's name.
-- c.  Venue.
-- d.  Total number of fan engagements recorded during each match.
-- e.  Name of the player from "Mumbai Indians" who has played the most matches up to the date of each match.

SELECT m.match_date,
CASE when m.team1_id = 1 then t2.team_name
        else t1.team_name
end as opposing_team, m.venue,
(select count(*) from Fan_Engagement FE
where FE.match_id = m.match_id) AS total_no_of_fan_engagements,
	(select P.player_name from Players P
	join Matches M2 ON P.team_id = M2.team1_id OR P.team_id = M2.team2_id
	where P.team_id = T.team_id and M2.match_date <= m.match_date
	group by P.player_name
	order by COUNT(*) desc
	limit 1) AS top_player from Matches m
	join Teams T ON T.team_name = 'Mumbai Indians'
	join Teams T1 ON m.team1_id = T1.team_id
	join Teams T2 ON m.team2_id = T2.team_id
	where T.team_id = M.team1_id OR T.team_id = m.team2_id
	order BY m.match_date;





-------------View-------------
-- Q. 1. Create a view named TopPerformers that shows the names of players, their teams, and the number of matches they 
-- have played, filtering only those who have played more than 100 matches.

create view TopPerformers as select p.player_name, t.team_name, p.matches_played
    from players p
    join teams t on p.team_id = t.team_id
    where p.matches_played > 100;

select * from TopPerformers


-- Q. 2. Create a view named MatchHighlights that displays the match date, teams involved, venue, and the winner of each match.

CREATE view MatchHighlights AS select m.match_date, t1.team_name AS team1, t2.team_name AS team2, m.venue, w.team_name AS winner
from Matches m
join Teams t1 ON m.team1_id = t1.team_id
join Teams t2 ON m.team2_id = t2.team_id
join Teams w ON m.winner_team_id = w.team_id;

SELECT * from MatchHighlights;


-- Q.3. Create a view named FanEngagementStats that summarizes the total engagements for each match, including match date and venue.

create view FanEngagementStats AS select m.match_date, m.venue, COUNT(e.engagement_id) AS total_engagements
from Matches m
LEFT join Fan_Engagement e ON m.match_id = e.match_id
group by m.match_date, m.venue;

SELECT * from FanEngagementStats;


-- Q. 4. Create a view named TeamPerformance that shows each team's name, the number of matches played, and the number of matches won.

create view TeamPerformance as
select t.team_name, count(m.match_id) as matches_played, 
       sum(case when m.winner_team_id = t.team_id then 1 else 0 end) as matches_won
    from teams t
    left join matches m on t.team_id in (m.team1_id, m.team2_id)
    group by t.team_name;

select * from TeamPerformance;


-- Q. 5. Create a view named TeamEngagementSummary that summarizes fan engagements for each team per match, including:
		-- Match date and venue.
		-- Team names (both teams).
		-- Total number of engagements for each team in each match.
		-- The date of the team's most engaged match (highest engagement).
		-- The fan ID who engaged the most during the team's most engaged match.

create view TeamEngagementSummary as
    select m.match_date, m.venue, t1.team_name as team1, t2.team_name as team2,
        sum(case when p1.team_id = m.team1_id or p2.team_id = m.team2_id then 1 else 0 end) as total_engagements,
        max(m.match_date) as most_engaged_date,
        max(f.fan_id) as most_engaged_fan_id
            from matches m
            join teams t1 on m.team1_id = t1.team_id
            join teams t2 on m.team2_id = t2.team_id
            left join fan_engagement f on m.match_id = f.match_id
            left join players p1 on p1.team_id = t1.team_id
            left join players p2 on p2.team_id = t2.team_id
            group by m.match_date, m.venue, t1.team_name, t2.team_name;

select * from TeamEngagementSummary;