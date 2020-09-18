local m_rules = {
	{x = 0,  y = 0,  z = -1},
	{x = 1,  y = 0,  z = 0},
	{x = -1, y = 0,  z = 0},
	{x = 0,  y = 0,  z = 1},
	{x = 1,  y = 1,  z = 0},
	{x = 1,  y = -1, z = 0},
	{x = -1, y = 1,  z = 0},
	{x = -1, y = -1, z = 0},
	{x = 0,  y = 1,  z = 1},
	{x = 0,  y = -1, z = 1},
	{x = 0,  y = 1,  z = -1},
	{x = 0,  y = -1, z = -1},
	{x = 0,  y = -1, z = 0},
	
	{x = 0,  y = 0,  z = -2},
	{x = 2,  y = 0,  z = 0},
	{x = -2, y = 0,  z = 0},
	{x = 0,  y = 0,  z = 2},
	{x = 2,  y = 2,  z = 0},
	{x = 2,  y = -2, z = 0},
	{x = -2, y = 2,  z = 0},
	{x = -2, y = -2, z = 0},
	{x = 0,  y = 2,  z = 2},
	{x = 0,  y = -2, z = 2},
	{x = 0,  y = 2,  z = -2},
	{x = 0,  y = -2, z = -2},
	{x = 0,  y = -2, z = 0},
}

minetest.register_node("alarms:fire", {
	description = "Fire alarm",
	groups = {snappy = 1},
	tiles = {"red.png", "red.png", "red.png", "red.png", "red.png", "gray.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.2, -0.2, 0.5, 0.2, 0.2, 0.4},
		},
	},
	mesecons = {
		effector = {
			rules = m_rules,
			action_on = function(pos, node)
				for _, obj in ipairs(minetest.get_objects_inside_radius(pos, 20)) do
					local sound = minetest.sound_play("alarm_fire", {
						to_player = obj,
						max_hear_distance = 20,
						gain = 10.0,
						loop = true,
					})
					local meta = minetest.get_meta(pos)
					local sounds = minetest.parse_json(meta:get_string("sounds"))
					table.insert(sounds, sound)
					meta:set_string("sounds", minetest.write_json(sounds))
				end
			end,
			action_off = function(pos, node)
				if not minetest.get_meta(pos):get_int("sound") then return end
				minetest.sound_stop(minetest.get_meta(pos):get_int("sound"))
			end,
		},
	},
	on_destruct = function(pos)
		if not minetest.get_meta(pos):get_int("sound") then return end
		minetest.sound_stop(minetest.get_meta(pos):get_int("sound"))
	end,
})
minetest.register_node("alarms:nuclear", {
	description = "Nuclear alarm",
	groups = {choppy = 1},
	tiles = {"gray.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.2, -0.2, -0.8, 0.2, 0.2, 0.8},
		},
	},
	mesecons = {
		effector = {
			rules = m_rules,
			action_on = function(pos, node)
				for _, obj in ipairs(minetest.get_objects_inside_radius(pos, 20)) do
					if not obj:is_player() then return end
					local sound = minetest.sound_play("alarm_nuclear", {
						to_player = obj:get_player_name(),
						max_hear_distance = 20,
						gain = 10.0,
						loop = true,
					})
				end
				minetest.get_meta(pos):set_int("sound", sound)
			end,
			action_off = function(pos, node)
				if not minetest.get_meta(pos):get_int("sound") then return end
				minetest.sound_stop(minetest.get_meta(pos):get_int("sound"))
			end,
		},
	},
	on_destruct = function(pos)
		if not minetest.get_meta(pos):get_int("sound") then return end
		minetest.sound_stop(minetest.get_meta(pos):get_int("sound"))
	end,
})
minetest.register_node("alarms:intruder", {
	description = "Intruder alarm",
	groups = {snappy = 1},
	tiles = {"gray.png", "gray.png", "gray.png", "gray.png", "gray.png", "red.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.2, -0.2, 0.5, 0.2, 0.2, 0.4},
		},
	},
	mesecons = {
		effector = {
			rules = m_rules,
			action_on = function(pos, node)
				for _, obj in ipairs(minetest.get_objects_inside_radius(pos, 20)) do
					if not obj:is_player() then return end
					local sound = minetest.sound_play("alarm_intruder", {
						to_player = obj:get_player_name(),
						max_hear_distance = 20,
						gain = 10.0,
						loop = true,
					})
				end
				minetest.get_meta(pos):set_int("sound", sound)
			end,
			action_off = function(pos, node)
				if not minetest.get_meta(pos):get_int("sound") then return end
				minetest.sound_stop(minetest.get_meta(pos):get_int("sound"))
			end,
		},
	},
	on_destruct = function(pos)
		if not minetest.get_meta(pos):get_int("sound") then return end
		minetest.sound_stop(minetest.get_meta(pos):get_int("sound"))
	end,
})
