-----------------------------------------------------------------------------------------
-- LoginPage.lua 
-----------------------------------------------------------------------------------------
--==================================================================================================================================
-- 												Code written by Ritish(driver) 
-- 												Verified by Jesheena(navigator)
--==================================================================================================================================
--==================================================================================================================================
-- 												Code modified by Jesheena(driver) Added functionality to move text fields up and down 
-- 												Verified by Adam(navigator)
--==================================================================================================================================
------------------------------------------------------------------
-- Declare and initialise variables.
------------------------------------------------------------------
-- This is needed to store the user's details.
local user = require("user")

-- This is needed to use the database.
require("sqlite3")
local path = system.pathForFile("data.db", system.DocumentsDirectory)
local db = sqlite3.open(path)

-- it need the composer at all time
local composer = require( "composer" )

-- this line is needed to create a new page
local scene = composer.newScene()

local widget = require ( "widget" )

local bg
local textObject
local loginButton
local aboutButton
local usernameLabel
local usernameField
local passwordLabel
local passwordField
local hideKeyboardBox

------------------------------------------------------------------
-- Functions.
------------------------------------------------------------------
-- Function to raise the fields.
local function moveUp()
	usernameLabel.y = 100
	usernameField.y = 140
	passwordLabel.y = 180
	passwordField.y = 220
end

-- Function to lower the fields.
local function moveDown()
	usernameLabel.y = 170
	usernameField.y = 210
	passwordLabel.y = 250
	passwordField.y = 290
end

-- If the user selects the 'About Us' button.
local function aboutScene( event )
	if ( "ended" == event.phase ) then
		-- Make sure the text fields are at their origional position, then move to About Us page.
		moveDown()
		composer.gotoScene("AboutUsPage",{effect = "fade",time = 500})		
	end		
end

-- Function to handle the username input field. 
local function nameFieldHandler( textField )
	return function( event )
		if ( "editing" == event.phase ) then
			-- Raise the fields when editing text.
			moveUp()
		
		elseif ( "submitted" == event.phase ) then
			-- Hide keyboard
			native.setKeyboardFocus( nil )
			
			-- Reset the fields to their original position when finished.
			moveDown()
		end
	end
end

-- Function to handle the password input field. 
local function passFieldHandler( textField )
	return function( event )
		if ( "editing" == event.phase ) then
			-- Raise the fields when editing text.
			moveUp()
		
		elseif ( "submitted" == event.phase ) then
			-- Hide keyboard
			native.setKeyboardFocus( nil )

			-- Reset the fields to their original position when finished.
			moveDown()
		end
	end
end

-- If the user selects the 'Submit' button.
local function loginScene( event )
	if ( "ended" == event.phase ) then

		-- Loop through the employee table and populate 'user' table if the user input matches details in database.
		for row in db:nrows("SELECT * FROM employee") do
			if(usernameField.text == row.empUsername and passwordField.text == row.empPassword) then
				user.empID = row.empID
				user.empName = row.empName
				user.empUsername = row.empUsername
				user.empPassword = row.empPassword
				user.empPhone = row.empPhone
				user.empType = row.empType
			end
		end
		
		-- If the user is a guard.
		if (user.empType == "Guard") then
			-- Make sure the text fields are at their origional position, then move to Guard Home page.
			moveDown()
			composer.gotoScene("GuardHomePage",{effect = "fromRight",time = 100})
		end

		-- If the user is an admin.
		else if (user.empType == "Admin") then
			-- Make sure the text fields are at their origional position, then move to Admin Home page.
			moveDown()
			composer.gotoScene("AdminHomePage",{effect = "fromRight",time = 100})
		
		-- If the username or password are wrong.
		else
			local alert = native.showAlert( "Invalid input", "Please make sure the username and password are correct and not empty.", { "OK" } )
		end
	end
end

------------------------------------------------------------------
-- Create scene.
------------------------------------------------------------------
function scene:create(event)

	local sceneGroup =self.view

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

	bg =   display.newImageRect( "images/IMG_6681.jpg", display.contentWidth, display.contentHeight)
	bg.x = display.contentCenterX
	bg.y = display.contentCenterY
	 -- Insert background into "sceneGroup"
	sceneGroup:insert(bg)
	
	
	HomePageTitle1 = display.newText("WELCOME TO TEAM 3's", 160, 20, "Showcard Gothic",28)
	HomePageTitle2 = display.newText("Security App", 160, 60, "Showcard Gothic", 28)
	HomePageTitle1:setFillColor(1,0,0)
	HomePageTitle2:setFillColor(1,0,0)

	sceneGroup:insert(HomePageTitle1)
	sceneGroup:insert(HomePageTitle2)
	
	--Create the login button
	loginButton = widget.newButton(
	{
		label = "Login",
		font = "Lucida Fax",
		fontSize = 22,
		labelColor = { default={ 0,0,0 }},
		onEvent = handleButtonEvent,
		onRelease = loginScene,
		emboss = false,
		shape = "roundedRect",
		width = 150,
		height = 45,
		cornerRadius = 5,
		fillColor = { default={0, 255, 0}, over={255, 255, 0} },
		strokeColor = { default={0,0,0}, over={0.8,0.8,1,1} },
		strokeWidth = 2
	})

	--Center the button
	loginButton.x = display.contentCenterX
	loginButton.y = 360

	--Insert button into "sceneGroup"
	sceneGroup:insert(loginButton)
	loginButton:addEventListener("tap", loginScene)

	--Create the Abous Us button
	aboutButton = widget.newButton(
	{		
	
		label = "About Us!",
		font = "Stencil",
		fontSize = 22,
		labelColor = { default={ 1,1,0.1 }, over={ 0,0,0 } },
		onEvent = handleButtonEvent,
		onRelease = aboutScene,
		emboss = false,
		shape = "roundedRect",
		width = 150,
		height = 45,
		cornerRadius = 8,
		fillColor = { default={0.8,0,0}, over={0.8,0,0} },
		strokeColor = { default={1,1,0.1}, over={0,0,0} },
		strokeWidth = 2
	})

	--Center the button
	aboutButton.x = display.contentCenterX
	aboutButton.y = 475	
	--Insert button into "sceneGroup"
	sceneGroup:insert(aboutButton)
	aboutButton:addEventListener("tap", aboutScene)
	
    	usernameLabel = display.newText( "Username:", 90, 165, "STENCIL", 25)
	usernameLabel:setFillColor(0, 255, 0)
	usernameLabel.anchorX = 0
	usernameLabel.y = 170
	sceneGroup:insert( usernameLabel )
	
	passwordLabel = display.newText( "Password:", 90, 165, "STENCIL", 25)
	passwordLabel:setFillColor(0, 255, 0)
	passwordLabel.anchorX = 0
	passwordLabel.y = 250
	sceneGroup:insert( passwordLabel )	
end

------------------------------------------------------------------
-- Show scene.
------------------------------------------------------------------
function scene:show( event )
	local sceneGroup = self.view

	if event.phase == "did" then
		-- The text field's native peice starts hidden, we show it after we are on screen.on
		local fieldWidth = display.contentWidth - 150
		if fieldWidth > 250 then
			fieldWidth = 250
		end

		-- username field.
		usernameField = native.newTextField( 50, 210, 220, 30 )
		usernameField:addEventListener( "userInput", nameFieldHandler( function() return usernameField end ) ) 
		sceneGroup:insert(usernameField)
		usernameField.anchorX = 0
		usernameField.placeholder = "Please type your Username"
 
		-- password field.
 		passwordField = native.newTextField( 50, 290, 220, 30 )
		passwordField:addEventListener( "userInput", passFieldHandler( function() return passwordField end ) ) 
		sceneGroup:insert(passwordField)
		passwordField.anchorX = 0
		passwordField.placeholder = "Please type your Password"	
    	end	
end
 
------------------------------------------------------------------
-- Hide scene.
------------------------------------------------------------------
function scene:hide( event )

    	local sceneGroup = self.view
	--
	-- Clean up native objects
	--

	if event.phase == "will" then
		-- avoid the text field from appearing on other pages
		usernameField:removeSelf()
		usernameField = nil
		passwordField:removeSelf()
		passwordField = nil

		--event.parent:reloadTable()
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
	scene:addEventListener("create",scene)
	scene:addEventListener("show",scene)
	scene:addEventListener("hide",scene)
	scene:addEventListener("destroy",scene)
--------------------------------------------------------------------------------------
return scene