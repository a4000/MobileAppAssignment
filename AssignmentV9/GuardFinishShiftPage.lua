-----------------------------------------------------------------------------------------
-- GuardFinishShiftPage.lua
-----------------------------------------------------------------------------------------
--==================================================================================================================================
-- 												Code written by Jesheena(driver) 
-- 												Verified by Adam(navigator)
--==================================================================================================================================
--==================================================================================================================================
-- 												Code modified by Ritish(driver) Added validation for start and end time 
-- 												Verified by Adam(navigator)
--==================================================================================================================================
------------------------------------------------------------------
-- Declare and initialise variables.
------------------------------------------------------------------
-- it need the composer at all time
local composer = require( "composer" )

 -- this line is needed to create a new page
local scene = composer.newScene()

-- This is needed to use the database.
require("sqlite3")
local path = system.pathForFile("data.db", system.DocumentsDirectory)
local db = sqlite3.open(path)

local user = require("user")

local widget = require ( "widget" ) 

local SubmitButton
local BackButton
local shiftStart
local shiftEnd
local StartTime
local EndTime
local pickerWheel

------------------------------------------------------------------
-- Functions.
------------------------------------------------------------------
-- Function to validate the input and show appropriate alert message.
local function inputValidation()

	-- If any of the fields are blank, show alert and return 0.
	if (shiftStart == nil or shiftEnd == nil) then
		local alert = native.showAlert( "Invalid input", "There must be a start time and an end time.", { "OK" } )
		return 0

	-- This code is needed to prevent an error that happens when the start time and end time are the same.
	elseif(shiftStart == shiftEnd) then
		local alert = native.showAlert( "Invalid input", "Start time must be before end time.", { "OK" } )
		return 0

	else
		-- Start by finding the mid and end positions of the start time and end time.
		local startMid = string.find( shiftStart, ":" )
		local endMid = string.find( shiftEnd, ":" )
		local startLen = string.len(shiftStart)
		local endLen = string.len(shiftEnd)

		-- Split the start time and end time by hours and minutes and convert to numbers.
		local startHour = tonumber(shiftStart:sub(1, startMid - 1))
		local startMin = tonumber(shiftStart:sub(startMid + 2, startLen))
		local endHour = tonumber(shiftEnd:sub(1, endMid - 1))
		local endMin = tonumber(shiftEnd:sub(endMid + 2, endLen))

		print(startHour)
		print(startMin)
		print(endHour)
		print(endMin)
		
		-- If start time is after end time, show alert and return 0.
		if(startHour > endHour or startHour == endHour and startMin >= endMin) then
			local alert = native.showAlert( "Invalid input", "Start time must be before end time.", { "OK" } )
			return 0

		-- If input is valid, return 1.
		else
			return 1
		end
	end
end

-- If user selects the 'Submit' button.
local function SubmitScene( event )
	if ( "ended" == event.phase ) then
		-- Validate input
		local isValid = inputValidation()
		
		-- If input is valid
		if (isValid == 1) then

			local date = tostring(os.date("%x"))
			local shiftStart = tostring(shiftStart)
			local shiftEnd = tostring(shiftEnd)
			local Name = user.empName
		
			-- Insert into shift table
			local insertQuery = [[INSERT INTO shift VALUES (NULL, "]]..date..[[", "]]..shiftStart..[[", "]]..shiftEnd..[[", "]]..Name..[["); ]]
			db:exec(insertQuery)	

			siteSignedIn = 0

			-- Go to Guard Home Page.
			composer.gotoScene("GuardHomePage",{effect = "fromLeft",time = 500})
		end		
	end		
end

-- If the user selects the 'Back' button.
local function BackScene( event )
	if ( "ended" == event.phase ) then
		-- Go to Guard Site Sign In Page.
		composer.gotoScene("GuardSiteSignInPage",{effect = "fromLeft",time = 500})		
	end	
end

-- Listener for the shift start time.
local function showStartValues( event )
	-- Retrieve the current values from the picker
	local values = pickerWheel:getValues()
		
	-- Update the status box text
	shiftStart = values[1].value .. ": " .. values[2].value .. "" .. values[3].value
	StartTime.text = "Start Time = " .. shiftStart
				
	return true
end

-- Listener for the shift end time.
local function showEndValues( event )
	-- Retrieve the current values from the picker
	local values = pickerWheel:getValues()
	
	-- Update the status box text
	shiftEnd = values[1].value .. ": " .. values[2].value .. "" .. values[3].value
	EndTime.text = "End Time = " .. shiftEnd		
		
	return true
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

	bg =   display.newImageRect( "images/orange-ish.jpg", display.contentWidth, display.contentHeight)
	bg.x = display.contentCenterX
	bg.y = display.contentCenterY
	-- Insert background into "sceneGroup"
	sceneGroup:insert(bg)
	
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
	})

	--Center the button
	SubmitButton.x = display.contentCenterX
	SubmitButton.y = 480
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
	BackButton.y = 20
	--Insert Button for go back  into "sceneGroup"
	sceneGroup:insert(BackButton)
	BackButton:addEventListener("tap", BackScene)
	
	-- Status text box for Start Shift
	local StartBox = display.newRect( 40, 60, display.contentWidth-110, 70 )
	StartBox.x = 115
	StartBox:setFillColor( 0.8,0.6,0.9 )
	sceneGroup:insert( StartBox )
	
	-- Status text for Shift Start Time
	StartTime = display.newText( "Start Time = 00: 00", 80, 350, 200, 0, "Arial Black", 16 )

	StartTime.anchorX = 0
	StartTime.x = 30
	StartTime.y = 85
	sceneGroup:insert( StartTime )

	StartBox.height = StartTime.height+16
	StartBox.y = StartTime.y

	-- Status text box for End Shift
	local EndBox = display.newRect( 40, 60, display.contentWidth-110, 70 )
	EndBox.x = 115
	EndBox:setFillColor( 0.8,0.5,0.7 )
	sceneGroup:insert( EndBox )
	
	-- Status text for Shift End Time
	EndTime = display.newText( "End Time = 00: 00", 80, 350, 400, 0, "Arial Black", 16 )
	EndTime.anchorX = 0
	EndTime.x = 35
	EndTime.y = 145
	sceneGroup:insert( EndTime )

	EndBox.height = EndTime.height+16
	EndBox.y = EndTime.y

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
	pickerWheel = widget.newPickerWheel {
	
		top = 200,
		columns = columnData
	}
	
	pickerWheel.x = display.contentCenterX
	pickerWheel.bg = display.contentCenterX
	sceneGroup:insert( pickerWheel )
	
	local getValuesButton = widget.newButton {
		top = 70,
		width = 192,
		height = 32,
		id = "getValues",
		label = "Update",
		labelColor = { default={ 0,0,0 }},
		font = "STENCIL",
		fontSize = 18,
		onRelease = showStartValues,
		onEvent = handleButtonEvent,
		emboss = false,
		shape = "roundedRect",
		width = 80,
		height = 30,
		cornerRadius = 2,
		fillColor = { default={0.5,1,0.7}, over={0.5,1,0.7} },
		strokeColor = { default={0.5,0.5,0.5}, over={0,0,0} },
		strokeWidth = 2
	}
	sceneGroup:insert( getValuesButton )
	getValuesButton.x = 270
	
	local getValuesButton = widget.newButton {
		top = 130,
		width = 192,
		height = 32,
		id = "getValues",
		label = "Update",
		labelColor = { default={ 0,0,0 }},
		font = "STENCIL",
		fontSize = 18,
		onRelease = showEndValues,
		onEvent = handleButtonEvent,
		emboss = false,
		shape = "roundedRect",
		width = 80,
		height = 30,
		cornerRadius = 2,
		fillColor = { default={0.5,1,0.7}, over={0.5,1,0.7} },
		strokeColor = { default={0.5,0.5,0.5}, over={0,0,0} },
		strokeWidth = 2
	}
	sceneGroup:insert( getValuesButton )
	getValuesButton.x = 270	
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
        	-- Code here runs when the scene is entirely on screen
    	end
end

------------------------------------------------------------------
-- Hide scene.
------------------------------------------------------------------
function scene:hide( event )

    	local sceneGroup = self.view
    	local phase = event.phase

    	if ( phase == "will" ) then
        	-- Code here runs when the scene is on screen (but is about to go off screen)

    	elseif ( phase == "did" ) then
        	-- Code here runs immediately after the scene goes entirely off screen
		--SiteButton.isVisible = true
		--StatusButton.isVisible = false
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