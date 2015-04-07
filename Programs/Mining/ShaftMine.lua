--movement functions


function lt(n)
turtle.turnLeft(n)
end
function rt(n)
turtle.turnRight(n)
end
function up(n)
turtle.up(n)
end
function dn(n)
turtle.down(n)
end
function fw(n)
turtle.forward(n)
end
function bk(n)
turtle.back(n)
end

--action functions
function dig(n)
turtle.dig(n)
end
function digu(n)
turtle.digUp(n)
end
function digd(n)
turtle.digDown(n)
end

--Tracking
function tracking(n)
	front=turtle.detect() --getting position...
	
	while front~=true do --Setting position....
	fw(1)
	front=turtle.detect()
	end
	front=false
	lt(1)
	while front~=true do
	fw(1)
	front=turtle.detect()
	end
	rt(1)
	front=false
	while front~=true do
	dn(1)
	front=turtle.detectDown()
	end	
end

--Mining
function mine(n)
dig(1)
fw(1)
digu(1)
up(1)
digu(1)
up(1)
rt(1)
dig(1)
fw(1)
lt(1)
digd(1)
dn(1)
digd(1)
dn(1)
rt(1)
dig(1)
fw(1)
lt(1)
digu(1)
up(1)
digu(1)
lt(1)
fw(1)
fw(1)
rt(1)
dn(1)
end

--Refuel
function fuel()
	for i = 1, 16 do -- loop through the slots
	  turtle.select(i) -- change to the slot
	  if turtle.refuel(0) then -- if it's valid fuel
		local halfStack = math.ceil(turtle.getItemCount(i)/2) -- work out half of the amount of fuel in the slot
		turtle.refuel(halfStack) -- consume half the stack as fuel
	  end
	end
end


--MAIN PROGRAM

print'Welcome to Kizzs simple miner.' 
print'1: Place some coal into the inventory.'
print'2: Choose how deep you want to mine (Suggested <25)'
print'3: Hit enter and watch the turtule for now.'
amt=io.read()
amt=amt+1-1

tracking()

while amt>0 do
fuel(1)
	fuellvl=turtle.getFuelLevel()
		if fuellvl<1 then
		print'Ran out of fuel!'
		amt=0
		end
	mine(1)
	amt=amt-1
end
