local composer = require( "composer" )
local scene = composer.newScene()
local widget = require( "widget" )
local json = require( "json" )

local titleText
local navBar
local firstNameLabel
local firstNameField

local submitButton



local function fieldHandler( textField )
	return function( event )
		if ( "began" == event.phase ) then
			-- This is the "keyboard has appeared" event
			-- In some cases you may want to adjust the interface when the keyboard appears.
		
		elseif ( "ended" == event.phase ) then
			-- This event is called when the user stops editing a field: for example, when they touch a different field
			
		elseif ( "editing" == event.phase ) then
		
		elseif ( "submitted" == event.phase ) then
			-- This event occurs when the user presses the "return" key (if available) on the onscreen keyboard
			print( textField().text )
			
			-- Hide keyboard
			native.setKeyboardFocus( nil )
		end
	end
end






function scene:create( event )
	local sceneGroup = self.view

    local background = display.newRect(0,0,display.contentWidth, display.contentHeight)
    background:setFillColor( 0.95, 0.95, 0.95 )
    background.x = display.contentWidth / 2
    background.y = display.contentHeight / 2

    sceneGroup:insert(background)

    local leftButton = {
        width = 35,
        height = 35,
        label = "<Back",
        onEvent = leftButtonEvent,
    }



    firstNameLabel = display.newText( "Username:", 10, 165, native.systemFont, 18)
	firstNameLabel:setFillColor( 0.3, 0.3, 0.3 )
	firstNameLabel.anchorX = 0
	sceneGroup:insert( firstNameLabel )

end

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

		firstNameField = native.newTextField( 130, firstNameLabel.y, fieldWidth, 30 )
		firstNameField:addEventListener( "userInput", fieldHandler( function() return firstNameField end ) ) 
		sceneGroup:insert( firstNameField)
		firstNameField.anchorX = 0
		firstNameField.placeholder = "First name"


	    submitButton = widget.newButton({
	        width = 160,
	        height = 40,
	        label = "Submit",
	        labelColor = { 
	            default = { 0.90, 0.60, 0.34 }, 
	            over = { 0.79, 0.48, 0.30 } 
	        },
	        labelYOffset = -4, 

	        fontSize = 18,
	        emboss = false,
	        onRelease = submitForm
	    })
	    submitButton.x = display.contentCenterX

	    sceneGroup:insert( submitButton )
	end
end

function scene:hide( event )
	local sceneGroup = self.view

	--
	-- Clean up native objects
	--

	if event.phase == "will" then
		-- remove the addressField since it contains a native object.
		firstNameField:removeSelf()
		firstNameField = nil

		event.parent:reloadTable()
	end
end

function scene:destroy( event )
	local sceneGroup = self.view

end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene