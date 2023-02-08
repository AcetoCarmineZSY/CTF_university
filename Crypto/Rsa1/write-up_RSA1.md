# Write-Up RSA 1

Les fichiers disponibles étaient "ciphertext1.bin", "ciphertext2.bin", "pubkey1.pem" et "pubkey2.pem".

Nous écrivons d'abord des scripts pour lire ces quatre fichiers. En RSA, la clé publique est composée de deux éléments : le modulus (N) et l'exposant de chiffrement (e).

```python
with open("pubkey1.pem","rb") as f:
    key1 = RSA.import_key(f.read())
    n = key1.n
    e1 = key1.e

with open("pubkey2.pem","rb") as f:
    key2 = RSA.import_key(f.read())
    n2 = key2.n
    e2 = key2.e
```

Lors de la lecture des deux textes de chiffrement c1 et c2, une conversion entre Bytes et Int est nécessaire.

```python
fileciphertext1bin = open("ciphertext1.bin", "rb")
dataciphertext1bin = fileciphertext1bin.read()
c1 = convertBytesToInt(dataciphertext1bin)

fileciphertext2bin = open("ciphertext2.bin", "rb")
dataciphertext2bin = fileciphertext2bin.read()
c2 = convertBytesToInt(dataciphertext2bin)
```

Notre objectif était de décoder les messages chiffrés contenus dans les fichiers "ciphertext1.bin" et "ciphertext2.bin". Pour ce faire, nous avons mis en place une "attaque par module commun", car en lisant le fichier ci-dessus, nous avons constaté que les deux n sont les mêmes.

Dans notre cas, nous avions accès à deux messages chiffrés (ciphertext1.bin et ciphertext2.bin) et aux clés publiques correspondantes (pubkey1.pem et pubkey2.pem). Nous avons extrait le modulus (N) et les exposants de chiffrement (e1 et e2) des clés publiques.



$$
c1 = m^{e1} mod N \\

c2 = m^{e2} mod N
$$
e1, e2 sont premiers entre eux, alors: `gcd(e1,e2)=1`.

Selon l'algorithme euclidien étendu pour les entiers a, b (ab!=0), gcd(a, b) désigne le plus grand diviseur commun de a, b. Alors il doit exister des entiers x, y tels que `gcd(a, b) = ax + by `

On peut obtenir: 
$$
(c1^{s1}*c2^{s2})mod\ n = ((m^{e1}\ mod\ n)^{s1}(m^{e2}\ mod\ n)^{s2})mod \ n
$$
Simplifie cette formule et on peut écrire le code. Enfin, en convertissant les Int en Bytes encore une fois, nous pouvons trouver Flag dans le message imprimé.

```python
s,s1,s2=gmpy2.gcdext(e1,e2)
m=(pow(c1,s1,n)*pow(c2,s2,n2)%n)
convertIntToBytes(int(m))
```

