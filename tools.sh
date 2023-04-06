#!/bin/bash

#todo PERMET DE RELOAD LE TERMINAL
#todo A FAIRE APRES CHAQUE MODIFICATION ET SAUVEGARDE
reload () {
	# source ~/.bashrc
	# exec bash -c "source ~/.bashrc"
	exec bash
	# printf $BIGreen"Restart de la console effectué !"$Color_Off
}
alias RELOAD='reload'
alias rel='reload'
alias REL='reload'

# * Chemin absolu du fichier tools.sh
# FILE_PATH="$(pwd)"
FILE_PATH="$( cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 ; pwd -P )"
# * chemin absolu du répertoire "src"
SRC_DIR=$FILE_PATH"/src"

# * on importe utils avant les autres
if [ -e "$SRC_DIR/utils/utils.sh" ]; then
	source "$SRC_DIR/utils/utils.sh"
fi

printf $BIGreen"Chargement du script tools.sh réussi !"$Color_Off

# ! IMPORTATION DES FICHIERS
# * on parcours les sous répertoires de src
for dir in "$SRC_DIR"/*/
do
	# * le nom du sous répertoire
	dir_name="$(basename "$dir" /)"

	# * on ne charge pas une seconde fois le fichier utils.sh
	if [ "$dir_name" != "utils" ]; then
		# * est-ce que le fichier .sh avec le nom du répertoire existe
		if [ -e "$dir/$dir_name.sh" ]; then
			# * on charge le fichier .sh
			source "$dir/$dir_name.sh"
		fi
	fi
done