-----------------------------------------------------------------------------------------
-- AddEmployeePage.lua
-----------------------------------------------------------------------------------------

-- When Admin wants to add an employee to the database.

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
local SubmitButton
local BackButton
local nameLabel
local nameField
local usernameLabel
local usernameField
local passwordLabel
local passwordField
local phoneLabel
local phoneField
local typeLabel
local typeField

------------------------------------------------------------------
-- Functions.
------------------------------------------------------------------
-- Function to raise the fields.
local function moveUp()
	nameLabel.y = -95
	nameField.y = -60
	usernameLabel.y = -25
	usernameField.y = 10
	passwordLabel.y = 45
	passwordField.y = 80
	phoneLabel.y = 115
	phoneField.y = 150 
	typeLabel.y = 185
	typeField.y = 220
end

-- Function to lower the fields.
local function moveDown()
	nameLabel.y = 70
	nameField.y = 105
	usernameLabel.y = 140
	usernameField.y = 175
	passwordLabel.y = 210
	passwordField.y = 245
	phoneLabel.y = 280
	phoneField.y = 315
	typeLabel.y = 350
	typeField.y = 385
end

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

-- Function to handle the username field. 
local function usernameFieldHandler( textField )
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

			moveDown()
		end
	end
end

-- Function to handle the password field.
local function passwordFieldHandler( textField )
	return function( event )
		if ( "began" == event.phase ) then
			-- This is the "keyboard has appeared" event
			-- In some cases you may want to adjust the interface when the keyboard appears.
		
		elseif ( "ended" == event.phase ) then
			-- This event is called when the user stops editing a field: for example, when they touch a different field
	
		elseif ( "editing" == event.phase ) then
			moveUp()
		
		elseif ( "submitted" == event.phase ) then
			-- This event occurs when the user presses the "return" key (if available) on the onscreen keyboard
	
			-- Hide keyboard
			native.setKeyboardFocus( nil )

			moveDown()
		end
	end
end

-- Function to handle the phone field. 
local function phoneFieldHandler( textField )
	return function( event )
		if ( "began" == event.phase ) then
			-- This is the "keyboard has appeared" event
			-- In some cases you may want to adjust the interface when the keyboard appears.
		
		elseif ( "ended" == event.phase ) then
			-- This event is called when the user stops editing a field: for example, when they touch a different field
	
		elseif ( "editing" == event.phase ) then
			moveUp()
		
		elseif ( "submitted" == event.phase ) then
			-- This event occurs when the user presses the "return" key (if available) on the onscreen keyboard
	
			-- Hide keyboard
			native.setKeyboardFocus( nil )

			moveDown()
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
			moveUp()
		
		elseif ( "submitted" == event.phase ) then
			-- This event occurs when the user presses the "return" key (if available) on the onscreen keyboard
	
			-- Hide keyboard
			native.setKeyboardFocus( nil )

			moveDown()
		end
	end
end

-- Function to validate the input and show appropriate alert message.
local function inputValidation()
	-- If any of the fields are blank, show alert and return 0.
	if (nameField.text == "" or usernameField.text == "" or passwordField.text == "" or phoneField.text == "" or typeField.text == "") then
		local alert = native.showAlert( "Invalid input", "The text fields can't be blank.", { "OK" } )
		return 0

	-- If type is not 'Admin' or 'Guard', show alert and return 0.
	elseif (typeField.text ~= "Admin" and typeField.text ~= "Guard") then
		local alert = native.showAlert( "Invalid input", "Type must be Admin or Guard.", { "OK" } )
		return 0
	
	-- If input is valid, return 1.
	else
		return 1
	end
end

-- If user selects the 'submit' button.
local function SubmitScene( event )
	if ( "ended" == event.phase ) then
		-- Validate input
		local isValid = inputValidation()
		
		-- If input is valid
		if (isValid == 1) then

			-- Insert the user input into the employee table.
			local insertQuery = [[INSERT INTO employee VALUES (NULL, "]]..nameField.text..[[", "]]..usernameField.text..[[", "]]..passwordField.text..[[", "]]..phoneField.text..[[", "]]..typeField.text..[["); ]]
			db:exec(insertQuery)		

			composer.gotoScene("AdminEmployeeDetailsPage",{effect = "fromLeft",time = 100})	
		end	
	end		
end

-- If the user selects the 'back' button.
local function BackScene( event )
	if ( "ended" == event.phase ) then
		composer.gotoScene("AdminEmployeeDetailsPage",{effect = "fromLeft",time = 100})		
	end	
end

-- create()
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

	bg =   display.newImageRect( "images/reddish.jpg", display.contentWidth, display.contentHeight)
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
		labelColor = { default={ 0, 0, 0}},
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
	SubmitButton.y = 460
	--Insert Button for go back  into "sceneGroup"
	sceneGroup:insert(SubmitButton)
	SubmitButton:addEventListener("tap", SubmitScene)

	-- Back button
	BackButton = widget.newButton(
		{
			width = 60,
			height = 60,
			defaultFile = "images/backButton.jpg",     
			onEvent = BackScene,
		}
	)
	 
	--Center the button
	BackButton.x = 270
	BackButton.y = 30
	--Insert Button for go back  into "sceneGroup"
	sceneGroup:insert(BackButton)
	BackButton:addEventListener("tap", BackScene)


	-- Name Label.
	nameLabel = display.newText( "Name:", 20, 165, "STENCIL", 22)
	nameLabel:setFillColor(0,1,0.5)
	nameLabel.anchorX = 0
	nameLabel.y = 70
	sceneGroup:insert( nameLabel )

	-- Username Label.
	usernameLabel = display.newText( "Username:", 20, 165, "STENCIL", 22)
	usernameLabel:setFillColor(0,1,0.5)
	usernameLabel.anchorX = 0
	usernameLabel.y = 140
	sceneGroup:insert( usernameLabel )
	
	-- Password Label.
	passwordLabel = display.newText( "Password:", 20, 165, "STENCIL", 22)
	passwordLabel:setFillColor(0,1,0.5)
	passwordLabel.anchorX = 0
	passwordLabel.y = 210
	sceneGroup:insert( passwordLabel )

	-- Phone Label.
	phoneLabel = display.newText( "Phone:", 20, 165, "STENCIL", 22)
	phoneLabel:setFillColor(0,1,0.5)
	phoneLabel.anchorX = 0
	phoneLabel.y = 280
	sceneGroup:insert( phoneLabel )
	
	-- Type Label.
	typeLabel = display.newText( "Type:", 20, 165, "STENCIL", 22)
	typeLabel:setFillColor(0,1,0.5)
	typeLabel.anchorX = 0
	typeLabel.y = 350
	sceneGroup:insert( typeLabel )
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
		nameField = native.newTextField( 20, 105, 220, 32 )
		nameField:addEventListener( "userInput", nameFieldHandler( function() return nameField end ) ) 
		sceneGroup:insert(nameField)
		nameField.anchorX = 0
		nameField.placeholder = "Enter Name"

		-- Username Field.
		usernameField = native.newTextField( 20, 175, 220, 32 )
		usernameField:addEventListener( "userInput", usernameFieldHandler( function() return usernameField end ) ) 
		sceneGroup:insert(usernameField)
		usernameField.anchorX = 0
		usernameField.placeholder = "Enter Username"

		-- Password Field.
 		passwordField = native.newTextField( 20, 245, 220, 32 )
		passwordField:addEventListener( "userInput", passwordFieldHandler( function() return passwordField end ) ) 
		sceneGroup:insert(passwordField)
		passwordField.anchorX = 0
		passwordField.placeholder = "Enter Password"

		-- Phone Field.
		phoneField = native.newTextField( 20, 315, 220, 32 )
		phoneField:addEventListener( "userInput", phoneFieldHandler( function() return phoneField end ) ) 
		sceneGroup:insert(phoneField)
		phoneField.anchorX = 0
		phoneField.placeholder = "Enter Phone Number"

		-- Type Field.
 		typeField = native.newTextField( 20, 385, 260, 32 )
		typeField:addEventListener( "userInput", typeFieldHandler( function() return typeField end ) ) 
		sceneGroup:insert(typeField)
		typeField.anchorX = 0
		typeField.placeholder = "Enter Type ('Admin' or 'Guard')"
    	end
end

-- hide()
function scene:hide( event )

    	local sceneGroup = self.view
    	local phase = event.phase

    	if ( phase == "will" ) then
		
		nameField:removeSelf()
		nameField = nil
        	usernameField:removeSelf()
		usernameField = nil
		passwordField:removeSelf()
		passwordField = nil
		phoneField:removeSelf()
		phoneField = nil
		typeField:removeSelf()
		typeField = nil

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