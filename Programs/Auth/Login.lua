
a=os.pullEvent
os.pullEvent = os.pullEventRaw


	while access~=1 do
	print'Enter Password:'
	pass=read("*")
	access=0
		if pass~="nou" and pass~="guest" then
		print'Wrong Password!'
		end
		sleep(1)
		term.clear()
		term.setCursorPos(1,1)
		if pass=="nou" then
		access=1
		shell.openTab("master")
		print'Welcome, Kizz, to Kizz OS!'
		print'Commands: '
		print'Logout - Logs user out. '
		print'Extend - Extends logout timer by x min.'
		print'Help - Shows more commands'
		user=1
		end
		if pass=="guest" then
		access=1
		shell.openTab("guest")
		print'Welcome, Guest, to Kizz OS!'
		print'Commands: '
		print'Logout - Logs user out. '
		print'Extend - Extends logout timer by x min.'
		print'Help - Shows more commands'
		user=0
		end
	end
	os.pullEvent=a
	
	function logme()
		if user==1 then userName="Kizz" end
		if user==0 then userName="Guest" end
		
		if not fs.exists("log") then
		local h = fs.open("log", "a")
		h.write(" ")
		h.close()
		end
		
		if fs.exists("log") then
			local h = fs.open("log", "r")
			loglen=h.readAll()
			--print(loglen)
			if string.len(loglen)>1000000 then
			h.close()
			fs.delete("log")
			end
			h.close()
			local h = fs.open("log", "a")
			h.write(userName.." - Day: "..os.day().." | Time: "..os.time()..". \n")
			h.close()
		end
	
	
	end
	
	
	logme()










