--KCMC Visual Launch System PC

--This CCPC will be the main visual system for monitoring and controlling the launch system
modem = peripheral.wrap('back')
function autorestart()
	while true do
		if redstone.getInput("right")==true then
			sleep(1)
			os.reboot()
		end
		sleep(1)
	end
end

function buttonevent()
	--while true do
	  bevent ={os.pullEvent("monitor_touch")}--monitor_touch
	  --print ("Got a monitor_touch event, here are the values:")
	  xt=bevent[3]
	  yt=bevent[4]
		--print("Got press at: X:"..xt..", Y:"..yt..".")
	--end
end

-----------------------------------------------

function init() 

screen = peripheral.wrap('top')
screen.clear()
screen.setCursorPos(1,1)
screen.setBackgroundColor(colors.orange)
screen.setCursorPos(50,50)
ps("")
screen.setBackgroundColor(colors.orange)
screen.clear()
screen.setCursorPos(1,1)

end

-----------------------------------------------

function ps(n) --similar to print
screen.write(n)
x,y=screen.getCursorPos()
y=y+1
screen.setCursorPos(1,y)
end

----------------------------------------

function w(n) --write same line
x1,y1=screen.getCursorPos()
screen.setCursorPos(1,y1)
screen.clearLine()
screen.write(n)
end

----------------------------------------

function reset() --places cursor to left again
x1,y1=screen.getCursorPos()
screen.setCursorPos(1,y1)
end

----------------------------------------

function center(n) --places cursor in center based on n=total chars in ps or w
w,h=screen.getSize()
half=w/2
n=n/2
fin=half-n
x,y=screen.getCursorPos()
screen.setCursorPos(fin+1,y)

end

----------------------------------------


function send(channel,rchannel,msg,secure)
	if secure==1 then --allows for only sending to one PC
		if modem.isOpen(channel)==true then
			--print'Channel is listening already'
		end
		if modem.isOpen(channel)==false then
			modem.transmit(channel,rchannel,msg)
			print("To " ..channel.. ": "..msg)
		end
	end
	if secure~=1 then --allows for channel wide chat
		modem.transmit(channel,rchannel,msg)
		print("To " ..channel.. ": "..msg)
	end
end
-------------------

function listen(chan,timeout)
modem.open(chan)        --Open Channel
check=modem.isOpen(chan)
	if check==true then --Listen and accept data
		if timeout~=nil then 
			timeout = os.startTimer(timeout)
		end
		eventid=1
		eventstore = {} --build an array to queue the least messages


	
		while true do
			levent = {os.pullEvent()}
			if levent[1] == "modem_message" then
				--print'Worked'
				--print(levent[1].." "..levent[2].." "..levent[3].." "..levent[4].." "..levent[5].." "..levent[6])
				msg=levent[5]
				returnchan=levent[4]
				chan=levent[3]
				
				eventstore[eventid]=msg,returnchan,chan
				print("From "..returnchan..": "..eventstore[eventid])
				eventid=eventid+1
				--modem.close(chan)
				--return
				
				elseif levent[1] == "timer" and levent[2] == timeout then
				modem.close(chan)
				break
			end
		end
	end
	if check==false then --Failed to bind
	print("Failed to bind channel: " ..chan.. ".")
	end
end 
----------------------------------------

function chksvr(rchan,sendchan,svrnum,gettmout) --allows me to easily check multiple servers without writing code for a month.
send(sendchan,2,"ping")
get(rchan,gettmout)
if success==1 and msg=="ping" then
screen.setCursorPos(1,svrnum+2)
w("Server "..svrnum..": Online")
return true
end
if success==0 then
screen.setCursorPos(1,svrnum+2)
w("Server "..svrnum..": DOWN")
return false
end
--sleep(5)
end

-----------------------------------------------

function psw(n,win) --similar to print for windows, n is the text, win is the window name, as a function, no ()
win.write(n)
x,y=win.getCursorPos()
y=y+1
win.setCursorPos(1,y)
end

-----------------------------------------------
function main()
	init() --setup
	print'System init complete.'
	screen.setTextColor(colors.blue)
	screen.setTextScale(1)
	center(5)
	ps("KLCMS")

	-----------------------------------------------

	sec1 = window.create(screen,2,2,7,5) --making the windows
	sec1.setBackgroundColor(colors.blue)
	sec1.setTextColor(colors.white)
	sec1.clear()

	sec2 = window.create(screen,10,2,7,5)
	sec2.setBackgroundColor(colors.blue)
	sec2.setTextColor(colors.white)
	sec2.clear()

	sec3 = window.create(screen,2,8,7,5)
	sec3.setBackgroundColor(colors.blue)
	sec3.setTextColor(colors.white)
	sec3.clear()

	sec4 = window.create(screen,10,8,7,5)
	sec4.setBackgroundColor(colors.blue)
	sec4.setTextColor(colors.white)
	sec4.clear()

	sec5 = window.create(screen,18,2,20,11)
	sec5.setBackgroundColor(colors.green)
	sec5.setTextColor(colors.white)
	sec5.clear()

	sec7 = window.create(screen,2,14,7,5)
	sec7.setBackgroundColor(colors.red)
	sec7.setTextColor(colors.white)
	sec7.clear()

	-----------------------------------------------

	local but1 = { --make buttons
	  minx = 2,
	  miny = 2,
	  maxx = 9,
	  maxy = 7,
	}
	local but2 = {
	  minx = 10,
	  miny = 2,
	  maxx = 17,
	  maxy = 7,
	}
	local but3 = {
	  minx = 2,
	  miny = 8,
	  maxx = 9,
	  maxy = 13,
	}
	local but4 = {
	  minx = 10,
	  miny = 8,
	  maxx = 17,
	  maxy = 13,
	}
	local but5 = {
	  minx = 1,
	  miny = 1,
	  maxx = 4,
	  maxy = 2,
	}
	local but7 = {
	  minx = 2,
	  miny = 14,
	  maxx = 9,
	  maxy = 19,
	}
	-----------------------------------------------
	lights=false

	psw("",sec1)
	psw("",sec1)
	psw(" Clear",sec1)

	psw("",sec2)
	psw("",sec2)
	psw(" Init",sec2)
	psw("System",sec2)

	psw("",sec3)
	psw("",sec3)
	psw("  Ex.",sec3)
	psw(" Stats",sec3)

	psw("",sec4)
	psw("",sec4)
	psw(" Load",sec4)

	psw("",sec7)
	psw("",sec7)
	psw("Lights",sec7)
	psw(" On",sec7)

	screen.setBackgroundColor(colors.orange)--er needed for some reason

	while true do --god damn this is really messy and could use some more functions...
		buttonevent()
	setl=0
		if xt>=but1.minx and xt<=but1.maxx and yt>=but1.miny and yt<=but1.maxy then --need a way to do this check but more cleanly.
			screen.clear()
			sec6 = window.create(screen,1,1,4,1)
			sec6.setBackgroundColor(colors.red)
			sec6.setTextColor(colors.white)
			sec6.clear()
			psw("Back",sec6)
			while true do
			buttonevent()
			
			if xt>=but5.minx and xt<=but5.maxx and yt>=but5.miny and yt<=but5.maxy then
				os.reboot()
			end
			end
		end

		if xt>=but2.minx and xt<=but2.maxx and yt>=but2.miny and yt<=but2.maxy then
			screen.clear()
			center(19)
			ps("Resetting System...")
			sleep(2)
			--sec6 = window.create(screen,1,1,4,1)
			--sec6.setBackgroundColor(colors.red)
			--sec6.setTextColor(colors.white)
			--sec6.clear()
			--psw("Back",sec6)
			--while true do
			--buttonevent()
			
			--if xt>=but5.minx and xt<=but5.maxx and yt>=but5.miny and yt<=but5.maxy then
				os.reboot()
			--end
			--end
		end

		if xt>=but3.minx and xt<=but3.maxx and yt>=but3.miny and yt<=but3.maxy then
			screen.clear()
			center(11)
			ps("Extra Stats")
			
			
			sec6 = window.create(screen,1,1,4,1)
			sec6.setBackgroundColor(colors.red)
			sec6.setTextColor(colors.white)
			sec6.clear()
			psw("Back",sec6)
			while true do
			buttonevent()
			
			if xt>=but5.minx and xt<=but5.maxx and yt>=but5.miny and yt<=but5.maxy then
				os.reboot()
			end
			end
		end

		if xt>=but4.minx and xt<=but4.maxx and yt>=but4.miny and yt<=but4.maxy then
			screen.clear()
			center(15)
			ps("Coming soon!...")
			sleep(2)
			--sec6 = window.create(screen,1,1,4,1)
			--sec6.setBackgroundColor(colors.red)
			--sec6.setTextColor(colors.white)
			--sec6.clear()
			--psw("Back",sec6)
			--while true do
			--buttonevent()
			
			--if xt>=but5.minx and xt<=but5.maxx and yt>=but5.miny and yt<=but5.maxy then
				os.reboot()
			--end
			--end
		end
		
		if xt>=but7.minx and xt<=but7.maxx and yt>=but7.miny and yt<=but7.maxy then
		

		
		if lights==false and setl==0 then
		sec7.setCursorPos(1,1)
		sec7.setBackgroundColor(colors.green)
		redstone.setOutput("left",true)
		psw("         ",sec7)
		psw("         ",sec7)
		psw("Lights    ",sec7)
		psw(" Off       ",sec7)
		psw("         ",sec7)
		psw("         ",sec7)
		
		lights=true
		setl=1
		end
		
		if lights==true and setl==0 then
		sec7.setCursorPos(1,1)
		sec7.setBackgroundColor(colors.red)
		redstone.setOutput("left",false)
		psw("         ",sec7)
		psw("         ",sec7)
		psw("Lights   ",sec7)
		psw("  On     ",sec7)
		psw("         ",sec7)
		psw("         ",sec7)
		
		lights=false
		setl=1
		end
		

		end
	end
end

function getTime()
	while true do
	gtime=os.time()
	sleep(.5)
	
	tempx,tempy=sec5.getCursorPos()
	psw("   Stats",sec5)
	psw("Time: "..gtime,sec5)
	psw("Day: "..os.day()-1,sec5)
	psw("V-Sys: Online",sec5)
	sec5.setCursorPos(tempx,tempy)
	end
end

function garbageCollection() --reboots every 6 hours to clear threads.
print'Garbage Collection Active...'
sleep(21600)
os.reboot()
end
parallel.waitForAll(autorestart,main,garbageCollection,getTime)

  --if event[3]>=bname.minx and event[3]<=bname.maxx and event[4]>=bname.miny and event[4]<=bname.maxy then
  --print("worked!")
