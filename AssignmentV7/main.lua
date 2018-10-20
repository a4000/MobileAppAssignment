-----------------------------------------------------------------------------------------
-- main.lua
-----------------------------------------------------------------------------------------

-- Run main when the application is started.

-----------------------------------------------------------------
-- This is needed to use the composer library.
local composer = require( "composer" )

-- This is needed to use the database.
require("sqlite3")
local path = system.pathForFile("data.db", system.DocumentsDirectory)
local db = sqlite3.open(path)

------------------------------------------------------------------
-- Declare the variables.
------------------------------------------------------------------
local adminInDB = 0
local guardInDB = 0

------------------------------------------------------------------
-- Functions.
------------------------------------------------------------------
-- Function to close the database if the application is exited.
local function onSystemEvent(event)
	if event.type == "applicationExit" then
		if db and db:isopen() then
			db:close()
		end
	end
end

-- If the employee table doesn't already exist in the database,
-- create it with the columns empID, empName, empUsername, empPassword, empPhone, and empType.
local createTable = [[CREATE TABLE IF NOT EXISTS employee(
	empID INTEGER PRIMARY KEY autoincrement, 
	empName, 
	empUsername, 
	empPassword, 
	empPhone, 
	empType);]]
db:exec(createTable)

-- If the site table doesn't already exist in the database,
-- create it with the columns siteID, siteName, and siteLocation.
local createTable = [[CREATE TABLE IF NOT EXISTS site(
	siteID INTEGER PRIMARY KEY autoincrement, 
	siteName, 
	siteLatitude,
	siteLongitude);]]
db:exec(createTable)

-- If the incidentReport table doesn't already exist in the database,
-- create it with the columns incID, and incComment.
local createTable = [[CREATE TABLE IF NOT EXISTS incidentReport(
	incID INTEGER PRIMARY KEY autoincrement, 
	incDate,
	incTime,
	incLocation,
	incDescription,
	empName);]]
db:exec(createTable)

-- If the shift table doesn't already exist in the database,
-- create it with the columns shiftID, shiftDate, shiftStart, shiftEnd, and shiftEmployee.
local createTable = [[CREATE TABLE IF NOT EXISTS shift(
	shiftID INTEGER PRIMARY KEY autoincrement, 
	shiftDate, 
	shiftStart, 
	shiftEnd,
	empName);]] 
db:exec(createTable)

-- If the roster table doesn't already exist in the database,
-- create it with the columns rosterID, rosterDate, and rosterDetails.
local createTable = [[CREATE TABLE IF NOT EXISTS roster(
	rosterID INTEGER PRIMARY KEY autoincrement, 
	rosterGuardName,
	rosterDate, 
	rosterTime,
	rosterLocation);]]
db:exec(createTable)

-- At least one admin and guard are needed in the database to be able to test if the app works properly.
-- Start by looping through the employee table and check if there is any admins or guards.
for row in db:nrows("SELECT * FROM employee") do
	if (row.empType == "Admin") then
		adminInDB = 1
	elseif (row.empType == "Guard") then
		guardInDB = 1
	end
end

-- If no admins are found in the database, insert an admin to the database.
if (adminInDB == 0) then
	local insertQuery = [[INSERT INTO employee VALUES (NULL, 'Bobby Bobkins', 'admin', 'admin123',
		       	      '0499991111', 'Admin'); ]]
	db:exec(insertQuery)
end

-- If no guards are found in the database, insert a guard to the database.
if (guardInDB == 0) then
	local insertQuery = [[INSERT INTO employee VALUES (NULL, 'Sammy Samkins', 'guard', 'guard123',
		       	      '0411119999', 'Guard'); ]]
	db:exec(insertQuery)
end

local ecuInDB = 0
for row in db:nrows("SELECT * FROM site") do
	if (row.siteName == "ECU Joondalup") then	
		ecuInDB = 1
	end
end

if (ecuInDB == 0) then
	local insertQuery = [[INSERT INTO site VALUES (NULL, 'ECU Joondalup', '-31.7592', '115.7684'); ]]
	db:exec(insertQuery)
end

-- Telling the program to go to a page called "loginPage".
composer.gotoScene( "LoginPage" , { effect="fade", time=500 })

-- Event listener to close database when application is exited.
Runtime:addEventListener("system", onSystemEvent)