#!/bin/bash
	echo "Inventorcho"
	echo "================="
	
	echo "Choose an option:"
  echo "-----------------"
	
	echo "1.- Show character"
	echo "2.- Show Inventory"
	echo "3.- Exit"


	read INPUT

	if [ "$INPUT" == "3" ] || [ "$INPUT" == "" ]; then
		echo "pos Hasta Luego"
		exit 0
	fi


	if [ "$INPUT" == "1" ]; then
		echo "Personajes:"
		echo "select id_character,name from characters" | mysql -u consulta amongmeme;

	elif [ "$INPUT" == "2" ]; then
		echo "Inventario"
		echo "----------"
		echo "Choose inventory you want"
		
		read INPUT

		if [ "$INPUT" == "" ]; then

			echo "Input something"
			exit 1
		fi
		echo "select * from view_characters_items_summary where id_characters=$INPUT" | mysql -u consulta amongmeme | cut -d $'\t' -f 4;
	else	
			echo "Incorrect Choice"
	fi
