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

