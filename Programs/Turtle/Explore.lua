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
	turtle.forward()
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

--Random movement
function explore(n)
	
	if n>0 then
	n=n*2
	end
	
	while n==0 do
	dist=math.random(5)
	dir=math.random(5)
	rest=math.random(.1,5)
		if dir==1 then
		lt(1)
		fw(dist)
		sleep(rest)
		end
		if dir==2 then
		lt(2)
		fw(dist)
		sleep(rest)
		end
		if dir==3 then
		rt(1)
		fw(dist)
		sleep(rest)
		end
		if dir==4 then
		rt(2)
		fw(dist)
		sleep(rest)
		end
		if dir==5 then
		fw(dist)
		sleep(rest)
		end
	end
		while n>0 do
	dist=math.random(5)
	dir=math.random(5)
	rest=math.random(.1,5)
		if dir==1 then
		lt(1)
		fw(dist)
		sleep(rest)
		end
		if dir==2 then
		lt(2)
		fw(dist)
		sleep(rest)
		end
		if dir==3 then
		rt(1)
		fw(dist)
		sleep(rest)
		end
		if dir==4 then
		rt(2)
		fw(dist)
		sleep(rest)
		end
		if dir==5 then
		fw(dist)
		sleep(rest)
		end
		n=n-1
	end
end

t=0
print'Please enter a time to wander. 0 To wander forever.'
t=io.read()
t=t+1-1

explore(t)
