---------------------------------------------------------------------------------------
-- straw - a very basic material
---------------------------------------------------------------------------------------
--  * straw mat - for animals and very poor NPC; also basis for other straw things
--  * straw bale - well, just a good source for building and decoration

local S = cottages.S

local cottages_can_use = function(meta, player)
	if(not(player) or not(meta)) then
		return false;
	end
	local pname = player:get_player_name();
	local owner = meta:get_string('owner');
	if(not(owner) or owner=="" or owner==pname) then
		return true;
	end
	return false;
end


-- an even simpler from of bed - usually for animals 
-- it is a nodebox and not wallmounted because that makes it easier to replace beds with straw mats
minetest.register_node("cottages:straw_mat", {
	description = S("Layer of straw"),
	drawtype = 'nodebox',
	tiles = { 'cottages_darkage_straw.png' }, -- done by VanessaE
	wield_image = 'cottages_darkage_straw.png',
	inventory_image = 'cottages_darkage_straw.png',
	sunlight_propagates = true,
	paramtype = 'light',
	paramtype2 = "facedir",
	walkable = false,
	groups = {hay = 3, snappy = 2, oddly_breakable_by_hand = 2, flammable = 3},
	sounds = default.node_sound_leaves_defaults,
	node_box = {
		type = "fixed",
		fixed = {
					{-0.48, -0.5,-0.48,  0.48, -0.45, 0.48},
			}
	},
	selection_box = {
		type = "fixed",
		fixed = {
					{-0.48, -0.5,-0.48,  0.48, -0.25, 0.48},
			}
	},
	is_ground_content = false,
	on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
		return cottages.sleep_in_bed(pos, node, clicker, itemstack, pointed_thing);
	end
})

-- straw bales are a must for farming environments; if you for some reason do not have the darkage mod installed, this here gets you a straw bale
minetest.register_node("cottages:straw_bale", {
	drawtype = "nodebox",
	description = S("Straw bale"),
	tiles = {"cottages_darkage_straw_bale.png"},
	paramtype = "light",
	groups = {hay = 3, snappy = 1, choppy = 2, oddly_breakable_by_hand = 2, flammable = 3, roof = 1},
	sounds = default.node_sound_wood_defaults,
	-- the bale is slightly smaller than a full node
	node_box = {
		type = "fixed",
		fixed = {
					{-0.45, -0.5,-0.45,  0.45,  0.45, 0.45},
			}
	},
	selection_box = {
		type = "fixed",
		fixed = {
					{-0.45, -0.5,-0.45,  0.45,  0.45, 0.45},
			}
	},
	is_ground_content = false,
})

-- just straw
minetest.register_node("cottages:straw", {
	drawtype = "normal",
	description = S("Straw block"),
	tiles = {"cottages_darkage_straw.png"},
	groups = {hay = 3, snappy = 3, choppy = 3, oddly_breakable_by_hand = 3, flammable = 3, roof = 1},
	sounds = default.node_sound_wood_defaults,
	-- the bale is slightly smaller than a full node
	is_ground_content = false,
})

-- dark-colored straw
minetest.register_node("cottages:straw_dark", {
	drawtype = "normal",
	description = S("Dark straw block"),
	tiles = {"cottages_dark_straw.png"},
	groups = {hay = 3, snappy = 3, choppy = 3, oddly_breakable_by_hand = 3, flammable = 3, roof = 1},
	sounds = default.node_sound_wood_defaults,
	-- the bale is slightly smaller than a full node
	is_ground_content = false,
})


--
-- -------------------- EQUIPMENT -------------------
--

-- "size[8,8]"..
-- 			"image[3.5,2.5;1,1;"..cottages.texture_stick.."]"..
-- 			"image[0,1;1,1;farming_wheat.png]"..
-- 			"list[context;harvest;1,1;2,1;]"..
-- 			"list[context;straw;6,0;2,2;]"..
-- 			"list[context;seeds;6,2;2,2;]"..
-- 			"label[1,0.5;"..S("Harvested wheat:").."]"..
-- 			"label[5,0.0;"..S("Straw:").."]"..
-- 			"label[5,2.0;"..S("Seeds:").."]"..
-- 			"label[0,0;"..S("Threshing floor").."]"..
-- 			"label[0,2.5;"..S("Punch threshing floor with a stick").."]"..
-- 			"label[0,3.0;"..S("to get straw and seeds from wheat.").."]"..
-- 			"list[current_player;main;0,4;8,4;]";

local cottages_formspec_treshing_floor = 
			"size[8,8]"..
			"image[3.5,2.5;1,1;"..cottages.texture_stick.."]"..
			"image[0,1;1,1;farming_wheat.png]"..
			"button_exit[3,1;2,1;public;"..S("Public?").."]"..
			"list[current_name;harvest;1,1;2,1;]"..
			"list[current_name;straw;6,0;2,2;]"..
			"list[current_name;seeds;6,2;2,2;]"..
			"label[1,0.5;"..S("Harvested wheat:").."]"..
			"label[5,0.0;"..S("Straw:").."]"..
			"label[5,2.0;"..S("Seeds:").."]"..
			"label[0,0;"..S("Threshing floor").."]"..
			"label[0,2.5;"..S("Punch threshing floor with a stick").."]"..
			"label[0,3.0;"..S("to get straw and seeds from wheat.").."]"..
			"list[current_player;main;0,4;8,4;]";

minetest.register_node("cottages:threshing_floor", {
	drawtype = "nodebox",
	description = S("threshing floor"),
-- TODO: stone also looks pretty well for this
	tiles = {"cottages_junglewood.png^farming_wheat.png","cottages_junglewood.png","cottages_junglewood.png^"..cottages.texture_stick},
	paramtype  = "light",
	paramtype2 = "facedir",
	-- can be dug with axe and pick
	groups = {cracky=2, choppy=2},
	is_ground_content = false,
	node_box = {
		type = "fixed",
		fixed = {
					{-0.50, -0.5,-0.50, 0.50, -0.40, 0.50},

					{-0.50, -0.4,-0.50,-0.45, -0.20, 0.50},
					{ 0.45, -0.4,-0.50, 0.50, -0.20, 0.50},

					{-0.45, -0.4,-0.50, 0.45, -0.20,-0.45},
					{-0.45, -0.4, 0.45, 0.45, -0.20, 0.50},
			}
	},
	selection_box = {
		type = "fixed",
		fixed = {
					{-0.50, -0.5,-0.50, 0.50, -0.20, 0.50},
			}
	},
	on_construct = function(pos)
		local meta = minetest.get_meta(pos);
		meta:set_string("infotext", S("Public threshing floor"));
		local inv = meta:get_inventory();
		inv:set_size("harvest", 2);
		inv:set_size("straw", 4);
		inv:set_size("seeds", 4);
		meta:set_string("formspec", cottages_formspec_treshing_floor);
		meta:set_string("public", "public")
	end,

	after_place_node = function(pos, placer)
		local meta = minetest.get_meta(pos);
		meta:set_string("owner", placer:get_player_name() or "");
		meta:set_string("infotext", S("Private threshing floor (owned by %s)"):format(meta:get_string("owner") or ""));
		meta:set_string("formspec",
				cottages_formspec_treshing_floor..
				"label[2.5,0;"..S("Owner: %s"):format(meta:get_string("owner") or "").."]");
		meta:set_string("public", "private")
	end,

	on_receive_fields = function(pos, formname, fields, sender)
		cottages.switch_public(pos, formname, fields, sender, 'threshing floor')
	end,

	can_dig = function(pos,player)
		local meta  = minetest.get_meta(pos);
		local inv   = meta:get_inventory();
		local owner = meta:get_string('owner');

		if( not(inv:is_empty("harvest"))
		  or not(inv:is_empty("straw"))
		  or not(inv:is_empty("seeds"))
		  or not(player)
		  or (owner and owner ~= ''  and player:get_player_name() ~= owner)) then
			return false;
		end
			return true;
	end,

	allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		local meta = minetest.get_meta(pos)
		if(not(cottages.player_can_use(meta, player))) then
			return 0
		end
		return count;
	end,

	allow_metadata_inventory_put = function(pos, listname, index, stack, player)
		local meta = minetest.get_meta(pos)
		-- only accept input the threshing floor can use/process
		if(   listname=='straw'
			or listname=='seeds' 
			or (listname=='harvest' and stack and not cottages.threshing_product[ stack:get_name() ])) then
				return 0;
		end

		if(not(cottages.player_can_use(meta, player))) then
			return 0
		end
		return stack:get_count()
	end,

	allow_metadata_inventory_take = function(pos, listname, index, stack, player)
		local meta = minetest.get_meta(pos)
		if(not(cottages.player_can_use(meta, player))) then
			return 0
		end
		return stack:get_count()
	end,


	on_punch = function(pos, node, puncher)
		if(not(pos) or not(node) or not(puncher)) then
			return;
		end
		-- only punching with a normal stick is supposed to work
		local wielded = puncher:get_wielded_item();
		if(   not(wielded)
		    or not(wielded:get_name())
		    or not(minetest.registered_items[ wielded:get_name() ])
		    or not(minetest.registered_items[ wielded:get_name() ].groups)
		    or not(minetest.registered_items[ wielded:get_name() ].groups.stick)) then
			return;
		end
		local name = puncher:get_player_name();

		local meta = minetest.get_meta(pos);
		local inv = meta:get_inventory();

		local input = inv:get_list('harvest');
		-- we have two input slots
		local stack1 = inv:get_stack('harvest', 1);
		local stack2 = inv:get_stack('harvest', 2);

		-- Check for empty or wrong content
		if ((stack1:is_empty() and stack2:is_empty())
			or (not(stack1:is_empty()) and not cottages.threshing_product[ stack1:get_name() ])
			or (not(stack2:is_empty()) and not cottages.threshing_product[ stack2:get_name() ])) then
			
			minetest.chat_send_player(name, S("Threshing floor is empty or cannot process the contents"));
			-- update the formspec
			meta:set_string("formspec",
				cottages_formspec_treshing_floor..
				"label[2.5,0;"..S("Owner: %s"):format(meta:get_string("owner") or "").."]");
			return
		end
		
		-- Check for content mismatch
		if (not stack1:is_empty() and not stack2:is_empty() and 
			cottages.threshing_product[ stack1:get_name() ] ~= cottages.threshing_product[ stack2:get_name() ]) then
			
				minetest.chat_send_player(name, S("Threshing floor must be loaded with one type of grain"));
				meta:set_string("formspec",
					cottages_formspec_treshing_floor..
					"label[2.5,0;"..S("Owner: %s"):format(meta:get_string("owner") or "").."]");
			return
		end
		
		local input_material = stack1:get_name() or stack2:get_name()
		
		-- should not be possible, but better safe than sorry
		if not input_material then
			return
		end
		
		-- on average, process 25 wheat (or compatible equivalent) at each punch (10..40 are possible)
		local grain_to_process = 10 + math.random(0, 30);
		-- we already made sure there is only wheat (or compatible equivalent) inside
		local grain_found = stack1:get_count() + stack2:get_count();
		
		-- do not process more grain than present in the input slots
		if(grain_found < grain_to_process) then
			grain_to_process = grain_found;
		end

		local overlay1 = "^farming_wheat.png";
		local overlay2 = "^"..cottages.straw_texture;
		local overlay3 = "^"..cottages.texture_wheat_seed;

		-- this can be enlarged by a multiplicator if desired
		local output_straw = grain_to_process;
		local output_seeds = grain_to_process;

		if (inv:room_for_item('straw','cottages:straw_mat '..tostring(output_straw))
			and inv:room_for_item('seeds',cottages.craftitem_seed_wheat..' '..tostring(output_seeds))) then

			-- the player gets two kind of output, straw...
			inv:add_item("straw", 'cottages:straw_mat '..tostring(output_straw));
			-- add seeds depending on what was loaded in the threshing floor
			local out=cottages.threshing_product[input_material]
			if type(out)=="table" then
				local o1={}
				local k1, n1 
				for n1=1,output_seeds do
					k1=math.random(1,#out)
					if type(o1[k1])=="number" then
						o1[k1]=o1[k1]+1
					else
						o1[k1]=1
					end
				end
				for n1=1,#out do
					if type(o1[n1])=="number" then
						inv:add_item("seeds", out[n1]..' '..tostring(o1[n1]));
					end
				end
			else
				inv:add_item("seeds", out..' '..tostring(output_seeds));
			end
			-- consume the wheat (or whatever is being processed)
			inv:remove_item("harvest", input_material..' '..tostring(grain_to_process));

			local grain_left = grain_found - grain_to_process;
			if(grain_left > 0) then
--				minetest.chat_send_player(name, S('You have threshed %s wheat (%s are left).'):format(grain_to_process,grain_left));
			else
--				minetest.chat_send_player(name, S('You have threshed the last %s wheat.'):format(grain_to_process));
				overlay1 = "";
			end
		end

		local hud0 = puncher:hud_add({
			hud_elem_type = "image",
			scale = {x = 38, y = 38},
			text = "cottages_junglewood.png^[colorize:#888888:128",
			position = {x = 0.5, y = 0.5},
			alignment = {x = 0, y = 0}
		});

		local hud1 = puncher:hud_add({
			hud_elem_type = "image",
			scale = {x = 15, y = 15},
			text = "cottages_junglewood.png"..overlay1,
			position = {x = 0.4, y = 0.5},
			alignment = {x = 0, y = 0}
		});
		local hud2 = puncher:hud_add({
			hud_elem_type = "image",
			scale = {x = 15, y = 15},
			text = "cottages_junglewood.png"..overlay2,
			position = {x = 0.6, y = 0.35},
			alignment = {x = 0, y = 0}
		});
		local hud3 = puncher:hud_add({
			hud_elem_type = "image",
			scale = {x = 15, y = 15},
			text = "cottages_junglewood.png"..overlay3,
			position = {x = 0.6, y = 0.65},
			alignment = {x = 0, y = 0}
		});

		local hud4 = puncher:hud_add({
			hud_elem_type = "text",
			text = tostring(grain_found-grain_to_process),
			number = 0x00CC00,
			alignment = {x = 0, y = 0},
			scale = {x = 100, y = 100}, -- bounding rectangle of the text
			position = {x = 0.4, y = 0.5},
		});
		if(not(output_straw)) then
			output_straw = "0";
		end
		if(not(output_seeds)) then
			output_seeds = "0";
		end
		local hud5 = puncher:hud_add({
			hud_elem_type = "text",
			text = '+ '..tostring(output_straw)..' straw',
			number = 0x00CC00,
			alignment = {x = 0, y = 0},
			scale = {x = 100, y = 100}, -- bounding rectangle of the text
			position = {x = 0.6, y = 0.35},
		});
		local hud6 = puncher:hud_add({
			hud_elem_type = "text",
			text = '+ '..tostring(output_seeds)..' seeds',
			number = 0x00CC00,
			alignment = {x = 0, y = 0},
			scale = {x = 100, y = 100}, -- bounding rectangle of the text
			position = {x = 0.6, y = 0.65},
		});



		minetest.after(2, function()
			if(puncher) then
				puncher:hud_remove(hud1);
				puncher:hud_remove(hud2);
				puncher:hud_remove(hud3);
				puncher:hud_remove(hud4);
				puncher:hud_remove(hud5);
				puncher:hud_remove(hud6);
				puncher:hud_remove(hud0);
			end
		end)
	end,
})


                                                  
local cottages_handmill_formspec = "size[8,8]"..
				"image[0,1;1,1;"..cottages.texture_wheat_seed.."]"..
				"button_exit[6.0,0.0;1.5,0.5;public;"..S("Public?").."]"..
				"list[current_name;seeds;1,1;1,1;]"..
				"list[current_name;flour;5,1;2,2;]"..
				"label[0,0.5;"..S("Wheat seeds:").."]"..
				"label[4,0.5;"..S("Flour:").."]"..
				"label[0,0;"..S("Mill").."]"..
				"label[0,2.5;"..S("Punch this hand-driven mill").."]"..
				"label[0,3.0;"..S("to convert wheat seeds into flour.").."]"..
				"list[current_player;main;0,4;8,4;]";

minetest.register_node("cottages:handmill", {
	description = S("mill, powered by punching"),
	drawtype = "mesh",
	mesh = "cottages_handmill.obj",
	tiles = {"cottages_stone.png"},
	paramtype  = "light",
	paramtype2 = "facedir",
	groups = {cracky=2},
	is_ground_content = false,
	selection_box = {
		type = "fixed",
		fixed = {
					{-0.50, -0.5,-0.50, 0.50,  0.25, 0.50},
			}
	},
	collision_box = {
		type = "fixed",
		fixed = {
					{-0.50, -0.5,-0.50, 0.50,  0.25, 0.50},
			}
	},
	on_construct = function(pos)
		local meta = minetest.get_meta(pos);
		meta:set_string("infotext", S("Public mill, powered by punching"));
		local inv = meta:get_inventory();
		inv:set_size("seeds", 1);
		inv:set_size("flour", 4);
		meta:set_string("formspec", cottages_handmill_formspec);
		meta:set_string("public", "public")
	end,

	after_place_node = function(pos, placer)
		local meta = minetest.get_meta(pos);
		meta:set_string("owner", placer:get_player_name() or "");
		meta:set_string("infotext", S("Private mill, powered by punching (owned by %s)"):format(meta:get_string("owner") or ""));
		meta:set_string("formspec",
				cottages_handmill_formspec..
				"label[2.5,0;"..S("Owner: %s"):format(meta:get_string('owner') or "").."]");
		meta:set_string("public", "private")
	end,

	on_receive_fields = function(pos, formname, fields, sender)
		cottages.switch_public(pos, formname, fields, sender, 'mill, powered by punching')
	end,

	can_dig = function(pos,player)
		local meta  = minetest.get_meta(pos);
		local inv   = meta:get_inventory();
		local owner = meta:get_string('owner');

		if( not(inv:is_empty("flour"))
			or not(inv:is_empty("seeds"))
			or not(player)
			or (owner and owner ~= ''  and player:get_player_name() ~= owner)) then
				return false;
		end
			return true;
	end,

	allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		local meta = minetest.get_meta(pos)
		if(not(cottages.player_can_use(meta, player))) then
			return 0
		end
		return count;
	end,

	allow_metadata_inventory_put = function(pos, listname, index, stack, player)
		local meta = minetest.get_meta(pos)
		-- only accept input the threshing floor can use/process
		if(   listname=='flour'
		    or (listname=='seeds' and stack and not(cottages.handmill_product[ stack:get_name()]))) then
			return 0;
		end

		if(not(cottages.player_can_use(meta, player))) then
			return 0
		end
		return stack:get_count()
	end,

	allow_metadata_inventory_take = function(pos, listname, index, stack, player)
		local meta = minetest.get_meta(pos)
		if(not(cottages.player_can_use(meta, player))) then
			return 0
		end
		return stack:get_count()
	end,

	-- this code is very similar to the threshing floor; except that it has only one input- and output-slot
	-- and does not require the usage of a stick
	on_punch = function(pos, node, puncher)
		if(not(pos) or not(node) or not(puncher)) then
			return;
		end
		local name = puncher:get_player_name();

		local meta = minetest.get_meta(pos);
		local inv = meta:get_inventory();

		local input = inv:get_list('seeds');
		local stack1 = inv:get_stack('seeds', 1);

		if ((stack1:is_empty()) or (not(stack1:is_empty())
			and not (cottages.handmill_product[ stack1:get_name() ]))) then

			if not(stack1:is_empty()) then
				minetest.chat_send_player(name,"Nothing happens...")
			end
			-- update the formspec
			meta:set_string("formspec",
				cottages_handmill_formspec..
				"label[2.5,0;"..S("Owner: %s"):format(meta:get_string('owner') or "").."]");
			return;
		end

		-- turning the mill is a slow process; 1-21 flour are generated per turn
		local output = 1 + math.random(cottages.handmill_min_per_turn, cottages.handmill_max_per_turn);
		-- we already made sure there is only wheat inside
		local found = stack1:get_count();
		
		-- do not process more wheat than present in the input slots
		if(found < output) then
			output = found;
		end

		local product_stack = ItemStack(cottages.handmill_product[ stack1:get_name() ]);
		local output_result = output;
		-- items that produce more
		if(product_stack:get_count()> 1) then
			output_result = output * product_stack:get_count();
		end

		if(   inv:room_for_item('flour', product_stack:get_name()..' '..tostring(output_result))) then

			inv:add_item('flour', product_stack:get_name()..' '..tostring(output_result));
			inv:remove_item('seeds', stack1:get_name()..' '..tostring(output));

			local grain_left = found - output;
			if(grain_left > 0) then
				minetest.chat_send_player(name, S('You have ground a %s (%s are left).'):format(stack1:get_definition().description,(grain_left)));
			else
				minetest.chat_send_player(name, S('You have ground the last %s.'):format(stack1:get_definition().description));
			end

			-- if the version of MT is recent enough, rotate the mill a bit
			if(minetest.swap_node) then
				node.param2 = node.param2 + 1;
				if(node.param2 > 3) then
					node.param2 = 0;
				end
				minetest.swap_node(pos, node);
			end
		end	
	end,
})




---------------------------------------------------------------------------------------
-- crafting receipes
---------------------------------------------------------------------------------------
-- this returns corn as well
-- the replacements work only if the replaced slot gets empty...
minetest.register_craft({
	output = "cottages:straw_mat 6",
	recipe = {
                {cottages.craftitem_stone,'',''},
		{"farming:wheat", "farming:wheat", "farming:wheat", },
	},
        replacements = {{ cottages.craftitem_stone, cottages.craftitem_seed_wheat.." 3" }},  
})

-- this is a better way to get straw mats
minetest.register_craft({
	output = "cottages:threshing_floor",
	recipe = {
		{cottages.craftitem_junglewood, cottages.craftitem_chest_locked, cottages.craftitem_junglewood, },
		{cottages.craftitem_junglewood, cottages.craftitem_stone,        cottages.craftitem_junglewood, },
	},
})

-- and a way to turn wheat seeds into flour
minetest.register_craft({
	output = "cottages:handmill",
	recipe = {
		{cottages.craftitem_stick,     cottages.craftitem_stone,    "", },
		{"",               cottages.craftitem_steel, "", },
		{"",                  cottages.craftitem_stone,    "", },
	},
})

minetest.register_craft({
	output = "cottages:straw_bale",
	recipe = {
		{"cottages:straw_mat"},
		{"cottages:straw_mat"},
		{"cottages:straw_mat"},
	},
})

minetest.register_craft({
	output = "cottages:straw",
	recipe = {
		{"cottages:straw_mat", "cottages:straw_mat", "cottages:straw_mat"}
	},
})


minetest.register_craft({
	output = "cottages:straw",
	recipe = {
		{"cottages:straw_bale"},
	},
})

minetest.register_craft({
	output = "cottages:straw_bale",
	recipe = {
		{"cottages:straw"},
	},
})

minetest.register_craft({
	output = "cottages:straw_dark 2",
	recipe = {
		{"cottages:straw_bale", "cottages:straw_bale"},
	},
})

minetest.register_craft({
	output = "cottages:straw_mat 3",
	recipe = {
		{"cottages:straw_bale"},
	},
})

-----
-- Straw as fuel
-----

minetest.register_craft({
	type = "fuel",
	recipe = "cottages:straw",
	burntime = 15,
})

minetest.register_craft({
	type = "fuel",
	recipe = "cottages:straw_bale",
	burntime = 20,
})

minetest.register_craft({
	type = "fuel",
	recipe = "cottages:straw_dark",
	burntime = 10,
})


-----
-- Derivative blocks for straw blocks (bale and regular)
-----

cottages.derive_blocks("cottages", 
				"straw_bale", 
				"Straw bale", 
				"cottages_darkage_straw_bale.png", 
				{snappy = 1, choppy = 2, oddly_breakable_by_hand = 2, flammable = 3, roof = 1})

				
cottages.derive_blocks("cottages", 
				"straw", 
				"Straw block", 
				"cottages_darkage_straw.png", 
				{snappy = 3, choppy = 3, oddly_breakable_by_hand = 3, flammable = 3, roof = 1})

cottages.derive_blocks("cottages", 
				"straw_dark", 
				"Dark straw block", 
				"cottages_dark_straw.png", 
				{snappy = 3, choppy = 3, oddly_breakable_by_hand = 3, flammable = 3, roof = 1})
                                                  
