ledClock= {}--begin module

function ledClock.buildImageMapping()
	local keys= "0123456789:"
	local format= [[led-clock/n%s.png]]
	local map= {}
	for i=1,string.len(keys) do
		local k= string.sub(keys,i,i)
		local v= k
		if k==":" then
			v=""
		end
		map[k]= string.format(format,v)
	end--for
	return map
end--function

function ledClock.buildImageText()
	return os.date("%H:%M:%S")
end--function

return ledClock--end module
