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

local UploadButton
local SubmitButton
local BackButton
local txtCommentBox
local lblCommentBox

local widget = require ( "widget" )
 
local function SubmitScene( event )

	if ( "ended" == event.phase ) then
		composer.gotoScene("",{effect = "fromRight",time = 100})		
	end	
	
end

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

--Button handler function 
local function UploadPictureScene ( event )
	
	local buttonID = event.target.id
	
	if ( buttonID == "Upload Photo!" ) then 
		--Create native alert
		local alertBox = native.showAlert( "Upload Photo", "Please send the incident report photo via email. Thanks!", { "Done", "Email Address" },
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
		PhotoButton.y = 150
		
		--Insert button for go back into "sceneGroup"
		sceneGroup:insert (PhotoButton)
		PhotoButton:addEventListener("tap", UploadPictureScene)
end
		
-- Button to submit shift details 
	SubmitButton = widget.newButton(
	{
		label = "Submit",
		labelColor = { default={ 0, 0, 0}},
		onEvent = handleButtonEvent,
		onRelease = SubmitScene,
		emboss = false,
		shape = "roundedRect",
		width = 150,
		height = 40,
		cornerRadius = 2,
		fillColor = { default={255, 215, 0}, over={128, 0, 128} },
		strokeColor = { default={0,0,0}, over={0,0,0} },
		strokeWidth = 3
	}
)

	--Center the button
	SubmitButton.x = display.contentCenterX
	SubmitButton.y = 470
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
	BackButton.y = -10
	--Insert Button for go back  into "sceneGroup"
	sceneGroup:insert(BackButton)
	BackButton:addEventListener("tap", BackScene)

	
end

------------------------------------------------------------------------
-- show()
function scene:show( event )
	local sceneGroup = self.view

	if event.phase == "did" then
		-- Create comment box
		txtCommentBox = native.newTextBox (160, 350, 280, 120)
		txtCommentBox.isEditable = true
		txtCommentBox.size = 15 --character size
		lblCommentBox = display.newText( "Comment: ", 90, 270, "Ravie", 20)
		lblCommentBox:setFillColor(0, 255, 127)

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
		txtCommentBox:removeSelf()
		txtCommentBox = nil
		lblCommentBox:removeSelf()
		lblCommentBox = nil

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