/mob/living/simple_animal/hostile/monster

/mob/living/simple_animal/hostile/monster/necromorph
	name = "necromorph"
	desc = "A twisted husk of what was once a human, repurposed to kill."
	speak_emote = list("roars")
	icon = 'icons/mob/monster_big.dmi'
	icon_state = "nmorph_standard"
	icon_living = "nmorph_standard"
	icon_dead = "nmorph_dead"
	health = 80
	maxHealth = 80
	melee_damage_lower = 25
	melee_damage_upper = 50
	attacktext = "slashes"
	attack_sound = 'sound/weapons/bladeslice.ogg'
	faction = "creature"
	speed = 4
	size = SIZE_BIG
	move_to_delay = 4

	min_oxy = 0
	max_oxy = 0
	min_tox = 0
	max_tox = 0
	min_co2 = 0
	max_co2 = 0
	min_n2 = 0
	max_n2 = 0
	minbodytemp = 0
	var/stance_step = 0

/mob/living/simple_animal/hostile/monster/skrite
	name = "skrite"
	desc = "A highly predatory being with two dripping claws."
	icon_state = "skrite"
	icon_living = "skrite"
	icon_dead = "skrite_dead"
	icon_gib = "skrite_dead"
	speak = list("SKREEEEEEEE!","SKRAAAAAAAAW!","KREEEEEEEEE!")
	speak_emote = list("screams", "shrieks")
	emote_hear = list("snarls")
	emote_see = list("lets out a scream", "rubs its claws together")
	speak_chance = 20
	turns_per_move = 5
	see_in_dark = 6
	meat_type = /obj/item/weapon/reagent_containers/food/snacks/meat
	maxHealth = 150
	health = 150
	melee_damage_lower = 10
	melee_damage_upper = 30
	attack_sound = 'sound/effects/lingstabs.ogg'
	attacktext = "uses its blades to stab"
	projectiletype = /obj/item/projectile/energy/neurotox
	projectilesound = 'sound/weapons/pierce.ogg'
	ranged = 1
	move_to_delay = 7

/obj/item/projectile/energy/neurotox
	damage = 10
	damage_type = TOX
	icon_state = "toxin"

/mob/living/simple_animal/hostile/monster/cyber_horror
	name = "cyber horror"
	desc = "What was once a man, twisted and warped by machine."
	icon_state = "cyber_horror"
	icon_dead = "cyber_horror_dead"
	icon_gib = "cyber_horror_dead"
	speak = list("H@!#$$P M@!$#", "GHAA!@@#", "KR@!!N", "K!@@##L!@@ %!@#E", "G@#!$ H@!#%, H!@%%@ @!E")
	speak_emote = list("emits", "groans")
	speak_chance = 30
	turns_per_move = 5
	see_in_dark = 6
	maxHealth = 70
	health = 70
	melee_damage_lower = 5
	melee_damage_upper = 15
	attacktext = "flails around and hits"
	move_to_delay = 5
	can_butcher = 0
	attack_sound = 'sound/weapons/hivehand_empty.ogg'

	var/emp_damage = 0
	var/nanobot_chance = 20

/mob/living/simple_animal/hostile/monster/cyber_horror/Life(var/mob/living/simple_animal/hostile/monster/cyber_horror/M)
	..()

	if(prob(90) && health+emp_damage<maxHealth)
		health+=2                                                                        //Created by misuse of medical nanobots, so it heals
		if(prob(15))
			visible_message("<span class='warning'>[src]'s wounds heal slightly!</span>")

/mob/living/simple_animal/hostile/monster/cyber_horror/emp_act(severity)
	if(flags & INVULNERABLE)
		return

	switch (severity)
		if (1)
			adjustBruteLoss(40)
			emp_damage+=40
			emote("lets out a horrible digital scream!")

		if (2)
			adjustBruteLoss(20)
			emp_damage+=20
			emote("lets out a horrible digital scream!")

/mob/living/simple_animal/hostile/monster/cyber_horror/AttackingTarget()
	..()
	var/mob/living/L = target
	if(L.reagents)
		if(prob(nanobot_chance))
			visible_message("<b><span class='warning'>[src] injects something from its flailing arm!</span>")
			L.reagents.add_reagent("mednanobots", 2)

/mob/living/simple_animal/hostile/monster/cyber_horror/Die()
	..()
	visible_message("<b>[src]</b> blows apart!")
	new /obj/effect/gibspawner/robot(src.loc)
	qdel(src)
	return
