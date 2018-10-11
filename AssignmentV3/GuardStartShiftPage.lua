--When Guard clicks on the Roster button

-----------------------------------------------------------------
-- it need the composer at all time
local composer = require( "composer" )

 -- this line is needed to create a new page
local scene = composer.newScene()

------------------------------------------------------------------

local BackButton

local widget = require ( "widget" ) 


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