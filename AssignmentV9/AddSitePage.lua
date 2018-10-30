-----------------------------------------------------------------------------------------
-- AddSitePage.lua
-----------------------------------------------------------------------------------------
--==================================================================================================================================
-- 												Code written by Jesheena(driver) 
-- 												Verified by Ritish(navigator)
--==================================================================================================================================
------------------------------------------------------------------
-- Declare and initialise variables.
------------------------------------------------------------------
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

local SubmitButton
local BackButton
local nameLabel
local nameField
local latitudeLabel
local latitudeField
local longitudeLabel
local longitudeField

------------------------------------------------------------------
-- Functions.
------------------------------------------------------------------
-- Function to raise the fields.
local function moveUp()
	nameLabel.y = 45
	nameField.y = 80
	latitudeLabel.y = 115
	latitudeField.y = 150 
	longitudeLabel.y = 185
	longitudeField.y = 220
end

-- Function to lower the fields.
local function moveDown()
	nameLabel.y = 110
	nameField.y = 145
	latitudeLabel.y = 195
	latitudeField.y = 230
	longitudeLabel.y = 280
	longitudeField.y = 315
end

-- Function to handle the name field. 
local function nameFieldHandler( textField )
	return function( event )
		if ( "editing" == event.phase ) then
			-- Raise the fields when editing text.
			moveUp()
		
		elseif ( "submitted" == event.phase ) then
			-- Hide keyboard
			native.setKeyboardFocus( nil )
			
			-- Reset the fields to their original position when finished.
			moveDown()
		end
	end
end

-- Function to handle the latitude field.
local function latitudeFieldHandler( textField )
	return function( event )
		if ( "editing" == event.phase ) then
			-- Raise the fields when editing text.
			moveUp()
		
		elseif ( "submitted" == event.phase ) then
			-- Hide keyboard
			native.setKeyboardFocus( nil )
			
			-- Reset the fields to their original position when finished.
			moveDown()
		end
	end
end

-- Function to handle the longitude field. 
local function longitudeFieldHandler( textField )
	return function( event )
		if ( "editing" == event.phase ) then
			-- Raise the fields when editing text.
			moveUp()
		
		elseif ( "submitted" == event.phase ) then
			-- Hide keyboard
			native.setKeyboardFocus( nil )
			
			-- Reset the fields to their original position when finished.
			moveDown()
		end
	end
end

-- Function to validate the input and show appropriate alert message.
local function inputValidation()
	-- If any of the fields are blank, show alert and return 0.
	if (nameField.text == "" or latitudeField.text == "" or longitudeField.text == "") then
		local alert = native.showAlert( "Invalid input", "The text fields can't be blank.", { "OK" } )
		return 0
	
	-- If longitude or latitude are not numbers, show alert and return 0.
	elseif(tonumber(latitudeField.text) == nil or tonumber(longitudeField.text) == nil) then
		local alert = native.showAlert( "Invalid input", "Longitude and latitude must be numbers.", { "OK" } )
		return 0

	-- If input is valid, return 1.
	else
		return 1
	end
end

-- If user selects the 'Submit' button.
local function SubmitScene( event )
	if ( "ended" == event.phase ) then
		-- Validate input
		local isValid = inputValidation()
		
		-- If input is valid
		if (isValid == 1) then

			-- Insert the user input into the site table.
			local insertQuery = [[INSERT INTO site VALUES (NULL, "]]..nameField.text..[[", "]]..latitudeField.text..[[", "]]..longitudeField.text..[["); ]]
			db:exec(insertQuery)		

			-- Make sure the text fields are at their origional position, then move to Admin Site Details page.
			moveDown()
			composer.gotoScene("AdminSiteDetailsPage",{effect = "fromLeft",time = 500})	
		end	
	end		
end

-- If the user selects the 'Back' button.
local function BackScene( event )
	if ( "ended" == event.phase ) then
		-- Make sure the text fields are at their origional position, then move to Admin Site Details page.
		moveDown()
		composer.gotoScene("AdminSiteDetailsPage",{effect = "fromLeft",time = 500})		
	end	
end

------------------------------------------------------------------
-- Create scene.
------------------------------------------------------------------
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
	})

	--Center the button
	SubmitButton.x = display.contentCenterX
	SubmitButton.y = 420
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
	})
	 
	--Center the button
	BackButton.x = 270
	BackButton.y = 30
	--Insert Button for go back  into "sceneGroup"
	sceneGroup:insert(BackButton)
	BackButton:addEventListener("tap", BackScene)
	
	-- Name Label.
	nameLabel = display.newText( "Name:", 20, 165, "STENCIL", 22)
	nameLabel:setFillColor(0,0.8,1)
	nameLabel.anchorX = 0
	nameLabel.y = 110
	sceneGroup:insert( nameLabel )
	
	-- Latitude Label.
	latitudeLabel = display.newText( "Latitude:", 20, 165, "STENCIL", 22)
	latitudeLabel:setFillColor(0,0.8,1)
	latitudeLabel.anchorX = 0
	latitudeLabel.y = 195
	sceneGroup:insert( latitudeLabel )
	
	-- Longitude Label.
	longitudeLabel = display.newText( "Longitude:", 20, 165, "STENCIL", 22)
	longitudeLabel:setFillColor(0,0.8,1)
	longitudeLabel.anchorX = 0
	longitudeLabel.y = 280
	sceneGroup:insert( longitudeLabel )
end

------------------------------------------------------------------
-- Show scene.
------------------------------------------------------------------
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
		nameField = native.newTextField( 20, 145, 250, 32 )
		nameField:addEventListener( "userInput", nameFieldHandler( function() return nameField end ) ) 
		sceneGroup:insert(nameField)
		nameField.anchorX = 0
		nameField.placeholder = "Enter Site Name"
		
		-- Latitude Field.
 		latitudeField = native.newTextField( 20, 230, 250, 32 )
		latitudeField:addEventListener( "userInput", latitudeFieldHandler( function() return latitudeField end ) ) 
		sceneGroup:insert(latitudeField)
		latitudeField.anchorX = 0
		latitudeField.placeholder = "eg: -31.7592"
		
		-- Longitude Field.
 		longitudeField = native.newTextField( 20, 315, 250, 32 )
		longitudeField:addEventListener( "userInput", longitudeFieldHandler( function() return longitudeField end ) ) 
		sceneGroup:insert(longitudeField)
		longitudeField.anchorX = 0
		longitudeField.placeholder = "eg: 115.7684"
    	end
end

------------------------------------------------------------------
-- Hide scene.
------------------------------------------------------------------
function scene:hide( event )

    	local sceneGroup = self.view
    	local phase = event.phase

    	if ( phase == "will" ) then
		
		nameField:removeSelf()
		nameField = nil
		latitudeField:removeSelf()
		latitudeField = nil
		longitudeField:removeSelf()
		longitudeField = nil

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