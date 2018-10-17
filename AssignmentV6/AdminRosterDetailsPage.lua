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
local dateLabel
local dateField
local shiftTimeLabel
local shiftTimeField
local locationLabel
local locationField

local widget = require ( "widget" ) 

-- If the user clicks the submit button.
local function SubmitScene( event )

	if ( "ended" == event.phase ) then
	
		local insertQuery = [[INSERT INTO roster VALUES (NULL, "]]..nameField.text..[[", "]]..dateField.text..[[", "]]..shiftTimeField.text..[[", "]]..locationField.text..[["); ]]
		db:exec(insertQuery)		

		composer.gotoScene("AdminHomePage",{effect = "fromLeft",time = 100})			
	end	
end

-- If the user clicks the home page button.
local function BackScene( event )

	if ( "ended" == event.phase ) then
		composer.gotoScene("AdminHomePage",{effect = "fromLeft",time = 100})		
	end	
	
end

------------------------------------------------------------------
-- Functions.
------------------------------------------------------------------
-- Function to handle the name field. 
local function nameFieldHandler( textField )
	return function( event )
		if ( "began" == event.phase ) then
			-- This is the "keyboard has appeared" event
			-- In some cases you may want to adjust the interface when the keyboard appears.
		
		elseif ( "ended" == event.phase ) then
			-- This event is called when the user stops editing a field: for example, when they touch a different field
	
		elseif ( "editing" == event.phase ) then
		
		elseif ( "submitted" == event.phase ) then
			-- This event occurs when the user presses the "return" key (if available) on the onscreen keyboard
	
			-- Hide keyboard
			native.setKeyboardFocus( nil )
		end
	end
end

-- Function to handle the date field. 
local function dateFieldHandler( textField )
	return function( event )
		if ( "began" == event.phase ) then
			-- This is the "keyboard has appeared" event
			-- In some cases you may want to adjust the interface when the keyboard appears.
		
		elseif ( "ended" == event.phase ) then
			-- This event is called when the user stops editing a field: for example, when they touch a different field
	
		elseif ( "editing" == event.phase ) then
		
		elseif ( "submitted" == event.phase ) then
			-- This event occurs when the user presses the "return" key (if available) on the onscreen keyboard
	
			-- Hide keyboard
			native.setKeyboardFocus( nil )
		end
	end
end

-- Function to handle the shift time field. 
local function shiftTimeFieldHandler( textField )
	return function( event )
		if ( "began" == event.phase ) then
			-- This is the "keyboard has appeared" event
			-- In some cases you may want to adjust the interface when the keyboard appears.
		
		elseif ( "ended" == event.phase ) then
			-- This event is called when the user stops editing a field: for example, when they touch a different field
	
		elseif ( "editing" == event.phase ) then
		
		elseif ( "submitted" == event.phase ) then
			-- This event occurs when the user presses the "return" key (if available) on the onscreen keyboard
			
			-- Hide keyboard
			native.setKeyboardFocus( nil )
		end
	end
end

-- Function to handle the location field.  
local function locationFieldHandler( textField )
	return function( event )
		if ( "began" == event.phase ) then
			-- This is the "keyboard has appeared" event
			-- In some cases you may want to adjust the interface when the keyboard appears.
		
		elseif ( "ended" == event.phase ) then
			-- This event is called when the user stops editing a field: for example, when they touch a different field
	
		elseif ( "editing" == event.phase ) then
		
		elseif ( "submitted" == event.phase ) then
			-- This event occurs when the user presses the "return" key (if available) on the onscreen keyboard
	
			-- Hide keyboard
			native.setKeyboardFocus( nil )
		end
	end
end

-- Function to handle the type field.  
local function typeFieldHandler( textField )
	return function( event )
		if ( "began" == event.phase ) then
			-- This is the "keyboard has appeared" event
			-- In some cases you may want to adjust the interface when the keyboard appears.
		
		elseif ( "ended" == event.phase ) then
			-- This event is called when the user stops editing a field: for example, when they touch a different field
	
		elseif ( "editing" == event.phase ) then
		
		elseif ( "submitted" == event.phase ) then
			-- This event occurs when the user presses the "return" key (if available) on the onscreen keyboard
	
			-- Hide keyboard
			native.setKeyboardFocus( nil )
		end
	end
end

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

	bg =   display.newImageRect( "images/greenish.jpg", display.contentWidth, display.contentHeight)
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
	SubmitButton.y = 380
	--Insert Button for go back  into "sceneGroup"
	sceneGroup:insert(SubmitButton)
	SubmitButton:addEventListener("tap", SubmitScene)
	
-- Button to click for admin to go back to admin's home page
	BackButton = widget.newButton(
		{
			width = 70,
			height = 70,
			defaultFile = "images/homeButton.jpg",     
			onEvent = BackScene,
		}
	)
	 
		--Center the button
		BackButton.x = display.contentCenterX
		BackButton.y = 470
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
	dateLabel = display.newText( "Date", 120, 165, "STENCIL", 22)
	dateLabel:setFillColor(1,0.8,0.4)
	dateLabel.anchorX = 0
	dateLabel.y = 110
	sceneGroup:insert( dateLabel )
	
	-- Shift Time Label.
	shiftTimeLabel = display.newText( "Shift (Start - End)", 55, 165, "STENCIL", 22)
	shiftTimeLabel:setFillColor(1,0.8,0.4)
	shiftTimeLabel.anchorX = 0
	shiftTimeLabel.y = 190
	sceneGroup:insert( shiftTimeLabel )

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
		dateField = native.newTextField( 50, 145, 220, 33 )
		dateField:addEventListener( "userInput", dateFieldHandler( function() return dateField end ) ) 
		sceneGroup:insert(dateField)
		dateField.anchorX = 0
		dateField.placeholder = "When?"

		-- Shift Time Field.
 		shiftTimeField = native.newTextField( 50, 225, 220, 33 )
		shiftTimeField:addEventListener( "userInput", shiftTimeFieldHandler( function() return shiftTimeField end ) ) 
		sceneGroup:insert(shiftTimeField)
		shiftTimeField.anchorX = 0
		shiftTimeField.placeholder = "Shift timing?"

		-- Location Field.
		locationField = native.newTextField( 50, 305, 220, 33 )
		locationField:addEventListener( "userInput", locationFieldHandler( function() return locationField end ) ) 
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
        	dateField:removeSelf()
		dateField = nil
		shiftTimeField:removeSelf()
		shiftTimeField = nil
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