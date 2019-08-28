obs = obslua
bit = require("bit")

ledClock= require("led-clock-module")

source_def = {}
source_def.id = "lua_led_clock"
source_def.output_flags = bit.bor(obs.OBS_SOURCE_VIDEO, obs.OBS_SOURCE_CUSTOM_DRAW)

function image_source_load(image, file)
	obs.obs_enter_graphics();
	obs.gs_image_file_free(image);
	obs.obs_leave_graphics();

	obs.gs_image_file_init(image, file);

	obs.obs_enter_graphics();
	obs.gs_image_file_init_texture(image);
	obs.obs_leave_graphics();

	if not image.loaded then
		print("failed to load texture " .. file);
	end
end

source_def.get_name = function()
	return "LED Clock"
end

source_def.create = function(source, settings)
	local data = {}

	local scriptPath= script_path()
	local mapping= ledClock.buildImageMapping()
	for k,v in pairs(mapping) do
		local image= obs.gs_image_file()
		local file= scriptPath..v
		image_source_load(image, file)
		data[k]= image
	end--for

	return data
end

source_def.destroy = function(data)
	obs.obs_enter_graphics();

	for k,v in pairs(data) do
		obs.gs_image_file_free(v);
	end--for

	obs.obs_leave_graphics();
end

source_def.video_render = function(data, effect)
	if not data["0"] or not data["0"].texture then
		return;
	end

	local text= ledClock.buildImageText()

	effect = obs.obs_get_base_effect(obs.OBS_EFFECT_DEFAULT)

	obs.gs_blend_state_push()
	obs.gs_reset_blend_state()

	while obs.gs_effect_loop(effect, "Draw") do
		for i=1,string.len(text) do
			local n= string.sub(text,i,i)
			local x=30*(i-1)
			obs.obs_source_draw(get_number(data,n),x, 0, 0, 0, false);
		end--for
	end--while

	obs.gs_blend_state_pop()
end

function get_number(data,n)
	local t= data[n].texture
	return t
end

source_def.get_width = function(data)
	return 250
end

source_def.get_height = function(data)
	return 40
end

function script_description()
	return "obs led clock QQ:2604904"
end

obs.obs_register_source(source_def)
