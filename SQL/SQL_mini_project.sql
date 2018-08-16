/* Welcome to the SQL mini project. For this project, you will use
Springboard' online SQL platform, which you can log into through the
following link:

https://sql.springboard.com/
Username: student
Password: learn_sql@springboard

The data you need is in the "country_club" database. This database
contains 3 tables:
    i) the "Bookings" table,
    ii) the "Facilities" table, and
    iii) the "Members" table.

Note that, if you need to, you can also download these tables locally.

In the mini project, you'll be asked a series of questions. You can
solve them using the platform, but for the final deliverable,
paste the code for each solution into this script, and upload it
to your GitHub.

Before starting with the questions, feel free to take your time,
exploring the data, and getting acquainted with the 3 tables. */


/* Q1: Some of the facilities charge a fee to members, but some do not.
Please list the names of the facilities that do. */

SELECT * 
FROM  country_club.Facilities
WHERE membercost > 0


/* Q2: How many facilities do not charge a fee to members? */

SELECT COUNT(membercost) AS free_facilities__count
FROM country_club.Facilities
WHERE membercost = 0


/* Q3: How can you produce a list of facilities that charge a fee to members,
where the fee is less than 20% of the facility's monthly maintenance cost?
Return the facid, facility name, member cost, and monthly maintenance of the
facilities in question. */

SELECT facid, name, membercost, monthlymaintenance
FROM  country_club.Facilities 
WHERE membercost > 0
AND membercost < ( .20 * monthlymaintenance ) 


/* Q4: How can you retrieve the details of facilities with ID 1 and 5?
Write the query without using the OR operator. */

SELECT * 
FROM  country_club.Facilities 
WHERE name LIKE  '%2%'


/* Q5: How can you produce a list of facilities, with each labelled as
'cheap' or 'expensive', depending on if their monthly maintenance cost is
more than $100? Return the name and monthly maintenance of the facilities
in question. */

SELECT name, 
       monthlymaintenance, 
       CASE WHEN monthlymaintenance >100 THEN 'Expensive' ELSE 'Cheap' END AS cost_label
FROM  country_club.Facilities  
ORDER BY monthlymaintenance DESC 


/* Q6: You'd like to get the first and last name of the last member(s)
who signed up. Do not use the LIMIT clause for your solution. */

SELECT surname, firstname, MAX( joindate ) AS join_date 
FROM (
SELECT joindate, surname, firstname
FROM country_club.Members
ORDER BY joindate DESC
)sub


/* Q7: How can you produce a list of all members who have used a tennis court?
Include in your output the name of the court, and the name of the member
formatted as a single column. Ensure no duplicate data, and order by
the member name. */


SELECT CONCAT(members.firstname,' ', members.surname) AS member_name, sub.facilities_name
FROM (
SELECT bookings.memid AS memid, facilities.facid AS facid, facilities.name AS facilities_name
FROM country_club.Bookings bookings
LEFT JOIN country_club.Facilities facilities ON bookings.facid = facilities.facid
) sub
LEFT JOIN country_club.Members members
ON sub.memid = members.memid
WHERE sub.facilities_name LIKE 'Tennis%' AND members.firstname != 'GUEST'
GROUP BY member_name
ORDER BY member_name


/* Q8: How can you produce a list of bookings on the day of 2012-09-14 which
will cost the member (or guest) more than $30? Remember that guests have
different costs to members (the listed costs are per half-hour 'slot'), and
the guest user's ID is always 0. Include in your output the name of the
facility, the name of the member formatted as a single column, and the cost.
Order by descending cost, and do not use any subqueries. */

SELECT bookid,
       name AS facility_name, 
       CASE WHEN memid = 0 THEN guestcost*slots ELSE membercost*slots END AS cost,
       starttime AS date
FROM country_club.Bookings bookings
LEFT JOIN country_club.Facilities facilities
ON bookings.facid = facilities.facid
WHERE starttime BETWEEN '2012-09-14 00:00:00' AND '2012-09-14 23:59:59'
HAVING cost >30
ORDER BY cost DESC

/* Q9: This time, produce the same result as in Q8, but using a subquery. */ 

SELECT *
FROM (
    SELECT bookid,
       name AS facility_name, 
       CASE WHEN memid = 0 THEN guestcost*slots ELSE membercost*slots END AS cost,
       starttime AS date
    FROM country_club.Bookings bookings
    LEFT JOIN country_club.Facilities facilities
    ON bookings.facid = facilities.facid
    WHERE starttime BETWEEN '2012-09-14 00:00:00' AND '2012-09-14 23:59:59'
    ) sub
WHERE cost > 30
ORDER BY cost DESC


/* Q10: Produce a list of facilities with a total revenue less than 1000.
The output of facility name and total revenue, sorted by revenue. Remember
that there's a different cost for guests and members! */


SELECT sub.facility_name,
       SUM(sub.rev) AS revenue
       
FROM (
    SELECT bookid,
       name AS facility_name, 
       CASE WHEN memid = 0 THEN guestcost*slots ELSE membercost*slots END AS rev,
       starttime AS date
FROM country_club.Bookings bookings
LEFT JOIN country_club.Facilities facilities
ON bookings.facid = facilities.facid
    ) sub
GROUP BY sub.facility_name