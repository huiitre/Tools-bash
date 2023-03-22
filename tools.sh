#!######################################################!
#!||                                                 #!||
#!||             Variables color & style             #!||
#!||                                                 #!||
#!######################################################!
# Reset
Color_Off='\033[0m'       # Color Reset
Style_Off='\e[0m'

# Italic Text
Italic='\e[3m'

# Regular Colors
Black='\033[0;30m'        # Black
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Blue='\033[0;34m'         # Blue
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan
White='\033[0;37m'        # White

# Bold
BBlack='\033[1;30m'       # Black
BRed='\033[1;31m'         # Red
BGreen='\033[1;32m'       # Green
BYellow='\033[1;33m'      # Yellow
BBlue='\033[1;34m'        # Blue
BPurple='\033[1;35m'      # Purple
BCyan='\033[1;36m'        # Cyan
BWhite='\033[1;37m'       # White

# Underline
UBlack='\033[4;30m'       # Black
URed='\033[4;31m'         # Red
UGreen='\033[4;32m'       # Green
UYellow='\033[4;33m'      # Yellow
UBlue='\033[4;34m'        # Blue
UPurple='\033[4;35m'      # Purple
UCyan='\033[4;36m'        # Cyan
UWhite='\033[4;37m'       # White

# Background
On_Black='\033[40m'       # Black
On_Red='\033[41m'         # Red
On_Green='\033[42m'       # Green
On_Yellow='\033[43m'      # Yellow
On_Blue='\033[44m'        # Blue
On_Purple='\033[45m'      # Purple
On_Cyan='\033[46m'        # Cyan
On_White='\033[47m'       # White

# High Intensity
IBlack='\033[0;90m'       # Black
IRed='\033[0;91m'         # Red
IGreen='\033[0;92m'       # Green
IYellow='\033[0;93m'      # Yellow
IBlue='\033[0;94m'        # Blue
IPurple='\033[0;95m'      # Purple
ICyan='\033[0;96m'        # Cyan
IWhite='\033[0;97m'       # White

# Bold High Intensity
BIBlack='\033[1;90m'      # Black
BIRed='\033[1;91m'        # Red
BIGreen='\033[1;92m'      # Green
BIYellow='\033[1;93m'     # Yellow
BIBlue='\033[1;94m'       # Blue
BIPurple='\033[1;95m'     # Purple
BICyan='\033[1;96m'       # Cyan
BIWhite='\033[1;97m'      # White

# High Intensity backgrounds
On_IBlack='\033[0;100m'   # Black
On_IRed='\033[0;101m'     # Red
On_IGreen='\033[0;102m'   # Green
On_IYellow='\033[0;103m'  # Yellow
On_IBlue='\033[0;104m'    # Blue
On_IPurple='\033[0;105m'  # Purple
On_ICyan='\033[0;106m'    # Cyan
On_IWhite='\033[0;107m'   # White

#!###############################################!
#!||                                          #!||
#!||                  General                 #!||
#!||                                          #!||
#!###############################################!
#todo Chemin absolu du fichier tools.sh (normalement le repo dans /c/)
TOOLS_PATH=$(dirname "$(readlink -f "$BASH_SOURCE")")
# echo "chemin tools.sh : $TOOLS_PATH"

#todo PERMET DE RELOAD LE TERMINAL
#todo A FAIRE APRES CHAQUE MODIFICATION ET SAUVEGARDE
reload () {
	source ~/.bashrc
	printf $BIGreen"Restart de la console effectué !"$Color_Off
}
alias RELOAD='reload'
alias rel='reload'
alias REL='reload'

#todo escape les simple quote (pas utilisé car bizarre)
escapeQuote () {
	local quoted=${1//\'/\'\\\'\'};
  printf "'%s'" "$quoted"
}

#todo échappe les simples quotes (mais pas encore les double)
quote_args() {
	local sq="'"
	local dq='"'
	local space=""
	local backtic='\'
	local arg

	for arg; do
			string1=$(echo -n "$space"${arg//$sq/$backtic$sq})
			# string2=$(echo -n "$space$dq"${string1//$dq/$backtic$dq}"$dq")
			# echo 'string2 : ' $string2

			echo -n $string1
			# echo -n "$space'${arg//$sq/$backtic$sq}'"
	done
}

#!###############################################!
#!||                                          #!||
#!||              PHP & Symfony               #!||
#!||                                          #!||
#!###############################################!
alias sy='php bin/console'
alias mm='php bin/console make:migration'
alias dmm='php bin/console doctrine:migration:migrate'
# alias dfl='bin/console d:f:l' remplacé par la fonction
alias DFL='dfl'

#todo Fixtures avec un nom de groupe
dfl () {
	param=$1
	if [ -z $param ]
	then
		printf $On_Green$BCyan"Commande :$Color_Off\n"
		printf $On_IRed$BCyan"> php bin/console d:f:l$Color_Off"
		php bin/console d:f:l
	else
		printf $On_Green$BCyan"Commande :$Color_Off\n"
		printf $On_IRed$BCyan"> php bin/console d:f:l --group=$param$Color_Off"
		php bin/console d:f:l --group=$param
	fi
}

#todo Serveur avec un port spécifique
phpserv () {
	#* port à 5050 par défaut
	param=${1-5050}
	var1="php -S localhost:$param -t public"
	$var1
}

# Anciens raccourcis
# alias php8080='php -S localhost:8080 -t public'
# alias php5050='php -S localhost:5050 -t public'
# alias php2525='php -S localhost:2525 -t public'

#todo On boucle pour créer un alias avec des ports allant de 1010 à 9090, uniquement par 10
# for (( c=1010; c<=9090; c = c+10 ))
# do
# 	alias php$c="php -S localhost:$c -t public"
# 	# Exemple de commande à taper : "php2020"
# done

#!###############################################!
#!                                              #!
#!                   REACT JS                   #!
#!                                              #!
#!###############################################!

create-app() {
	# copie des fichiers cachés et non-cachés présents à la racine du modèle
	# note : des alertes sont affichées à propos de dossiers ignorés, c'est normal
	cp -n C:/wamp64/www/perso/React-modele/{.*,*} .

	# copie (récursive) des dossiers src/, config/ et public/
	# note : des alertes sont affichées à propos de dossiers ignorés, c'est normal
	cp -rn C:/wamp64/www/perso/React-modele/{src,config,public} .
}


#!###############################################!
#!||                                          #!||
#!||              COMMANDES GIT               #!||
#!||                                          #!||
#!###############################################!

# todo checkout fonction
# todo penser à refaire en prenant compte des dossiers bug/, feature/, etc ...
#* fonction qui permet de switch d'une branche à une autre
#* évite de devoir taper les guillemets "" pour entourer le numéro de ticket
checkout() {
	# Stocker les noms de branches qui correspondent au nom spécifié
	local branches
	branches=$(git branch --list "*$1*" | awk '{print $1}')
	
	# Vérifier si des branches ont été trouvées
	if [ -n "$branches" ]; then
		# Compter le nombre de branches trouvées
		local branch_count
		branch_count=$(echo "$branches" | wc -l)
		
		# Si il n'y a qu'une branche, la sélectionner
		if [ "$branch_count" -eq 1 ]; then
			git checkout $(echo "$branches")
		
		# Sinon, afficher une liste des branches trouvées
		else
			echo "Plusieurs branches ont été trouvées:"
			echo "$branches"
		fi
	else
		echo "Aucune branche trouvée avec le nom '$1'"
	fi
}

#todo RESET COMMIT (pour le dev de la fonction commit)
gitreset () {
	ret='git reset --soft HEAD^'
	$ret
}

#todo commit 
commit() {
  # Récupérer le nom de la branche courante
  local branch=$(git symbolic-ref HEAD --short 2> /dev/null)

  # Récupérer le numéro de ticket avec le # en plus
  local ticket=$(echo $branch | grep '#.*' -o)

  # Si le numéro de ticket n'existe pas, utiliser le nom de la branche à la place
  if [ -z "$ticket" ]; then
    ticket=$branch
  fi

  # Récupérer le message de commit 
  local message=$(printf "%s : %s" "$ticket" "$*")

  # Si il y a au moins un argument
  if [[ $# -gt 0 ]]; then
    printf "$On_Green Commit sur $branch$Color_Off\n"
    printf "$On_Green Message : $message$Color_Off\n\n"
    git commit -m "$message"
  else
    printf "Le message de commit est vide !"
  fi
}


#!###############################################!
#!||                                          #!||
#!||            CORDOVA & ANDROID             #!||
#!||                                          #!||
#!###############################################!

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

#todo Fonction qui retourne la liste des numéros de série des pda quand on fait adb devices
getDevices() {
  # Exécute la commande "adb devices" et stocke le résultat dans une variable
  devices=$(adb devices)

  # Vérifie si la chaîne "List of devices attached" se trouve dans le résultat
  if [[ "$devices" == *"List of devices attached"* ]]; then
    # Si la chaîne est présente, on peut extraire la liste des numéros de série à l'aide de la commande awk
    devices=$(echo "$devices" | awk '{if (NR!=1) print $1}')
    # Si la liste est vide, cela signifie qu'aucun périphérique n'est connecté
    if [[ -z "$devices" ]]; then
      echo "false"
    else
      # Sinon, on retourne la liste sous forme de tableau
      echo "$devices"
    fi
  else
    # Si la chaîne n'est pas présente, cela signifie qu'il y a eu une erreur lors de l'exécution de la commande "adb devices"
    # On retourne la valeur "false"
    echo "false"
  fi
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
	adb logcat -c;
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
				printf $BIPurple"PDA : $opt$Color_Off"
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
				printf $BIPurple"PDA : $name$opt$Color_Off"
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
	local DEFAULT_PDA=$(grep "^DEFAULT_PDA=" "$CONFIG_FILE" | cut -d= -f2)

	checkConfigFile() {
		if [ -f "$CONFIG_FILE" ]; then
			return 0
		else
			# on check si le path est accessible en écriture
			if ! touch "$CONFIG_FILE" 2>&1; then
				printf $BRed"Erreur : Le chemin $CONFIG_FILE n'est pas accessible en écriture, veuillez modifier la variable CONFIG_FILE au début de la fonction !"$Color_Off
				return 1
			else
				echo "DEFAULT_PDA=ct60" >> "$CONFIG_FILE"
				return 0
			fi
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

	# * on lance checkConfigFile afin de créer le fichier de config
	local check_config_resul
	check_config_result=$(checkConfigFile)
	if [ $(expr "$check_config_result" : '^[0-9]*$') -eq 1 ] && [ "$check_config_result" -eq 1 ]; then
    return 1
	else
			checkConfigFile
	fi
	

	# * Liste des commandes disponibles
	if echo "$1" | grep -qiE '^-{1,2}h(elp)?$'; then
		displayHelp
	elif echo "$1" | grep -qiE '^-{1,2}d(efault)?$'; then
		displayDefault
	elif echo "$1" | grep -qiE '^-{1,2}l(ist)?$'; then
		echo "LISTE EN COURS DE DEVELOPPEMENT"
	elif echo "$1" | grep -qiE '^-{1,2}v(ersion)?$'; then
		displayVersion
	elif echo "$1" | grep -qiE '^--?.*'; then
		echo "commande inconnue"
	else
		runPda $1
	fi
}
# todo alias run to RUN
alias RUN='run'

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
