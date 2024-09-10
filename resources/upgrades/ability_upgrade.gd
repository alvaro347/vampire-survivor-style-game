extends Resource
class_name AbilityUpgrade


# NOTE: Resources are meant to store data. Any script can be resource but since
# this is a ability upgrade. We can choose which data has the abilities. (id, name, description)


@export var id: String
@export var name: String
@export_multiline var description: String
