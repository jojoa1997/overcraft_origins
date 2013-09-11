Minetest 0.4 mod: factions v0.1
===============================

License of source code:
-----------------------
Copyright (C) 2011-2012 Jonjeg <jonathan.jegouzo@gmail.com>

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU Lesser General Public License as published by
the Free Software Foundation; either version 2 of the License, or
(at your option) any later version.

http://www.gnu.org/licenses/lgpl-2.1.html

Dependancies
------------
This mod require my other mod localisation, you can find it at https://github.com/Jonjeg/localisation.

Language support
----------------
EN,FR

Description:
------------
This mod allow players to group as factions,it can be useful for pvp.
Anyone can create his faction.
Faction got a name, a public description, a creation date, a faction channel and can be free to join or private(private par default).
The creator of a faction can kick someone from the faction,invite players in the faction,change the faction description and the access to the faction.
The factions are stored in a txt file in the mod folder and are saved currently each 5min.
These settings can be modified in init.lua in the mod folder.

Usage:
------

type /help faction for help on commands

/faction create <factionname> -> create your faction
/faction list -> list of all factions
/faction info <factionname> -> info on the faction
/faction join <factionname> -> join the faction
/faction leave -> leave your current faction

Faction administration
----------------------

/faction kick <playername> -> kick the player from your faction
/faction invite <playername> -> the player join your faction
/faction disband -> disband the faction
/faction set_free -> allow the players to join freely
/faction description <text> -> change the description text of your faction
/f <msg> for speaking in the faction channel.