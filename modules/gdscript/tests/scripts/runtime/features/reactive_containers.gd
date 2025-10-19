extends RefCounted

@reactive
var items: Array = []

@reactive  
var inventory: Dictionary = {}

var array_signal_count = 0
var dict_signal_count = 0
var last_array_old = null
var last_array_new = null
var last_dict_old = null
var last_dict_new = null

func test():
	# Connect to the reactive signals
	@warning_ignore("return_value_discarded")
	items_changed.connect(_on_items_changed)
	@warning_ignore("return_value_discarded")
	inventory_changed.connect(_on_inventory_changed)
	
	print("Initial values:")
	print("items: ", items)
	
	# Test array assignment (complete replacement)
	print("Setting items to [1, 2, 3]")
	items = [1, 2, 3]
	
	print("Array signal count: ", array_signal_count)
	print("Last array old: ", last_array_old)
	print("Last array new: ", last_array_new)
	
	# Test array modification (should trigger on reassignment)
	print("Appending 4 to items")
	items.append(4)
	
	print("Array signal count: ", array_signal_count)
	print("Last array old: ", last_array_old)
	print("Last array new: ", last_array_new)

	print("Initial values:")
	print("inventory: ", inventory)

	# Test dictionary assignment (complete replacement)
	print("Setting inventory to {'sword': 1, 'potion': 3}")
	inventory = {"sword": 1, "potion": 3}
	
	print("Dict signal count: ", dict_signal_count)  
	print("Last dict old: ", last_dict_old)
	print("Last dict new: ", last_dict_new)

	inventory["shield"] = 1  # should trigger the signal
	
	print("Dict signal count after modification: ", dict_signal_count)  
	print("Last dict old after modification: ", last_dict_old)
	print("Last dict new after modification: ", last_dict_new)
	
	inventory.shield += 1  # should trigger the signal
	
	print("Dict signal count after modification: ", dict_signal_count)  
	print("Last dict old after modification: ", last_dict_old)
	print("Last dict new after modification: ", last_dict_new)
	
	

func _on_items_changed(old_value, new_value):
	array_signal_count += 1
	last_array_old = old_value
	last_array_new = new_value
	print("Items changed signal: ", old_value, " -> ", new_value)

func _on_inventory_changed(old_value, new_value):
	dict_signal_count += 1
	last_dict_old = old_value
	last_dict_new = new_value
	print("Inventory changed signal: ", old_value, " -> ", new_value)
