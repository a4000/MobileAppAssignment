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

local AddButton
local HomePageButton

local widget = require ( "widget" ) 

-- If user selects the 'delete' button
local function deleteScene(event)

	if ( "ended" == event.phase ) then
		print("button pressed")
		local currID = tostring(event.target.id)
		local deleteQuery = [[DELETE FROM site WHERE siteID = "]]..currID..[[";]]
		db:exec(deleteQuery)
	end
end 

-- onRowRender function for the tableview
local function onRowRender(event)
	local row = event.row
	local font = "Yu Gothic UI Semibold"
	local fontSize = 18
	local rowHeight = row.height/4
	
	local options_name = 
	{
		parent = row,
		text = " \nSite Name: " .. row.params.Name .. " \nLatitude: " .. row.params.Latitude .. " \nLongitude: " .. row.params.Longitude ,
		x = 10,
		y = rowHeight,
		font = font,
		fontSize = fontSize,
	}

	row.name = display.newText(options_name)
	row.name.anchorX = 0
	row.name:setFillColor(0,0.1,1)

	-- Delete button
	row.deleteButton = widget.newButton
	{
		id = row.params.ID,
		width = 20,
		hieght = 20,
		onRelease = deleteScene,
		label = "delete",
		font = "Arial Rounded MT Bold",
		fontSize = 22,
		labelColor = { default={ 1, 0, 0}},
		emboss = false
	}
	row.deleteButton.x = 240
	row.deleteButton.y = rowHeight
	row:insert(row.deleteButton)
end


-- If user selects the 'add' button.
local function AddScene( event )
	if ( "ended" == event.phase ) then
		composer.gotoScene("AddSitePage",{effect = "fromRight",time = 100})		
	end		
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
		height = 350,
		width = 280,
		left = 20,
		right = 10,
		onRowRender = onRowRender,
	}
	local tableView = widget.newTableView(table_options)
	
	-- Retrieve data from database and add to tableview
	for row in db:nrows("SELECT * FROM site") do
		local rowParams = 
		{
			ID = row.siteID,
			Name = row.siteName,
			Latitude = row.siteLatitude,
			Longitude = row.siteLongitude,
		}

		tableView:insertRow({rowHeight = 150, params = rowParams,})
	end	
	sceneGroup:insert(tableView)	
------------------------------------------------------------------

-- Create the widget
-- Button to add the site 
	AddButton = widget.newButton(
	{
		label = "Add Site",
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
	}
)

	--Center the button
	AddButton.x = display.contentCenterX
	AddButton.y = 400
	--Insert Button for go back  into "sceneGroup"
	sceneGroup:insert(AddButton)
	AddButton:addEventListener("tap", AddScene)
	
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