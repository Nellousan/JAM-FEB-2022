extends Node

class_name TickWaiter

var is_started = false
var ticks_to_wait = 0
var ticks_waited = 0

signal ticks_finished

func wait_for_ticks(ticks: int):
	ticks_to_wait = ticks
	var timer = get_node("/root/main/Timer")
	timer.connect("timeout", self, "on_main_timer_tick")
	
func on_main_timer_tick():
	ticks_waited += 1
	if ticks_waited >= ticks_to_wait:
		emit_signal("ticks_finished")
		queue_free()
