fl=turtle.getFuelLevel()
print(fl)
print'Press 1 to add fuel or 2 to exit.'
ch=io.read()
ch=ch+1-1
if ch==1 then 
turtle.refuel(1)
end

sleep(2)
