extends Button

signal add_resource

var resource_name: String


func _on_pressed():
	add_resource.emit(resource_name)
