print("Aeprox ESP8266 datalogger V1.1-dev (Compatible with NodeMCU 0.9.6 build 20150627) ")

-- variables
h,t,lx0,lx1,Vdd=0,0,0,0,0
dofile("usersettings.lua")

local function dologger()
    if wifi.sta.status() < 5 then
        print("Wifi connection failed. Reconnecting..")
        wifi.setmode(wifi.STATION)
        wifi.sta.config(SSID,password)
        tmr.alarm(1,5000,0,dologger)
    else
        dofile("readsensors.lc")
        dofile("thingspeakPOST.lc")
    end
end
tmr.alarm(0,2000,0,dologger)

function gotosleep()
    if(serialOut) then print("Taking a "..APIdelay.." second nap") end
    node.dsleep(APIdelay*1000000)
    --tmr.alarm(0,APIdelay*1000,0,donetwork)
end
