Minetest 0.4 mod: localisation
==============================

License of source code:
-----------------------
Copyright (C) 2011-2012 Jonjeg <jonathan.jegouzo@gmail.com>

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU Lesser General Public License as published by
the Free Software Foundation; either version 2 of the License, or
(at your option) any later version.

http://www.gnu.org/licenses/lgpl-2.1.html

Description:
------------
This mod allow mod devellopers to publish their mod in differents 
language with less work needed.

Usage:
------
The minetest setting 'language' is set to EN when this mod is first loaded.
You can modify this setting in your minetest.conf.
If no translation is found for a message, his english counterpart is used instead.
If no english counterpart are found, then no error are thrown but an error message is returned instead of the translation.

Exemple(Code lua) :
-------------------
	local translations = {
		EN = {
			message1 = "english version",
			message_with_parameter = "$1 will be replaced by the first additionnal parameter",
			message_existing_in_english_only = "lorem ipsum"
			...etc
		},
		FR = {
			message1 = "version française"
			message_with_parameter = "$1 va être remplacé par la 1ère valeur additionnelle"
			message_with_some_parameters = "$1,$2,$3"
		}
	}
    -- Registering the translations
    localisation.register_translations("your_mod_name",your_var_containing_translations)
    
	localisation.translate("your_mod_name:message1") -> "english version" -- si language = EN
	localisation.translate("your_mod_name:message1") -> "version française" -- si language = FR
	localisation.translate("your_mod_name:message1") -> "english version" -- si language = other than FR
	localisation.translate("your_mod_name:message_existing_in_english_only") -> "lorem ipsum"
	localisation.translate("your_mod_name:message_with_parameter","value") -> "value will be replaced by the first additionnal parameter" -- si language = EN
	localisation.translate("your_mod_name:message_with_parameter","value") -> "value va être remplacé par la 1ère valeur additionnelle" -- si language = FR
	localisation.translate("your_mod_name:message_with_some_parameters","value",2,3.5) -> "value,2,3.5"
	localisation.translate("your_mod_name:message_inexistant","value",2,3.5) -> "Translate(EN,message_inexistant) = No translations available" -- si language = EN
	localisation.translate("bad_message_without_mod_name","value",2,3.5) -> "No mod_name specified or other error message"
    
Language Patching
-----------------

If you want to translate a mod using this mod, it's possible.
Create a mod and/or specify the mod_name in the depends.txt and and register your translation with the mod_name.
The messages that wont be patched will be the messages that are used before the initialisation of the patch mod.

Exemple 
-------
If you want to add another language support(DE by exemple) to this mod(localisation), you can do it like that
local translations = {
    EN = {
        no_translation_available = "new english message, just because",
    },
    DE = {
        no_translation_available = "...",
        no_translation_registered_for_mod = "...",
    }
}
localisation.translate("localisation:no_translation_available") = <previous message>
localisation.register_translations("localisation",translations)
localisation.translate("localisation:no_translation_available") = "new english message, just because"
