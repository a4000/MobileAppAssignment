--Login Page - Starting page of the app

-----------------------------------------------------------------
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
------------------------------------------------------------------
local widget = require ( "widget" )

local bg
local textObject
local loginButton
local usernameLabel
local usernameField
local passwordLabel
local passwordField
local inputUsername
local inputPassword

local function nameFieldHandler( textField )
	return function( event )
		if ( "began" == event.phase ) then
			-- This is the "keyboard has appeared" event
			-- In some cases you may want to adjust the interface when the keyboard appears.
		
		elseif ( "ended" == event.phase ) then
			-- This event is called when the user stops editing a field: for example, when they touch a different field
			inputUsername = textField().text			

		elseif ( "editing" == event.phase ) then
		
		elseif ( "submitted" == event.phase ) then
			-- This event occurs when the user presses the "return" key (if available) on the onscreen keyboard
			print( textField().text )
			inputUsername = textField().text
			
			-- Hide keyboard
			native.setKeyboardFocus( nil )
		end
	end
end

-- Function to take the password input from the password box. 
local function passFieldHandler( textField )
	return function( event )
		if ( "began" == event.phase ) then
			-- This is the "keyboard has appeared" event
			-- In some cases you may want to adjust the interface when the keyboard appears.
		
		elseif ( "ended" == event.phase ) then
			-- This event is called when the user stops editing a field: for example, when they touch a different field
			inputPassword = textField().text
	
		elseif ( "editing" == event.phase ) then
		
		elseif ( "submitted" == event.phase ) then
			-- This event occurs when the user presses the "return" key (if available) on the onscreen keyboard
			inputPassword = textField().text
			
			-- Hide keyboard
			native.setKeyboardFocus( nil )
		end
	end
end

local function loginScene( event )
	if ( "ended" == event.phase ) then
		-- Loop through the employee table and populate 'user' table if the user input matches details in database.
		for row in db:nrows("SELECT * FROM employee") do
			if(inputUsername == row.empUsername and inputPassword == row.empPassword) then
				user.empID = row.empID
				user.empName = row.empName
				user.empUsername = row.empUsername
				user.empPassword = row.empPassword
				user.empPhone = row.empPhone
				user.empType = row.empType
			end
		end
		
		-- If the user is a guard, go to guard home page.
		if (user.empType == "Guard") then
			print("Guard logged in")
			composer.gotoScene("GuardHomePage",{effect = "fromRight",time = 100})
		end

		-- If the user is an admin, go to admin home page.
		else if (user.empType == "Admin") then
			print("Admin logged in")
			composer.gotoScene("AdminHomePage",{effect = "fromRight",time = 100})
		end
	end
end

--Create()
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

	--bg = display.newImage ("images/IMG_6681.jpg")
	--bg.x = display.contentCenterX
	--bg.y = display.contentCenterY
	--bg.width = screenWidth
	--bg.height = screenHeight
    -- Assign "self.view" to local variable "sceneGroup" for easy reference
    local sceneGroup = self.view

	bg =   display.newImageRect( "images/IMG_6681.jpg", display.contentWidth, display.contentHeight)
	bg.x = display.contentCenterX
	bg.y = display.contentCenterY
	 -- Insert background into "sceneGroup"
	sceneGroup:insert(bg)
	
	
	HomePageTitle1 = display.newText("WELCOME TO TEAM 3's", 160, 0, "Showcard Gothic",28)
	HomePageTitle2 = display.newText("Security App", 160, 40, "Showcard Gothic", 28)
	HomePageTitle1:setFillColor(255, 0, 0)
	HomePageTitle2:setFillColor(255, 0, 0)

	sceneGroup:insert(HomePageTitle1)
	sceneGroup:insert(HomePageTitle2)
	--bg = display.newImage( "images/IMG_6681.jpg")
	--bg.x = display.contentCenterX
	--bg.y = display.contentCenterY
	 -- Insert background into "sceneGroup"
	--sceneGroup:insert(bg)
	-----------------------------------------------------------------
	--textObject = display.newText("WELCOME TO TEAM 3", 50, 50, native.systemFont, 28)
	--textObject:setTextColor(255, 0, 0)
	--textObject.x = 160
	--textObject.y = 5
	---------------------------------------------------------------
	--local longLine = display.newLine (15, 100, 300, 100)
	--longLine.y = 20
	--title.size= 50
	 -- Insert title into "sceneGroup"
	--sceneGroup:insert(title)
	
----------------------------------------------------------------
-- Create the widget
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
	}
)

	--Center the button
	loginButton.x = display.contentCenterX
	loginButton.y = 400

	--Insert button into "sceneGroup"
	sceneGroup:insert(loginButton)
	loginButton:addEventListener("tap", loginScene)
	
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

----------------------------------------------------------------------------------

--Creating text field label	
--local lblUserName = display.newText("Username:", 125, 165, native.systemFont, 25)
--Creating the text field
--local txtUserName = native.newTextField(160, 200, 200, 40)
--txtUserName.size = 20
--txtUserName:addEventListener( "userInput", txtUserName )

--Creating text field Label
--local lblUserName = display.newText("Password:", 120, 240, native.systemFont, 25)
--Creating the text field
--local txtPassword = native.newTextField(160, 275, 200, 40)
--txtPassword.size = 20
--txtPassword:addEventListener( "userInput", txtPassword )

--Creating label to show feedback to user
--local lblFeedback = display.newText ( "", 150, 360, native.systemFont, 25)

--function txtUserName:userInput ( event )
	--if event.phase == "began" then
		--clear the text field
		--event.target.text = ''
		--lblFeedback.text = "waiting"
		
	--elseif event.phase == "submitted" then
		--lblFeedback.text = "Logging in as " .. " " .. event.target.text
	
	--else if event.phase == "editing" then
		--lblFeedback.text = event.startPosition
	--end
--end
--end

-------------------------------------------------------------------------------------

-- show()
function scene:show( event )
	local sceneGroup = self.view

	if event.phase == "did" then
		-- The text field's native peice starts hidden, we show it after we are on screen.on

		-- lets make the fields fit our adaptive screen better
		-- Why 150? The labels are around 120px wide. We want at least a 10px margin on either side of the labels
		-- and fields and we need some space betwen the label and the field. Let's start with 10px each

		local fieldWidth = display.contentWidth - 150
		if fieldWidth > 250 then
			fieldWidth = 250
		end

		usernameField = native.newTextField( 50, 210, 220, 30 )
		usernameField:addEventListener( "userInput", nameFieldHandler( function() return usernameField end ) ) 
		sceneGroup:insert(usernameField)
		usernameField.anchorX = 0
		usernameField.placeholder = "Please type your Username"
 
 		passwordField = native.newTextField( 50, 290, 220, 30 )
		passwordField:addEventListener( "userInput", passFieldHandler( function() return passwordField end ) ) 
		sceneGroup:insert(passwordField)
		passwordField.anchorX = 0
		passwordField.placeholder = "Please type your Password"
		
    end
end
 
-- hide()
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
 
 
-- destroy()
function scene:destroy( event )
 
    local sceneGroup = self.view
    -- Code here runs prior to the removal of scene's view
 
end



-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
	scene:addEventListener("create",scene)
	scene:addEventListener("show",scene)
	scene:addEventListener("hide",scene)
	scene:addEventListener("destroy",scene)
-- -----------------------------------------------------------------------------------
return scene