#!###############################################!
#!||                                          #!||
#!||              COMMANDES GIT               #!||
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