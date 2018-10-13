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
local TimeLabel
local TimeField
local LocationLabel
local LocationField
local txtDescription
local lblDescription
local inputTime
local inputLocation
local inputDescription

local widget = require ( "widget" )
 
-- If user selects the 'submit' button.
local function SubmitScene( event )
	if ( "ended" == event.phase ) then
		local date = tostring(os.date("%x"))
		local Name = user.empName
		
		local insertQuery = [[INSERT INTO incidentReport VALUES (NULL, "]]..date..[[", "]]..inputTime..[[", "]]..inputLocation..[[", "]]..Name..[["); ]]
		db:exec(insertQuery)		

		composer.gotoScene("GuardHomePage",{effect = "fade",time = 500})		
	end		
end

local function BackScene( event )

	if ( "ended" == event.phase ) then
		composer.gotoScene("GuardHomePage",{effect = "fromLeft",time = 100})		
	end	
	
end

------------------------------------------------------------------
-- Functions.
------------------------------------------------------------------
-- Function to take the time input from the time box. 
local function TimeFieldHandler( textField )
	return function( event )
		if ( "began" == event.phase ) then
			-- This is the "keyboard has appeared" event
			-- In some cases you may want to adjust the interface when the keyboard appears.
		
		elseif ( "ended" == event.phase ) then
			-- This event is called when the user stops editing a field: for example, when they touch a different field
			inputTime = textField().text
	
		elseif ( "editing" == event.phase ) then
		
		elseif ( "submitted" == event.phase ) then
			-- This event occurs when the user presses the "return" key (if available) on the onscreen keyboard
			inputTime = textField().text
			
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
		fillColor = { default={ 0.7,0.7,1 }, over={0.9,0.2,0.3} },
		strokeColor = { default={0,0,0}, over={0,0,0} },
		strokeWidth = 2
		
	})
	
		buttonGroup:insert ( PhotoButton )
		
		--Center the button
		PhotoButton.x = display.contentCenterX
		PhotoButton.y = 80
		
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
	SubmitButton.y = 480
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
	BackButton.x = 250
	BackButton.y = 0
	--Insert Button for go back  into "sceneGroup"
	sceneGroup:insert(BackButton)
	BackButton:addEventListener("tap", BackScene)

	-- Time Label.
	TimeLabel = display.newText( "Time: ", 50, 165, "Britannic Bold", 22)
	TimeLabel:setFillColor(1,1,0.1)
	TimeLabel.anchorX = 0
	TimeLabel.y = 140
	sceneGroup:insert( TimeLabel )

	-- Location Label.
	LocationLabel = display.newText( "Location: ", 50, 165, "Britannic Bold", 22)
	LocationLabel:setFillColor(1,1,0.1)
	LocationLabel.anchorX = 0
	LocationLabel.y = 220
	sceneGroup:insert( LocationLabel )
	
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
		TimeField = native.newTextField( 50, 175, 220, 33 )
		TimeField:addEventListener( "userInput", TimeFieldHandler( function() return TimeField end ) ) 
		sceneGroup:insert(TimeField)
		TimeField.anchorX = 0
		TimeField.placeholder = "What time did it happen?"

		-- Location Field.
		LocationField = native.newTextField( 50, 255, 220, 33 )
		LocationField:addEventListener( "userInput",LocationFieldHandler( function() return LocationField end ) ) 
		sceneGroup:insert(LocationField)
		LocationField.anchorX = 0
		LocationField.placeholder = "Where did it happen?"
		
		-- Create comment box
		txtDescription = native.newTextBox (160, 380, 280, 120)
		txtDescription.isEditable = true
		txtDescription.size = 18 --character size
		txtDescription.placeholder = " Describe the incident..."
		lblDescription = display.newText( "Incident Description: ", 130, 300, "Britannic Bold", 22)
		lblDescription:setFillColor(1,1,0.1)		

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

		TimeField:removeSelf()
		TimeField = nil
		LocationField:removeSelf()
		LocationField = nil
		txtDescription:removeSelf()
		txtDescription = nil
		lblDescription:removeSelf()
		lblDescription = nil

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