local path = minetest.get_modpath(minetest.get_current_modname())

local filepath = minetest.get_worldpath()

local function save_player_data()
	local file = io.open(filepath .. "/playerdata.txt", "w")
	file:write(minetest.serialize(playerdata))
	file:close()
end

function load_player_data()
	local file = io.open(filepath .. "/playerdata.txt", "r")
	if file then
		local table = minetest.deserialize(file:read("*all"))
		if type(table) == "table" then
			return table
			
		end
	end
	return {}
end

inventory = {}
inventory.inventory_size = 0
pagenum = 0
playerdata = load_player_data()

dofile(path.."/config.txt")
dofile(path.."/api.lua")
dofile(path.."/workbench.lua")

minetest.register_on_joinplayer(function(player)
	pname = player:get_player_name()
	playerdata = load_player_data()
	if not playerdata[pname] then
		playerdata[pname] = {}
		playerdata[pname]['gamemode'] = Default_Mode
		save_player_data()
	end
	if not playerdata[pname]['gamemode'] then
		playerdata[pname]['gamemode'] = Default_Mode
		save_player_data()
		playerdata = load_player_data()
		minetest.after(0.3, function() updategamemode(pname, "0") end)
	else
		minetest.after(0.3, function() updategamemode(pname, "0") end)
	end
end)

--Ensure that all mods are loaded before editing inventory.
minetest.after(0.2, function()
local trash = minetest.create_detached_inventory("creative_trash", {
		-- Allow the stack to be placed and remove it in on_put()
		-- This allows the creative inventory to restore the stack
		allow_put = function(inv, listname, index, stack, player)
				return stack:get_count()
		end,
		on_put = function(inv, listname, index, stack, player)
			inv:set_stack(listname, index, "")
		end,
})
trash:set_size("main", 1)


creative_list = {}
for name,def in pairs(minetest.registered_items) do
		if (not def.groups.not_in_creative_inventory or def.groups.not_in_creative_inventory == 0)
				and def.description and def.description ~= "" then
			table.insert(creative_list, name)
		end

end


local inv = minetest.create_detached_inventory("creative", {
		allow_move = function(inv, from_list, from_index, to_list, to_index, count, player)
				return count
		end,
		allow_put = function(inv, listname, index, stack, player)
			return 0
		end,
		allow_take = function(inv, listname, index, stack, player)
				return -1
		end,
		on_move = function(inv, from_list, from_index, to_list, to_index, count, player)
		end,
		on_put = function(inv, listname, index, stack, player)
		end,
		on_take = function(inv, listname, index, stack, player)
			print(player:get_player_name().." takes item from creative inventory; listname="..dump(listname)..", index="..dump(index)..", stack="..dump(stack))
			if stack then
				print("stack:get_name()="..dump(stack:get_name())..", stack:get_count()="..dump(stack:get_count()))
			end
		end,
	})
	
table.sort(creative_list)

inv:set_size("main", #creative_list)

for _,itemstring in ipairs(creative_list) do
	inv:add_item("main", ItemStack(itemstring))
end
	inventory.inventory_size = #creative_list

end)	

-- Create detached creative inventory after loading all mods
function updategamemode(pname, status)
	playerdata = load_player_data()
	if not status then
	print(pname.." has switched to "..playerdata[pname]['gamemode'].." Mode.")
	minetest.chat_send_all(pname.." has switched to "..playerdata[pname]['gamemode'].." Mode.")
	end
	if playerdata[pname]['gamemode'] == "Creative" then
	local player = minetest.env:get_player_by_name(pname)
	
	inventory.set_player_formspec(player, 1, 1)
	else
	
	local player = minetest.env:get_player_by_name(pname)
	inventory.set_player_formspec(player, 1, 1)

	end
end
inventory.set_player_formspec = function(player, start_i, pagenum)
playerdata = load_player_data()
	if playerdata[player:get_player_name()]['gamemode'] == "Creative" or creative_type == "default" then
		inventory.creative_inv(player)
		inventory.hotbar(player)
	end
	if creative_type == "search" then
		pagenum = math.floor(pagenum)
		pagemax = math.floor((inventory.inventory_size-1) / (9*4) + 1)
		CREATIVE_SEARCH_ITEMS = "invsize[11,9.5;]"..
			"button[9.5,0;1.5,1.5;creative_search;Search]"..
			"list[current_player;main;0.5,6.74;9,1;]"..
			"list[detached:creative;main;0.5,2.5;9,4;"..tostring(start_i).."]"..
			"label[7.25,1.7;"..tostring(pagenum).."/"..tostring(pagemax).."]"..
			"button[5.5,1.5;1.5,1;creative_prev;<<]"..
			"button[8,1.5;1.5,1;creative_next;>>]"..
			"button[9.5,8;1.5,1.5;creative_survival;Survival]"
		player:set_inventory_formspec(CREATIVE_SEARCH_ITEMS)
		inventory.hotbar(player)
	end
	if playerdata[player:get_player_name()]['gamemode'] == "Survival" then
		inventory.survival_inv(player)
		inventory.hotbar(player)
	end
end
minetest.register_on_player_receive_fields(function(player, formname, fields)
	if not playerdata[pname]['gamemode'] == "Creative" then
		return
	end
	-- Figure out current page from formspec
	local current_page = 0
	local formspec = player:get_inventory_formspec()
	local start_i = string.match(formspec, "list%[detached:creative;main;[%d.]+,[%d.]+;[%d.]+,[%d.]+;(%d+)%]")
	start_i = tonumber(start_i) or 0

	if fields.clear_inventory then
		local inventory = {}
		player:get_inventory():set_list("main", inventory)
	end
	
	if fields.creative_search then
		creative_type = "search"
	end
	
	if fields.creative_survival then
		creative_type = "default"
		inventory.creative_inv(player)
	end
	
	if fields.creative_prev then
		start_i = start_i - 9*4
	end
	if fields.creative_next then
		start_i = start_i + 9*4
	end

	if start_i < 0 then
		start_i = start_i + 9*4
	end
	if start_i >= inventory.inventory_size then
		start_i = start_i - 9*4
	end
		
	if start_i < 0 or start_i >= inventory.inventory_size then
		start_i = 0
	end
	
	inventory.set_player_formspec(player, start_i, start_i / (9*4) + 1)
end)

if minetest.setting_getbool("creative_mode")==false then
	local gm_priv = true
elseif minetest.setting_getbool("creative_mode")==true then
	local gm_priv = false
end

minetest.register_chatcommand('gamemode',{
	params = "1, c | 0, s",
	description = 'Switch your gamemode',
	privs = {gamemode = gm_priv},
	func = function(name, param)
		if param == "1" or param == "c" then
			playerdata[name]['gamemode'] = "Creative"
			save_player_data()
			minetest.chat_send_player(name, 'Your gamemode is now: '..playerdata[name]['gamemode'])
			updategamemode(name)
		elseif param == "0" or param == "s" then
			playerdata[name]['gamemode'] = "Survival"
			save_player_data()
			minetest.chat_send_player(name, 'Your gamemode is now: '..playerdata[name]['gamemode'])
			updategamemode(name)
		else
			minetest.chat_send_player(name, "Error: That player does not exist!")
			return false
		end
	end
})


--[[minetest.register_on_punchnode(function(pos, node, puncher)
	local pos = pos
	local pname = puncher:get_player_name()
	if playerdata[pname]['gamemode'] == "Creative" then
	minetest.after(0.1, function()
	minetest.env:remove_node(pos)
	end)
	end
end)]]

minetest.register_on_placenode(function(pos, newnode, placer, oldnode, itemstack)
	local pname = placer:get_player_name()
	if playerdata[pname]['gamemode'] == "Creative" then
	return true
	end
end)

minetest.register_privilege("gamemode", "Permission to use /gamemode.")
