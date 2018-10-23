-----------------------------------------------------------------------------------------
-- SOPDetailsPage.lua
-----------------------------------------------------------------------------------------
------------------------------------------------------------------
-- Declare and initialise variables.
------------------------------------------------------------------
-- it need the composer at all time
local composer = require( "composer" )

 -- this line is needed to create a new page
local scene = composer.newScene()

local widget = require ( "widget" )

------------------------------------------------------------------
-- Functions.
------------------------------------------------------------------
-- If the user selects the 'Back' button.
local function BackScene( event )
	if ( "ended" == event.phase ) then
		-- Go to Guard Site Sign In Page.
		composer.gotoScene("GuardSiteSignInPage",{effect = "slideDown",time = 1000})		
	end	
end

--scrollView Listener
local function scrollListener ( event )

	local phase = event.phase
	local direction = event.direction
	
	-- In the event a scroll limit is reached...
	if ( event.limitReached ) then
    		if ( event.direction == "up" ) then 
			print( "Reached bottom limit" )
    		elseif ( event.direction == "down" ) then 
			print( "Reached top limit" )
    		elseif ( event.direction == "left" ) then 
			print( "Reached right limit" )
    		elseif ( event.direction == "right" ) then 
			print( "Reached left limit" )
    		end
 	end	
	return true
end

------------------------------------------------------------------
-- Create scene.
------------------------------------------------------------------
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

	bg =   display.newImageRect( "images/Board.jpg", display.contentWidth, display.contentHeight)
	bg.x = display.contentCenterX
	bg.y = display.contentCenterY
	 -- Insert background into "sceneGroup"
	sceneGroup:insert(bg)
	
	--Create a ScrollView
	local scrollView = widget.newScrollView
	{
    		top = 0,
    		left = 10,
    		right = 10,
    		width = 300,
    		height = 400,
    		scrollWidth = 300,
    		scrollHeight = 800,
    		topPadding = 120,
    		bottomPadding = 50, 
    		leftPadding = 5, 
    		rightPadding = 5,
    		horizontalScrollDisabled = false,
    		verticalScrollDisabled = false,
		listener = scrollListener,
		hideBackground = true,
	}

	-- Path for the file to read
	local path =  system.pathForFile( "SOP.txt", system.ResourcesDirectory )
	-- Open the file handle
	local myFile = io.open( path, "r" )

	local contents = myFile:read ( "*a" )

	--Create a text object containing the large text string and insert it into the scrollView
	local SOPDetails = display.newText (contents, 0, 0, 280, 700, "Berlin Sans FB", 18)
	SOPDetails:setTextColor (1,1,1)
	SOPDetails.x = 150
	SOPDetails.y = display.contentCenterY
	scrollView:insert ( SOPDetails )
	sceneGroup:insert (scrollView)

	-- Back button
	local BackButton = widget.newButton(
	{
		width = 70,
		height = 70,
		defaultFile = "images/backButton.jpg",     
		onEvent = BackScene,
	})
	 
	--Center the button
	BackButton.x = display.contentCenterX
	BackButton.y = 470
	--Insert Button for go back  into "sceneGroup"
	sceneGroup:insert(BackButton)
	BackButton:addEventListener("tap", BackScene)
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