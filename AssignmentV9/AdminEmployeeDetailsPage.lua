-----------------------------------------------------------------------------------------
-- AdminEmployeeDetailsPage.lua
-----------------------------------------------------------------------------------------
--==================================================================================================================================
-- 												Code written by Ritish(driver) 
-- 												Verified by Pankaj(navigator)
--==================================================================================================================================
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

local AddButton
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
	for row in db:nrows("SELECT * FROM employee") do
		local rowParams = 
		{
			ID = row.empID,
			Name = row.empName,	
		}

		tableView:insertRow({rowHeight = 40, params = rowParams,})
	end	
end

-- If user selects the 'Delete' button
local function deleteScene(event)

	if ( "ended" == event.phase ) then
		-- Delete from the employee table in the database.
		local currID = tostring(event.target.id)
		local deleteQuery = [[DELETE FROM employee WHERE empID = "]]..currID..[[";]]
		db:exec(deleteQuery)

		-- Reload the table view.
        	reloadView()
	end
end 

-- onRowRender function for the tableview
local function onRowRender(event)

	local row = event.row
	local font = "Yu Gothic UI Semibold"
	local fontSize = 22
	local rowHeight = row.height/2
	
	local options_name = 
	{
		parent = row,
		text = row.params.Name,
		x = 10,
		y = rowHeight,
		font = font,
		fontSize = 20,
	}

	row.name = display.newText(options_name)
	row.name.anchorX = 0
	row.name:setFillColor(0,0.7,0.2)

	-- Delete button
	row.deleteButton = widget.newButton
	{
		id = row.params.ID,
		onRelease = deleteScene,
		label = "Delete",
		font = "Stencil",
		fontSize = 20,
		labelColor = { default={ 0,0,0}},
		emboss = false,
		shape = "roundedRect",
		width = 80,
		height = 30,
		cornerRadius = 8,
		fillColor = { default={1, 0, 0}, over={0.9,0.8,0.7} },
		strokeColor = { default={0,0,0}, over={0,0,0} },
		strokeWidth = 3,

	}
	row.deleteButton.x = 230
	row.deleteButton.y = rowHeight
	row:insert(row.deleteButton)
end

-- If user selects the 'Add' button.
local function AddScene( event )
	if ( "ended" == event.phase ) then
		-- Go to add employee page.
		composer.gotoScene("AddEmployeePage",{effect = "fromRight",time = 500})		
	end		
end

-- If the user selects the 'Back' button.
local function BackScene( event )
	if ( "ended" == event.phase ) then
		-- Go to admin home page
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
		top = 0,
		height = 350,
		width = 280,
		left = 20,
		right = 10,
		onRowRender = onRowRender,
		hideBackground = true,
	}
	tableView = widget.newTableView(table_options)
	
	-- Retrieve data from database and add to tableview
	for row in db:nrows("SELECT * FROM employee") do
		local rowParams = 
		{
			ID = row.empID,
			Name = row.empName,	
		}

		tableView:insertRow({rowHeight = 50, params = rowParams,})
	end	
	sceneGroup:insert(tableView)

	-- Button to add the employee
	AddButton = widget.newButton(
	{
		label = "Add Employee",
		font = "Arial Rounded MT Bold",
		fontSize = 18,
		labelColor = { default={ 0, 0, 0}},
		onEvent = handleButtonEvent,
		onRelease = AddScene,
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
	AddButton.x = display.contentCenterX
	AddButton.y = 400
	--Insert Button for go back  into "sceneGroup"
	sceneGroup:insert(AddButton)
	AddButton:addEventListener("tap", AddScene)
	
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