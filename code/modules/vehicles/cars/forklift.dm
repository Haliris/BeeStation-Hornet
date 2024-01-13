//forklift
/obj/vehicle/sealed/car/forklift
	name = "forklift"
	desc = "a forklift used to used for lifting and moving crates around."
	iconstate = "pussywagon"
	key_type = /obj/item/key/forklift
	var/cratestack
	var/forks_down = TRUE
	var/crateload = FALSE

/obj/vehicle/sealed/car/Initialize(mapload)
	. = ..()
	update_icon()anchored
	var/datum/component/riding/D = LoadComponent(/datum/component/riding)
	//properly configure riding component and offset

/obj/vehicle/sealed/car/forklift/proc/add_crate(obj/O)
	if(!istype(O))
		return FALSE
	cratestack = O
	return TRUE

/obj/vehicle/sealed/car/forklift/proc/load_crate()

/obj/vehicle/sealed/car/foklift/proc/remove_crate(obj/O)
	if(!istype(O))
		return FALSE
	cratestack = NULL
	return TRUE

/obj/vehicle/sealed/car/forklift/proc/crate_exit(obj/O,  silent = FALSE, randomstep = FALSE)
	if(!istype(O))
		return FALSE
	remove_crate(O)
	O.forceMove(exit_location(O))
		var/turf/target_turf = get_step(exit_location(O), pick(GLOB.cardinals))
		O.throw_at(target_turf, 5, 10)
	if(!silent)
		M.visible_message("<span class='notice'>[O] drops out of \the [src]!</span>")
	return TRUE

/obj/vehicle/sealed/car/forklift/proc/toggleForks()
	if(!forks_down)
		forks_down = TRUE
		if(cratestack != NULL)
			remove_crate()

	else
		forks_down = FALSE
		if(crate_load)
			add_crate()

/obj/vehicle/sealed/car/forklift/Bump(atom/movable/M)
	. = ..()
	if(istype(M, /obj/structure/closet/crate) && forks_down)
		//add the crate(s) to the forks
		M.anchored = FALSE
		load_crate()
		update_icon() //find a way to displace the crates on the forks




/obj/vehicle/sealed/car/forklift/destroy()
	//Set the forklift to drop its load when destroy is called on it
	crate_exit()
	. = ..()

/obj/vehicle/sealed/car/forklift/update_icon()
	cut_overlays()
	//add upgrades if some are made

// Forklift will load crates if prongs are lowered and it makes contact with a crate.
