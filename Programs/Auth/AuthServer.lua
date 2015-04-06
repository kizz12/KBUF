modem = peripheral.wrap("top")
--This program is going to focus on R&D for better network functions.

--AUTH WALL 1

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
	--modem = peripheral.wrap('left')
	screen = {
	peripheral.wrap('back'); 
	peripheral.wrap('');
	}
	for i=1,#screen do
		screen[i].clear()
		screen[i].setCursorPos(1,1)
		screen[i].setBackgroundColor(colors.orange)
		screen[i].setCursorPos(50,50)
		screen[i].setTextColor(colors.blue)
		--ps("")
		screen[i].setBackgroundColor(colors.orange)
		screen[i].clear()
		screen[i].setCursorPos(1,1)

	end
end

--

function psw(n,win) --similar to print for windows, n is the text, win is the window name, as a function, no ()
	win.write(n)
	x,y=win.getCursorPos()
	y=y+1
	win.setCursorPos(1,y)
end

function ps(n) --similar to print
	for i=1,#screen do
		screen[i].write(n)
		x,y=screen[i].getCursorPos()
		y=y+1
		screen[i].setCursorPos(1,y)
	end
end

init() --setup
	print'System init complete.'

ps("Input 3 Digit Auth")
	-----------------------------------------------
	sec1 = {
	}
	for i=1,#screen do
		sec1[i] = window.create(screen[i],4,2,4,3) --making the windows
		sec1[i].setBackgroundColor(colors.blue)
		sec1[i].setTextColor(colors.white)
		sec1[i].clear()
	end
		sec2 = {
	}
	for i=1,#screen do
		sec2[i] = window.create(screen[i],4,9,4,3) --making the windows
		sec2[i].setBackgroundColor(colors.blue)
		sec2[i].setTextColor(colors.white)
		sec2[i].clear()
	end
		sec3 = {
	}
	for i=1,#screen do
		sec3[i] = window.create(screen[i],12,2,4,3) --making the windows
		sec3[i].setBackgroundColor(colors.blue)
		sec3[i].setTextColor(colors.white)
		sec3[i].clear()
	end
		sec4 = {
	}
	for i=1,#screen do
		sec4[i] = window.create(screen[i],12,9,4,3) --making the windows
		sec4[i].setBackgroundColor(colors.blue)
		sec4[i].setTextColor(colors.white)
		sec4[i].clear()
	end
		sec5 = {
	}
	for i=1,#screen do
		sec5[i] = window.create(screen[i],8,6,5,2) --making the windows
		sec5[i].setBackgroundColor(colors.blue)
		sec5[i].setTextColor(colors.white)
		sec5[i].clear()
	end

	-----------------------------------------------

	local but1 = { --make buttons
	  minx = 3,
	  miny = 2,
	  maxx = 7,
	  maxy = 5,
	}
	local but2 = { --make buttons
	  minx = 3,
	  miny = 9,
	  maxx = 7,
	  maxy = 12,
	}
	local but3 = { --make buttons
	  minx = 12,
	  miny = 2,
	  maxx = 16,
	  maxy = 5,
	}
	local but4 = { --make buttons
	  minx = 12,
	  miny = 9,
	  maxx = 16,
	  maxy = 12,
	}
	local but5 = { --make buttons
	  minx = 8,
	  miny = 6,
	  maxx = 13,
	  maxy = 7,
	}

	-----------------------------------------------



	for i=1,#sec1 do
		psw("",sec1[i])
		psw("  1",sec1[i])
	end
	
	for i=1,#sec2 do
		psw("",sec2[i])
		psw("  2",sec2[i])
	end
	
	for i=1,#sec3 do
		psw("",sec3[i])
		psw("  3",sec3[i])
	end
	
	for i=1,#sec4 do
		psw("",sec4[i])
		psw("  4",sec4[i])
	end
	
	for i=1,#sec5 do
		psw("",sec5[i])
		psw("Reset",sec5[i])
	end
	
	
function getauth()

	if lockc==1 and lock1==true and lock2~=true and lock3~=true and lock4~=true then
		continue=true
	end
	if lockc==2 and continue==true and lock1==true and lock2==true and lock3~=true and lock4~=true then
		continue=false
	end
	if lockc==2 and continue==true and lock1==true and lock2~=true and lock3~=true and lock4==true then
		continue=true
	end
	if lockc==3 and continue==true and lock1==true and lock2==true and lock3~=true and lock4==true then
		authget=true
		print("GOT AUTH")
		for i=1,#screen do
		screen[i].setBackgroundColor(colors.green)
		screen[i].setTextColor(colors.white)
		screen[i].setCursorPos(3,12)
		ps("Auth. Success")
		send(201,202,"auth",1)
		sleep(3)
		os.reboot()
		end
	end
	if lockc==3 and authget~=true then
		print("Auth Failed")
		for i=1,#screen do
			screen[i].setBackgroundColor(colors.red)
			screen[i].setTextColor(colors.white)
			screen[i].setCursorPos(3,12)
		end
		ps("Auth. Failure")
		send(201,202,"noauth",1)
		sleep(3)
		os.reboot()
	end
end

function main()
continue=false
lockc=0

	while true do --god damn this is really messy and could use some more functions...
		buttonevent()
		if xt>=but1.minx and xt<=but1.maxx and yt>=but1.miny and yt<=but1.maxy then --need a way to do this check but more cleanly.
			for i=1,#sec1 do
				sec1[i].clear()
				sec1[i].setCursorPos(1,1)
				sec1[i].setBackgroundColor(colors.green)
				sec1[i].setTextColor(colors.white)	
			end
			--sec1.clear()
			for i=1,#sec1 do
				psw("    ",sec1[i])
				psw("Lock",sec1[i])
				psw("    ",sec1[i])
			end
			lock1=true
			lockc=lockc+1
			--screen[i].clear()
		end
		
		if xt>=but2.minx and xt<=but2.maxx and yt>=but2.miny and yt<=but2.maxy then --need a way to do this check but more cleanly.
			for i=1,#sec2 do
				sec2[i].clear()
				sec2[i].setCursorPos(1,1)
				sec2[i].setBackgroundColor(colors.green)
				sec2[i].setTextColor(colors.white)	
			end
			--sec2.clear()
			for i=1,#sec2 do
				psw("    ",sec2[i])
				psw("Lock",sec2[i])
				psw("    ",sec2[i])
			end
			lock2=true
			lockc=lockc+1
			--screen[i].clear()	
		end
		
		if xt>=but3.minx and xt<=but3.maxx and yt>=but3.miny and yt<=but3.maxy then --need a way to do this check but more cleanly.
			for i=1,#sec3 do
				sec3[i].clear()
				sec3[i].setCursorPos(1,1)
				sec3[i].setBackgroundColor(colors.green)
				sec3[i].setTextColor(colors.white)	
			end
			--sec3.clear()
			for i=1,#sec3 do
				psw("    ",sec3[i])
				psw("Lock",sec3[i])
				psw("    ",sec3[i])
			end
			lock3=true
			lockc=lockc+1
			--screen[i].clear()
		end
		
		if xt>=but4.minx and xt<=but4.maxx and yt>=but4.miny and yt<=but4.maxy then --need a way to do this check but more cleanly.
			for i=1,#sec4 do
				sec4[i].clear()
				sec4[i].setCursorPos(1,1)
				sec4[i].setBackgroundColor(colors.green)
				sec4[i].setTextColor(colors.white)	
			end
			--sec4.clear()
			for i=1,#sec4 do
				psw("    ",sec4[i])
				psw("Lock",sec4[i])
				psw("    ",sec4[i])
			end
			lock4=true
			lockc=lockc+1
			--screen[i].clear()
		end
		
		if xt>=but5.minx and xt<=but5.maxx and yt>=but5.miny and yt<=but5.maxy then --need a way to do this check but more cleanly.
			for i=1,#sec5 do
				sec5[i].clear()
				sec5[i].setCursorPos(1,1)
				sec5[i].setBackgroundColor(colors.red)
				sec5[i].setTextColor(colors.white)	
			end
			--sec5.clear()
			for i=1,#sec5 do
				psw("    ",sec5[i])
				psw("Reset",sec5[i])
				psw("    ",sec5[i])
			end
			sleep(3)
			os.reboot()
			--screen[i].clear()
		end
		
		--print(lockc)
		getauth()
	end
end
function garbageCollection() --reboots every 6 hours to clear threads.
print'Garbage Collection Active...'
sleep(21600)
os.reboot()
end
parallel.waitForAll(main,garbageCollection)

