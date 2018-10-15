--When Guard clicks on the Roster button

---------------------------------------------------------------------------------------------------------------
-- it need the composer at all time
local composer = require( "composer" )

 -- this line is needed to create a new page
local scene = composer.newScene()

-- This is needed to use the database.
require("sqlite3")
local path = system.pathForFile("data.db", system.DocumentsDirectory)
local db = sqlite3.open(path)

local user = require("user")
---------------------------------------------------------------------------------------------------------------

local SubmitButton
local BackButton
local shiftStart
local shiftEnd

local widget = require ( "widget" ) 

-- If user selects the 'submit' button.
local function SubmitScene( event )
	if ( "ended" == event.phase ) then
		local date = tostring(os.date("%x"))
		local shiftStart = tostring(shiftStart)
		local shiftEnd = tostring(shiftEnd)
		local Name = user.empName
		
		local insertQuery = [[INSERT INTO shift VALUES (NULL, "]]..date..[[", "]]..shiftStart..[[", "]]..shiftEnd..[[", "]]..Name..[["); ]]
		db:exec(insertQuery)		

		composer.gotoScene("GuardHomePage",{effect = "fromLeft",time = 100})		
	end		
end

local function BackScene( event )

	if ( "ended" == event.phase ) then
		composer.gotoScene("GuardSiteSignInPage",{effect = "fromLeft",time = 100})		
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
	
-------------------------------------------------------------------------------------------------------------------

-- Create the widget
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

------------------------------------------------------------------------------------------------------------------

	-- Status text box for Start Shift
	local StartBox = display.newRect( 40, 60, display.contentWidth-110, 70 )
	StartBox.x = 115
	StartBox:setFillColor( 0.8,0.6,0.9 )
	sceneGroup:insert( StartBox )
	
	-- Status text for Shift Start Time
	local StartTime = display.newText( "Start Time = 00: 00", 80, 350, 200, 0, "Arial Black", 16 )

	StartTime.anchorX = 0
	StartTime.x = 30
	StartTime.y = 85
	sceneGroup:insert( StartTime )

	StartBox.height = StartTime.height+16
	StartBox.y = StartTime.y
-------------------------------------------------------------------------------------------------------------------	
	-- Status text box for End Shift
	local EndBox = display.newRect( 40, 60, display.contentWidth-110, 70 )
	EndBox.x = 115
	EndBox:setFillColor( 0.8,0.5,0.7 )
	sceneGroup:insert( EndBox )
	
	-- Status text for Shift End Time
	local EndTime = display.newText( "End Time = 00: 00", 80, 350, 400, 0, "Arial Black", 16 )
	EndTime.anchorX = 0
	EndTime.x = 35
	EndTime.y = 145
	sceneGroup:insert( EndTime )

	EndBox.height = EndTime.height+16
	EndBox.y = EndTime.y

--------------------------------------------------------------------------------------------------------------------

	-- Set up the picker column data
	local hour = {}
	local minutes = {}
	local seconds = {}
	for i = 1,24 do hour[i] = i end
	for i = 0,6 do minutes[i] = -1+i end
	for j = 0,10 do seconds[j] = -1+j end

	local columnData = { 
		{
			align = "right",
			width = 90,
			startIndex = 7,
			labels = hour
		},
		{
			align = "right",
			width = 70,
			startIndex = 2,
			labels = minutes,
		},
		{
			align = "left",
			width = 65,
			startIndex = 2,
			labels = seconds,
		},
	}
		
	-- Create a new Picker Wheel
	local pickerWheel = widget.newPickerWheel {
	
		top = 200,
		columns = columnData
	}
	
	pickerWheel.x = display.contentCenterX
	pickerWheel.bg = display.contentCenterX
	sceneGroup:insert( pickerWheel )

-----------------------------------------------------------------------------------------------------------------------	
	local function showStartValues( event )
		-- Retrieve the current values from the picker
		local values = pickerWheel:getValues()
		
		-- Update the status box text
		shiftStart = values[1].value .. ": " .. values[2].value .. "" .. values[3].value
		StartTime.text = "Start Time = " .. shiftStart
				
		return true
	end
	
	local getValuesButton = widget.newButton {
		top = 70,
		width = 192,
		height = 32,
		id = "getValues",
		label = "Update",
		labelColor = { default={ 0.5,1,0.7 }},
		font = "Cooper Black",
		fontSize = 18,
		onRelease = showStartValues,
	}
	sceneGroup:insert( getValuesButton )
	getValuesButton.x = 270
------------------------------------------------------------------------------------------------------------------------
	local function showEndValues( event )
		-- Retrieve the current values from the picker
		local values = pickerWheel:getValues()
		
		-- Update the status box text
		shiftEnd = values[1].value .. ": " .. values[2].value .. "" .. values[3].value
		EndTime.text = "End Time = " .. shiftEnd		
		
		return true
	end
	
	local getValuesButton = widget.newButton {
		top = 130,
		width = 192,
		height = 32,
		id = "getValues",
		label = "Update",
		labelColor = { default={ 0.5,1,0.7 }},
		font = "Cooper Black",
		fontSize = 18,
		onRelease = showEndValues,
	}
	sceneGroup:insert( getValuesButton )
	getValuesButton.x = 270
	
end
-----------------------------------------------------------------------------------------------------------------------
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