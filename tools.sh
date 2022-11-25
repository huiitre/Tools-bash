#!###############################################!
#!||                                          #!||
#!||             Variables color              #!||
#!||                                          #!||
#!###############################################!
# Reset
Color_Off='\033[0m'       # Text Reset

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
	#* Attribut à 8080 par défaut
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
#* fonction qui permet de switch d'une branche à une autre
#* évite de devoir taper les guillemets "" pour entourer le numéro de ticket
checkout() {
	attr=${1}
	#* Si c'est égal à 5 && supérieur à zéro
	if [ ${#attr} -eq 5 ] && [ "$attr" -ge 0 ]
	then
		cmd="git checkout #${attr}"
	else
		cmd="git checkout ${attr}"
	fi
	$cmd
}

#todo RESET COMMIT (pour test de la fonction commit)
gitreset () {
	ret='git reset --soft HEAD^'
	$ret
}

#todo commit 
commit () {
	#* On récupère le nom de la branche courante
	local branch=$(git symbolic-ref HEAD --short 2> /dev/null)
	#* On récupère le nombre d'arguments de la fonction
	local argTotal=$#
	#* La liste des arguments
	local argList=$@
	#* On déclare le début de la commande
	local cmd="git commit -m "

	#* Si il y a au moins un argument
	if [[ $argTotal -gt 0 ]]
	then
		printf $BIPurple"Commit sur $On_Green $branch $Color_Off\n"
		# printf $BIPurple"Message : $On_Green $argList $Color_Off\n"
		printf $BIPurple"Message : $On_Green $argList $Color_Off\n\n"
		$cmd "$branch : $argList"
	else
		printf $BIRed"Le message de commit est vide !"$Color_Off
	fi
}

#!###############################################!
#!||                                          #!||
#!||            CORDOVA & ANDROID             #!||
#!||                                          #!||
#!###############################################!

# Test d'extraction d'une BDD d'un PDA
ext() {
	adb shell run-as net.distrilog.easymobile sh -c "/ > /data/data/net.distrilog.easymobile/app_webview/Default/databases/file__0/1"
	# Réponse : 
	# /system/bin/sh: can't create /data/data/net.distrilog.easymobile/app_webview/Default/databases/file__0/test.txt: Permission denied
	# Besoin de root le pda
}

alias adbd='adb devices'

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

# todo alias run to RUN
alias RUN='run'

# todo V1 RUN du pc perso, en commentaire car la version 2 viendra remplacer 
runperso () {
	adb devices;
	yarn build;
	cd 'src-cordova';
	cordova run android;
	cd '../'
}

# todo V2 que j'utilise avec distrilog
run () {
	string=$(adb devices)
	if [ ${#string} -gt 24 ]
	then
		read -p "Veuillez cibler le PDA [defaut : eda52]: " name
		name=${name:-eda52}
		if [ -e "C:\Users\Yanis\Desktop\test\pda\run_$name.bat" ]
		then
			echo '##################################'
			echo "||    LANCEMENT DU BUILD ...    ||"
			echo '##################################'
			ret="C:\Users\Yanis\Desktop\test\pda\run_$name.bat"
			$ret
		else
			echo '#########################################'
			echo '                                         '
			echo "    LE PDA << $name >> N'EXISTE PAS      "
			echo '                                         '
			echo '#########################################'
		fi
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

			read -p "Veuillez inscrire le nom du PDA à ajouter : " response
			name=$response
			# * On vérifie si le champ est vide ET si le pda existe pas déjà
			while [ -z "$name" ] || [[ " ${array[*]} " =~ " ${name} " ]]
			do
				echo ""
				echo "Le nom du PDA est vide ou existe déjà !"
				read -p "Veuillez inscrire le nom du PDA à ajouter : " response
				name=$response
			done

			read -p "Veuillez inscrire le numéro du PDA à ajouter : " response
			number=$response
			while [ -z "$number" ]
			do
				echo ""
				echo "Le numéro du PDA << $name >> est vide !"
				read -p "Veuillez inscrire le numéro du PDA << $name >> à ajouter : " response
				number=$response
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
			echo 'key avant : '${!array[@]}
			echo 'val avant : '${array[@]}
			unset array[$name]
			echo 'key apres : '${!array[@]}
			echo 'val apres : '${array[@]}

			# * on replace dans le fichier le reste des pda
			for key in ${!array[@]}
			do
				# todo récupérer le contenu du fichier puis insérer la ligne courant
				# todo puis faire ça pour chaque ligne afin de ne pas écraser à chaque fois
				# echo -e "$key"="${array[$key]}\n" > data.txt
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
			echo "salut salut";;

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
