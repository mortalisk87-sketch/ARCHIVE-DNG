# DNG Archives - mise en ligne sur GitHub Pages

Fichiers : `index.html`, `bliss.jpg`, `peltsden.jpg` (+ `supabase.sql` pour la base).

## 1. Mettre le site en ligne (GitHub Pages)
1. Sur github.com : New repository (ex. `dng-archives`), en Public.
2. "Add file" > "Upload files" : envoie `index.html`, `bliss.jpg`, `peltsden.jpg`. Commit.
3. Settings > Pages > Source : "Deploy from a branch", branche `main`, dossier `/ (root)`. Save.
4. Après 1-2 minutes, le site est sur `https://TON-PSEUDO.github.io/dng-archives/`.

Sans l'étape 5, le site marche en **mode local** : tu peux te connecter et publier, mais les vidéos ne sont enregistrées que dans TON navigateur (les visiteurs ne les voient pas).

## 2. Vidéos visibles par tout le monde (Supabase, gratuit)
1. Crée un projet sur supabase.com.
2. SQL Editor > New query > colle le contenu de `supabase.sql` > Run.
3. Project Settings > API : copie "Project URL" et la clé "anon public".
4. Dans `index.html`, en haut du script, remplis :
   `var CFG={SUPABASE_URL:"https://xxxx.supabase.co",SUPABASE_ANON_KEY:"ta_cle_anon"};`
   (la clé anon est faite pour être publique, ce n'est pas un secret.)
5. Commit le fichier modifié sur GitHub.

Le mot de passe est vérifié par Supabase : sans lui, personne ne peut publier ni supprimer.
Pour changer le mot de passe : calcule son SHA-256 et mets à jour la ligne `writer_hash` de la table `secrets`.

## 3. Ajouter des vidéos
Pas d'envoi de fichier sur GitHub Pages. Colle un lien :
- YouTube en "non répertoriée" (recommandé, aucune limite de taille)
- ou un lien https direct vers un .mp4 (ex. un fichier mis dans Supabase Storage > bucket public).

## Astuces
- Ajoute `#glitch` à l'URL pour tester le crash.
- Chemin secret dans la barre d'adresse : `C:\DELIVERY_NOT_GUARANTEED\PELTSDEN`
