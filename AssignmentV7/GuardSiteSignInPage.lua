--When Guard clicks on the Roster button

-----------------------------------------------------------------
-- it need the composer at all time
local composer = require( "composer" )

 -- this line is needed to create a new page
local scene = composer.newScene()

------------------------------------------------------------------

local switchText
local onOffSwitch
local ShiftButton
local StartShiftButton
local BackButton
local SOPButton
local PostOrderButton

local widget = require ( "widget" )

local infoShowing = false

local function ShiftScene( event )

	if ( "ended" == event.phase ) then
		composer.gotoScene("GuardFinishShiftPage",{effect = "fromRight",time = 100})		
	end	
	
end

--[[local function StartShiftScene( event )

	if ( "ended" == event.phase ) then
		composer.gotoScene("",{effect = "fromRight",time = 100})		
	end	
	
end]]

local function BackScene( event )

	if ( "ended" == event.phase ) then
		composer.gotoScene("GuardHomePage",{effect = "fromLeft",time = 800})		
	end	
	
end

local function SOPScene( event )

	if ( "ended" == event.phase ) then
		composer.gotoScene("SOPpage",{effect = "slideUp",time = 800})		
	end	
	
end

local function PostOrderScene( event )

	if ( "ended" == event.phase ) then
		composer.gotoScene("PostOrderPage",{effect = "slideUp",time = 800})		
	end	
	
end

------------------------------------------------------------------------------------------------------------------

		
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
		
------------------------------------------------------------------------------------------------------------------

-- Button to click when guard has finish his/her shift
	ShiftButton = widget.newButton(
	{
		width = 95,
		height = 95,
		defaultFile = "images/finishButton.jpg",     
		onEvent = ShiftScene,
				
	}
)

	--Center the button
	ShiftButton.x = display.contentCenterX
	ShiftButton.y = 340
	--Insert Button for go back  into "sceneGroup"
	sceneGroup:insert(ShiftButton)
	ShiftButton:addEventListener("tap", ShiftScene)
	
	--Finish Shift Label
	FinishButton = display.newText(" Finish Shift", 160, 405, "Arial Black", 18)
	FinishButton:setFillColor(1,1,1)
	sceneGroup:insert(FinishButton)
		
-- Button to click for guard to view the SOPs
	SOPButton = widget.newButton(
	{
		width = 150,
		height = 150,
		defaultFile = "images/SOPButton.jpg",     
		onEvent = SOPScene,
	}
)

	--Center the button
	SOPButton.x = 70
	SOPButton.y = 200
	--Insert Button for go back  into "sceneGroup"
	sceneGroup:insert(SOPButton)
	SOPButton:addEventListener("tap", SOPScene)
	
	--SOPs Label
	SOPButton = display.newText("SOPs", 70, 260, "Arial Black", 18)
	SOPButton:setFillColor(1,1,1)
	sceneGroup:insert(SOPButton)
	
-- Button to click for guard to view the Post Order
	PostOrderButton = widget.newButton(
	{
		width = 95,
		height = 95,
		defaultFile = "images/POButton.jpg",     
		onEvent = PostOrderScene,
	}
)

	--Center the button
	PostOrderButton.x = 250
	PostOrderButton.y = 200
	--Insert Button for go back  into "sceneGroup"
	sceneGroup:insert(PostOrderButton)
	PostOrderButton:addEventListener("tap", PostOrderScene)
	
	--Post Order Label
	POButton = display.newText(" Post \nOrder", 250, 270, "Arial Black", 18)
	POButton:setFillColor(1,1,1)
	sceneGroup:insert(POButton)
---------------------------------------------------------------------------------------------------------------------------------------------
-- Button handler function
local function EmergencyScene( event )

	local buttonID = event.target.id

	if ( buttonID == "" ) then
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
local menuButtons = { ""}

-- Loop through table to display buttons

local buttonGroup = display.newGroup()
for i = 1,#menuButtons do
	
	local EmergencyButton = widget.newButton(
	{
		label = menuButtons[i],
		id = menuButtons[i],
		width = 95,
		height = 95,
		defaultFile = "images/PanicButton.jpg",     
		onEvent = EmergencyScene,		
	})
	
	buttonGroup:insert( EmergencyButton )
	--Center the button
	EmergencyButton.x = display.contentCenterX
	EmergencyButton.y = 50
	--Insert Button for go back  into "sceneGroup"
	sceneGroup:insert(EmergencyButton)
	EmergencyButton:addEventListener("tap", EmergencyScene)
	
	--Emergency Label
	PanicButton = display.newText("Emergency", 165, 110, "Arial Black", 18)
	PanicButton:setFillColor(1,1,1)
	sceneGroup:insert(PanicButton)

end

-- Button to click for guard to return to guard's home page
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
end

----------------------------------------------------------------------------------------------------------------------------------------------------

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

    	if ( "did" == event.phase ) then
		
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

