-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

local background = display.newImageRect('background.png', 500, 580)
local car = display.newImageRect('car.png', 100, 70)
car.x = display.contentCenterX
car.y = display.contentCenterY
car:rotate(90)
background.x = display.contentCenterX
background.y = display.contentCenterY

local physics = require( "physics" )
physics.start()
physics.setGravity(0, 10)

local rocksTable = {}
local dificultad = 700

dificultadDisplay = display.newText( 'easy', 150, 0, native.systemFont, 36)
cont = 0

local function createCar()
	local newCar = display.newImageRect('enemyCar.png', 100, 70)
	newCar:rotate(-90)
	newCar:setFillColor(math.random(0,1), math.random(0,1), math.random(0,1))
	table.insert( rocksTable, newCar )
	physics.addBody(newCar, "dynamic")
	local rand = math.random(4)
	if (rand == 1) then
		newCar.x = display.contentCenterX + 40
	elseif rand == 2 then
		newCar.x = display.contentCenterX + 110
	elseif rand == 3 then
		newCar.x = display.contentCenterX - 40
	elseif rand == 4 then
		newCar.x = display.contentCenterX - 110		
	end
	newCar.y = -100
end

local function destroyCars()
	for i = #rocksTable, 1, -1 do
		local thisRock = rocksTable[i]
		if ( thisRock.y > 400)
		then
			display.remove( thisRock )
			table.remove( rocksTable, i )
		end
	end
end

local function updateText(val)
	if val == 0 then
		return 'easy'
	elseif val == 1 then
		return 'medium'
	elseif val == 1 then
		return 'hard'
	end
end

local function gameLoop()
	cont = cont + 1
	createCar()
	destroyCars()
	if (cont == 20) then
		dificultadDisplay.text = 'medium'
	end
	if (cont == 30) then
		dificultadDisplay.text = 'hard'
	end
end 

gameLoopTimer = timer.performWithDelay( 500, gameLoop, 0 )