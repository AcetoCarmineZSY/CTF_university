# write-up rsa2

La question suggère que la signature est générée par go 1.5.1, cette version du module rsa sur l'architecture 32 bits présente une vulnérabilité, c'est-à-dire que lors de l'utilisation de rsa-crt pour calculer la signature, il y a une certaine probabilité d'erreur, ici l'erreur se réfère à la " rsa-crt fault signature attack ".

L'idée générale de cette attaque est que le message incorrectement calculé n'est pas congruence que le message original sous le mod p. De cette façon, nous soustrayons le message d'erreur le message correct utilisé dans la signature de celui-ci, et ce que nous obtenons est un multiple de p. `assert (pow(sig, e, N)) != msg`. Ensuite, nous prenons ce résultat et faisons un pgcd avec N pour trouver p, qui décompose N. Enfin, il suffit de compter la clé privée d pour le déchiffrer. Quant à savoir comment trouver ce message mal calculé, nous essayons la signature donnée dans la question une par une. Enfin, nous avons trouvé une erreur de calcul dans l'ensemble des données de la ligne 135. Nous écrivons un script pour trouver le flag en suivant le modèle ci-dessus.

```python
p = gcd(pow(sig, e, N) - msg, N)
q = N // p
```

Sur la base des idées précédentes, nous écrivons les deux lignes de code du noyau comme ci-dessus. Dans les détails, nous devons encore effectuer quelques conversions entre bytes et int.