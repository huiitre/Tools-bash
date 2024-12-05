#!##################################################!
#!||                                             #!||
#!||            FONCTIONS DEPRECIEES             #!||
#!||                                             #!||
#!##################################################!

# ! CORDOVA

# todo V1 RUN du pc perso
runperso () {
	adb devices;
	yarn build;
	cd 'src-cordova';
	cordova run android;
	cd '../'
}

# todo V2 que j'utilise avec distrilog (obsolète)
run_old () {
	local pwd=$(pwd)
	local RACINE_PATH=$pwd"/pda/"
	local RACINE_PATH="/c/dev/pda/"

	printf $BIBlue"CURRENT_PATH : $RACINE_PATH$Color_Off\n"

	string=$(adb devices)
	opt=$1
	
	# * est-ce qu'un pda est branché ? adb devices
	if [ ${#string} -gt 24 ]
	then
		# * est-ce qu'une option a été écrite après la fonction ? "funcName blabla"
		if [ ! -z $opt ]
		then
			echo 'il y a une option'
			# * est-ce que le pda demandé existe dans le dossier /pda ?
			if [ $opt = "all" ]
			then
				# Récupération de la liste des ID de smartphones connectés
				device_ids=$(getDevices)

				echo $device_ids

				# Pour chaque ID de smartphone dans la liste
				for device_id in $device_ids
				do
					# Exécution de l'application Cordova sur le smartphone avec l'ID spécifié
					cordova run android --target=$device_id
				done
			# * On lance cordova run android sans target
			elif [ -e $RACINE_PATH"run_$opt.bat" ]
			then
				echo '##################################'
				echo "||    LANCEMENT DU BUILD ...    ||"
				echo '##################################'
				printf $BIPurple"PDA : $opt$Color_Off\n"
				ret=$RACINE_PATH"run_$name.bat"
				$ret
			# * le pda demandé n'existe pas dans le dossier
			else
				echo '#########################################'
				echo '                                         '
				echo "    LE PDA << $opt >> N'EXISTE PAS      "
				echo '                                         '
				echo '#########################################'
			fi
		# * pas d'option, on demande le nom du pda
		else
			# * on récupère le pda demandé par l'user
			read -p "Veuillez cibler le PDA [defaut : eda52]: " name
			name=${name:-eda52}
			# * est-ce que le pda demandé existe dans le dossier /pda ?
			if [ $name = "all" ]
			then
				# Récupération de la liste des ID de smartphones connectés
				device_ids=$(getDevices)

				echo $device_ids

				# Pour chaque ID de smartphone dans la liste
				for device_id in $device_ids
				do
					# Exécution de l'application Cordova sur le smartphone avec l'ID spécifié
					cordova run android --target=$device_id
				done
			# * On lance cordova run android sans target
			elif [ -e $RACINE_PATH"run_$name.bat" ]
			then
				echo '##################################'
				echo "||    LANCEMENT DU BUILD ...    ||"
				echo '##################################'
				printf $BIPurple"PDA : $name$opt$Color_Off\n"
				ret=$RACINE_PATH"run_$name.bat"
				$ret
			# * le pda demandé n'existe pas dans le dossier
			else
				echo '#########################################'
				echo '                                         '
				echo "    LE PDA << $name >> N'EXISTE PAS      "
				echo '                                         '
				echo '#########################################'
			fi
		fi
	# * adb devices renvoie aucuns pda
	else
		echo '#################################################'
		echo '||                                             ||'
		echo "||    AUCUNS PDA N'EST ACTUELLEMENT BRANCHE    ||"
		echo '||                                             ||'
		echo '#################################################'
	fi
}

# todo V3 de run() pour les run cordova android, en cours de developpement
lol () {
	# * Version 1.0

	# ! Récupération du nom de la fonction principale
	readonly scriptName=$FUNCNAME

	#! Fonction help
	Help () {
		echo "Liste des commandes disponibles. "
		echo ""
		echo "-h|-H|-help|-HELP			Affiche l'aide"
		echo "-a|-A|-add|-ADD				Ajouter un PDA"
		echo "-r|-R|-rm|-RM				Supprimer un PDA"
		echo "-l|-L|-list|-LIST			Affiche la liste des PDA"
		echo "-adb|-ADB|adb				Lance la commande << adb devices >>"
		echo "-v|-V|-version|-VERSION			Version actuelle du script"
	}

	#! Fonction de création d'un PDA
	Add () {
		#? Fonction qui va créer le PDA
		CreatePDA () {
			#* on récupère le contenu actuel du fichier
			content=$(cat data.txt)

			# * on récupère tous les noms des PDA dans un tableau
			OIFS=$IFS;
			IFS=$'\n';
			declare -a tab=( $content );
			IFS=$OIFS
			declare -a array
			for line in ${tab[@]}
			do
				pda=$(echo $line | grep -P '^([^=])+' -o)
				array+=($pda)
			done

			read -rp "Veuillez inscrire le nom du PDA à ajouter : " name
			# * On vérifie si le champ est vide ET si le pda existe pas déjà
			while [ -z "$name" ] || [[ " ${array[*]} " =~ " ${name} " ]]
			do
				echo ""
				echo "Le nom du PDA est vide ou existe déjà !"
				read -rp "Veuillez inscrire le nom du PDA à ajouter : " name
			done

			read -rp "Veuillez inscrire le numéro du PDA à ajouter : " number
			while [ -z "$number" ]
			do
				echo ""
				echo "Le numéro du PDA << $name >> est vide !"
				read -rp "Veuillez inscrire le numéro du PDA << $name >> à ajouter : " number
			done
			
			#* on replace le contenu avec en plus le nouveau pda
			if [ -z "$content" ]
			then
				#* si le fichier est vide, on insère pas de retour chariot
				echo "$name"="$number" > data.txt
			else
				#* si le fichier n'est pas vide, on insère un retour chariot
				echo -e "$content\n$name"="$number" > data.txt
			fi
			#todo Vérification avec un grep que le pda a bien été ajouté ?
			echo "Le PDA $name : $number a bien été ajouté !"
		}

		#* On vérifie si le fichier data existe
		if [ -e "${PWD}/data.txt" ]
		then
			CreatePDA
		else
			read -p "Le fichier data n'existe pas, voulez vous le créer ? o/n [defaut : oui ] : " response
			response=${response:-o}
			case $response in
				o|O)
					echo 'Création du fichier ...'
					touch data.txt
					sleep 0.5s
					#todo vérification avant de dire que le fichier a été créé ?
					echo 'Le fichier a été créé avec succès !'
					sleep 0.5s
					CreatePDA;;
			esac
		fi
	}

	# ! Fonction qui supprime un PDA de la liste
	Remove () {
		# todo vérifier si le fichier existe au moment où on tape la commande maFonction -r
		#* on récupère le contenu actuel du fichier
		contentFile=$(cat data.txt)

		# * on récupère tous les noms des PDA dans un tableau
		OIFS=$IFS;
		IFS=$'\n';
		declare -a tab=( $contentFile );
		IFS=$OIFS
		declare -A array
		for line in ${tab[@]}
		do
			pda=$(echo $line | grep -P '^([^=])+' -o)
			value=$(echo $line | grep -P '([^=])+$' -o)
			array[$pda]=$value
		done

		read -p "Veuillez inscrire le nom du PDA à supprimer : " response
		name=$response
		# * on vérifie que le fichier existe et que le nom du PDA à supprimer existe, et que le champ n'est pas vide
		if [ ! -f "${PWD}/data.txt" ] || [ -z "$contentFile" ]
		then
			echo ""
			echo "Le fichier data n'existe pas ou ce dernier est vide."
			echo "Faites un << $scriptName -add >> afin d'ajouter un PDA."
		else
			# * On vérifie si le champ est vide ou si le pda n'existe pas
			while [ -z "$name" ] || [[ ! " ${!array[*]} " =~ " ${name} " ]]
			do
				echo ""
				echo "Le PDA n'existe pas."
				echo ""
				read -p "Veuillez inscrire le nom du PDA à supprimer : " response
				name=$response
			done
			
			# * on supprime le pda du tableau
			unset array[$name]

			# * on supprime le fichier
			rm -f data.txt

			# * on recrée le fichier avec le contenu à l'intérieur
			touch data.txt

			for key in ${!array[@]}
			do
				echo "$key=${array[$key]}" >> data.txt
			done

			# * On récupère tous les PDA et on les range dans un tableau associatif
			# * Je sais pas ce que ça fait, mais ça le fait
			# OIFS=$IFS;
			# IFS=$'\n';
			# declare -a tab=( $contentFile );
			# IFS=$OIFS

			# declare -A array
			# for line in ${tab[@]}
			# do
			# 	# * on récupère le nom et la valeur du pda et on stock ça dans un tableau assoc
			# 	name=$(echo $line | grep -P '^([^=])+' -o)
			# 	value=$(echo $line | grep -P '([^=])+$' -o)
			# 	array[$name]=$value
			# done

			# # * on parcours le tableau assoc, on trouve la ligne à supprimer, puis on la supprime
			# for line in ${array[@]}
			# do
			# 	echo $line
			# done
		fi
	}

	#! Fonction retournant la liste des PDA ajoutés
	List () {
		#* On vérifie si le fichier existe et si il est rempli
		contentFile=$(cat data.txt)
		if [ ! -f "${PWD}/data.txt" ] || [ -z "$contentFile" ]
		then
			#* Le fichier n'existe pas ou est vide
			echo 'La liste des PDA est vide.'
		else
			# * Je sais pas ce que ça fait, mais ça le fait
			OIFS=$IFS;
			IFS=$'\n';
			declare -a tab=( $contentFile );
			IFS=$OIFS

			declare -A array
			for line in ${tab[@]}
			do
				# * on récupère le nom et la valeur du pda et on stock ça dans un tableau assoc
				name=$(echo $line | grep -P '^([^=])+' -o)
				value=$(echo $line | grep -P '([^=])+$' -o)
				array[$name]=$value
			done

			# todo Pas obligé de passer par un tableau assoc pour afficher la liste
			# todo Mais ça reste stylé donc je laisse comme ça
			# * on parcours le tableau assoc et on affiche la clé : valeur
			for key in ${!array[@]}
			do
				echo ""
				echo "PDA : "$key
				echo 'Numéro : '${array[$key]}
				echo ""
			done
		fi
	}

	#! Options de l'utilisateur
	opt=$1
	case $opt in
		#? HELP
		"-h"|"-H"|"-help"|"-HELP")
			Help;;

		#? LISTE DES PDA
		"-l"|"-L"|"-list"|"-LIST")
			List;;

		#? AJOUTER UN PDA
		"-add"|"-ADD"|"-a"|"-A")
			Add;;

		#? SUPPRIMER UN PDA
		"-rm"|"-RM"|"-r"|"-R")
			Remove;;

		#? VERSION DU SCRIPT
		"-v"|"-V"|"-version"|"-VERSION")
			echo "Commande version actuelle du script";;

		#? LANCE LA COMMANDE ADB DEVICES
		"-adb"|"-ADB"|"adb")
			adb devices;;

		#? RUN LE BUILD
		"")
			echo "salut salutsqdqsqsd";;

		#? COMMANDE INCORRECT
		*)
			echo "Commande incorrecte"
			echo ""
			Help;;
	esac


	# adbdevices=$(adb devices)
	# # Si adb devices est rempli
	# if [ ${#adbdevices} -gt 24 ]
	# then
	# 	read -p "Veuillez cibler le PDA [defaut : ct45] : " name name=${name:-ct45}
	# 	echo $name
	# fi
}
