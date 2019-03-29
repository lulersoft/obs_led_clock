obs = obslua
bit = require("bit")

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

	data.n0 = obs.gs_image_file()
	data.n1 = obs.gs_image_file()
	data.n2 = obs.gs_image_file()
	data.n3 = obs.gs_image_file()
	data.n4 = obs.gs_image_file()
	data.n5 = obs.gs_image_file()
	data.n6 = obs.gs_image_file()
	data.n7 = obs.gs_image_file()
	data.n8 = obs.gs_image_file()
	data.n9 = obs.gs_image_file()
	data.n = obs.gs_image_file()


	image_source_load(data.n0, script_path() .. "led-clock/n0.png")
	image_source_load(data.n1, script_path() .. "led-clock/n1.png")
	image_source_load(data.n2, script_path() .. "led-clock/n2.png")
	image_source_load(data.n3, script_path() .. "led-clock/n3.png")
	image_source_load(data.n4, script_path() .. "led-clock/n4.png")
	image_source_load(data.n5, script_path() .. "led-clock/n5.png")
	image_source_load(data.n6, script_path() .. "led-clock/n6.png")
	image_source_load(data.n7, script_path() .. "led-clock/n7.png")
	image_source_load(data.n8, script_path() .. "led-clock/n8.png")
	image_source_load(data.n9, script_path() .. "led-clock/n9.png")
	image_source_load(data.n, script_path() .. "led-clock/n.png")

	return data
end

source_def.destroy = function(data)
	obs.obs_enter_graphics();
	obs.gs_image_file_free(data.n0);
	obs.gs_image_file_free(data.n1);
	obs.gs_image_file_free(data.n2);
	obs.gs_image_file_free(data.n3);
	obs.gs_image_file_free(data.n4);
	obs.gs_image_file_free(data.n5);
	obs.gs_image_file_free(data.n6);
	obs.gs_image_file_free(data.n7);
	obs.gs_image_file_free(data.n8);
	obs.gs_image_file_free(data.n9);
	obs.gs_image_file_free(data.n);

	obs.obs_leave_graphics();
end

source_def.video_render = function(data, effect)
	if not data.n.texture then
		return;
	end

	local time = os.date("*t")
	local seconds = time.sec
	local mins = time.min
	local hours = time.hour

	effect = obs.obs_get_base_effect(obs.OBS_EFFECT_DEFAULT)

	obs.gs_blend_state_push()
	obs.gs_reset_blend_state()

	while obs.gs_effect_loop(effect, "Draw") do
		
		local number=tostring(hours)
		local k=string.len(number)
		local list1={}
		if (k>1) then
			for i=1,k do
				list1[i]=string.sub(number,i,i)
			end
			obs.obs_source_draw(get_number(data,list1[1]),0, 0, 0, 0, false);
			obs.obs_source_draw(get_number(data,list1[2]),30, 0, 0, 0, false);
		else
			obs.obs_source_draw(data.n0.texture, 0,0, 0, 0, false);
			obs.obs_source_draw(get_number(data,number), 30, 0, 0, 0, false);
		end	
		obs.obs_source_draw(data.n.texture, 60, 0, 0, 0, false);


		local number=tostring(mins)
		local k=string.len(number)
		local list1={}
		if (k>1) then
			for i=1,k do
				list1[i]=string.sub(number,i,i)
			end
			obs.obs_source_draw(get_number(data,list1[1]),90, 0, 0, 0, false);
			obs.obs_source_draw(get_number(data,list1[2]),120, 0, 0, 0, false);
		else
			obs.obs_source_draw(data.n0.texture, 90,0, 0, 0, false);
			obs.obs_source_draw(get_number(data,number), 120, 0, 0, 0, false);
		end
		obs.obs_source_draw(data.n.texture, 150, 0, 0, 0, false);

		local number=tostring(seconds)
		local k=string.len(number)
		local list1={}
		if (k>1) then
			for i=1,k do
				list1[i]=string.sub(number,i,i)
			end
			obs.obs_source_draw(get_number(data,list1[1]),180, 0, 0, 0, false);
			obs.obs_source_draw(get_number(data,list1[2]),210, 0, 0, 0, false);
		else
			obs.obs_source_draw(data.n0.texture, 180, 0, 0, 0, false);
			obs.obs_source_draw(get_number(data,number), 210, 0, 0, 0, false);
		end

	end

	obs.gs_blend_state_pop()
end

function get_number(data,n)
	local t=data.n0.texture
	if n=='0' then
		t=data.n0.texture
	elseif  n=='1' then
		t=data.n1.texture
	elseif  n=='2' then
		t=data.n2.texture
	elseif  n=='3' then
		t=data.n3.texture
	elseif  n=='4' then
		t=data.n4.texture
	elseif  n=='5' then
		t=data.n5.texture
	elseif  n=='6' then
		t=data.n6.texture
	elseif  n=='7' then
		t=data.n7.texture
	elseif  n=='8' then
		t=data.n8.texture
	elseif  n=='9' then
		t=data.n9.texture
	end
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
