dpt=0

--movement functions
function lt(n)
amt=n
	while amt>0 do
	turtle.turnLeft()
	amt=amt-1
	end
end
function rt(n)
amt=n
	while amt>0 do
	turtle.turnRight()
	amt=amt-1
	end
end
function up(n)
amt=n
	while amt>0 do
	turtle.up()
	amt=amt-1
	end
end
function dn(n)
amt=n
	while amt>0 do
	turtle.down()
	amt=amt-1
	end
end
function fw(n)
amt=n
	while amt>0 do
	
	wr=turtle.forward()
	if wr==false then
	wrr=false
	while wrr==false do
	turtle.dig()
	wrr=turtle.forward()
	end
	end
	amt=amt-1
	end
end
function bk(n)
amt=n
	while amt>0 do
	turtle.back()
	amt=amt-1
	end
end

--action functions
function dig(n)
amt=n
	while amt>0 do
	turtle.dig()
	amt=amt-1
	end
end
function digu(n)
amt=n
	while amt>0 do
	turtle.digUp()
	amt=amt-1
	end
end
function digd(n)
amt=n
	while amt>0 do
	turtle.digDown()
	amt=amt-1
	end
end

--track to ground
function track(n)
flr=turtle.detectDown()
	if flr==false then
		while flr==false do
		dn(1)
		flr=turtle.detectDown()
		end
		
	end
end

--auto fuel
function fuel()
	for i = 1, 16 do -- loop through the slots
	  turtle.select(i) -- change to the slot
	  if turtle.refuel(0) then -- if it's valid fuel
		local halfStack =(turtle.getItemCount(i)) -- work out half of the amount of fuel in the slot
		turtle.refuel(halfStack) -- consume half the stack as fuel
	  end
	end
end

--inventory management
function invchk(n)
ttl=0
	for i = 1, 16 do -- loop through the slots
	local itm=turtle.getItemCount(i)
		if itm>0 then 
		ttl=ttl+1
		end
	end
	if (ttl==16) and (as~=1) then
	
	print'Inventory full!'
	os.reboot()
	end
	if (ttl==16) and (as==1) then
	print'Inventory full! Dumping!'
	up(n)
	print(n)
	lt(2)
		for i=1,16 do
		turtle.select(i)
		turtle.drop()
		end
		dn(n)
		rt(2)
	end
end


--mine 5x5
function m5(n)

	while n>0 do
	if af==1 then
	fuel(1) --autofuel
	end
	
	

	digd(1)
	dn(1)
	dpt=dpt+1
	invchk(dpt) --inv check
	
	d=4
	while d>0 do
	dig(1)
	fw(1)
	d=d-1
	end
	rt(1)
	
	d=4
	while d>0 do
	dig(1)
	fw(1)
	d=d-1
	end
	rt(1)

	d=4
	while d>0 do
	dig(1)
	fw(1)
	d=d-1
	end
	rt(1)	
	
	d=3
	while d>0 do
	dig(1)
	fw(1)
	d=d-1
	end
	rt(1)

	d=3
	while d>0 do
	dig(1)
	fw(1)
	d=d-1
	end
	rt(1)

	d=2
	while d>0 do
	dig(1)
	fw(1)
	d=d-1
	end
	rt(1)	

	d=2
	while d>0 do
	dig(1)
	fw(1)
	d=d-1
	end
	rt(1)

	d=1
	while d>0 do
	dig(1)
	fw(1)
	d=d-1
	end
	rt(1)

	dig(1)
	
	lt(1)
	fw(2)
	rt(1)
	bk(1)
	
	n=n-1
	end
end

--mine 10x10
function m10(n)
	--where n is the depth to mine
	while n>0 do -- total loop
	
	if af==1 then --autofuel 
	fuel(1)
	end
	
	
	
	digd(1) --setup
	dn(1)
	dpt=dpt+1
	invchk(dpt)--inv check
	r=10 
		while r>0 do --alternating linear pathing loop
		d=9
			while d>0 do --linear path loop
			dig(1)
			fw(1)
			d=d-1
			end
			if r%2==0 then --if even turn right
			rt(1)
			dig(1)
			fw(1)
			rt(1)
			end
			if r%2~=0 then --if odd turn left
			lt(1)
			dig(1)
			fw(1)
			lt(1)
			end
		r=r-1	
		end
	lt(1)
	fw(10) --reset
	rt(1)
	
	n=n-1
	end
end

--return to surface
function rts(n)
up(n)
end





--MAIN PROGRAM
af=0
as=0

print'Welcome to Kizzs verticle autominer. This miner can have several options.'
print'Please select the mine size:'
print'1: 5x5 Verticle'
print'2: 10x10 Verticle'
ch=io.read() --choose mine size
ch=ch+1-1

print'Please enter how deep you would like to mine. Please avoid a number larger than your current Z height.'
depth=io.read()
depth=depth+1-1 --choose depth

fuellvl=turtle.getFuelLevel()
		if fuellvl<1 then
		print'No fuel!'
		end
		if fuellvl>=1 then
		print("Current fuel level: " ,fuellvl )
		end
		
print'Enable auto-refuel? Will check after each level for fuel and use it.'
print'1: Yes'
print'2: No'
af=io.read() --enable auto fuel
af=af+1-1

print'Enable auto-store? Will check after each level for full inventory and dump.'
print'1: Yes'
print'2: No'
as=io.read() --enable auto fuel
as=as+1-1


if ch==1 then --if 5x5 track and dig
track(err)
if err==false then
print'Tracking failed.'
os.reboot()
end
print'Successfully Tracked.'

m5(depth)

end

if ch==2 then --if 10x10 track and dig
track(err)
if err==false then
print'Tracking failed.'
os.reboot()
end
print'Successfully Tracked.'

m10(depth)

end

rts(depth) --return to top

print("Mine complete.")
