-----------------------------------------------------------------------------------------
-- main.lua
-----------------------------------------------------------------------------------------

-- need to have this composer
local composer = require( "composer" )

-- Telling the program to go to a page called "loginPage"
composer.gotoScene( "LoginPage" , { effect="fade", time=500 })