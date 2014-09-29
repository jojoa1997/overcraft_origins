-- Commands that are edited to be similiar to Minecraft
-- Copyright(C) @ jojoa1997

minetest.register_chatcommand("timeset", {
	params = "<0...24000>",
	description = "set time of day",
	privs = {settime=true},
	func = function(name, param)
		local newtime = tonumber(param)
		if param == "" then
			return false, "Missing time."
		end
		if param == "day" then
			minetest.set_timeofday((6000 % 24000) / 24000)
			minetest.log("action", name .. " sets time to day")
			return true, "Time of day changed."
		elseif param == "night" then
			minetest.set_timeofday((20000 % 24000) / 24000)
			minetest.log("action", name .. " sets time to night")
			return true, "Time of day changed."
		else
			if newtime == nil then
				return false, "Invalid time."
			end
			minetest.set_timeofday((newtime % 24000) / 24000)
			minetest.log("action", name .. " sets time to "..newtime)
			return true, "Time of day changed."
		end
	end,
})
