/obj/structure/closet/cardboard
	name = "large cardboard box"
	desc = "Just a box..."
	icon_state = "cardboard"
	mob_storage_capacity = 1
	resistance_flags = FLAMMABLE
	obj_integrity = 70
	max_integrity = 70
	can_weld_shut = 0
	cutting_tool = /obj/item/weapon/wirecutters
	open_sound = 'sound/effects/rustle2.ogg'
	cutting_sound = 'sound/items/poster_ripped.ogg'
	material_drop = /obj/item/stack/sheet/cardboard
	var/move_speed_multiplier = 1
	var/move_delay = 0
	var/egged = 0

/obj/structure/closet/cardboard/relaymove(mob/user, direction)
	if(opened || move_delay || user.stat || user.stunned || user.weakened || user.paralysis || !isturf(loc) || !has_gravity(loc))
		return
	move_delay = 1
	if(step(src, direction))
		spawn(config.walk_speed*move_speed_multiplier)
			move_delay = 0
	else
		move_delay = 0

/obj/structure/closet/cardboard/open()
	if(opened || !can_open())
		return 0
	if(!egged)
		var/mob/living/Snake = null
		for(var/mob/living/L in src.contents)
			Snake = L
			break
		if(Snake)
			var/list/alerted = viewers(7,src)
			if(alerted)
				for(var/mob/living/L in alerted)
					if(!L.stat)
						L.do_alert_animation(L)
						egged = 1
				alerted << sound('sound/machines/chime.ogg')
	..()

/mob/living/proc/do_alert_animation(atom/A)
	var/image/I
	I = image('icons/obj/closet.dmi', A, "cardboard_special", A.layer+1)
	var/list/viewing = list()
	for(var/mob/M in viewers(A))
		if(M.client)
			viewing |= M.client
	flick_overlay(I,viewing,8)
	I.alpha = 0
	animate(I, pixel_z = 32, alpha = 255, time = 5, easing = ELASTIC_EASING)


/obj/structure/closet/cardboard/metal
	name = "large metal box"
	desc = "THE COWARDS! THE FOOLS!"
	icon_state = "metalbox"
	obj_integrity = 500
	mob_storage_capacity = 5
	resistance_flags = 0
	move_speed_multiplier = 2
	cutting_tool = /obj/item/weapon/weldingtool
	open_sound = 'sound/machines/click.ogg'
	cutting_sound = 'sound/items/Welder.ogg'
	material_drop = /obj/item/stack/sheet/plasteel