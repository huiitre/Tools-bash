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

# todo Importation de la fonction RUN
source "c:\dev\run-pda-shell\run.sh"

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