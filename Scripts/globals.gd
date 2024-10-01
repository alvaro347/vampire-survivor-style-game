extends Node

@export var enemies: Dictionary = {
	basic_enemy = {
		health = 10,
		damage = 5
	},
	wizard_enemy = {
	health = 30,
	damage = 5
	}
}

@export var player: Dictionary = {
	health = 10,
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
