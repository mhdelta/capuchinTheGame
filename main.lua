-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------
local physics = require( "physics" )
physics.start()
physics.setGravity(0, 10)

local background1 = display.newImageRect('background.png', 500, 580)
local background2 = display.newImageRect('background.png', 500, 580)
local car = display.newImageRect('car.png', 100, 70)
physics.addBody(car, "static")
car.x = display.contentCenterX
car.y = display.contentCenterY
car:rotate(90)

background1.x = display.contentCenterX 
background1.y = display.contentCenterY
background2.x = display.contentCenterX 
background2.y = display.contentCenterY * - 2  + 20


local rocksTable = {}
local dificultad = 700

-- dificultadDisplay = display.newText( 'easy', 150, 0, native.systemFont, 36)
cont = 0

local function createCar()
	local newCar = display.newImageRect('enemyCar.png', 100, 70)
	newCar:rotate(-90)
	newCar:setFillColor(math.random(0,1), math.random(0,1), math.random(0,1))
	table.insert( rocksTable, newCar )
	physics.addBody(newCar, "dynamic")
	local rand = math.random(4)
	newCar.y = -100
	if (rand == 1) then
		newCar.x = display.contentCenterX + 40
		-- newCar.y = 500
		newCar.gravityScale = 0.6
		newCar:rotate(-180)		
	elseif rand == 2 then
		newCar.x = display.contentCenterX + 110
		-- newCar.y = 500
		newCar.gravityScale = 0.6
		newCar:rotate(-180)		
	elseif rand == 3 then
		newCar.x = display.contentCenterX - 40
		newCar:setLinearVelocity(0, 700)		
	elseif rand == 4 then
		newCar.x = display.contentCenterX - 110
		newCar:setLinearVelocity(0, 1000)		
	end
end

local function destroyCars()
	for i = #rocksTable, 1, -1 do
		local thisRock = rocksTable[i]
		if ( thisRock.y > 800) or ( thisRock.y < -900)
		then
			display.remove( thisRock )
			table.remove( rocksTable, i )
		end
	end
end

local function createDestroy()
	createCar()
	destroyCars()
end

local function backLoop()
	if background1.y > 300 then
		background1.y = display.contentCenterY
	end
	if background2.y > 300 then
		background2.y = display.contentCenterY  * - 2
	end
	background1.y = background1.y + 10
	background2.y = background2.y + 20

end 

local function dragCar( event )
	local car = event.target
	local phase = event.phase
	if ( "began" == phase ) then
        -- Set touch focus on the ship
		display.currentStage:setFocus(car)
		-- Store initial offset position
		car.touchOffsetX = event.x - car.x
		car.touchOffsetY = event.y - car.y
	elseif ( "moved" == phase ) then
        -- Move the car to the new touch position
		car.x = event.x - car.touchOffsetX
		car.y = event.y - car.touchOffsetY
	elseif ( "ended" == phase or "cancelled" == phase ) then
        -- Release touch focus on the ship
		display.currentStage:setFocus( nil )
	end

	return true  -- Prevents touch propagation to underlying objects
end

car:addEventListener( "touch", dragCar )
gameLoopTimer = timer.performWithDelay( 15, backLoop, 0 )
creationTimer = timer.performWithDelay( 600, createDestroy, 0 )