-----------------------------------------------------------------------------------------
-- GuardHomePage.lua
-----------------------------------------------------------------------------------------
--==================================================================================================================================
-- 												Code written by Adam(driver) 
-- 												Verified by Jesheena(navigator)
--==================================================================================================================================
--==================================================================================================================================
-- 												Code modified by Ritish(driver) Fixed bugs found in locationHandler function
-- 												Verified by Jesheena(navigator)
--==================================================================================================================================
------------------------------------------------------------------
-- Declare and initialise variables.
------------------------------------------------------------------
-- it need the composer at all time
local composer = require( "composer" )

-- This is needed to store the user's details.
local user = require("user")

-- This is needed to use the database.
require("sqlite3")
local path = system.pathForFile("data.db", system.DocumentsDirectory)
local db = sqlite3.open(path)

 -- this line is needed to create a new page
local scene = composer.newScene()

local widget = require ( "widget" ) 

local logoutButton
local RosterButton
local SiteButton
local IncidentButton
local StatusButton

------------------------------------------------------------------
-- Functions.
------------------------------------------------------------------
-- If the user selects the 'Logout' button.
local function LogoutScene( event )
	if ( "ended" == event.phase ) then
		
		-- Set the user details to nil.
		user.empID = nil
		user.empName = nil
		user.empUsername = nil
		user.empPassword = nil
		user.empPhone = nil
		user.empType = nil
	
		-- Reset the visibility of the buttons.
		SiteButton.isVisible = true
		StatusButton.isVisible = false	
	
		-- Go to Login Page.
		composer.gotoScene("LoginPage",{effect = "fromLeft",time = 500})		
	end	
end

-- If the user selects the 'Roster' button.
local function RosterScene( event )
	if ( "ended" == event.phase ) then
		-- Go to Guard Roster Page.
		composer.gotoScene("GuardRosterPage",{effect = "fromRight",time = 500})		
	end	
end

-- Listener to handle the site sign in.
local locationHandler = function( event )

	-- Check for error (user may have turned off Location Services)
	if event.errorCode then
		native.showAlert( "GPS Location Error", event.errorMessage, {"OK"} )
		print( "Location error: " .. tostring( event.errorMessage ) )
	-- Else no errors
	else
		local currLatitude = string.format( '%.4f', event.latitude )
		local currLongitude = string.format( '%.4f', event.longitude )
		
		currLatitude = tonumber(currLatitude)
		currLongitude = tonumber(currLongitude)

		local minLat
		local maxLat
		local minLong
		local maxLong
		local signIn = 0
	
		-- Loop through the site table in the database.
		-- Check if the latitude is positive or negative and set the minLat and maxLat values
		-- to the appropriate values, then do the same thing with longitude.
		for row in db:nrows("SELECT * FROM site") do
			minLat = currLatitude - 0.0100
			maxLat = currLatitude + 0.0100
			minLong = currLongitude - 0.0100
			maxLong = currLongitude + 0.0100
		
			
			print(minLat)
			print(currLatitude)
			print(maxLat)
			print(minLong)
			print(currLongitude)
			print(maxLong)
			
			-- Make sure currLatitude is somewhere between minLat and maxLat.
			-- Also make sure currLongitude is somewhere between minLong and maxLong.
			local sLat = tonumber(row.siteLatitude)
			local sLong = tonumber(row.siteLongitude)
			
			if ( (sLat>= minLat and sLat<= maxLat) and (sLong >= minLong and sLong <= maxLong))then 
				
				-- Show a 'Sign in Successfull' message.
				signIn = 1
				siteSignedIn = 1
				
				local alertBox = native.showAlert( "Sign in Successful", "Please view your SOP's and Post Orders", { "OK" },
				function( event )
					if ( event.action == "clicked" ) then
						composer.gotoScene( "GuardSiteSignInPage" , { effect="fade", time = 500 })				
					end
				end)
		
				-- Switch the visibility of the site button and status button.
				SiteButton.isVisible = false 
				StatusButton.isVisible = true
			end 	
		end
		-- If the user is not at a valid site, show a "Sign in Un-Successfull" message.
		if signIn == 0 then
			local alertBox = native.showAlert( "Sign in Un-Successful", "Please go to a site and try again later!", { "OK" })
		end
	end
end

-- If the user selects the site 'Site Sign-In' button.
local function SiteScene( event )
	if ( "ended" == event.phase ) then
		display.setStatusBar( display.HiddenStatusBar )
		display.setDefault( "anchorX", 0.0 )	-- default to Left anchor point
		local latitude = display.newText( "--", 1000, 0, native.systemFont, 0 )
		local longitude = display.newText( "--", 0, 4000, native.systemFont, 0 )
		display.setDefault( "anchorX", 0.5 )

		-- Activate location listener
		
		Runtime:addEventListener( "location", locationHandler )	
	end
end

-- Is the user selects the 'Incident' button.
local function IncidentScene( event )
	if ( "ended" == event.phase ) then
		-- Go to the Guard Incident Report Page.
		composer.gotoScene("GuardIncidentReportPage",{effect = "fromRight",time = 500})		
	end	
end

-- Is the user selects the 'Status' button.
local function StatusScene( event )
	if ( "ended" == event.phase ) then
		-- Go to the Guard Site Sign In Page.
		composer.gotoScene("GuardSiteSignInPage",{effect = "fromRight",time = 500})		
	end	
end

------------------------------------------------------------------
-- Create scene.
------------------------------------------------------------------
function scene:create ( event )

	local sceneGroup = self.view

	display.setStatusBar(display.HiddenStatusBar)

	centerX = display.contentCenterX
	centerY = display.contentCenterY
	screenLeft = display.screenOriginX
	screenWidth = display.contentWidth - screenLeft * 2
	screenRight = screenLeft + screenWidth
	screenTop = display.screenOriginY
	screenHeight = display.contentHeight - screenTop * 2
	screenBottom = screenTop + screenHeight
	display.contentWidth = screenWidth
	display.contentHeight = screenHeight

    	-- Assign "self.view" to local variable "sceneGroup" for easy reference
    	local sceneGroup = self.view

	bg =   display.newImageRect( "images/caution.jpg", display.contentWidth, display.contentHeight)
	bg.x = display.contentCenterX
	bg.y = display.contentCenterY
	 -- Insert background into "sceneGroup"
	sceneGroup:insert(bg)
	
	-- Display the guard name.
	GuardName = display.newText(user.empName .. " is logged in", 160, 70, "Showcard Gothic", 20)
	GuardName:setFillColor(1,1,0)
	sceneGroup:insert(GuardName)	
	
	logoutButton = widget.newButton(
	{
		label = "Logout",
		font = "Lucida Fax",
		fontSize = 24,
		labelColor = { default={ 0,0,0 }},
		onEvent = handleButtonEvent,
		onRelease = LogoutScene,
		emboss = false,
		shape = "roundedRect",
		width = 100,
		height = 40,
		cornerRadius = 8,
		fillColor = { default={1,0,0}, over={0, 128, 0} },
		strokeColor = { default={0.8,0.8,0.8}, over={0.8,0.8,0.8} },
		strokeWidth = 3
	})

	--Center the button
	logoutButton.x = 250
	logoutButton.y = 10

	--Insert Button for go back  into "sceneGroup"
	sceneGroup:insert(logoutButton)
	logoutButton:addEventListener("tap", LogoutScene)

	--Roster button
	RosterButton = widget.newButton(
	{
		label = "ROSTERS",
		font = "Cooper Black",
		labelColor = { default={ 0,0,0 }},
		onEvent = handleButtonEvent,
		onRelease = RosterScene,
		emboss = false,
		shape = "roundedRect",
		width = 200,
		height = 40,
		cornerRadius = 2,
		fillColor = { default={0.6,1,0.9}, over={0.8,1,0.2} },
		strokeColor = { default={0.3,0.5,1}, over={0,0,0} },
		strokeWidth = 3
	})

	--Center the button
	RosterButton.x = display.contentCenterX
	RosterButton.y = 135
	--Insert Button for go back  into "sceneGroup"
	sceneGroup:insert(RosterButton)
	RosterButton:addEventListener("tap", RosterScene)

	--Site Sign-In button
	SiteButton = widget.newButton(
	{
		label = "SITE SIGN-IN",
		font = "Cooper Black",
		labelColor = { default={ 0,0,0 }},
		onEvent = handleButtonEvent,
		onRelease = SiteScene,
		emboss = false,
		shape = "roundedRect",
		width = 200,
		height = 40,
		cornerRadius = 2,
		fillColor = { default={0.6,1,0.9}, over={0.8,1,0.2} },
		strokeColor = { default={0.3,0.5,1}, over={0,0,0} },
		strokeWidth = 3
	})

	--Center the button
	SiteButton.x = display.contentCenterX
	SiteButton.y = 200
	--Insert Button for go back  into "sceneGroup"
	sceneGroup:insert(SiteButton)
	SiteButton:addEventListener("tap", SiteScene)

	--Incident Report button
	IncidentButton = widget.newButton(
	{
		label = "INCIDENT REPORT",
		font = "Cooper Black",
		labelColor = { default={ 0,0,0 }},
		onEvent = handleButtonEvent,
		onRelease = IncidentScene,
		emboss = false,
		shape = "roundedRect",
		width = 200,
		height = 40,
		cornerRadius = 2,
		fillColor = { default={0.6,1,0.9}, over={0.8,1,0.2} },
		strokeColor = { default={0.3,0.5,1}, over={0,0,0} },
		strokeWidth = 3
	})

	--Center the button
	IncidentButton.x = display.contentCenterX
	IncidentButton.y = 265
	--Insert Button for go back  into "sceneGroup"
	sceneGroup:insert(IncidentButton)
	IncidentButton:addEventListener("tap", IncidentScene)
	
	--Shift Status button
	StatusButton = widget.newButton(
	{
		label = "SHIFT STATUS",
		font = "Cooper Black",
		labelColor = { default={ 0,0,0 }},
		onEvent = handleButtonEvent,
		onRelease = StatusScene,
		emboss = false,
		shape = "roundedRect",
		width = 200,
		height = 40,
		cornerRadius = 2,
		fillColor = { default={0.6,1,0.9}, over={0.8,1,0.2} },
		strokeColor = { default={0.3,0.5,1}, over={0,0,0} },
		strokeWidth = 3,
	})

	--Center the button
	StatusButton.x = display.contentCenterX
	StatusButton.y = 330
	
	-- Make the button invisible at the start.
	StatusButton.isVisible = false
	--Insert Button for go back  into "sceneGroup"
	sceneGroup:insert(StatusButton)
	StatusButton:addEventListener("tap", StatusScene)
end

------------------------------------------------------------------
-- Show scene.
------------------------------------------------------------------
function scene:show( event )

    	local sceneGroup = self.view
    	local phase = event.phase

    	if ( phase == "will" ) then
        	-- Change the GuardName to the guard that is logged in.
		GuardName.text = user.empName .. " is logged in"
		if (siteSignedIn == 0) then
				SiteButton.isVisible = true
				StatusButton.isVisible = false
		end
		

    	elseif ( phase == "did" ) then
        	-- Code here runs when the scene is entirely on screen
    	end
end

------------------------------------------------------------------
-- Hide scene.
------------------------------------------------------------------
function scene:hide( event )

    	local sceneGroup = self.view
    	local phase = event.phase

    	if ( phase == "will" ) then
        	-- Code here runs when the scene is on screen (but is about to go off screen)

    	elseif ( phase == "did" ) then
        	-- Code here runs immediately after the scene goes entirely off screen
    	end
end

------------------------------------------------------------------
-- Destroy scene.
------------------------------------------------------------------
function scene:destroy( event )

    	local sceneGroup = self.view
    	-- Code here runs prior to the removal of scene's view
end

--------------------------------------------------------------------------------------
-- Scene event function listeners
--------------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
--------------------------------------------------------------------------------------

return scene