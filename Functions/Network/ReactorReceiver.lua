--Reactor Receiver PC
local reactor=peripheral.wrap('back')
local modem=peripheral.wrap('right')
 
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
				break
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
 

--Reactor Control/Monitor Vars 
function update()
chkCn=reactor.getConnected()
chkActive=reactor.getActive()
chkEnergyStored=reactor.getEnergyStored()
chkFuelTemp=reactor.getFuelTemperature()
chkCasingTemp=reactor.getCasingTemperature()
chkFuel=reactor.getFuelAmount()
chkWaste=reactor.getWasteAmount()
chkEnergyTick=reactor.getEnergyProducedLastTick()
chkReactivity=reactor.getFuelReactivity()
end
function reactorPowerCtrl(n)
reactor.setActive(n)
end
function setAllRodLvl(n)
reactor.setAllControlRodLevels(n)
end
function ejectWaste(n)
reactor.doEjectWaste(n)
end
--Passing code: Passes all reactor monitoring vars to Server 1
function request()
print'Listening'
while true do
update()
get(9)
if msg=="req" then
send(10,9,chkActive)
sleep(.1)
send(11,9,chkEnergyStored)
sleep(.1)
send(12,9,chkFuelTemp)
sleep(.1)
send(13,9,chkCasingTemp)
sleep(.1)
send(14,9,chkFuel)
sleep(.1)
send(15,9,chkWaste)
sleep(.1)
send(16,9,chkEnergyTick)
sleep(.1)
send(17,9,chkReactivity)
--sleep(5)
end
end
end

function request2()
print'Listening2'
while true do
update()
get(29)
--print'got'
if msg=="req" then
send(30,9,chkActive)
sleep(.2)
send(31,9,chkEnergyStored)
sleep(.2)
send(32,9,chkFuelTemp)
sleep(.2)
send(33,9,chkCasingTemp)
sleep(.2)
send(34,9,chkFuel)
sleep(.2)
send(35,9,chkWaste)
sleep(.2)
send(36,9,chkEnergyTick)
sleep(.2)
send(37,9,chkReactivity)
--sleep(5)
end
end
end

function comms()
chkCn=reactor.getConnected()
if chkCn==true then
parallel.waitForAll(request,request2)
end
if chkCn==false then
print'Failed to connect to reactor...'
sleep(1)
end
end

function watchdog()
	while true do
	get(100)
	--print(msg)
	if msg=="pwrON" then
	reactorPowerCtrl(true)
	end

	if msg=="pwrOFF" then
	reactorPowerCtrl(false)
	end

	if msg=="rodsLvl" then
	get(50)
	print(msg)
	rlvl=msg+1-1
		if rlvl>=0 and rlvl<=100 then
		setAllRodLvl(rlvl)
		end
	end
	end
end

function overflow()
print("Overflow Check Active")
	while true do
		rOn=reactor.getActive()
		engLevel=reactor.getEnergyStored()
		if engLevel>=8000000 and rOn==true then
		reactorPowerCtrl(false)
		end
		if engLevel<8000000 and rOn==false then
		reactorPowerCtrl(true)
		end
		sleep(3)
	end
end

function garbageCollection() --reboots every 6 hours to clear threads.
print'Garbage Collection Active...'
sleep(21600)
os.reboot()
end

parallel.waitForAll(comms,watchdog,overflow,garbageCollection)
