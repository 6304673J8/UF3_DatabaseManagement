#!/bin/bash

DEBUG=$FALSE

clear

echo "Inventorcho"
echo "================="

echo "Choose an option:"
echo "-----------------"

echo "1.- Show character"
echo "2.- Show Inventory"
echo "3.- Create character"
echo "4.- Create Item "
echo "5.- Equip Item"
echo "6.- Update Character"
echo "7.- Delete Character"
echo "Q.- Exit"


read INPUT

if [ "$INPUT" == "Q" ] || [ "$INPUT" == "q" ] || [ "$INPUT" == "" ]; then
	echo "Abur"
	exit 0
fi

if [ "$INPUT" == "" ]; then
	echo "You need to input something."
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
		
		QUERY="select * from view_characters_items_summary where id_character=$INPUT"
		echo | mysql -u consulta amongmeme | cut -d $'\t' -f 4;
	elif [ "$INPUT" == "3" ]; then
		echo "Insert Character"
		echo "****************"

		echo -n "NAME: "
		read NAME

		echo -n "AGE: "
		read AGE
		
		echo -n "HP: "
		read HP
		
		echo -n "(1)"
		read GENDER

		echo -n "STYLE(1): "
		read STYLE

		echo -n "MANA: "
		read MANA

		echo -n "CLASS(2): " 
		read CLASS

		echo -n "RACE(2): " 
		read RACE

		echo -n "XP: " 
		read XP
		
		echo -n "LEVEL: "
		read LEVEL

		echo -n "HEIGHT: " 
		read HEIGHT

		QUERY="INSERT INTO characters (name, age, hp, gender, style, mana, class,"
		QUERY="$QUERY race, xp, level, height)"
		QUERY="$QUERY VALUES ('$NAME', $AGE, $HP, '$GENDER', '$STYLE', $MANA, '$CLASS',"
		QUERY="$QUERY '$RACE', $XP, $LEVEL, $HEIGHT)"
	
		echo $QUERY | mysql -u manager amongmeme

	elif [ "$INPUT" == "4" ]; then
		echo "Insert Item"
		echo "***********"

		echo -n "Item Name: "
		read ITEM

		echo -n "Cost: "
		read COST

		echo -n "IS Consumable: "
		read CONSUMABLE

		echo -n "IS Tradeable: "
		read TRADEABLE

		echo -n "Weight: "
		read WEIGHT

		echo -n "Image: "
		read IMAGE

		echo -n "Item Description: "
		read DESCRIPTION

		echo -n "Item Type(index): "
		read ID_ITEM_TYPE
		
		QUERY="INSERT INTO items (item, cost, consumable, tradeable, weight,"
		QUERY="$QUERY image, description, id_item_type"
		
		QUERY="$QUERY VALUES ('$ITEM', $COST, $CONSUMABLE, $TRADEABLE, $WEIGHT,"
		QUERY="$QUERY '$IMAGE', '$DESCRIPTION', $ID_ITEM_TYPE)"
		
		echo $QUERY | mysql -u manager amongmeme

	elif [ "$INPUT" == "5" ]; then
		echo "Give item to character: "
		read CHARACTER

		echo "Item to give: "
		read ITEM

		QUERY="INSERT INTO characters_items(id_character, id_item) "
		QUERY="$QUERY VALUES($ID_CHARACTER, $ID_ITEM)";

		if [ "$DEBUG" == "1" ];then
			echo $QUERY
		fi

		echo $QUERY | mysql -u manager amongmeme;
	elif [ "$INPUT" == "6" ]; then
		echo "Which character should be upgraded?"
		read NAME
	
		LEN =`echo -n $NAME | wc -c`

		if [ $LEN -lt 4 ]; then
			echo "Error: Name too short. NAME >= 4"	
			exit 1;
		fi
		QUERY="SELECT id_character,name FROM characters WHERE name LIKE '%$NAME%'"
		CHAR=`echo $QUERY | mysql -u manager amongmeme | tail -n 1`
		if [ "$NAME" == "" ];then
			echo "ERROR: Introduce a name."
			exit 4;
		fi

		ID_CHAR=`echo $CHAR | cut -d " " -f 1`
		CHAR_NAME=`echo $CHAR | cut -d " " -f 2`

		echo "Full Name: $CHAR_NAME"
		echo -n "Input new name:"

		read NAME

		if [ `echo -n $NAME | wc -c` -lt 4 ]; then
			echo "ERROR: name too short"
			exit 3
		fi

		QUERY="UPDATE characters SET name="

	elif [ "$INPUT" == "7" ]; then

		echo "Enter Admin Password"
		read -s PASS

		echo "Delete character:"
		echo "_________________"
		read NAME

		LEN =`echo -n $NAME | wc -c`

		if [ $LEN -lt 4 ]; then
			echo "Error: Name too short. NAME >= 4"	
			exit 1;
		fi

		QUERY="SELECT id_character FROM characters WHERE  name LIKE '%$NAME%'"
		ID_CHAR = `echo $QUERY | mysql -u manager amongmeme | tail -n 1`
		if [ "$ID_CHAR" == "" ]; then
			echo "NO MATCH"
			exit 2
		fi

		echo "valor char: $ID_CHAR"

		QUERY="DELETE FROM characters_items WHERE id_character=$ID_CHAR"
		echo $QUERY | mysql -u enti -p$PASS amongmeme
	
		QUERY="DELETE FROM characters WHERE id_character=$ID_CHAR"
		#echo $QUERY

		echo $QUERY | mysql -u enti -p$PASS amongmeme
	else
		echo "Incorrect Choice"
	fi
