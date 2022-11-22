# Fonctionnement

1. Clonez le repo à la racine de votre disque dur C
2. Ajoutez dans votre fichier *.bashrc* le code suivant :

```bash
if [ -f c:/tools-bash/tools.sh ]
then
	source c:/tools-bash/tools.sh
fi
```
*On vient ajouter le contenu de tools.sh, ce qui nous donne ensuite accès à tous les alias et à toutes les fonctions*

Pour recharger le terminal sans le fermer, lancer la fonction `reload`