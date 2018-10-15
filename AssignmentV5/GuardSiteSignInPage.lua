--When Guard clicks on the Roster button

-----------------------------------------------------------------
-- it need the composer at all time
local composer = require( "composer" )

 -- this line is needed to create a new page
local scene = composer.newScene()

------------------------------------------------------------------

local switchText
local onOffSwitch
local ShiftButton
local StartShiftButton
local HomePageButton
local SOPButton
local PostOrderButton

local widget = require ( "widget" )

local infoShowing = false

local function ShiftScene( event )

	if ( "ended" == event.phase ) then
		composer.gotoScene("GuardFinishShiftPage",{effect = "fromRight",time = 100})		
	end	
	
end

local function StartShiftScene( event )

	if ( "ended" == event.phase ) then
		composer.gotoScene("",{effect = "fromRight",time = 100})		
	end	
	
end

local function HomePageScene( event )

	if ( "ended" == event.phase ) then
		composer.gotoScene("GuardHomePage",{effect = "fromLeft",time = 800})		
	end	
	
end

local function SOPScene( event )

	if ( "ended" == event.phase ) then
		composer.gotoScene("SOPpage",{effect = "slideUp",time = 800})		
	end	
	
end

local function PostOrderScene( event )

	if ( "ended" == event.phase ) then
		composer.gotoScene("PostOrderPage",{effect = "slideUp",time = 800})		
	end	
	
end

------------------------------------------------------------------------------------------------------------------

		
--create()
function scene:create ( event )

 -- Assign "self.view" to local variable "sceneGroup" for easy reference
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

	bg =   display.newImageRect( "images/simple.jpg", display.contentWidth, display.contentHeight)
	bg.x = display.contentCenterX
	bg.y = display.contentCenterY
	 -- Insert background into "sceneGroup"
	sceneGroup:insert(bg)
	
	--[[Create buttons table for the tabBar
	local tabButtons = 
	{
		{
			label = "Site Sign In",
			onPress = function() composer.gotoScene( "GuardSiteSignInPage" ); end,
			selected = true,
			size = 14,
			font = "Franklin Gothic Demi"
			
		},
		{
			label = "SOPs",
			onPress = function() composer.gotoScene( "SOPpage", "slideUp", 800  ); end,
			size = 14,
			font = "Franklin Gothic Demi"
		},
		{
			label = "Post Order",
			onPress = function() composer.gotoScene( "PostOrderPage", "slideUp", 800  ); end,
			size = 14,
			font = "Franklin Gothic Demi"
		},

	}
	
	-- Create tabBar at bottom of the screen
	local tabBar = widget.newTabBar
	{

		buttons = tabButtons,

	}
	tabBar.x = display.contentCenterX
	tabBar.y = 480
	tabBar.isVisible = true
	--sceneGroup:insert( tabBar )]]--
	
	
		
-------------------------------------------------------------------------------------------------------------------
	
-- Status text box
	local statusBox = display.newRect( 80, 0, 210, 70 )
	statusBox.anchorX = 0
	statusBox:setFillColor( 0, 0, 0 )
	statusBox.alpha = 0.32
	sceneGroup:insert( statusBox )
	statusBox.x = 70

-- Status text
	local statusText = display.newText( "Interact with a Widget...\n", 0, 80, 200, 0, native.systemFont, 14 )

	statusText.anchorX = 0
	statusText.x = 80
	sceneGroup:insert( statusText )
	statusBox.width = 180
	statusBox.height = 40
	statusBox.y = statusText.y
	
-- widget.newSwitch() "onOff"
	switchText = display.newText ( "Turn Location On ", 120, 18, "Stencil", 18)
	switchText.anchorY = 0
	switchText:setFillColor( 0, 128, 0 )
	sceneGroup:insert ( switchText )
	
	local function onOffSwitchListener ( event )
		statusText.text = "On/Off Switch\nLocation is On = " .. tostring( event.target.isOn )
	end
	
	-- Create a default on/off switch using widget.setTheme
	onOffSwitch = widget.newSwitch
	{
		left = 190,
		top = 180,
		onRelease = onOffSwitchListener, -- onPress = onOffSwitchListener
	}
	sceneGroup:insert( onOffSwitch )
	onOffSwitch.x = 230
	onOffSwitch.y = 30
	--local longLine = display.newLine (50, 100, 190, 100)
	--longLine.y = 90
	
------------------------------------------------------------------------------------------------------------------

-- Button to click when guard has finish his/her shift
	ShiftButton = widget.newButton(
	{
		label = "FINISH SHIFT",
		font = "Britannic Bold",
		fontSize = 20,
		labelColor = { default={ 0, 0, 0}},
		onEvent = handleButtonEvent,
		onRelease = ShiftScene,
		emboss = false,
		shape = "roundedRect",
		width = 180,
		height = 40,
		cornerRadius = 2,
		fillColor = { default={1,0.9,1}, over={0.8,1,0.2} },
		strokeColor = { default={1,0.4,0.6}, over={0,0,0} },
		strokeWidth = 3
	}
)

	--Center the button
	ShiftButton.x = display.contentCenterX
	ShiftButton.y = 185
	--Insert Button for go back  into "sceneGroup"
	sceneGroup:insert(ShiftButton)
	ShiftButton:addEventListener("tap", ShiftScene)
	
-- Button to click for guard to return to guard's home page
	HomePageButton = widget.newButton(
	{
		label = "Home",
		font = "Showcard Gothic",
		fontSize = 22,
		labelColor = { default={1,0.6,0.1}},
		onEvent = handleButtonEvent,
		onRelease = HomePageScene,
		emboss = false
	}
)

	--Center the button
	HomePageButton.x = display.contentCenterX
	HomePageButton.y = 470
	--Insert Button for go back  into "sceneGroup"
	sceneGroup:insert(HomePageButton)
	HomePageButton:addEventListener("tap", HomePageScene)
	
-- Button to click for guard to view the SOPs
	SOPButton = widget.newButton(
	{
		label = "SOPs",
		font = "Jokerman",
		fontSize = 20,
		labelColor = { default={1,1,1}},
		onEvent = handleButtonEvent,
		onRelease = SOPScene,
		emboss = false
	}
)

	--Center the button
	SOPButton.x = 50
	SOPButton.y = 470
	--Insert Button for go back  into "sceneGroup"
	sceneGroup:insert(SOPButton)
	SOPButton:addEventListener("tap", SOPScene)

-- Button to click for guard to view the Post Order
	PostOrderButton = widget.newButton(
	{
		label = " Post \nOrder",
		font = "Jokerman",
		fontSize = 20,
		labelColor = { default={1,1,1}},
		onEvent = handleButtonEvent,
		onRelease = PostOrderScene,
		emboss = false
	}
)

	--Center the button
	PostOrderButton.x = 270
	PostOrderButton.y = 480
	--Insert Button for go back  into "sceneGroup"
	sceneGroup:insert(PostOrderButton)
	PostOrderButton:addEventListener("tap", PostOrderScene)
---------------------------------------------------------------------------------------------------------------------------------------------
-- Button handler function
local function EmergencyScene( event )

	local buttonID = event.target.id

	if ( buttonID == "EMERGENCY!" ) then
		-- Create native alert
		local alertBox = native.showAlert( "Emergency Contact", "Please call this number 0123456789!", { "OK", "Contact Mr.Rana" },
			function( event )
				if ( event.action == "clicked" ) then
					if ( event.index == 2 ) then
						system.openURL( "https://www.facebook.com/profile.php?id=100006442068606" )
					end					
				end
			end
		)	
	end
end


-- Table of labels for buttons
local menuButtons = { "EMERGENCY!"}

-- Loop through table to display buttons

local buttonGroup = display.newGroup()
for i = 1,#menuButtons do
	
	local EmergencyButton = widget.newButton(
	{
		label = menuButtons[i],
		id = menuButtons[i],
		font = "Britannic Bold",
		fontSize = 20,
		labelColor = { default={ 0, 0, 0}},
		onEvent = handleButtonEvent,
		onRelease = EmergencyScene,
		emboss = false,
		shape = "roundedRect",
		width = 180,
		height = 40,
		cornerRadius = 2,
		fillColor = { default={1,0.9,1}, over={0.8,1,0.2} },
		strokeColor = { default={1,0.4,0.6}, over={0,0,0} },
		strokeWidth = 3
		
	})
	
	buttonGroup:insert( EmergencyButton )
	--Center the button
	EmergencyButton.x = display.contentCenterX
	EmergencyButton.y = 250
	--Insert Button for go back  into "sceneGroup"
	sceneGroup:insert(EmergencyButton)
	EmergencyButton:addEventListener("tap", EmergencyScene)
end
----------------------------------------------------------------------------------------------------------------------------------------------------
	-- Button to click when guard has start his/her shift
	StartShiftButton = widget.newButton(
	{
		label = "START SHIFT",
		font = "Britannic Bold",
		fontSize = 20,
		labelColor = { default={ 0, 0, 0}},
		onEvent = handleButtonEvent,
		onRelease = StartShiftScene,
		emboss = false,
		shape = "roundedRect",
		width = 180,
		height = 40,
		cornerRadius = 2,
		fillColor = { default={1,0.9,1}, over={0.8,1,0.2} },
		strokeColor = { default={1,0.4,0.6}, over={0,0,0} },
		strokeWidth = 3
	}
)

	--Center the button
	StartShiftButton.x = display.contentCenterX
	StartShiftButton.y = 315
	--Insert Button for go back  into "sceneGroup"
	sceneGroup:insert(StartShiftButton)
	StartShiftButton:addEventListener("tap", StartShiftScene)
		
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

    	if ( "did" == event.phase ) then
		
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

