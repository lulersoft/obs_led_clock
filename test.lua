#!/usr/bin/env lua

local ledClock= require("led-clock-module")

local mapping= ledClock.buildImageMapping()
print("-- mapping --")
for k,v in pairs(mapping) do
	print(k,v)
end--for

print("")
local text= ledClock.buildImageText()
print("-- time --")
print(text)

print("")
print("-- mapping result --")
for i=1,string.len(text) do
	local s= string.sub(text,i,i)
	print(s, mapping[s])
end--for

print("")
print("-- end --")

