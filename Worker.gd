extends Node

var base_strength = {
	"gold": 0,
	"wood": 0,
	"food": 0,
}

var worker_type: String


func set_worker_type(worker_type, strength):
	base_strength[worker_type] = strength
