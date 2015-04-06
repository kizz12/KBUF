--Kizz tower Control Master Screen PC

--Modem Communication Numbering
-- 1/2 Screen to Server 1
-- 2/1 Server 1 to Screen
--3/4 Screen to Power Emergency PC
-- 4/3 Pwr Em. PC to Screen 

local modem = peripheral.wrap('back')
local screen = peripheral.wrap('top')


--begin functions
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

function send(chan,reply,m) --transmits a message
		modem.transmit(chan,reply,m)
end

----------------------------------------

function get(getchan,tmout,ref)--listener, will timeout or wait, and passes message into msg
	if tmout==nil then
	tmout=100000000000000000000000000000 --change to call event w/o timer
	end
	modem.open(getchan) --opens port
	chk=modem.isOpen(getchan) --checks to make sure it is open
		if chk==true then --will set listener
		--mm = os.pullEvent("modem_message")
		timeout = os.startTimer(tmout)
		while true do
			event = {os.pullEvent()}
			if event[1] == "modem_message" then
				--print'Worked'
				--print(event[1].." "..event[2].." "..event[3].." "..event[4].." "..event[5].." "..event[6])
				if ref==nil then
				msg=event[5]
				end
				if ref==1 then
				msg1=event[5]
				end
				returnchan=event[4]
				chan2=event[3]
				--print(chan2) --Used for debug
				success=1
				modem.close(getchan)
				break
				elseif event[1] == "timer" and event[2] == timeout then
				success=0
				modem.close(getchan)
				break
				elseif event[1] == "stop_main" then --to allow system to shutdown without cluttering screen
				return
			end
		end

	end
	if chk==false then
		--send error# to screen
		print('Error 100: Failed to Bind Port '..chan..'.')
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

----------------------------------------

function main() --this guy will check that we're not shutting down, then run our various checks

    while true do
	timeout2 = os.startTimer(.1) --must be low for some reason
	
    eventData = {os.pullEvent()}
        if eventData[1] == "stop_main" then
		print's'
			sleep(10000000) --here to prevent main moving on... >.<
            return
            elseif eventData[1] == "timer" and eventData[2] == timeout2 then
			--Power system checks/screen
			listenR()
			
			
			--Server Checks/Screen
			chksvr(2,1,1,.3) --Server 1 Status
			
		
			chksvr(4,3,2,.3) --Server 2 Status
			
			
			chksvr(6,5,3,.3) --Server 3 Status
			
			
			
			
			fx,fy=screen.getCursorPos()--Re-align stuff, may have a function to do this, but scrolling up is too much work.
			screen.setCursorPos(1,fy+1)
			
			ps("")--Following displays live data from reactor
			screen.clearLine()
			ps("    ---Reactor Status---")
						screen.clearLine()
			ps("Core Temp:   "..tostring(fuelTemp).."C")
						screen.clearLine()
			ps("Casing Temp: "..tostring(casingTemp).."C")
						screen.clearLine()
			ps("Fuel Amount: "..tostring(fuelLvl).."mB")
						screen.clearLine()
			ps("Energy/tick: "..tostring(energyTick).."RF/t")
						screen.clearLine()
			ps("Held Energy: "..tostring(storedEnergy).."RF")
						screen.clearLine()
			sleep(.5)
			
			
			
			
			--Screen choice chk
        end 		
	end
end

----------------------------------------

function scch() --this guy handles user input, screen selection and begins the shutdown process
while true do
	print'Welcome to the Screen Server'
	print'Please select an option:'
	print'1: Reactor Monitor'
	print'2: System Control Touch Monitor'
	print'3: System Shutdown'

	sel=io.read()
	sel=sel+1-1

	if sel==0 then --Junk really
	print'Scanning...'
	--sleep(1)
	end
	
	if sel==1 then --Displays a static display of all reactor functions | Does not refresh
	os.queueEvent("stop_main") 
		screen.clear()
		screen.setCursorPos(1,1)
		ps('Current Reactor status:')
		ps("Reactor Active: "..tostring(active))
		ps("Stored Energy: "..storedEnergy.."RF")
		ps("Fuel Temp: "..fuelTemp.."C")
		ps("Casing Temp: "..casingTemp.."C")
		ps("Fuel Level: "..fuelLvl.."mB")
		ps("Waste Level: "..wasteLvl.."mB")
		ps("Energy/Tick: "..energyTick.."RF/t")
		ps("Reactivity: "..reactivity.."%")
		print('Press enter to continue...')
		io.read()
		screen.clear()
		screen.setCursorPos(1,1)
		os.reboot()
	end


	if sel==2 then --Future
	print'Coming soon.'
	end

	if sel==3 then --Will stop everything and shut the system down
	print'Shutting down!'
	os.queueEvent("stop_main") --sends the shutdown event
	--os.pullEvent("stop_main")
	sleep(.5) 
	screen.clear()
	screen.setCursorPos(1,1)
	ps("Warning! System Shutting Down!")
	sleep(5) --delay to allow the user to know what's happening
	screen.clear()
	os.shutdown() --BYE :D
	end
	term.clear()
	term.setCursorPos(1,1) --just cause, we want to clean up after we're done selecting other choices
	end
end

----------------------------------------
function listenR() --This function queues and grabs the latest reactor status information | Should have used a for or while loop...  :( but this allows debugging
--print'ListeningR...'
--print'tick'
send(29,10,"req")
--sleep(1)--Not sure why but this is required for accurate reading!
get(30,1,1)
if chan2==30 then
active=msg1
end
--print(active)
--sleep(.1)
get(31,1,1)
if chan2==31 then
storedEnergy=msg1
end
--print(storedEnergy)
--sleep(.1)
get(32,1,1)
if chan2==32 then
fuelTemp=msg1
end
--print(fuelTemp)
--sleep(.1)
get(33,1,1)
if chan2==33 then
casingTemp=msg1
end
--print(casingTemp)
--sleep(.1)
get(34,1,1)
if chan2==34 then
fuelLvl=msg1
end
--print(fuelLvl)
--sleep(.1)
get(35,1,1)
if chan2==35 then
wasteLvl=msg1
end
--print(wasteLvl)
--sleep(.1)
get(36,1,1)
if chan2==36 then
energyTick=msg1
end
--print(energyTick)
--sleep(.1)
get(37,1,1)
if chan2==37 then
reactivity=msg1
end
--print(reactivity)
--sleep(.1)
--print'tick'
end

function garbageCollection() --reboots every 6 hours to clear threads.
print'Garbage Collection Active...'
sleep(21600)
os.reboot()
end

-----------------------------------------
--end functions



--Body
screen.clear() --start by cleaning up incase of improper shutdown.
screen.setCursorPos(1,1)

ps("Kizz Tower Control: ONLINE") --Tell everyone we're alive
ps("")
ps("Loading...") --Tell people we're not ready yet

parallel.waitForAll(scch,main,garbageCollection) --all systems go, let's run this baby!

--end body

