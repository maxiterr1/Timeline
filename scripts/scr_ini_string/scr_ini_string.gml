function ini_string(str) {
	str = string_split(str, "&&")
	temp = ""
	for (var j = 0; j < array_length(str); j++)
		temp += str[j] + "\n"
	return temp
}