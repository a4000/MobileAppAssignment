-----------------------------------------------------------------------------------------
-- AdminEmployeeDetailsPage.lua
-----------------------------------------------------------------------------------------

-- When Admin clicks on the Employee button.

-----------------------------------------------------------------
-- This is needed to use the composer library.
local composer = require( "composer" )

-- This is needed to store the user's details.
local user = require("user")

-- This is needed to use the database.
require("sqlite3")
local path = system.pathForFile("data.db", system.DocumentsDirectory)
local db = sqlite3.open(path)

-- This line is needed to create a new page.
local scene = composer.newScene()

-- This is needed to use the widget library.
local widget = require ( "widget" )

------------------------------------------------------------------
-- Declare the variables.
------------------------------------------------------------------
local AddButton
local BackButton

------------------------------------------------------------------
-- Functions.
------------------------------------------------------------------
-- onRowRender function for the tableview
local function onRowRender(event)
	local row = event.row
	local font = native.systemFont
	local fontSize = 24
	local rowHeight = row.height/2
	
	local options_name = 
	{
		parent = row,
		text = row.params.Name,
		x = 10,
		y = rowHeight,
		font = font,
		fontSize = fontSize,
	}

	row.name = display.newText(options_name)
	row.name.anchorX = 0
	row.name:setFillColor(1, 0, 0)
end

-- If user selects the 'add' button.
local function AddScene( event )
	if ( "ended" == event.phase ) then
		composer.gotoScene("AddEmployeePage",{effect = "fromRight",time = 100})		
	end		
end

-- If the user selects the 'back' button.
local function BackScene( event )
	if ( "ended" == event.phase ) then
		composer.gotoScene("AdminHomePage",{effect = "fromLeft",time = 100})		
	end	
end

-- create()
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

	-- Create tableview widget
	local table_options = 
	{
		top = 0,
		height = 300,
		onRowRender = onRowRender,
	}
	local tableView = widget.newTableView(table_options)
	
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


------------------------------------------------------------------

	-- Create the widget
	-- Add button
	AddButton = widget.newButton(
	{
		label = "Add",
		labelColor = { default={ 0, 0, 0}},
		onEvent = handleButtonEvent,
		onRelease = AddScene,
		emboss = false,
		shape = "roundedRect",
		width = 100,
		height = 40,
		cornerRadius = 2,
		fillColor = { default={0, 139, 139}, over={128, 0, 128} },
		strokeColor = { default={0,0,0}, over={0,0,0} },
		strokeWidth = 3
	}
)

	--Center the button
	AddButton.x = display.contentCenterX
	AddButton.y = 400
	--Insert Button for go back  into "sceneGroup"
	sceneGroup:insert(AddButton)
	AddButton:addEventListener("tap", AddScene)
	
	-- Back button
	BackButton = widget.newButton(
	{
		label = "Back",
		labelColor = { default={ 0, 0, 0}},
		onEvent = handleButtonEvent,
		onRelease = BackScene,
		emboss = false,
		shape = "roundedRect",
		width = 100,
		height = 40,
		cornerRadius = 2,
		fillColor = { default={139, 0, 0}, over={0, 128, 0} },
		strokeColor = { default={0,0,0}, over={0,0,0} },
		strokeWidth = 3
	}
)

	--Center the button
	BackButton.x = display.contentCenterX
	BackButton.y = 470
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

    	end
end


-- hide()
function scene:hide( event )

    	local sceneGroup = self.view
    	local phase = event.phase

    	if ( phase == "will" ) then
        	-- Code here runs when the scene is on screen (but is about to go off screen)

    	elseif ( phase == "did" ) then
        
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