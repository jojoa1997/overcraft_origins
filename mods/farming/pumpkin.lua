LIGHT_MAX = 14

minetest.register_craftitem("farming:pumpkin_seed", {
	description = "Pumpkin Seed",
	inventory_image = "farming_pumpkin_seed.png",
	on_place = function(itemstack, placer, pointed_thing)
		local above = minetest.env:get_node(pointed_thing.above)
		if above.name == "air" then
			above.name = "farming:pumpkin_1"
			minetest.env:set_node(pointed_thing.above, above)
			itemstack:take_item(1)
			return itemstack
		end
	end
})

minetest.register_node("farming:pumpkin_1", {
	paramtype = "light",
	sunlight_propagates = true,
	drawtype = "nodebox",
	drop = "",
	tiles = {"farming_pumpkin_top.png", "farming_pumpkin_top.png", "farming_pumpkin_side.png", "farming_pumpkin_side.png", "farming_pumpkin_side.png", "farming_pumpkin_side.png"},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.2, -0.5, -0.2, 0.2, -0.1, 0.2}
		},
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.2, -0.5, -0.2, 0.2, -0.1, 0.2}
		},
	},
	groups = {choppy=2, oddly_breakable_by_hand=2, flammable=2, not_in_creative_inventory=1},
})

minetest.register_node("farming:pumpkin_2", {
	paramtype = "light",
	sunlight_propagates = true,
	drawtype = "nodebox",
	drop = "",
	tiles = {"farming_pumpkin_top.png", "farming_pumpkin_top.png", "farming_pumpkin_side.png", "farming_pumpkin_side.png", "farming_pumpkin_side.png", "farming_pumpkin_side.png"},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.35, -0.5, -0.35, 0.35, 0.2, 0.35}
		},
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.35, -0.5, -0.35, 0.35, 0.2, 0.35}
		},
	},
	groups = {choppy=2, oddly_breakable_by_hand=2, flammable=2, not_in_creative_inventory=1},
})

minetest.register_node("farming:pumpkin", {
	description = "Pumpkin",
	paramtype2 = "facedir",
	tiles = {"farming_pumpkin_top.png", "farming_pumpkin_top.png", "farming_pumpkin_side.png", "farming_pumpkin_side.png", "farming_pumpkin_side.png", "farming_pumpkin_side.png"},
	groups = {choppy=2, oddly_breakable_by_hand=2, flammable=2},
	
	on_punch = function(pos, node, puncher)
		local tool = puncher:get_wielded_item():get_name()
		if tool and tool == "default:sword_wood" or tool == "default:sword_stone" or tool == "default:sword_steel" then
			node.name = "farming:pumpkin_face"
			minetest.env:set_node(pos, node)
			puncher:get_inventory():add_item("main", ItemStack("farming:pumpkin_seed"))
			if math.random(1, 5) == 1 then
				puncher:get_inventory():add_item("main", ItemStack("farming:pumpkin_seed"))
			end
		end
	end
})

farming:add_plant("farming:pumpkin", {"farming:pumpkin_1", "farming:pumpkin_2"}, 80, 20)

minetest.register_node("farming:pumpkin_face", {
	description = "Pumpkin Face",
	paramtype2 = "facedir",
	tiles = {"farming_pumpkin_top.png", "farming_pumpkin_top.png", "farming_pumpkin_side.png", "farming_pumpkin_side.png", "farming_pumpkin_side.png", "farming_pumpkin_face.png"},
	groups = {choppy=2, oddly_breakable_by_hand=2, flammable=2},
})

minetest.register_node("farming:pumpkin_face_light", {
	description = "Jack O' Lantern",
	paramtype2 = "facedir",
	light_source = LIGHT_MAX-2,
	tiles = {"farming_pumpkin_top.png", "farming_pumpkin_top.png", "farming_pumpkin_side.png", "farming_pumpkin_side.png", "farming_pumpkin_side.png", "farming_pumpkin_face_light.png"},
	groups = {choppy=2, oddly_breakable_by_hand=2, flammable=2},
})

minetest.register_craft({
	type = "shapeless",
	output = "farming:pumpkin_face_light",
	recipe = {"farming:pumpkin_face", "default:torch"}
})


-- ========= FUEL =========
minetest.register_craft({
	type = "fuel",
	recipe = "farming:pumpkin_seed",
	burntime = 1
})

minetest.register_craft({
	type = "fuel",
	recipe = "farming:pumpkin",
	burntime = 5
})

minetest.register_craft({
	type = "fuel",
	recipe = "farming:pumpkin_face",
	burntime = 5
})

minetest.register_craft({
	type = "fuel",
	recipe = "farming:pumpkin_face_light",
	burntime = 7
})
