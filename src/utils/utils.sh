#!#########################################!
#!||                                    #!||
#!||                  Utils             #!||
#!||                                    #!||
#!#########################################!

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

#todo Chemin absolu du fichier tools.sh (normalement le repo dans /c/)
TOOLS_PATH=$(dirname "$(readlink -f "$BASH_SOURCE")")
# echo "chemin tools.sh : $TOOLS_PATH"

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