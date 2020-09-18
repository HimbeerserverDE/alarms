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

local function a_action_on(pos, node)
	for _, obj in ipairs(minetest.get_objects_inside_radius(pos, 20)) do
		local sound = minetest.sound_play("alarm_" .. node.name:split(":")[2], {
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
end

local function a_action_off(pos, node)
	local meta = minetest.get_meta(pos)
	local sounds = minetest.parse_json(meta:get_string("sounds"))
	for _, sound in ipairs(sounds) do
		minetest.sound_stop(sound)
	end
	sounds = {}
	meta:set_string("sounds", minetest.write_json(sounds))
end

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
			action_on = a_action_on,
			action_off = a_action_off,
		},
	},
	on_destruct = function(pos)
		a_action_off(pos, {name = "alarms:fire"})
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
			action_on = a_action_on,
			action_off = a_action_off,
		},
	},
	on_destruct = function(pos)
		a_action_off(pos, {name = "alarms:nuclear"})
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
			action_on = a_action_on,
			action_off = a_action_off,
		},
	},
	on_destruct = function(pos)
		a_action_off(pos, {name = "alarms:nuclear"})
	end,
})
