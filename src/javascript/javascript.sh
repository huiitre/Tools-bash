#!###############################################!
#!                                              #!
#!                   REACT JS                   #!
#!                                              #!
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

create-app() {
	# copie des fichiers cachés et non-cachés présents à la racine du modèle
	# note : des alertes sont affichées à propos de dossiers ignorés, c'est normal
	cp -n C:/wamp64/www/perso/React-modele/{.*,*} .

	# copie (récursive) des dossiers src/, config/ et public/
	# note : des alertes sont affichées à propos de dossiers ignorés, c'est normal
	cp -rn C:/wamp64/www/perso/React-modele/{src,config,public} .
}