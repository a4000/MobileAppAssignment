-----------------------------------------------------------------------------------------
-- AdminTimesheetDetailsPage.lua
-----------------------------------------------------------------------------------------
------------------------------------------------------------------
-- Declare and initialise variables.
------------------------------------------------------------------
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

local widget = require ( "widget" )

local BackButton
local tableView

------------------------------------------------------------------
-- Functions.
------------------------------------------------------------------
-- Function to reload the table view when database is changed. 
local function reloadView()
	-- Start by deleting all rows in current table view.
	tableView:deleteAllRows() 

	-- Retrieve data from database and add to tableview
	for row in db:nrows("SELECT * FROM shift") do
		local rowParams = 
		{
			ID = row.shiftID,
			Date = row.shiftDate,
			ShiftStart = row.shiftStart,
			ShiftEnd = row.shiftEnd,
			Employee = row.empName
		}

		tableView:insertRow({rowHeight = 65, params = rowParams,})
	end	
end

-- onRowRender function for the tableview
local function onRowRender(event)
	local row = event.row
	local font = "Rockwell"
	local fontSize = 18
	local rowHeight = row.height/2
	
	local options_name = 
	{
		parent = row,
		text = row.params.Date .. " \nEmployee: " .. row.params.Employee .. " \nTime: " .. row.params.ShiftStart .. " - " .. row.params.ShiftEnd,
		x = 2,
		y = rowHeight,
		font = font,
		fontSize = fontSize,
	}

	row.name = display.newText(options_name)
	row.name.anchorX = 0
	row.name:setFillColor( 0.4,0.4,0.5 )
end

-- If the user selects the 'Back' button.
local function BackScene( event )
	if ( "ended" == event.phase ) then
		-- Go to Admin Home Page.
		composer.gotoScene("AdminHomePage",{effect = "fromLeft",time = 500})		
	end	
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

	bg =   display.newImageRect( "images/greenish.jpg", display.contentWidth, display.contentHeight)
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
		width = 280,
		left = 20,
		right = 20,	
		onRowRender = onRowRender,
		hideBackground = true,
	}
	tableView = widget.newTableView(table_options)
	
	-- Retrieve data from database and add to tableview
	for row in db:nrows("SELECT * FROM shift") do
		local rowParams = 
		{
			ID = row.shiftID,
			Date = row.shiftDate,
			ShiftStart = row.shiftStart,
			ShiftEnd = row.shiftEnd,
			Employee = row.empName
		}

		tableView:insertRow({rowHeight = 65, params = rowParams,})
	end	
	sceneGroup:insert(tableView)
	
	-- Button to click for admin to go back to admin's home page
	BackButton = widget.newButton(
	{
		width = 70,
		height = 70,
		defaultFile = "images/homeButton.jpg",     
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
        	-- Reload the table view incase the database has changed.
        	reloadView()

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