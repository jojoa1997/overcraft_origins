-- mods/default/craftitems.lua

--
-- Crafting items
--

minetest.register_craftitem("default:stick", {
	description = "Stick",
	inventory_image = "default_stick.png",
})

minetest.register_craftitem("default:paper", {
	description = "Paper",
	inventory_image = "default_paper.png",
})

minetest.register_craftitem("default:book", {
	description = "Book",
	inventory_image = "default_book.png",
})

minetest.register_craftitem("default:coal_lump", {
	description = "Coal Lump",
	inventory_image = "default_coal_lump.png",
})

minetest.register_craftitem("default:charcoal_lump", {
	description = "Charcoal Lump",
	inventory_image = "default_charcoal_lump.png",
})

minetest.register_craftitem("default:gold_nugget", {
	description = "Gold Nugget",
	inventory_image = "default_gold_nugget.png",
})

minetest.register_craftitem("default:diamond", {
	description = "Diamond",
	inventory_image = "default_diamond.png",
})

minetest.register_craftitem("default:clay_lump", {
	description = "Clay Lump",
	inventory_image = "default_clay_lump.png",
})

minetest.register_craftitem("default:steel_ingot", {
	description = "Steel Ingot",
	inventory_image = "default_steel_ingot.png",
})

minetest.register_craftitem("default:gold_ingot", {
	description = "Gold Ingot",
	inventory_image = "default_gold_ingot.png"
})

minetest.register_craftitem("default:emerald", {
	description = "Emerald",
	inventory_image = "default_emerald.png",
})

minetest.register_craftitem("default:clay_brick", {
	description = "Clay Brick",
	inventory_image = "default_clay_brick.png",
})

minetest.register_craftitem("default:scorched_stuff", {
	description = "Scorched Stuff",
	inventory_image = "default_scorched_stuff.png",
})

minetest.register_craftitem("default:flint", {
	description = "Flint",
	inventory_image = "default_flint.png",
})

minetest.register_craftitem("default:sulphur", {
	description = "Sulphurr",
	inventory_image = "default_sulphur.png",
})

minetest.register_craftitem("default:bone", {
	description = "Bone",
	inventory_image = "default_bone.png",
})

minetest.register_craftitem("default:glowstone_dust", {
	description = "Glowstone Dust",
	inventory_image = "default_glowstone_dust.png",
})

minetest.register_craftitem("default:fish_raw", {
	description = "Raw Fish",
    groups = {},
    inventory_image = "default_fish.png",
	 on_use = minetest.item_eat(2),
})

minetest.register_craftitem("default:fish", {
	description = "Cooked Fish",
    groups = {},
    inventory_image = "default_fish_cooked.png",
	 on_use = minetest.item_eat(4),
})

minetest.register_craftitem("default:sugar", {
	description = "Sugar",
	inventory_image = "default_sugar.png",
})

minetest.register_craftitem("default:sugarcane",{
	description = "Sugarcane",
	inventory_image = "default_sugar_cane.png",
})
