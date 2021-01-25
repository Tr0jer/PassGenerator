#!/bin/bash

# Pass Generator v1.0.0, Author: Tr0jan

#Colours
greenColour="\e[0;32m\033[1m"
endColour="\033[0m\e[0m"
redColour="\e[0;31m\033[1m"
blueColour="\e[0;34m\033[1m"
yellowColour="\e[0;33m\033[1m"
purpleColour="\e[0;35m\033[1m"
turquoiseColour="\e[0;36m\033[1m"
grayColour="\e[0;37m\033[1m"

trap ctrl_c INT

# Functions

# Salir del programa

function ctrl_c(){
	echo -e "\n\n${redColour}[!] Saliendo ${endColour}\n"
	tput cnorm; exit 0
}

# Panel de ayuda

function helpPanel(){
	echo -e "\n\n${yellowColour}[!]${endColour}${grayColour} Cómo usar Pass Generator ${endColour}"

	for i in $(seq 1 32); do
		echo -ne "${redColour}-${endColour}"
	done

	echo -e "\n${purpleColour}[-g] Generar contraseña${endColour}"
	echo -e "\t${redColour}random: ${endColour}\t\t\t${turquoiseColour}Generar contraseña random${endColour}"
	echo -e "\t${redColour}dictionary palabras_clave.txt: ${endColour}\t${turquoiseColour}Generar un diccionario de contraseñas${endColour}"
	echo -e "\t${redColour}word: ${endColour}\t\t\t\t${turquoiseColour}Generar contraseña en base a una palabra${endColour}"
	echo -e "\n${purpleColour}[-h] Abrir panel de ayuda${endColour}\n"

	echo -e "${purpleColour}[-n] Limitar letras o contraseñas (Ejem: -n 10)${endColour}\n"
}

# Generar contraseña random con límite

function randomPassGeneratorWithLimit(){
	local numero=$1
}

# Gemerar contraseña random 

function randomPassGenerator(){
	declare -a chars=('a' 'A' 'b' 'B' 'c' 'C' 'd' 'D' '_' 'e' 'E' 'f' 'F' '!' 'g' 'G' 'h' 'H' '?' 'i' 'I' 'j' 'J' '@' 'k' 'K' 'l' 'L' 'm' 'M' 'n' 'N' 'o' 'O' 'p' 'P' 'q' 'Q' 'r' 'R' 's' 'S' 't' 'T' 'u' 'U' 'v' 'V' 'w' 'W' 'x' 'X' 'y' 'Y' 'z' 'Z')
	random_number=$(shuf -i 1000000000000000000-9999999999999999999 -n 1)
	big_or_small=$(shuf -i 1-2 -n 1)
	declare -a password=()
	for (( i=0; i<=${#random_number}; i++ )); do
		current_number=${random_number:$i:$big_or_small}
		password+=($current_number)
	done
	for i in "${password[@]}"; do
		if [ "${i:0:1}" == 0 ]; then
			#echo -ne "\n\n${redColour}[!] Ups! Algo ha salido mal. Intentalo nuevamente :D${endColour}::${i:0:1}::$i, "
			echo -n "${chars[${i:1:1}]}"
			echo -e "\n\n${yellowColour}¿No estás satisfecho? Intentalo nuevamente D:${endColour}"
			exit 1;
		fi
		echo -n "${chars[i]}"
	done

	echo -e "\n\n${yellowColour}¿No estás satisfecho? Intentalo nuevamente D:${endColour}"
}

# Argumentos

parameter_counter=0; while getopts "g:n:h" arg; do
	case $arg in
		g) generate=$OPTARG; let parameter_counter+=1;;
		n) number=$OPTARG; let parameter_counter+=1;;
		h) helpPanel; let parameter_counter+=1;;
	esac
done

tput civis

if [ $parameter_counter -eq 0 ]; then
	echo -e "\n\n${redColour}[!] Argumento faltante... ${endColour}"
	for i in $(seq 1 28); do echo -ne "${grayColour}-${endColour}"; done
	echo -e "\n\n${yellowColour}Tal vez quieras echar un vistazo a: ./PassGenerator.sh -h${endColour}\n"
else
	if [ "$(echo $generate)" == "random" ]; then
		if [ "$number" ]; then
			echo "hola $number"
		else
			echo -e "\n${greenColour}[+] La contraseña se ha generado correctamente!${endColour}"
			echo -e "\n${purpleColour}Contraseña random: ${endColour}${grayColour}$(randomPassGenerator)${endColour}"
		fi
	fi
fi
