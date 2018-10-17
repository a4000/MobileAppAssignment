--When Guard clicks on the Roster button

-------------------------------------------------------------------------------------------------------------------------------------------------------
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

-------------------------------------------------------------------------------------------------------------------------------------------------------

local UploadButton
local SubmitButton
local BackButton
local timeLabel
local timeField
local locationLabel
local locationField
local descriptionLabel
local descriptionField
--local txtDescription
--local lblDescription
local inputTime
local inputLocation
local inputDescription

local widget = require ( "widget" )
 
-- If user selects the 'submit' button.
local function SubmitScene( event )
	if ( "ended" == event.phase ) then
		local date = tostring(os.date("%x"))
		local txtDescription = tostring(txtDescription)
		local Name = user.empName
		
		local insertQuery = [[INSERT INTO incidentReport VALUES (NULL, "]]..date..[[", "]]..timeField.text..[[", "]]..locationField.text..[[", "]]..descriptionField.text..[[", "]]..Name..[["); ]]
		db:exec(insertQuery)		

		composer.gotoScene("GuardHomePage",{effect = "fade",time = 500})		
	end		
end

local function BackScene( event )

	if ( "ended" == event.phase ) then
		composer.gotoScene("GuardHomePage",{effect = "fromLeft",time = 800})		
	end	
	
end

------------------------------------------------------------------
-- Functions.
------------------------------------------------------------------
--[[Function to handle the time field.  
local function timeFieldHandler( textField )
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
end]]--

--[[Function to handle the location field. 
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
end]]--

--[[Function to handle the description field. 
local function descriptionFieldHandler( textField )
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
end]]--

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

	bg =   display.newImageRect( "images/blue-ish.jpg", display.contentWidth, display.contentHeight)
	bg.x = display.contentCenterX
	bg.y = display.contentCenterY
	 -- Insert background into "sceneGroup"
	sceneGroup:insert(bg)
	
-------------------------------------------------------------------------------------------------------------------------------------------------------
-- Create the widget

--Button handler function 
local function UploadPictureScene ( event )
	
	local buttonID = event.target.id
	
	if ( buttonID == "Upload Photo!" ) then 
		--Create native alert
		local alertBox = native.showAlert( "Upload Photo", "Please send the photo via email. Thanks!", { "OK", "Email" },
			function ( event )
				if ( event.action == "clicked" ) then
					if ( event.index == 2 ) then
						system.openURL ( "" )
					end
				end
			end
		)
	end
end

--Table of labels for buttons
local menuButtons = { "Upload Photo!" }

--Loop through table to display buttons
local buttonGroup = display.newGroup()
for i = 1, #menuButtons do

	local PhotoButton = widget.newButton (
	{
		label = menuButtons[i],
		id = menuButtons[i],
		labelColor = { default={ 0, 0, 0}},
		font = "Britannic Bold",
		fontSize = 20,
		onEvent = handleButtonEvent,
		onRelease = UploadPictureScene,
		emboss = false,
		shape = "roundedRect",
		width = 250,
		height = 40,
		cornerRadius = 8,
		fillColor = { default={ 1,0.7,1 }, over={1,0.9,0} },
		strokeColor = { default={1,1,1}, over={1,1,1} },
		strokeWidth = 2
		
	})
	
		buttonGroup:insert ( PhotoButton )
		
		--Center the button
		PhotoButton.x = display.contentCenterX
		PhotoButton.y = 90
		
		--Insert button for go back into "sceneGroup"
		sceneGroup:insert (PhotoButton)
		PhotoButton:addEventListener("tap", UploadPictureScene)
end
		
-- Button to submit shift details 
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
	SubmitButton.y = 470
	--Insert Button for go back  into "sceneGroup"
	sceneGroup:insert(SubmitButton)
	SubmitButton:addEventListener("tap", SubmitScene)
	
-- Button to click for guard to return to guard's home page
	BackButton = widget.newButton(
		{
			width = 60,
			height = 60,
			defaultFile = "images/homeButton.jpg",     
			onEvent = BackScene,
		}
	)
	 
		--Center the button
		BackButton.x = 260
		BackButton.y = 20
		--Insert Button for go back  into "sceneGroup"
		sceneGroup:insert(BackButton)
		BackButton:addEventListener("tap", BackScene)
	

	-- Time Label.
	timeLabel = display.newText( "Time: ", 50, 165, "Britannic Bold", 22)
	timeLabel:setFillColor(1,1,0.1)
	timeLabel.anchorX = 0
	timeLabel.y = 140
	sceneGroup:insert( timeLabel )

	-- Location Label.
	locationLabel = display.newText( "Location: ", 50, 165, "Britannic Bold", 22)
	locationLabel:setFillColor(1,1,0.1)
	locationLabel.anchorX = 0
	locationLabel.y = 220
	sceneGroup:insert( locationLabel )
	
	-- Description Label.
	descriptionLabel = display.newText( "Incident Description: ", 35, 165, "Britannic Bold", 22)
	descriptionLabel:setFillColor(1,1,0.1)
	descriptionLabel.anchorX = 0
	descriptionLabel.y = 300
	sceneGroup:insert( descriptionLabel )
end

----------------------------------------------------------------------------------------------------------------------------------------------------
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

		-- Time Field.
		timeField = native.newTextField( 50, 175, 220, 33 )
		--timeField:addEventListener( "userInput", timeFieldHandler( function() return timeField end ) ) 
		sceneGroup:insert(timeField)
		timeField.anchorX = 0
		timeField.placeholder = "What time did it happen?"

		-- Location Field.
		locationField = native.newTextField( 50, 255, 220, 33 )
		--locationField:addEventListener( "userInput",locationFieldHandler( function() return locationField end ) ) 
		sceneGroup:insert(locationField)
		locationField.anchorX = 0
		locationField.placeholder = "Where did it happen?"
		
		-- Description Field.
		descriptionField = native.newTextBox( 30, 375, 260, 100)
		--descriptionField:addEventListener( "userInput",descriptionFieldHandler( function() return lescriptionField end ) ) 
		descriptionField.isEditable = true
		descriptionField.size = 18 --character size
		sceneGroup:insert(descriptionField)
		descriptionField.anchorX = 0
		descriptionField.placeholder = "Describe the incident..."
				
    	end
end

-- hide()
function scene:hide( event )

    local sceneGroup = self.view
	--
	-- Clean up native objects
	--

	if event.phase == "will" then
		-- avoid the text field from appearing on other pages

		timeField:removeSelf()
		timeField = nil
		locationField:removeSelf()
		locationField = nil
		descriptionField:removeSelf()
		descriptionField = nil

		--event.parent:reloadTable()
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