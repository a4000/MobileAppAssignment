-----------------------------------------------------------------------------------------
-- AdminHomePage.lua
-----------------------------------------------------------------------------------------

-- When Admin logged in.

-----------------------------------------------------------------
-- This is needed to use the composer library.
local composer = require( "composer" )

-- This is needed to store the user's details.
local user = require("user")

-- This is needed to use the database.
require("sqlite3")
local path = system.pathForFile("data.db", system.DocumentsDirectory)
local db = sqlite3.open(path)

-- This line is needed to create a new page.
local scene = composer.newScene()

-- This is needed to use the widget library.
local widget = require ( "widget" )

------------------------------------------------------------------
-- Declare the variables.
------------------------------------------------------------------
local logoutButton
local RosterButton
local IncidentButton
local SiteButton
local EmployeeButton
local TimesheetButton
local welcomeLabel

------------------------------------------------------------------
-- Functions.
------------------------------------------------------------------
-- If the user selects the 'logout' button.
local function LogoutScene( event )
	if ( "ended" == event.phase ) then
		composer.gotoScene("LoginPage",{effect = "fromLeft",time = 100})		
	end	
end

-- If the user selects the 'roster' button.
local function RosterScene( event )
	if ( "ended" == event.phase ) then
		composer.gotoScene("AdminRosterDetailsPage",{effect = "fromRight",time = 100})		
	end	
end

-- If the user selects the 'incident' button.
local function IncidentScene( event )
	if ( "ended" == event.phase ) then
		composer.gotoScene("AdminIncidentDetailsPage",{effect = "fromRight",time = 100})		
	end	
end

-- If the user selects the 'site' button.
local function SiteScene( event )
	if ( "ended" == event.phase ) then
		composer.gotoScene("AdminSiteDetailsPage",{effect = "fromRight",time = 100})		
	end	
end

-- If the user selects the 'employee' button.
local function EmployeeScene( event )
	if ( "ended" == event.phase ) then
		composer.gotoScene("AdminEmployeeDetailsPage",{effect = "fromRight",time = 100})		
	end	
end

-- If the user selects the 'timesheet' button.
local function TimesheetScene( event )
	if ( "ended" == event.phase ) then
		composer.gotoScene("AdminTimesheetDetailsPage",{effect = "fromRight",time = 100})		
	end	
end

--create()
function scene:create ( event )

print(user.empName, "is logged in")

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

	bg =   display.newImageRect( "images/spotlight.jpg", display.contentWidth, display.contentHeight)
	bg.x = display.contentCenterX
	bg.y = display.contentCenterY
	 -- Insert background into "sceneGroup"
	sceneGroup:insert(bg)
	
------------------------------------------------------------------

	-- Create the widget
	logoutButton = widget.newButton(
	{
		label = "Logout",
		labelColor = { default={ 0,0,0 }},
		onEvent = handleButtonEvent,
		onRelease = LogoutScene,
		emboss = false,
		shape = "roundedRect",
		width = 100,
		height = 40,
		cornerRadius = 8,
		fillColor = { default={139, 0, 0}, over={0, 128, 0} },
		strokeColor = { default={0,0,0}, over={0.8,0.8,1,1} },
		strokeWidth = 3
	}
)

	--Center the button
	logoutButton.x = 250
	logoutButton.y = -10

	--Insert Button for go back  into "sceneGroup"
	sceneGroup:insert(logoutButton)
	logoutButton:addEventListener("tap", LogoutScene)

----------------------------------------------------------------------
	--Roster button
	RosterButton = widget.newButton(
	{
		label = "Rosters",
		labelColor = { default={ 255, 255, 255 }},
		onEvent = handleButtonEvent,
		onRelease = RosterScene,
		emboss = false,
		shape = "roundedRect",
		width = 170,
		height = 40,
		cornerRadius = 2,
		fillColor = { default={0, 0, 139}, over={128, 0, 128} },
		strokeColor = { default={0,0,0}, over={0,0,0} },
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
	--Incident button
	IncidentButton = widget.newButton(
	{
		label = "Incident Reports",
		labelColor = { default={ 255, 255, 255 }},
		onEvent = handleButtonEvent,
		onRelease = IncidentScene,
		emboss = false,
		shape = "roundedRect",
		width = 170,
		height = 40,
		cornerRadius = 2,
		fillColor = { default={0, 0, 139}, over={128, 0, 128} },
		strokeColor = { default={0,0,0}, over={0,0,0} },
		strokeWidth = 3
	}
)

	--Center the button
	IncidentButton.x = display.contentCenterX
	IncidentButton.y = 200
	--Insert Button for go back  into "sceneGroup"
	sceneGroup:insert(IncidentButton)
	IncidentButton:addEventListener("tap", IncidentScene)

----------------------------------------------------------------------
	--Site button
	SiteButton = widget.newButton(
	{
		label = "Site Details",
		labelColor = { default={ 255, 255, 255 }},
		onEvent = handleButtonEvent,
		onRelease = SiteScene,
		emboss = false,
		shape = "roundedRect",
		width = 170,
		height = 40,
		cornerRadius = 2,
		fillColor = { default={0, 0, 139}, over={128, 0, 128} },
		strokeColor = { default={0,0,0}, over={0,0,0} },
		strokeWidth = 3
	}
)

	--Center the button
	SiteButton.x = display.contentCenterX
	SiteButton.y = 265
	--Insert Button for go back  into "sceneGroup"
	sceneGroup:insert(SiteButton)
	SiteButton:addEventListener("tap", SiteScene)
	
----------------------------------------------------------------------
	--Employee button
	EmployeeButton = widget.newButton(
	{
		label = "Employee Details",
		labelColor = { default={ 255, 255, 255 }},
		onEvent = handleButtonEvent,
		onRelease = EmployeeScene,
		emboss = false,
		shape = "roundedRect",
		width = 170,
		height = 40,
		cornerRadius = 2,
		fillColor = { default={0, 0, 139}, over={128, 0, 128} },
		strokeColor = { default={0,0,0}, over={0,0,0} },
		strokeWidth = 3
	}
)

	--Center the button
	EmployeeButton.x = display.contentCenterX
	EmployeeButton.y = 330
	--Insert Button for go back  into "sceneGroup"
	sceneGroup:insert(EmployeeButton)
	EmployeeButton:addEventListener("tap", EmployeeScene)
	
----------------------------------------------------------------------
	--Timesheet button
	TimesheetButton = widget.newButton(
	{
		label = "Timesheet",
		labelColor = { default={ 255, 255, 255 }},
		onEvent = handleButtonEvent,
		onRelease = TimesheetScene,
		emboss = false,
		shape = "roundedRect",
		width = 170,
		height = 40,
		cornerRadius = 2,
		fillColor = { default={0, 0, 139}, over={128, 0, 128} },
		strokeColor = { default={0,0,0}, over={0,0,0} },
		strokeWidth = 3
	}
)

	--Center the button
	TimesheetButton.x = display.contentCenterX
	TimesheetButton.y = 395
	--Insert Button for go back  into "sceneGroup"
	sceneGroup:insert(TimesheetButton)
	TimesheetButton:addEventListener("tap", TimesheetScene)

	-- Welcome the user when they log in.
	welcomeLabel = display.newText( "Welcome "..user.empName, 0, 165, "STENCIL", 25)
	welcomeLabel:setFillColor(0, 255, 0)
	welcomeLabel.anchorX = 0
	welcomeLabel.y = 50
	sceneGroup:insert( welcomeLabel )
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