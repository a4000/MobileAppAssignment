--When Guard clicks on the Roster button

-----------------------------------------------------------------
-- it need the composer at all time
local composer = require( "composer" )

 -- this line is needed to create a new page
local scene = composer.newScene()

------------------------------------------------------------------

local widget = require ( "widget" )
 
------------------------------------------------------------------------------------------------------------------

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
	
------------------------------------------------------------------------------------------------------------------
	local table_options = 
	{
		--the white box properties
		top = 10,
		height = 400,
		width = 280,
		left = 20,
		right = 20,	
	}
	local tableView = widget.newTableView(table_options)
	
	sceneGroup:insert(tableView)


	
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

