-- ************************************************
-- Thingspeak example for ESP8266 with nodeMCU
-- tested 2015-07-20 with build 20150627
--
-- Written by Aeprox @ github
--
-- MIT license, http://opensource.org/licenses/MIT
-- ************************************************

wkey = "8T9YUBFQEPSPZF5" -- thingspeak API write key
dataValues = {} 

wifi.sta.connect()

function onSendComplete(success,status) 
    if success then 
        print("Done sending data. Reply status:"..status)
    else
        print("Couldn't send data")
    end
    
    -- unload module
    thingspeak = nil
    package.loaded["thingspeak"]=nil
end
function sendData()
    thingspeak = require("thingspeak")

    -- fill table with values
    dataValues["field1"] = 123
    dataValues["field5"] = 7.65
    dataValues["field4"] = 8000
    dataValues["field2"] = 9.5453
    dataValues["status"] = "Success"
    -- send to thingspeak
    thingspeak.send(wkey,dataValues,onSendComplete)
end
     
sendData()
tmr.alarm(2,15000,1,sendData)       
