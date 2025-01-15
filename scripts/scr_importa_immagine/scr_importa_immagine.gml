function importa_immagine(dir){
	if dir == "none"
		return spr_none
	
	if !file_exists(dir) {
		show_message("File " + dir + " non trovato!")
		game_restart()
	}
	
	return sprite_add(dir, 1, false, false, 0, 0)
}