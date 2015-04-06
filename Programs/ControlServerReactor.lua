--Server 1 Control Server. Controls Main Reactor System

local modem = peripheral.wrap('back')


function send(chan,reply,m)
	modem.transmit(chan,reply,m)
end

function get(chan,tmout)--listener
	if tmout==nil then
	tmout=100000000000000000000000000000 --change to call event w/o timer
	end
	modem.open(chan) --opens port
	chk=modem.isOpen(chan) --checks to make sure it is open
		if chk==true then --will set listener
		--mm = os.pullEvent("modem_message")
		timeout = os.startTimer(tmout)
		while true do
			event = {os.pullEvent()}
			if event[1] == "modem_message" then
				--print'Worked'
				--print(event[1].." "..event[2].." "..event[3].." "..event[4].." "..event[5].." "..event[6])
				msg=event[5]
				returnchan=event[4]
				chan=event[3]
				modem.close(chan)
				return
				elseif event[1] == "timer" and event[2] == timeout then
				modem.close(chan)
				break
			end
		end

	end
	if chk==false then
		--send error# to screen
		print('Error 100: Failed to Bind Port '..chan..'.')
	end
end

function listen()
print'Listening...'
while true do
get(1)
--print(msg)
send(2,1,"ping")
--sleep(.5)
--os.reboot()
end
end
function listenR()
print'ListeningR...'
while true do
send(9,10,"req")
get(10)
active=msg
--print(active)
get(11)
storedEnergy=msg
--print(storedEnergy)
get(12)
fuelTemp=msg
--print(fuelTemp)
get(13)
casingTemp=msg
--print(casingTemp)
get(14)
fuelLvl=msg
--print(fuelLvl)
get(15)
wasteLvl=msg
--print(wasteLvl)
get(16)
energyTick=msg
--print(energyTick)
get(17)
reactivity=msg
--print(reactivity)
sleep(5)
end
end
function test()
while true do
term.clear()
term.setCursorPos(1,1)
print'Welcome to Server 1.'
print'System online.'
print'Please make a choice:'
print'1: Reactor Monitor'
print'2: Reactor Control'
print'3: Shutdown'
print'4: Reboot'
print'5: Terminate'

ch=io.read()
ch=ch+1-1

if ch==1 then

print'Welcome to the Reactor Control Center'
print'Current status:'
print("Reactor Active: "..tostring(active))
print("Current Stored Energy: "..storedEnergy.."RF")
print("Fuel Temp: "..fuelTemp.."C")
print("Casing Temp: "..casingTemp.."C")
print("Fuel Level: "..fuelLvl.."mB")
print("Waste Level: "..wasteLvl.."mB")
print("Energy/Tick: "..energyTick.."RF/t")
print("Reactivity: "..reactivity.."%")
print'Press enter to continue...'
io.read()
end

if ch==2 then
print'---Reactor Control---'
print'Please make a choice:'
if active==true then
print'1: Turn Reactor off'
end
if active==false then
print'1: Turn Reactor on'
end

print'2: Set Control Rod Level (0-100%)'

sel=io.read()
sel=sel+1-1

if sel==1 and active==true then
send(100,1,"pwrOFF")
print'Shutting Reactor Down'
sleep(1)
end
if sel==1 and active==false then
send(100,1,"pwrON")
print'Powering on Reactor'
sleep(1)
end

if sel==2 then
print'Please input desired rod level for all rods(0-100% with no % symbol):'
rlvl=io.read()
rlvl=rlvl+1-1
send(100,1,"rodsLvl")
sleep(.1)
send(50,1,rlvl)
print('Sent '..rlvl.." to the reactor.")
sleep(1)
end

end

if ch==3 then
print'Shutting down!'
sleep(1)
os.shutdown()
end

if ch==4 then
print'Rebooting!'
sleep(1)
os.reboot()
end

if ch==5 then
print'Terminating program!'
sleep(1)
term.clear()
term.setCursorPos(1,1)
break
end

end
end

active=failed
storedEnergy=failed
fuelTemp=failed
casingTemp=failed
fuelLvl=failed
wasteLvl=failed
energyTick=failed
reactivity=failed

function garbageCollection() --reboots every 6 hours to clear threads.
print'Garbage Collection Active...'
sleep(21600)
os.reboot()
end


parallel.waitForAll(test,listen,listenR,garbageCollection)
