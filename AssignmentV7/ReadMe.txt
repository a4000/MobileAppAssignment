----------------------------------------------------------------------------------------------------------------
-----------------------------------------------ReadMe.txt
----------------------------------------------------------------------------------------------------------------
How To Install:


----------------------------------------------------------------------------------------------------------------
Login Page:

Pressing 'About' us will show the version number and the developers.
The 'username' field is for the username of the user logging in.
The 'password' field is for the password of the user logging in.
Pressing 'Login' will validate the users username and password, and if the validation info is correct, 
the user will be taken to either the guard home page or the admin home page.
There are two default users for this app.
There is one guard and one admin, so both user types can be tested.

The login details for the guard is 
username: guard
password: guard123

The login details for the admin is
username: admin
password: admin123

----------------------------------------------------------------------------------------------------------------
Admin Home Page:

Pressing 'Logout' will log the user out and return the app to the login page.
Pressing 'Rosters' will take the user to the Admin Rosters Page.
Pressing 'Incident Reports' will take the user to the Admin Incident Reports Page.
Pressing 'Site Details' will take the user to the Admin Site Details Page.
Pressing 'Employee Details' will take the user to the Admin Employee Details Page.
Pressing 'Timesheet' will take the user to the Admin Timesheet Page.

----------------------------------------------------------------------------------------------------------------
Admin Roster Page:

Pressing the house icon will return the user to the Admin Home Page
The 'Guard on Duty' field is for the name of the guard to be assigned to the shift.
The 'Date' field is for the date of the shift.
The 'Shift (Start-End)' field is for the start and end time for the shift.
The 'Location' field is for the name of the location to be assigned to the shift.
Pressing 'Submit' will store the details in the database then return the user to the Admin Home Page.

----------------------------------------------------------------------------------------------------------------
Admin Incident Reports Page:

Pressing the house icon will return the user to the Admin Home Page
The table view on this page shows the incident reports that the guards have submitted.

----------------------------------------------------------------------------------------------------------------
Admin Site Details Page:

Pressing the house icon will return the user to the Admin Home Page.
The table view on this page shows the site details with delete buttons.
Pressing 'Delete' will delete that row from the database.
There's one default site on the app, the ECU Joondalup campus.
Pressing 'Add Site' will take the user to the Add Site Page.

----------------------------------------------------------------------------------------------------------------
Add Site Page:

Pressing the back arrow icon will return the user to the Admin Site Details Page.
The 'Name' field is for the name of the site.
The 'Latitude' field is for the latitude of the site.
The 'Longitude' field is for the longitude of the site.
Pressing 'Submit' will store the details in the database then return the user to the Admin Site Details Page.

----------------------------------------------------------------------------------------------------------------
Admin Employee Details Page:

Pressing the house icon will return the user to the Admin Home Page.
The table view on this page shows the employee details with delete buttons.
Pressing 'Delete' will delete that row from the database.
There's two default employees on the app.
Pressing 'Add employee' will take the user to the Add Employee Page.

----------------------------------------------------------------------------------------------------------------
Add Employee Page:

Pressing the back arrow icon will return the user to the Admin Employee Details Page.
The 'Name' field is for the name of the employee.
The 'Username' field is for the username of the employee and is used for validation.
The 'Password' field is for the password of the employee and is used for validation.
The 'Phone' field is for the phone number of the employee.
The 'Type' field is for the type of the employee. It can either be 'Admin' or 'Guard'
Pressing 'Submit' will store the details in the database then return the user to the Admin Employee Details Page.

----------------------------------------------------------------------------------------------------------------
Admin Timesheet Page:

Pressing the house icon will return the user to the Admin Home Page.
The table view on this page shows the time sheet details.

----------------------------------------------------------------------------------------------------------------
Guard Home Page:

Pressing 'Logout' will log the user out and return the app to the login page.
Pressing 'Rosters' will take the user to the Guard Rosters Page.
Pressing 'Site Sign-In' will take the user's current location and compare it to the database to see if the user is at a valid site.
By default there is one site in the database. That site is the ECU Joondalup campus.

Pressing 'Incident Report' will take the user to the Guard Incident Report Page.
Pressing 'Shift Status' will take the user to the Guard Site Sign In Page.

----------------------------------------------------------------------------------------------------------------
Guard Rosters Page:

Pressing the house icon will return the user to the Guard Home Page.
The table view on this page shows the roster details.

----------------------------------------------------------------------------------------------------------------
Guard Incident Report Page:

Pressing the house icon will return the user to the Guard Home Page.
Pressing 'Upload Photo' will allow the user to send an image as an email.
The 'Time' field is for the time of the incident.
The 'Location' field is for the location of the incident.
The 'Incident Description' field is for a short description of the incident.
Pressing 'Submit' will store the details in the database then return the user to the Guard Home Page.

----------------------------------------------------------------------------------------------------------------
Guard Shift Status Page:

Pressing the house icon will return the user to the Guard Home Page.
Pressing 'Emergency' will allow the user to call an emergency number.
Pressing 'SOPs' will show the SOPs.
Pressing 'post Order' will show the Post Order.
Pressing 'Finish Shift' will take the user to the Guard Finish Shift Page.

----------------------------------------------------------------------------------------------------------------
Guard Finish Shift Page:

Pressing the back arrow icon will return the user to the Guard Shift Status Page.
The two 'Update' buttons allow the user to update the start time and end time
Pressing 'Submit' will store the details in the database then return the user to the Guard Home Page.