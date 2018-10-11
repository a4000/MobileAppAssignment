--When Guard clicks on the Roster button

-----------------------------------------------------------------
-- it need the composer at all time
local composer = require( "composer" )

 -- this line is needed to create a new page
local scene = composer.newScene()

------------------------------------------------------------------

local switchText
local onOffSwitch
local SOPButton
local PostButton
local ShiftButton
local StartShiftButton
local BackButton
local widget = require ( "widget" )
 
local infoShowing = false

local function PostScene( event )

	if ( "ended" == event.phase ) then
		composer.gotoScene("",{effect = "fromRight",time = 100})		
	end	
	
end

local function ShiftScene( event )

	if ( "ended" == event.phase ) then
		composer.gotoScene("GuardFinishShiftPage",{effect = "fromRight",time = 100})		
	end	
	
end

local function StartShiftScene( event )

	if ( "ended" == event.phase ) then
		composer.gotoScene("GuardStartShiftPage",{effect = "fromRight",time = 100})		
	end	
	
end

local function BackScene( event )

	if ( "ended" == event.phase ) then
		composer.gotoScene("GuardHomePage",{effect = "fromLeft",time = 100})		
	end	
	
end

------------------------------------------------------------------------------------------------------------------

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
	local backGroup = display.newGroup()
	local frontGroup = display.newGroup()
	local textGroupContainer = display.newContainer( 288, 240 ) ; frontGroup:insert( textGroupContainer )
	local barContainer = display.newContainer( display.actualContentWidth, 80 )
	frontGroup:insert( barContainer )
	barContainer.anchorX = 0
	barContainer.anchorY = 0
	barContainer.anchorChildren = false
	barContainer.x = display.screenOriginX
	barContainer.y = display.screenOriginY

	local scrollBounds
	local infoBoxState = "canOpen"
	local transComplete


	local buildNum

	-- Read from the ReadMe.txt file
	local readMeText = ""
	local readMeFilePath = system.pathForFile( "ReadMe.txt", system.ResourceDirectory )
	if readMeFilePath then
		local readMeFile = io.open( readMeFilePath )
		local rt = readMeFile:read( "*a" )
		if string.len( rt ) > 0 then readMeText = rt end
		io.close( readMeFile ) ; readMeFile = nil ; rt = nil
	end
	
-- Button for SOPs
	SOPButton = widget.newButton(
	{
		label = "SOPs",
		font = "Britannic Bold",
		fontSize = 20,
		labelColor = { default={ 0, 0, 0}},
		onEvent = handleButtonEvent,
		onRelease = SOPScene,
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
	SOPButton.x = display.contentCenterX
	SOPButton.y = 145
	--Insert Button for go back  into "sceneGroup"
	sceneGroup:insert(SOPButton)
	--SOPButton:addEventListener("tap", SOPScene)
-- Create table for initial object positions
	local objPos = { infoBoxOffY=0, infoBoxDestY=0 }

	-- Resize change handler
	local function onResize( event )

		-- If info box is opening or already open, snap it entirely on screen
		objPos["infoBoxOffY"] = display.screenOriginY - 130
		objPos["infoBoxDestY"] = (barContainer.y + barContainer.contentHeight + 320)
		if ( infoBoxState == "opening" or infoBoxState == "canClose" ) then
			transition.cancel( "infoBox" )
			textGroupContainer.xScale, textGroupContainer.yScale = 1,1
			textGroupContainer.y = objPos["infoBoxDestY"]
			if scrollBounds then
				scrollBounds.x, scrollBounds.y = display.contentCenterX, objPos["infoBoxDestY"]
			end
			transComplete()
		-- If info box is closing or already closed, snap it entirely off screen
		elseif ( infoBoxState == "closing" or infoBoxState == "canOpen" ) then
			transition.cancel( "infoBox" )
			textGroupContainer.y = objPos["infoBoxOffY"]
			if scrollBounds then
				scrollBounds.x, scrollBounds.y = display.contentCenterX, objPos["infoBoxOffY"]
			end
			transComplete()
		end
	end
	Runtime:addEventListener( "resize", onResize )

	-- If there is ReadMe.txt content, create needed elements
	if readMeText ~= "" then

		-- Create the info box scrollview
		scrollBounds = widget.newScrollView
		{
			x = 160,
			y = objPos["infoBoxDestY"],
			width = 288,
			height = 240,
			horizontalScrollDisabled = true,
			hideBackground = true,
			hideScrollBar = true,
			topPadding = 0,
			bottomPadding = 0
		}

		frontGroup:insert( scrollBounds )
		
		-- Creating the box to display the details from readMe
		local infoBoxBack = display.newRect( 0, 0, 288, 240 )
		infoBoxBack:setFillColor( 1,0.8,0.1 ) 
		textGroupContainer:insert( infoBoxBack )

		-- Create the info text group
		local infoTextGroup = display.newGroup()
		textGroupContainer:insert( infoTextGroup )

		-- Find and then sub out documentation links
		local docLinks = {}
		for linkTitle, linkURL in string.gmatch( readMeText, "%[([%w\%s\%p\%—]-)%]%(([%w\%p]-)%)" ) do
			docLinks[#docLinks+1] = { linkTitle, linkURL }
		end
		readMeText = string.gsub( readMeText, "%[([%w\%s\%p\%—]-)%]%(([%w\%p]-)%)", "" )

		-- Create the info text and anchoring box
		local infoText = display.newText( infoTextGroup, "", 0, 0, 260, 0, useFont, 12 )
		infoText:setFillColor( 0 )
		local function trimString( s )
			return string.match( s, "^()%s*$" ) and "" or string.match( s, "^%s*(.*%S)" )
		end
		-- Reading whatever that is in the readMe
		readMeText = trimString( readMeText )
		infoText.text = "\n" .. readMeText
		infoText.anchorX = 0
		infoText.anchorY = 0
		infoText.x = -130

		transComplete = function()

			if infoBoxState == "opening" then
				scrollBounds:insert( infoTextGroup )
				infoTextGroup.x = 144 ; infoTextGroup.y = 120

				scrollBounds.x, scrollBounds.y = display.contentCenterX, objPos["infoBoxDestY"]
				infoBoxState = "canClose"
				infoShowing = true
				--if self.onInfoEvent then
					--self.onInfoEvent( { action="show", phase="did" } )
				--end
			elseif infoBoxState == "closing" then
				infoTextGroup.isVisible = false
				textGroupContainer.isVisible = false
				
				infoBoxState = "canOpen"
				infoShowing = false
				--if self.onInfoEvent then
					--self.onInfoEvent( { action="hide", phase="did" } )
				--end
			end
		end

		local function controlInfoBox( event )
			if event.phase == "began" then
				if infoBoxState == "canOpen" then
					infoBoxState = "opening"
					infoShowing = true
					--if self.onInfoEvent then
						--self.onInfoEvent( { action="show", phase="will" } )
					--end
					textGroupContainer.x = display.contentCenterX
					textGroupContainer.y = objPos["infoBoxOffY"]
					textGroupContainer:insert( infoTextGroup )
					infoTextGroup.isVisible = true
					textGroupContainer.isVisible = true
					textGroupContainer.xScale = 0.96 ; textGroupContainer.yScale = 0.96
					
					transition.cancel( "infoBox" )
					
					transition.to( textGroupContainer, { time=900, tag="infoBox", y=objPos["infoBoxDestY"], transition=easing.outCubic } )
					transition.to( textGroupContainer, { time=400, tag="infoBox", delay=750, xScale=1, yScale=1, transition=easing.outQuad, onComplete=transComplete } )

				elseif infoBoxState == "canClose" then
					infoBoxState = "closing"
					infoShowing = false
					--if self.onInfoEvent then
						--self.onInfoEvent( { action="hide", phase="will" } )
					--end
					textGroupContainer:insert( infoTextGroup )
					
					infoTextGroup.x = 0 ; infoTextGroup.y = scrollY
					
					transition.cancel( "infoBox" )
					
					transition.to( textGroupContainer, { time=400, tag="infoBox", xScale=0.96, yScale=0.96, transition=easing.outQuad } )
					transition.to( textGroupContainer, { time=700, tag="infoBox", delay=200, y=objPos["infoBoxOffY"], transition=easing.inCubic, onComplete=transComplete } )
				end
			end
			return true
		end
				
		SOPButton.isVisible = true
		SOPButton:addEventListener( "touch", controlInfoBox )
		SOPButton.listener = controlInfoBox

	end

	self.SOPButton = SOPButton
	self.titleBarBottom = barContainer.y + barContainer.contentHeight - 2
	backGroup:toBack() ; self.backGroup = backGroup
	frontGroup:toFront() ; self.frontGroup = frontGroup
	onResize()

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Button for Post Order
	PostButton = widget.newButton(
	{
		label = "POST ORDER",
		font = "Britannic Bold",
		fontSize = 20,
		labelColor = { default={ 0, 0, 0}},
		onEvent = handleButtonEvent,
		onRelease = PostScene,
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
	PostButton.x = display.contentCenterX
	PostButton.y = 210
	--Insert Button for go back  into "sceneGroup"
	sceneGroup:insert(PostButton)
	PostButton:addEventListener("tap", PostScene)
	
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
	ShiftButton.y = 275
	--Insert Button for go back  into "sceneGroup"
	sceneGroup:insert(ShiftButton)
	ShiftButton:addEventListener("tap", ShiftScene)

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
	EmergencyButton.y = 340
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
	StartShiftButton.y = 405
	--Insert Button for go back  into "sceneGroup"
	sceneGroup:insert(StartShiftButton)
	StartShiftButton:addEventListener("tap", StartShiftScene)
	
-- Back button
	BackButton = widget.newButton(
	{
		label = "Back",
		font = "Lucida Fax",
		fontSize = 22,
		labelColor = { default={ 0,0,0 }},
		onEvent = handleButtonEvent,
		onRelease = BackScene,
		emboss = false,
		shape = "roundedRect",
		width = 200,
		height = 40,
		cornerRadius = 2,
		fillColor = { default={1,0,0}, over={0, 128, 0} },
		strokeColor = { default={0.8,0.8,0.8}, over={0.8,0.8,0.8} },
		strokeWidth = 3
	}
)

	--Center the button
	BackButton.x = display.contentCenterX
	BackButton.y = 470
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

