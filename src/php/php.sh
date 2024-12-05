#!###############################################!
#!||                                          #!||
#!||              PHP & Symfony               #!||
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

# todo différents alias utiles
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
		printf $On_IRed$BCyan"> php bin/console d:f:l$Color_Off\n"
		php bin/console d:f:l
	else
		printf $On_Green$BCyan"Commande :$Color_Off\n"
		printf $On_IRed$BCyan"> php bin/console d:f:l --group=$param$Color_Off\n"
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