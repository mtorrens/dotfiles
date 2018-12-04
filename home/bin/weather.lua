#!/usr/bin/lua
-- load the http socket module
http = require("socket.http")
-- load the json module
json = require("json")

api_url = "http://api.openweathermap.org/data/2.5/weather?"

-- http://openweathermap.org/help/city_list.txt , http://openweathermap.org/find
cityid = "2800866"

-- metric or imperial
cf = "metric"

-- get an open weather map api key: http://openweathermap.org/appid
apikey = "dda365d29d20a50b3173abee4048370b"

-- measure is °C if metric and °F if imperial
measure = (cf == 'metric' and '' or '')

-- save the cache somewhere safe
cachename = os.getenv("HOME") .. '/.cache/weather.json'

-- Unicode weather symbols to use
icons = {
  ["01"] = "",
  ["02"] = "",
  ["03"] = "",
  ["04"] = "",
  ["09"] = "",
  ["10"] = "",
  ["11"] = "",
  ["13"] = "",
  ["50"] = "",
}

currenttime = os.date("!%Y%m%d%H%M%S")

file_exists = function (name)
    f=io.open(name,"r")
    if f~=nil then
        io.close(f)
        return true
    else
        return false
    end
end

if file_exists(cachename) then
    cache = io.open(cachename, "r+")
    data = json.decode(cache:read())
    timepassed = os.difftime(currenttime, data.timestamp)
else
    cache = io.open(cachename, "w")
    timepassed = 6000
end

makecache = function (s)
    s.timestamp = currenttime
    save = json.encode(s)
    cache:write(save)
end

if timepassed < 3600 then
    response = data
else
    weather = http.request(("%sid=%s&units=%s&APPID=%s"):format(api_url, cityid, cf, apikey))
    if weather then
        response = json.decode(weather)
        makecache(response)
    else
        response = data
    end
end

math.round = function (n)
    return math.floor(n + 0.5)
end

temp = response.main.temp
conditions = response.weather[1].main
icon = response.weather[1].icon:sub(1, 2)

io.write(("%s %s%s %s\n"):format(icons[icon], math.round(temp), measure, conditions))

cache:close()
