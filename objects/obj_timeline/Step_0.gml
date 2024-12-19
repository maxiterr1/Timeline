if timer == 0
	timerSuOGiu = true
else if timer == 30
	timerSuOGiu = false

if timerSuOGiu
	timer += 0.5
else
	timer -= 0.5

if mouseTimer > 450
	trasparenzaFrecce = trasparenzaFrecce == 0 ? 0 : trasparenzaFrecce - 0.01
else
	trasparenzaFrecce = 1

if exMouseX != mouse_x or exMouseY != mouse_y {
	mouseTimer = 0
	exMouseX = mouse_x
	exMouseY = mouse_y
} else
	mouseTimer++