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

local HomePageButton

local widget = require ( "widget" ) 

-- onRowRender function for the tableview
local function onRowRender(event)
	local row = event.row
	local font = "Rockwell"
	local fontSize = 18
	local rowHeight = row.height/2
	
	local options_name = 
	{
		parent = row,
		text = " Name: " .. row.params.Name .. "\n" .. row.params.Date .. " -> Time: " .. row.params.Time .. " \nLocation: " .. row.params.Location .. " \nDescription: " .. row.params.Description,
		x = 0,
		y = rowHeight,
		font = font,
		fontSize = fontSize,
	}

	row.name = display.newText(options_name)
	row.name.anchorX = 0
	row.name:setFillColor( 0.4,0.4,0.5 )
end

local function HomePageScene( event )

	if ( "ended" == event.phase ) then
		composer.gotoScene("AdminHomePage",{effect = "fromLeft",time = 100})		
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

	-- Create tableview widget
	local table_options = 
	{
		--the white box properties
		top = 10,
		height = 400,
		width = 300,
		left = 10,
		right = 20,	
		onRowRender = onRowRender,
	}
	local tableView = widget.newTableView(table_options)
	
	-- Retrieve data from database and add to tableview
	for row in db:nrows("SELECT * FROM incidentReport") do
		local rowParams = 
		{
			ID = row.incID,
			Date = row.incDate,
			Time = row.incTime,
			Location = row.incLocation,
			Description = row.incDescription,
			Name = row.empName
			
		}

		tableView:insertRow({rowHeight = 100, params = rowParams,})
	end	
	sceneGroup:insert(tableView)
	
------------------------------------------------------------------

-- Create the widget
-- Button to click for admin to go back to admin's home page
	HomePageButton = widget.newButton(
	{
		label = "HOME",
		font = "Showcard Gothic",
		fontSize = 28,
		labelColor = { default={1,0.6,0.1}},
		onEvent = handleButtonEvent,
		onRelease = HomePageScene,
		emboss = false
	}
)

	--Center the button
	HomePageButton.x = display.contentCenterX
	HomePageButton.y = 480
	--Insert Button for go back  into "sceneGroup"
	sceneGroup:insert(HomePageButton)
	HomePageButton:addEventListener("tap", HomePageScene)

	
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