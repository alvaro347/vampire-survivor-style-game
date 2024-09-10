extends Node

@export var max_health: float = 100
@export var enemies = {
	basic_enemy = {
		health = 10,
		damage = 5
	}
}

@export var weapons = {
	basic_sword = {
		damage = 50
	}
}

enum Weapon {
	BASIC_SWORD,
	AVANCED_SWORD
}

enum Enemies {
	BASIC,
	SLIME
}

# const BASIC = {
	# health = 50 	# NOTE: It seems that enums are only int values. it's not a dictionary
# }

# @export var enemies := Enemies
# @export var weapon1 := Weapon.BASIC_SWORD