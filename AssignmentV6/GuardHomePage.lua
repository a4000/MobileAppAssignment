--When Security Guard logged in

-----------------------------------------------------------------
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

------------------------------------------------------------------
local logoutButton
local RosterButton
local SiteButton
local IncidentButton
local StatusButton
local widget = require ( "widget" ) 

-----------------------------------------------------------------------------------------------------------

local function LogoutScene( event )

	if ( "ended" == event.phase ) then
		user.empID = nil
		user.empName = nil
		user.empUsername = nil
		user.empPassword = nil
		user.empPhone = nil
		user.empType = nil
		composer.gotoScene("LoginPage",{effect = "fromLeft",time = 100})		
	end	
	
end

local function RosterScene( event )

	if ( "ended" == event.phase ) then
		composer.gotoScene("GuardRosterPage",{effect = "fromRight",time = 100})		
	end	
	
end

-------------------------------------------------------------------------------------------------------------

local function SiteScene( event )

	if ( "ended" == event.phase ) then
	
	local currentLatitude = 0
	local currentLongitude = 0

	display.setStatusBar( display.HiddenStatusBar )

	display.setDefault( "anchorX", 0.0 )	-- default to Left anchor point

	local latitude = display.newText( "--", 1000, 0, native.systemFont, 0 )

	local longitude = display.newText( "--", 0, 4000, native.systemFont, 0 )

	display.setDefault( "anchorX", 0.5 )


local locationHandler = function( event )

	-- Check for error (user may have turned off Location Services)
	if event.errorCode then
		native.showAlert( "GPS Location Error", event.errorMessage, {"OK"} )
		print( "Location error: " .. tostring( event.errorMessage ) )
	else
	
		local latitudeText = string.format( '%.4f', event.latitude )
		currentLatitude = latitudeText
		latitude.text = latitudeText
		
		local longitudeText = string.format( '%.4f', event.longitude )
		currentLongitude = longitudeText
		longitude.text = longitudeText
		
local minLat
local maxLat
local minLong
local maxLong
	
	for row in db:nrows("SELECT * FROM site") do
		if row.siteLatitude < '0' then
			minLat = tostring(row.siteLatitude + 0.0100)
			maxLat = tostring(row.siteLatitude - 0.0100)
		else
			minLat = tostring(row.siteLatitude - 0.0100)
			maxLat = tostring(row.siteLatitude + 0.0100)
		end
		if row.siteLongitude < '0' then
			minLong = tostring(row.siteLongitude + 0.0100)
			maxLong = tostring(row.siteLongitude - 0.0100)
		else
			minLong = tostring(row.siteLongitude - 0.0100)
			maxLong = tostring(row.siteLongitude + 0.0100)
		end
		
		print (minLat , maxLat ,  minLong , maxLong) 

	if ( (latitude.text>= minLat and latitude.text<= maxLat) and (longitude.text >= minLong and longitude.text <= maxLong) )then 

		
	signin = true 
	local alertBox = native.showAlert( "Sign in Successfull", "Please view your SOP's and Post Orders", { "OK" },
	function( event )
				if ( event.action == "clicked" ) then
				composer.gotoScene( "GuardSiteSignInPage" , { effect="fade", time=500 })
										
				end
			end
		)
		
		SiteButton.isVisible = false 
		StatusButton.isVisible = true
 
	else 
	signin = false
	local alertBox = native.showAlert( "Sign in Un-Successfull", "Please go to a site and try again later!", { "OK" },
	function( event )
				if ( event.action == "clicked" ) then
													
				end
			end
		) 
	SiteButton.isVisible = true
	StatusButton.isVisible = true
	
	end 

	end
end
end

-- Activate location listener
Runtime:addEventListener( "location", locationHandler )	

end
end

--------------------------------------------------------------------------------------------------------------------------------------------------------

local function IncidentScene( event )

	if ( "ended" == event.phase ) then
		composer.gotoScene("GuardIncidentReportPage",{effect = "fromRight",time = 100})		
	end	
	
end

local function StatusScene( event )

	if ( "ended" == event.phase ) then
		composer.gotoScene("GuardSiteSignInPage",{effect = "fromRight",time = 100})		
	end	
	
end

--create()
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

	--bg = display.newImage ("images/IMG_6681.jpg")
	--bg.x = display.contentCenterX
	--bg.y = display.contentCenterY
	--bg.width = screenWidth
	--bg.height = screenHeight
    	-- Assign "self.view" to local variable "sceneGroup" for easy reference
    	local sceneGroup = self.view

	bg =   display.newImageRect( "images/caution.jpg", display.contentWidth, display.contentHeight)
	bg.x = display.contentCenterX
	bg.y = display.contentCenterY
	 -- Insert background into "sceneGroup"
	sceneGroup:insert(bg)
	
	--[[GuardName = display.newText(user.empName .. " is logged in", 160, 110, "Showcard Gothic", 20)
	GuardName:setFillColor(1,1,0)
	
	sceneGroup:insert(GuardName)]]--	
	
------------------------------------------------------------------

-- Create the widget
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
	}
)

	--Center the button
	logoutButton.x = 250
	logoutButton.y = 10

	--Insert Button for go back  into "sceneGroup"
	sceneGroup:insert(logoutButton)
	logoutButton:addEventListener("tap", LogoutScene)

----------------------------------------------------------------------
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
	}
)

	--Center the button
	RosterButton.x = display.contentCenterX
	RosterButton.y = 135
	--Insert Button for go back  into "sceneGroup"
	sceneGroup:insert(RosterButton)
	RosterButton:addEventListener("tap", RosterScene)

----------------------------------------------------------------------
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
	}
)

	--Center the button
	SiteButton.x = display.contentCenterX
	SiteButton.y = 200
	--Insert Button for go back  into "sceneGroup"
	sceneGroup:insert(SiteButton)
	SiteButton:addEventListener("tap", SiteScene)

----------------------------------------------------------------------
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
	}
)

	--Center the button
	IncidentButton.x = display.contentCenterX
	IncidentButton.y = 265
	--Insert Button for go back  into "sceneGroup"
	sceneGroup:insert(IncidentButton)
	IncidentButton:addEventListener("tap", IncidentScene)
	
----------------------------------------------------------------------
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
		strokeWidth = 3
	}
)

	--Center the button
	StatusButton.x = display.contentCenterX
	StatusButton.y = 330
	--Insert Button for go back  into "sceneGroup"
	sceneGroup:insert(StatusButton)
	StatusButton:addEventListener("tap", StatusScene)
	
end

------------------------------------------------------------------------
-- show()
function scene:show( event )

    	local sceneGroup = self.view
    	local phase = event.phase

    	if ( phase == "will" ) then
        	-- Code here runs when the scene is still off screen (but is about to come on screen)

    	elseif ( phase == "did" ) then
        	-- Code here runs when the scene is entirely on screen
    	end
end


-- hide()
function scene:hide( event )

    	local sceneGroup = self.view
    	local phase = event.phase

    	if ( phase == "will" ) then
        	-- Code here runs when the scene is on screen (but is about to go off screen)

    	elseif ( phase == "did" ) then
        	-- Code here runs immediately after the scene goes entirely off screen
    	end
end


-- destroy()
function scene:destroy( event )

    local sceneGroup = self.view
    -- Code here runs prior to the removal of scene's view
end


-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------

return scene