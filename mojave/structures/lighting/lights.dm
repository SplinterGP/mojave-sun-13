/obj/machinery/light/ms13
	name = "light fixture"
	icon = 'mojave/icons/structure/lighting.dmi'
	overlay_icon = 'mojave/icons/structure/lighting_overlay.dmi'
	base_state = "light_tube"
	icon_state = "light_tube"
	desc = "A lighting fixture."
	max_integrity = 100
	brightness = 6
	bulb_power = 0.9
	bulb_colour = "#e9d8b2"
	light_type = /obj/item/light/ms13/tube
	fitting = "tube"
	start_with_cell = FALSE
	no_emergency = TRUE

/obj/machinery/light/ms13/deconstruct(disassembled = TRUE)
	if(flags_1 & NODECONSTRUCT_1)
		qdel(src)
		return
	var/obj/structure/light_construct/new_light = null
	switch(fitting)
		if("tube")
			new_light = new /obj/machinery/light/ms13/built(loc)
			new_light.pixel_x = pixel_x
			new_light.pixel_y = pixel_y

		if("bulb")
			new_light = new /obj/machinery/light/ms13/bulb/built(loc)
			new_light.pixel_x = pixel_x
			new_light.pixel_y = pixel_y

	new_light.setDir(dir)
	if(!disassembled)
		new_light.take_damage(new_light.max_integrity * 0.5, sound_effect=FALSE)
		if(status != LIGHT_BROKEN)
			break_light_tube()
		if(status != LIGHT_EMPTY)
			drop_light_tube()
	transfer_fingerprints_to(new_light)
	qdel(src)

/obj/machinery/light/ms13/Initialize(mapload) //shoutout to the shartcoder that coded in lights backwards
	. = ..()
	switch(dir)
		if(SOUTH)
			pixel_y = -2
		if(NORTH)
			pixel_y = 35
		if(WEST)
			pixel_x = -16
			pixel_y = 16
		if(EAST)
			pixel_x = 16
			pixel_y = 16

/obj/machinery/light/ms13/broken
	icon_state = "light_tube-broken"
	status = LIGHT_BROKEN

/obj/machinery/light/ms13/built
	icon_state = "light_tube-empty"
	status = LIGHT_EMPTY

/obj/machinery/light/ms13/bulb
	base_state = "light_bulb"
	icon_state = "light_bulb"
	max_integrity = 35
	brightness = 5
	bulb_power = 0.8
	bulb_colour = "#ddd2b9"
	light_type = /obj/item/light/ms13/bulb
	fitting = "bulb"

/obj/machinery/light/ms13/bulb/broken
	icon_state = "light_bulb-broken"
	status = LIGHT_BROKEN

/obj/machinery/light/ms13/bulb/built
	icon_state = "light_bulb-empty"
	status = LIGHT_EMPTY

/obj/machinery/light/ms13/bulb/industrial
	base_state = "light_bulb_indust"
	icon_state = "light_bulb_indust"
	max_integrity = 55
	brightness = 5

/obj/machinery/light/ms13/bulb/industrial/broken
	icon_state = "light_bulb_indust-broken"
	status = LIGHT_BROKEN

/obj/machinery/light/ms13/bulb/industrial/built
	icon_state = "light_bulb_indust-empty"
	status = LIGHT_EMPTY

// Light items (bulbs and stuff) //

/obj/item/light/ms13
	icon = 'mojave/icons/objects/construction/construction_world.dmi'
	force = 2
	throwforce = 5

/obj/item/light/ms13/Initialize()
	. = ..()
	AddElement(/datum/element/inworld_sprite, 'mojave/icons/objects/construction/construction_inventory.dmi')

/obj/item/light/ms13/tube
	name = "light tube"
	desc = "A tube used for lighting."
	icon_state = "ltube"
	base_state = "ltube"
	inhand_icon_state = "c_tube"
	brightness = 7

/obj/item/light/ms13/tube/broken
	status = LIGHT_BROKEN

/obj/item/light/ms13/tube/burned
	status = LIGHT_BURNED

/obj/item/light/ms13/bulb
	name = "light bulb"
	desc = "A light bulb that can be screwed into a fixture."
	icon_state = "lbulb"
	base_state = "lbulb"
	inhand_icon_state = "contvapour"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	brightness = 4.5

/obj/item/light/ms13/bulb/broken
	status = LIGHT_BROKEN

/obj/item/light/ms13/bulb/burned
	status = LIGHT_BURNED
