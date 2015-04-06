--AUTH Pads/Main access pc


redstone.setOutput("back",true)
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
	peripheral.wrap('left'); 
	peripheral.wrap('right');
	}
	for i=1,#screen do
		screen[i].clear()
		screen[i].setCursorPos(1,1)
		screen[i].setBackgroundColor(colors.orange)
		screen[i].setCursorPos(50,50)
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

-----------------------------------------------

modem = peripheral.wrap("top")
--This program is going to focus on R&D for better network functions.



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
				modem.close(chan)
				return
				
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

function lis()
	listen(201)
	print(msg)
	chkauth=msg
	if chkauth=="auth" then
		auth=true
	end
	if chkauth~="auth" then
		auth=false
	end
	print(auth)
end

function main()
-----------------------------------------------

	init() --setup
	print'System init complete.'


	-----------------------------------------------
	sec1 = {
	}
	for i=1,#screen do
		sec1[i] = window.create(screen[i],2,2,4,3) --making the windows
		sec1[i].setBackgroundColor(colors.blue)
		sec1[i].setTextColor(colors.white)
		sec1[i].clear()
	end

	-----------------------------------------------

	local but1 = { --make buttons
		minx = 1,
		miny = 1,
		maxx = 5,
		maxy = 5,
	}

	-----------------------------------------------



	for i=1,#sec1 do
		psw("",sec1[i])
		psw("Auth",sec1[i])
	end


	while true do --god damn this is really messy and could use some more functions...
		buttonevent()


		if auth==true then
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
				psw("Good",sec1[i])
				psw("    ",sec1[i])
				end
				redstone.setOutput("back",false)
				sleep(5)

				--screen[i].clear()
				
				os.reboot()
			end
		end
		if auth~=true then
			if xt>=but1.minx and xt<=but1.maxx and yt>=but1.miny and yt<=but1.maxy then --need a way to do this check but more cleanly.
				for i=1,#sec1 do
					sec1[i].clear()
					sec1[i].setCursorPos(1,1)
					sec1[i].setBackgroundColor(colors.red)
					sec1[i].setTextColor(colors.white)	
				end
				for i=1,#sec1 do
					psw("    ",sec1[i])
					psw("Fail",sec1[i])
					psw("    ",sec1[i])
				end
				print'Failed to authenticate user.'
				sleep(2)
				os.reboot()
			end
		end
	end
end

function garbageCollection() --reboots every 6 hours to clear threads.
print'Garbage Collection Active...'
sleep(21600)
os.reboot()
end

parallel.waitForAll(lis,main,garbageCollection)
	
