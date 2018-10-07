-----------------------------------------------------------------------------------------
-- GuardSiteSignInPage.lua
-----------------------------------------------------------------------------------------

-- When Guard clicks on the Site Sign In button.

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
local LocationButton
local SOPButton
local PostButton
local ShiftButton
local EmergencyButton
local BackButton

------------------------------------------------------------------
-- Functions.
------------------------------------------------------------------
-- If the user selects the 'location' button.
local function LocationScene( event )
	if ( "ended" == event.phase ) then
		composer.gotoScene("",{effect = "fromRight",time = 100})		
	end	
end

-- If the user selects the 'SOP' button.
local function SOPScene( event )
	if ( "ended" == event.phase ) then
		composer.gotoScene("",{effect = "fromRight",time = 100})		
	end	
end

-- If the user selects the 'postorder' button.
local function PostScene( event )
	if ( "ended" == event.phase ) then
		composer.gotoScene("",{effect = "fromRight",time = 100})		
	end	
end

-- If the user selects the 'shift' button.
local function ShiftScene( event )
	if ( "ended" == event.phase ) then
		composer.gotoScene("GuardFinishShiftPage",{effect = "fromRight",time = 100})		
	end	
end

-- If the user selects the 'emergency' button.
local function EmergencyScene( event )
	if ( "ended" == event.phase ) then
		composer.gotoScene("",{effect = "fromRight",time = 100})		
	end	
end

-- If the user selects the 'back' button.
local function BackScene( event )
	if ( "ended" == event.phase ) then
		composer.gotoScene("GuardHomePage",{effect = "fromLeft",time = 100})		
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

	bg =   display.newImageRect( "images/simple.jpg", display.contentWidth, display.contentHeight)
	bg.x = display.contentCenterX
	bg.y = display.contentCenterY
	 -- Insert background into "sceneGroup"
	sceneGroup:insert(bg)
	
------------------------------------------------------------------

-- Create the widget
-- Button to turn on the location
	LocationButton = widget.newButton(
	{
		label = "Turn Location On",
		labelColor = { default={ 0, 0, 0}},
		onEvent = handleButtonEvent,
		onRelease = LocationScene,
		emboss = false,
		shape = "roundedRect",
		width = 180,
		height = 40,
		cornerRadius = 2,
		fillColor = { default={0, 139, 139}, over={128, 0, 128} },
		strokeColor = { default={0,0,0}, over={0,0,0} },
		strokeWidth = 3
	}
)

	--Center the button
	LocationButton.x = display.contentCenterX
	LocationButton.y = 80
	--Insert Button for go back  into "sceneGroup"
	sceneGroup:insert(LocationButton)
	LocationButton:addEventListener("tap", LocationScene)
	
	-- Button for SOPs
	SOPButton = widget.newButton(
	{
		label = "SOPs",
		labelColor = { default={ 0, 0, 0}},
		onEvent = handleButtonEvent,
		onRelease = SOPScene,
		emboss = false,
		shape = "roundedRect",
		width = 180,
		height = 40,
		cornerRadius = 2,
		fillColor = { default={0, 139, 139}, over={128, 0, 128} },
		strokeColor = { default={0,0,0}, over={0,0,0} },
		strokeWidth = 3
	}
)

	--Center the button
	SOPButton.x = display.contentCenterX
	SOPButton.y = 145
	--Insert Button for go back  into "sceneGroup"
	sceneGroup:insert(SOPButton)
	SOPButton:addEventListener("tap", SOPScene)

	-- Button for Post Order
	PostButton = widget.newButton(
	{
		label = "Post Order",
		labelColor = { default={ 0, 0, 0}},
		onEvent = handleButtonEvent,
		onRelease = PostScene,
		emboss = false,
		shape = "roundedRect",
		width = 180,
		height = 40,
		cornerRadius = 2,
		fillColor = { default={0, 139, 139}, over={128, 0, 128} },
		strokeColor = { default={0,0,0}, over={0,0,0} },
		strokeWidth = 3
	}
)

	--Center the button
	PostButton.x = display.contentCenterX
	PostButton.y = 210
	--Insert Button for go back  into "sceneGroup"
	sceneGroup:insert(PostButton)
	PostButton:addEventListener("tap", PostScene)
	
	-- Button to click when guard has finish his/her shift
	ShiftButton = widget.newButton(
	{
		label = "Finish Shift",
		labelColor = { default={ 0, 0, 0}},
		onEvent = handleButtonEvent,
		onRelease = ShiftScene,
		emboss = false,
		shape = "roundedRect",
		width = 180,
		height = 40,
		cornerRadius = 2,
		fillColor = { default={0, 139, 139}, over={128, 0, 128} },
		strokeColor = { default={0,0,0}, over={0,0,0} },
		strokeWidth = 3
	}
)

	--Center the button
	ShiftButton.x = display.contentCenterX
	ShiftButton.y = 275
	--Insert Button for go back  into "sceneGroup"
	sceneGroup:insert(ShiftButton)
	ShiftButton:addEventListener("tap", ShiftScene)

	-- Button for Emergency Contact (Panic Button)
	EmergencyButton = widget.newButton(
	{
		label = "Emergency Contact",
		labelColor = { default={ 0, 0, 0}},
		onEvent = handleButtonEvent,
		onRelease = EmergencyScene,
		emboss = false,
		shape = "roundedRect",
		width = 180,
		height = 40,
		cornerRadius = 2,
		fillColor = { default={0, 139, 139}, over={128, 0, 128} },
		strokeColor = { default={0,0,0}, over={0,0,0} },
		strokeWidth = 3
	}
)

	--Center the button
	EmergencyButton.x = display.contentCenterX
	EmergencyButton.y = 340
	--Insert Button for go back  into "sceneGroup"
	sceneGroup:insert(EmergencyButton)
	EmergencyButton:addEventListener("tap", EmergencyScene)
	
	-- Back button
	BackButton = widget.newButton(
	{
		label = "Back",
		labelColor = { default={ 0, 0, 0}},
		onEvent = handleButtonEvent,
		onRelease = BackScene,
		emboss = false,
		shape = "roundedRect",
		width = 180,
		height = 40,
		cornerRadius = 2,
		fillColor = { default={139, 0, 0}, over={0, 128, 0} },
		strokeColor = { default={0,0,0}, over={0,0,0} },
		strokeWidth = 3
	}
)

	--Center the button
	BackButton.x = display.contentCenterX
	BackButton.y = 405
	--Insert Button for go back  into "sceneGroup"
	sceneGroup:insert(BackButton)
	BackButton:addEventListener("tap", BackScene)	
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