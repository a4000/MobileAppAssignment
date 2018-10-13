--When Guard clicks on the Roster button

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
local SubmitButton
local BackButton
local nameLabel
local nameField
local DateLabel
local DateField
local ShiftTimeLabel
local ShiftTimeField
local locationLabel
local locationField
local inputName
local inputDate
local inputShiftTime
local inputLocation

local widget = require ( "widget" ) 

local function SubmitScene( event )

	if ( "ended" == event.phase ) then
	
		local insertQuery = [[INSERT INTO roster VALUES (NULL, "]]..inputName..[[", "]]..inputDate..[[", "]]..inputShiftTime..[[", "]]..inputLocation..[["); ]]
		db:exec(insertQuery)		

		composer.gotoScene("AdminHomePage",{effect = "fromLeft",time = 100})			
	end	
	
end

local function BackScene( event )

	if ( "ended" == event.phase ) then
		composer.gotoScene("AdminHomePage",{effect = "fromLeft",time = 100})		
	end	
	
end

------------------------------------------------------------------
-- Functions.
------------------------------------------------------------------
-- Function to take the name input from the name box. 
local function nameFieldHandler( textField )
	return function( event )
		if ( "began" == event.phase ) then
			-- This is the "keyboard has appeared" event
			-- In some cases you may want to adjust the interface when the keyboard appears.
		
		elseif ( "ended" == event.phase ) then
			-- This event is called when the user stops editing a field: for example, when they touch a different field
			inputName = textField().text
	
		elseif ( "editing" == event.phase ) then
		
		elseif ( "submitted" == event.phase ) then
			-- This event occurs when the user presses the "return" key (if available) on the onscreen keyboard
			inputName = textField().text
	
			-- Hide keyboard
			native.setKeyboardFocus( nil )
		end
	end
end

-- Function to take the date input from the date box. 
local function DateFieldHandler( textField )
	return function( event )
		if ( "began" == event.phase ) then
			-- This is the "keyboard has appeared" event
			-- In some cases you may want to adjust the interface when the keyboard appears.
		
		elseif ( "ended" == event.phase ) then
			-- This event is called when the user stops editing a field: for example, when they touch a different field
			inputDate = textField().text
	
		elseif ( "editing" == event.phase ) then
		
		elseif ( "submitted" == event.phase ) then
			-- This event occurs when the user presses the "return" key (if available) on the onscreen keyboard
			inputDate = textField().text
	
			-- Hide keyboard
			native.setKeyboardFocus( nil )
		end
	end
end

-- Function to take the guard's shift time input from the shift timing box. 
local function ShiftTimeFieldHandler( textField )
	return function( event )
		if ( "began" == event.phase ) then
			-- This is the "keyboard has appeared" event
			-- In some cases you may want to adjust the interface when the keyboard appears.
		
		elseif ( "ended" == event.phase ) then
			-- This event is called when the user stops editing a field: for example, when they touch a different field
			inputShiftTime = textField().text
	
		elseif ( "editing" == event.phase ) then
		
		elseif ( "submitted" == event.phase ) then
			-- This event occurs when the user presses the "return" key (if available) on the onscreen keyboard
			inputShiftTime = textField().text
			
			-- Hide keyboard
			native.setKeyboardFocus( nil )
		end
	end
end

-- Function to take the location input from the location box. 
local function LocationFieldHandler( textField )
	return function( event )
		if ( "began" == event.phase ) then
			-- This is the "keyboard has appeared" event
			-- In some cases you may want to adjust the interface when the keyboard appears.
		
		elseif ( "ended" == event.phase ) then
			-- This event is called when the user stops editing a field: for example, when they touch a different field
			inputLocation = textField().text
	
		elseif ( "editing" == event.phase ) then
		
		elseif ( "submitted" == event.phase ) then
			-- This event occurs when the user presses the "return" key (if available) on the onscreen keyboard
			inputLocation = textField().text
	
			-- Hide keyboard
			native.setKeyboardFocus( nil )
		end
	end
end

-- Function to take the type input from the type box. 
local function typeFieldHandler( textField )
	return function( event )
		if ( "began" == event.phase ) then
			-- This is the "keyboard has appeared" event
			-- In some cases you may want to adjust the interface when the keyboard appears.
		
		elseif ( "ended" == event.phase ) then
			-- This event is called when the user stops editing a field: for example, when they touch a different field
			inputType = textField().text
	
		elseif ( "editing" == event.phase ) then
		
		elseif ( "submitted" == event.phase ) then
			-- This event occurs when the user presses the "return" key (if available) on the onscreen keyboard
			inputType = textField().text
	
			-- Hide keyboard
			native.setKeyboardFocus( nil )
		end
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

    -- Assign "self.view" to local variable "sceneGroup" for easy reference
    local sceneGroup = self.view

	bg =   display.newImageRect( "images/simple.jpg", display.contentWidth, display.contentHeight)
	bg.x = display.contentCenterX
	bg.y = display.contentCenterY
	 -- Insert background into "sceneGroup"
	sceneGroup:insert(bg)
	
------------------------------------------------------------------
	-- Create the widget
	-- Submit button
	SubmitButton = widget.newButton(
	{
		label = "Submit",
		font = "Arial Rounded MT Bold",
		fontSize = 18,
		labelColor = { default={ 0,0,0 }},
		onEvent = handleButtonEvent,
		onRelease = SubmitScene,
		emboss = false,
		shape = "roundedRect",
		width = 150,
		height = 40,
		cornerRadius = 2,
		fillColor = { default={0.9,0.8,0.7}, over={0, 139, 139} },
		strokeColor = { default={0, 139, 139}, over={0.9,0.8,0.7} },
		strokeWidth = 3
	}
)

	--Center the button
	SubmitButton.x = display.contentCenterX
	SubmitButton.y = 410
	--Insert Button for go back  into "sceneGroup"
	sceneGroup:insert(SubmitButton)
	SubmitButton:addEventListener("tap", SubmitScene)
	
-- Back button
	BackButton = widget.newButton(
	{
		label = "Back",
		font = "Lucida Fax",
		fontSize = 24,
		labelColor = { default={ 0,0,0 }},
		onEvent = handleButtonEvent,
		onRelease = BackScene,
		emboss = false,
		shape = "roundedRect",
		width = 100,
		height = 40,
		cornerRadius = 2,
		fillColor = { default={1,0,0}, over={0, 128, 0} },
		strokeColor = { default={0.8,0.8,0.8}, over={0.8,0.8,0.8} },
		strokeWidth = 3
	}
)

	--Center the button
	BackButton.x = display.contentCenterX
	BackButton.y = 480
	--Insert Button for go back  into "sceneGroup"
	sceneGroup:insert(BackButton)
	BackButton:addEventListener("tap", BackScene)

	-- Name Label.
	nameLabel = display.newText( "Guard On Duty", 75, 165, "STENCIL", 22)
	nameLabel:setFillColor(1,0.8,0.4)
	nameLabel.anchorX = 0
	nameLabel.y = 30
	sceneGroup:insert( nameLabel )

	-- Date Label.
	DateLabel = display.newText( "Date", 120, 165, "STENCIL", 22)
	DateLabel:setFillColor(1,0.8,0.4)
	DateLabel.anchorX = 0
	DateLabel.y = 110
	sceneGroup:insert( DateLabel )
	
	-- Shift Time Label.
	ShiftTimeLabel = display.newText( "Shift (Start - End)", 55, 165, "STENCIL", 22)
	ShiftTimeLabel:setFillColor(1,0.8,0.4)
	ShiftTimeLabel.anchorX = 0
	ShiftTimeLabel.y = 190
	sceneGroup:insert( ShiftTimeLabel )

	-- Location Label.
	locationLabel = display.newText( "Location", 100, 165, "STENCIL", 22)
	locationLabel:setFillColor(1,0.8,0.4)
	locationLabel.anchorX = 0
	locationLabel.y = 270
	sceneGroup:insert( locationLabel )
	
end

------------------------------------------------------------------------

-- show()
function scene:show( event )
	local sceneGroup = self.view
    	local phase = event.phase

    	if ( phase == "will" ) then
        	-- Code here runs when the scene is still off screen (but is about to come on screen)

    	elseif ( phase == "did" ) then
    		local fieldWidth = display.contentWidth - 150
		if fieldWidth > 250 then
			fieldWidth = 250
		end

		-- Name Field.
		nameField = native.newTextField( 50, 65, 220, 33 )
		nameField:addEventListener( "userInput", nameFieldHandler( function() return nameField end ) ) 
		sceneGroup:insert(nameField)
		nameField.anchorX = 0
		nameField.placeholder = "Who is the guard?"

		-- Date Field.
		DateField = native.newTextField( 50, 145, 220, 33 )
		DateField:addEventListener( "userInput", DateFieldHandler( function() return DateField end ) ) 
		sceneGroup:insert(DateField)
		DateField.anchorX = 0
		DateField.placeholder = "When?"

		-- Shift Time Field.
 		ShiftTimeField = native.newTextField( 50, 225, 220, 33 )
		ShiftTimeField:addEventListener( "userInput", ShiftTimeFieldHandler( function() return ShiftTimeField end ) ) 
		sceneGroup:insert(ShiftTimeField)
		ShiftTimeField.anchorX = 0
		ShiftTimeField.placeholder = "Shift timing?"

		-- Location Field.
		locationField = native.newTextField( 50, 305, 220, 33 )
		locationField:addEventListener( "userInput", LocationFieldHandler( function() return locationField end ) ) 
		sceneGroup:insert(locationField)
		locationField.anchorX = 0
		locationField.placeholder = "Where is the location?"

    	end
end


-- hide()
function scene:hide( event )

    	local sceneGroup = self.view
    	local phase = event.phase

    	if ( phase == "will" ) then
		
		nameField:removeSelf()
		nameField = nil
        DateField:removeSelf()
		DateField = nil
		ShiftTimeField:removeSelf()
		ShiftTimeField = nil
		locationField:removeSelf()
		locationField = nil

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