
local S = mobs.intllib


-- custom particle effects
local effect = function(pos, amount, texture, min_size, max_size, radius, gravity, glow)

	radius = radius or 2
	min_size = min_size or 0.5
	max_size = max_size or 1
	gravity = gravity or -10
	glow = glow or 0

	minetest.add_particlespawner({
		amount = amount,
		time = 0.25,
		minpos = pos,
		maxpos = pos,
		minvel = {x = -radius, y = -radius, z = -radius},
		maxvel = {x = radius, y = radius, z = radius},
		minacc = {x = 0, y = gravity, z = 0},
		maxacc = {x = -20, y = gravity, z = 15},
		minexptime = 0.1,
		maxexptime = 1,
		minsize = min_size,
		maxsize = max_size,
		texture = texture,
		glow = glow,
	})
end


-- Sand Monster by PilzAdam

mobs:register_mob("mobs_monster:sand_monster", {
	type = "monster",
	group_attack = true,
	passive = false,
	attack_type = "dogfight",
	pathfinding = true,
	--specific_attack = {"player", "mobs_npc:npc"},
	reach = 3,
	damage = 4,
	hp_min = 25,
	hp_max = 65,
	armor = 100,
	collisionbox = {-0.4, -1, -0.4, 0.4, 0.8, 0.4},
	visual = "mesh",
	mesh = "mobs_sand_monster.b3d",
	textures = {
		{"mobs_sand_monster.png"},
	},
	blood_texture = "default_desert_sand.png",
	makes_footstep_sound = true,
	sounds = {
		random = "mobs_sandmonster_neutral",
		damage = "mobs_sandmonster_hit",
		death = "mobs_sandmonster_death",
		attack = "mobs_sandmonster_attack",
		distance = 15
	},
	walk_velocity = 1.5,
	run_velocity = 4,
	view_range = 16,
	jump = true,
	floats = 0,
	drops = {
		{name = "default:desert_sand", chance = 1, min = 3, max = 5},
		{name = "default:cactus", chance = 3, min = 1, max = 2},
	},
	water_damage = 10,
	lava_damage = 10,
	light_damage = 10,
	fear_height = 4,
	animation = {
		speed_normal = 15,
		speed_run = 15,
		stand_start = 0,
		stand_end = 39,
		walk_start = 41,
		walk_end = 72,
		run_start = 74,
		run_end = 105,
		punch_start = 74,
		punch_end = 105,
	},
--[[
	custom_attack = function(self, p)
		local pos = self.object:get_pos()
		minetest.add_item(pos, "default:sand")
	end,
]]
	on_die = function(self, pos)
		pos.y = pos.y + 0.5
		effect(pos, 30, "mobs_sand_particles.png", 0.1, 2, 3, 5)
		pos.y = pos.y + 0.25
		effect(pos, 30, "mobs_sand_particles.png", 0.1, 2, 3, 5)
	end,
})


mobs:spawn({
	name = "mobs_monster:sand_monster",
	nodes = {"default:desert_sand", "default:sand"},
	chance = 7000,
	active_object_count = 2,
	min_height = 0,
	max_light = 7,
	min_light = 0,
	day_toggle = false,
})


mobs:register_egg("mobs_monster:sand_monster", S("Sand Monster"), "default_desert_sand.png", 1)


mobs:alias_mob("mobs:sand_monster", "mobs_monster:sand_monster") -- compatibility
