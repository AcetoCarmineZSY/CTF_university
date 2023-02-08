# Write-up Reverse1

Ouvrez le fichier avec IDA-32bits. Nous trouvons l'emplacement de la fonction main:`080483A0                 lea     ecx, [esp+4]`. 

Plusieurs lignes plus bas, on trouve le Flag: `080483B9                 push    offset s2       ; "SuperFlagSecuriseCommePasPossible"`.