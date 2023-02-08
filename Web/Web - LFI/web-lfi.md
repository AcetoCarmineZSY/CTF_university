# Write-up LFI

Lorsque nous cliquons sur "Contactez-nous" sur le site cible, l'adresse URL devient http://15.236.122.71/index.php?view=contact-us.html. En examinant attentivement cette URL, nous pouvons voir qu'il y a un paramètre "view" qui peut être modifié pour inclure d'autres fichiers.

Nous allons tenter d'exploiter cette vulnérabilité en modifiant le paramètre "view" pour inclure un fichier nommé "flag.txt" qui se trouve dans le répertoire "/var/www/". En essayant de changer "contact-us.html" en "flag.txt", nous obtenons une alerte `"Warning: include(): Failed opening '/var/www/html/flag.txt'"`. Cela nous informe que notre emplacement actuel est "/var/www/html".

Comme nous savons que le flag se trouve dans le répertoire "/var/www", nous devons accéder à ce répertoire en retournant au répertoire parent. Nous pouvons le faire en modifiant le paramètre "view" dans l'URL en utilisant "../" comme ceci :

http://15.236.122.71/index.php?view=../flag.txt

Si le site est vulnérable à une attaque de lecture de fichier, nous devrions être en mesure de voir le contenu du fichier "flag.txt" dans le répertoire "/var/www".