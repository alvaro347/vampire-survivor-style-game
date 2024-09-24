extends Resource
class_name AbilityUpgrade


# NOTE: Resources are meant to store data. Any script can be resource but since
# this is a ability upgrade. We can choose which data has the abilities. (id, name, description)
# This is a script that can be attached to many more resources


@export var id: String
@export var max_quantity: int
@export var name: String
@export_multiline var description: String
