if timer == 0
	timerSuOGiu = true
else if timer == 70
	timerSuOGiu = false

if timerSuOGiu
	timer += 0.5
else
	timer -= 0.5
	
//show_debug_message(timer)