#!###############################################!
#!||                                          #!||
#!||            CORDOVA & ANDROID             #!||
#!||                                          #!||
#!###############################################!

FILE_PATH="$( cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 ; pwd -P )"
# FILE_NAME=$(basename "$FILE_PATH")
FILE_NAME=$(basename "${BASH_SOURCE[0]}")

# ! IMPORTATION DES FICHIERS
for file in "$FILE_PATH"/*.sh
do
	if [[ "$file" != "$FILE_PATH/$FILE_NAME" ]]; then
		source "$file"
	fi
done

#todo CHIRON BUILDER
chiron() {
	#? Le dossier de chiron
  chironCordovaDir="/c/dev/cordova_chiron_builder"

  #? Le dossier de chiron cordova
  chironDir="/c/dev/chiron"

	# On save le dossier courant afin d'y revenir plus tard
	currentDir=$(pwd)

	# On navigue vers chiron et on lance le build
	cd $chironDir &&

	# On lance le build
	npm run build &&
	echo "========== BUILD OK =========="

  # # Si on a le chemin du dossier en paramètre, on le prend
  # if [ -n "$1" ]; then
  #   chironDir="$1"
  # fi
	# echo "PATH CHIRON : $chironDir"

  # # Lance la compilation de chiron, la copie du build dans cordova et la compilation cordova
  # echo "========= Compilation de CHIRON"
  # cd "$chironDir"
  # npm run build && \
	
	# echo "PATH PARENT : $parent"
  # echo "========= Envoi vers mobile" && \
	# echo "DOSSIER CHIRON CORDOVA : $parent"
  # cp -r "$chironDir/dist" "$parent/www" && \
  # cd "$parent" && \
  # cp keystore/* platforms/android/app/ && \
  # cp gradle.properties platforms/android/ && \
  # cordova run android
}

#todo Test d'extraction d'une BDD d'un PDA
ext() {
	adb shell run-as net.distrilog.easymobile sh -c "/ > /data/data/net.distrilog.easymobile/app_webview/Default/databases/file__0/1"
	# Réponse : 
	# /system/bin/sh: can't create /data/data/net.distrilog.easymobile/app_webview/Default/databases/file__0/test.txt: Permission denied
	# Besoin de root le pda
}

alias adbd='adb devices -l'

#todo /-----/ LOG JAVA /-----/
logcat() {
	# # liste des pda
	# local devices=$(adb devices -l)

	# # PDA par défaut
	# local DEFAULT_PDA="CT60"

	# # si le résultat est vide
	# if [ "$(echo "$devices" | tr -d '\r\n')" = "List of devices attached" ]; then
	# 	adb devices -l
	# 	printf $BRed"Erreur: aucun appareil trouvé."$Color_Off
	# 	return 1
	# fi

	# # * si l'argument est vide
	# if [ -z "$1" ]; then
	# 	# * on récupère le pda demandé par l'user
	# 	read -p "Veuillez cibler le PDA [défaut : $DEFAULT_PDA]: " name
	# 	local name=${name:-$DEFAULT_PDA}
	# 	# * on récupère le modèle et on converti les caractères minuscule en majuscule
	# 	local model=$(echo "$name" | tr '[:lower:]' '[:upper:]')
	# 	local result=$(echo "$devices" | grep -iw "$model")

	# 	# * si le pda n'a pas été trouvé
	# 	if [ -z "$result" ]; then
	# 		printf $BRed"Erreur: $model non trouvé."$Color_Off
	# 		return 1
	# 	fi

	# 	# * si l'id du PDA n'a pas pu être récupéré
	# 	local device_id=$(echo "$result" | awk '{print $1}')
	# 	if [ -z "$device_id" ]; then
	# 		printf $BRed"Erreur: aucun appareil trouvé."$Color_Off
	# 		return 1
	# 	fi

	# 	printf "${BGreen}Début du debug JAVA${Color_Off}\n"
	# 	cordova run android --target="$device_id"

	# # * l'argument n'est pas vide, on continue
	# else
	# 	# * on récupère le modèle et on converti les caractères minuscule en majuscule
	# 	local model=$(echo "$1" | tr '[:lower:]' '[:upper:]')
	# 	local result=$(echo "$devices" | grep -iw "$model")

	# 	# * si le pda n'a pas été trouvé
	# 	if [ -z "$result" ]; then
	# 		printf $BRed"Erreur: $1 non trouvé."$Color_Off
	# 		return 1
	# 	fi

	# 	local device_id=$(echo "$result" | awk '{print $1}')
	# 	# * si l'id du PDA n'a pas pu être récupéré
	# 	if [ -z "$device_id" ]; then
	# 		printf $BRed"Erreur: aucun appareil trouvé."$Color_Off
	# 		return 1
	# 	fi

	# 	printf "${BGreen}Lancement du build en cours ...${Color_Off}\n"
	# 	adb devices -l
	# 	cordova run android --target="$device_id"
	# 	adb logcat -c
	# 	adb logcat 
	# fi

	# on clear le terminal
	adb logcat -c
	# on exécute la commande
	adb logcat -s ${1-easymobile_tools}
}

# todo run pour java
runjava() {
	"C:\dev\easymobile\run_ct45.bat";
	sleep 5;
	adb logcat -c;
	adb logcat -s ${1-easymobile_tools}
}

#todo cordova requirements fonction depuis n'importe où
cordorequi () {
	cd 'src-cordova'
	cordova requirements
	cd '../'
}

# todo variante de run qui utilise adb devices -l en checkant le modèle du pda renvoyé
run() {
	# * On récupère le résultat de la commande
	local devices=$(adb devices -l)

	# * chemin absolu du fichier de config
	local CONFIG_FILE="/c/run-pda-config.cfg"

	# * pour l'export de la fonction, on déclare ici les variables de couleur
	local Color_Off='\033[0m'
	local Style_Off='\e[0m'
	local BRed='\033[1;31m'
	local BGreen='\033[1;32m'
	local Italic='\e[3m'

	# * on récupère la valeur par défaut
	local DEFAULT_PDA='CT60'
	# $(grep "^DEFAULT_PDA=" "$CONFIG_FILE" | cut -d= -f2)

	# * variable qui gère le mode défaut
	local defaultMode=true

	checkConfigFile() {
		# * est-ce que le fichier existe
		if [ -f "$CONFIG_FILE" ]; then
			# * on récupère le pda par défaut si il existe
			local pda=$(grep "^DEFAULT_PDA=" "$CONFIG_FILE" | cut -d= -f2)
			if [ -n "$pda" ]; then
				DEFAULT_PDA="$pda"
			fi
		else
			touch "$CONFIG_FILE" 2> /dev/null
			if [ $? -ne 0 ]; then
				defaultMode=false
				return 1
			fi
			echo "DEFAULT_PDA=ct60" >> "$CONFIG_FILE"
		fi
	}

	runPda() {
		# * si le résultat est vide
		if [ "$(echo "$devices" | tr -d '\r\n')" = "List of devices attached" ]; then
			adb devices -l
			printf $BRed"Erreur: aucun appareil trouvé."$Color_Off
			return 1
		fi

		# * si l'argument est vide
		if [ -z "$1" ]; then
			# * on récupère le pda demandé par l'user
			read -p "Veuillez cibler le PDA [défaut : $DEFAULT_PDA]: " name
			local name=${name:-$DEFAULT_PDA}
			# * on récupère le modèle et on converti les caractères minuscule en majuscule
			local model=$(echo "$name" | tr '[:lower:]' '[:upper:]')
			local result=$(echo "$devices" | grep -iw "$model")

			# * si le pda n'a pas été trouvé
			if [ -z "$result" ]; then
				printf $BRed"Erreur: $model non trouvé."$Color_Off
				return 1
			fi

			# * si l'id du PDA n'a pas pu être récupéré
			local device_id=$(echo "$result" | awk '{print $1}')
			if [ -z "$device_id" ]; then
				printf $BRed"Erreur: aucun appareil trouvé."$Color_Off
				return 1
			fi

			printf "${BGreen}Lancement du build en cours ...${Color_Off}\n"
			adb devices -l
			cordova run android --target="$device_id"

		# * l'argument n'est pas vide, on continue
		else
			# * on récupère le modèle et on converti les caractères minuscule en majuscule
			local model=$(echo "$1" | tr '[:lower:]' '[:upper:]')
			local result=$(echo "$devices" | grep -iw "$model")

			# * si le pda n'a pas été trouvé
			if [ -z "$result" ]; then
				printf $BRed"Erreur: $1 non trouvé."$Color_Off
				return 1
			fi

			local device_id=$(echo "$result" | awk '{print $1}')
			echo 'device_id : '$device_id
			# * si l'id du PDA n'a pas pu être récupéré
			if [ -z "$device_id" ]; then
				printf $BRed"Erreur: aucun appareil trouvé."$Color_Off
				return 1
			fi

			printf "${BGreen}Lancement du build en cours ...${Color_Off}\n"
			adb devices -l
			cordova run android --target="$device_id"
		fi
	}

	# displayListActivesPda() {

	# }

	displayHelp() {
		echo -e $BIBlue"==========================================="$Color_Off
		echo -e $BIBlue"Liste des commandes disponibles : $Color_Off"
		echo -e $BIBlue"==========================================="$Color_Off
		echo -e $Italic"Note : Marche également avec deux tirets << -- >>."$Style_Off
		echo ""
		printf $BIBlue"%-50s %s" "Commande :" "Description :"
		echo -e $Color_Off
		printf "%-50s %s\n" "-h | -H | -help    | -HELP" "Affiche l'aide"
		printf "%-50s %s\n" "-l | -L | -list    | -LIST" "Affiche la liste des PDA"
		printf "%-50s %s\n" "-v | -V | -version | -VERSION" "Version actuelle du script"
	}

	displayDefault() {
		# checkConfigFile
		# * on check si le fichier existe ou si il a pu être créé
		if [ $? -eq 0 ]; then
			printf "$BIBlue========== Configuration du PDA par défaut ==========$Color_Off\n"
			printf $Italic$IPurple"PDA actuel par défaut : $BIWhite$DEFAULT_PDA\n\n"$Color_Off
			read -p "Veuillez inscrire le nom du PDA à build par défaut : " response
			pda=$response
			if [ ! -z "$pda" ]; then
				sed -i "s/DEFAULT_PDA=.*/DEFAULT_PDA=$pda/g" "$CONFIG_FILE"
				echo -e $BIGreen"Le PDA par défaut a été modifié de $BIRed$DEFAULT_PDA $BIGreenà $BICyan$pda ${BIGreen}avec success !"$Color_Off
			else
				echo -e $BIRed"ERREUR : Le champ renseigné est vide !"$Color_Off
			fi
		else
			echo -e $BIRed"ERROR : Le fichier est introuvable ou n'a pas pu être créé"$Color_Off
		fi
	}

	displayVersion() {
		echo -e $BIPurple
		echo -e "##################################################"
		echo -e "||                   RUN PDA                    ||"
		echo -e "||                 Version 1.0                  ||"
		echo -e "||                    by YDL                    ||"
		echo -e "##################################################"$Color_Off
		echo ""
		echo "CE QUI VA SUIVRE EST EN COURS DE DEVELOPPEMENT"

		# * VERSIONING
		declare -A versions

		# * VERSION 1.0
		version='1.0'
		printf -v versions["$version"] '%s\n' \
			"20-02-2023 : Ajout de la fonction de versioning" \
			"21-02-2023 : Ajout de la fonction de debug"

		# * VERSION 1.1
		version="1.1"
		printf -v versions["$version"] '%s\n' \
			"24-02-2023 : Correction de bugs mineurs" \
			"28-02-2023 : Amélioration de l'interface utilisateur"

		# * VERSION 1.2
		version="1.2"
		printf -v versions["$version"] '%s\n' \
			"29-02-2023 : Ajout de la fonction de login" \
			"29-02-2023 : Ajout de la fonction de logout" \
			"30-02-2023 : Ajout de la fonction de création de compte"

		# * Affichage du versioning
		echo ""
		echo -e "Version\t\tDate\t\t\tDescription"
		# printf "%-15s %-22s %s\n" "Version" "Date" "Description"
		echo -e '---------------------------------------------------'

		for version in "${!versions[@]}"; do
			first_modification=true
			for modification in "${versions[$version]}"; do
				if [ "$first_modification" = true ]; then
					printf "%-15s %-22s %s\n" "$version" "$modification"
					first_modification=false
				else
					printf "%-15s %-22s %s\n" "" "$(echo "$modification" | sed 's/^/                  /')"
				fi
			done
		done
	}

	checkAppInstalled() {
		# * le num de série
		SERIAL=$1
		# * est-ce que l'app est installé
		APP_INSTALLED=$(adb -s $SERIAL shell pm list packages | grep net.distrilog.easymobile)
		if [[ -n "$APP_INSTALLED" ]]; then
			echo "true"
		else
			echo "false"
		fi
	}

	displayClearApp() {

		pda=$1
		# * est-ce qu'on a des pda de branchés
		if [ "$(echo "$devices" | tr -d '\r\n')" = "List of devices attached" ]; then
			adb devices -l
			printf $BRed"Erreur: aucun appareil trouvé."$Color_Off
			return 1
		fi

		# * pas d'arguments
		if [ -z "$pda" ]; then
			# * on récupère le pda demandé par l'user
			read -p "Veuillez cibler le PDA à clear [défaut : $DEFAULT_PDA]: " name
			local name=${name:-$DEFAULT_PDA}

			# * on récupère le modèle et on converti les caractères minuscule en majuscule
			local model=$(echo "$name" | tr '[:lower:]' '[:upper:]')
			local result=$(echo "$devices" | grep -iw "$model")

			# * si le pda n'a pas été trouvé
			if [ -z "$result" ]; then
				printf $BRed"Erreur: $model non trouvé."$Color_Off
				return 1
			fi

			# * si l'id du PDA n'a pas pu être récupéré
			local device_id=$(echo "$result" | awk '{print $1}')
			if [ -z "$device_id" ]; then
				printf $BRed"Erreur: aucun appareil trouvé."$Color_Off
				return 1
			fi

			# todo on lance le clear ...
			# * est-ce que l'app est installé sur le pda
			if [ $(checkAppInstalled $device_id) = 'false' ]; then
				printf "EasyMobile n'est pas installé sur le PDA $model"
				return 1
			fi

			printf "${BBlue}Clear du stockage du pda $model en cours ...${Color_Off}\n"
			result=$(adb -s $device_id shell pm clear net.distrilog.easymobile)
			
			if [ $result = 'Success' ]; then
				printf "${BGreen}L'application a bien été clear !${Color_Off}\n"
				printf "${BBlue}Lancement de l'application ...${Color_Off}\n"
				adb -s $device_id shell am start -n net.distrilog.easymobile/.MainActivity > /dev/null 2>&1
				printf "${BGreen}L'application a bien été lancé !${Color_Off}\n"
			else
				printf $BRed"Erreur lors du clear de l'application."$Color_Off
				return 1
			fi

		# * sinon, si on a un argument
		else
			local model=$(echo "$pda" | tr '[:lower:]' '[:upper:]')
			local result=$(echo "$devices" | grep -iw "$model")

			# * si le pda demandé n'a pas été trouvé
			if [ -z "$result" ]; then
				printf $BRed"Erreur: $pda non trouvé."$Color_Off
				return 1
			fi

			local device_id=$(echo "$result" | awk '{print $1}')
			# * si l'id du pda n'a pas été trouvé
			if [ -z "$device_id" ]; then
				printf $BRed"Erreur: aucun appareil trouvé."$Color_Off
				return 1
			fi

			# * est-ce que l'app est installé sur le pda
			if [ $(checkAppInstalled $device_id) = 'false' ]; then
				printf "EasyMobile n'est pas installé sur le PDA $model"
				return 1
			fi

			printf "${BBlue}Clear du stockage du pda $model en cours ...${Color_Off}\n"
			result=$(adb -s $device_id shell pm clear net.distrilog.easymobile)
			
			if [ $result = 'Success' ]; then
				printf "${BGreen}L'application a bien été clear !${Color_Off}\n"
				printf "${BBlue}Lancement de l'application ...${Color_Off}\n"
				adb -s $device_id shell am start -n net.distrilog.easymobile/.MainActivity > /dev/null 2>&1
				printf "${BGreen}L'application a bien été lancé !${Color_Off}\n"
			else
				printf $BRed"Erreur lors du clear de l'application."$Color_Off
				return 1
			fi
		fi
	}

	# * on lance checkConfigFile afin de créer le fichier de config
	checkConfigFile
	

	# lancement de l'appli
	# adb -s 21245B18DD shell am start -n net.distrilog.easymobile/.MainActivity
	# fermeture de l'appli
	# adb -s 21245B18DD shell am force-stop net.distrilog.easymobile
	# vidage du stockage de l'appli
	# adb -s 21245B18DD shell pm clear net.distrilog.easymobile
	# désinstaller l'appli
	# adb -s 21245B18DD uninstall net.distrilog.easymobile
	# * Liste des commandes disponibles
	if echo "$1" | grep -qiE '^-{1,2}h(elp)?$'; then
		displayHelp
	elif echo "$1" | grep -qiE '^-{1,2}d(efault)?$'; then
		if [ $defaultMode = true ]; then
			displayDefault
		else
			echo -e $BRed"La déclaration d'un PDA par défaut est désactivée car vous n'avez pas les droits d'écriture sur $CONFIG_FILE, vous ne pouvez pas utiliser cette commande."$Color_Off
			echo -e $BRed"Pour activer la fonctionnalité, veuillez modifier la variable CONFIG_FILE en lui spécifiant un chemin correct et accessible en lecture et écriture."$Color_Off
		fi
	elif echo "$1" | grep -qiE '^-{1,2}l(ist)?$'; then
		echo "LISTE EN COURS DE DEVELOPPEMENT"
	elif echo "$1" | grep -qiE '^-{1,2}v(ersion)?$'; then
		displayVersion
	elif echo "$1" | grep -qiE '^-{1,2}l(ist)?$'; then
		displayListActivesPda
	elif echo "$1" | grep -qiE '^-{1,2}c(lear)?$'; then	
		displayClearApp $2
	elif echo "$1" | grep -qiE '^-{1,2}u(ninstall)?$'; then	
		echo 'uninstall'
	elif echo "$1" | grep -qiE '^--?.*'; then
		echo "commande inconnue"
	else
		runPda $1
	fi
}
# todo alias run to RUN
alias RUN='run'