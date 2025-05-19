# 🐳 Inception - Projet Docker 42

## 📋 Description

Inception est un projet d'administration système de l'école 42 visant à créer une infrastructure Dockerisée fonctionnelle, sécurisée et bien organisée. 

Ce projet met en œuvre différents services web conteneurisés et interconnectés via Docker.

## 🔍 Objectif

Le but est de configurer, dans une machine virtuelle, une mini-infrastructure composée de services tels que NGINX, WordPress, MariaDB, Redis, FTP, Adminer, Prometheus, cAdvisor et un site personnel statique.

 Chaque service tourne dans son propre conteneur Docker. L’ensemble est orchestré avec `docker-compose`.

## ⚙️ Fonctionnement

Chaque service fonctionne dans un conteneur séparé construit depuis un `Dockerfile` personnalisé, à l’aide de `docker-compose`.

Tous les services sont interconnectés via un réseau Docker privé.

L’architecture repose sur l’utilisation de volumes persistants pour la base de données et les fichiers du site.

## 🧱 Infrastructure
```
         [Client]
             |
          [NGINX]
             |
  ------------------------
  |     |      |    |    |
WP   Adminer  FTP  Site  cAdvisor
  \     |                |
 MariaDB                 Prometheus
                         |
                         Grafana
```
### Services obligatoires :

- 🔒 **NGINX** : reverse proxy en HTTPS (Certificat SSL + TLSv1.2 / TLSv1.3 uniquement).
- 🗄️ **WordPress** : site web avec interface d’administration.
- 🗄️ **MariaDB** : base de données pour WordPress.
- 💾 **Volumes persistants** :
  - Base de données (MariaDB)
  - Fichiers WordPress
- 🌐 Réseau Docker interne pour la communication inter-containers.

### Services bonus :

- 🧠 **Redis** : système de cache pour WordPress.
- 📂 **FTP Server** : accès au volume WordPress via FTP.
- 🛠️ **Adminer** : interface web pour manipuler MariaDB.
- 🌐 **Site personnel statique** (top 10 mangas).
- 📡 **cAdvisor** : collecte et expose en temps réel les métriques des conteneurs Docker (CPU, RAM, I/O, etc.) au format compatible Prometheus.
- 📊 **Prometheus** : interroge périodiquement cAdvisor pour récupérer les métriques exposées, les stocke et les organise dans une base temporelle.
- 📈 **Grafana** : visualise les métriques collectées par Prometheus via des dashboards dynamiques.


## 🧪 Lancement

### 1. Cloner le dépôt
```bash
git clone https://github.com/agraille/Inception && cd Inception
```
### 2. Configurer les variables
- Modifier le fichier .env et les mdp dans secret/files si vous le souhaitez.
- Modifier ou créer les chemins des volumes locaux (en bas du docker compose)
### 3. Build
```
make
```
### 4. Accéder aux services

- 🌐 **WordPress** : [https://localhost](https://localhost)
- 🛠️ **Adminer** : [https://login.42.fr:8080](https://login.42.fr:8080)
- 🌍 **Site perso** : [http://localhost:8181](http://localhost:8181)
- 📡 **cAdvisor** : [http://localhost:8282/containers/](http://localhost:8282/containers/)
- 📊 **Prometheus** : [http://localhost:9090](http://localhost:9090)
- 📈 **Grafana** : [http://localhost:3000](http://localhost:3000)
- - 📂 **FTP** : Accessible via un client FTP comme **FileZilla**  
- Hôte : `localhost`  
- Port : `21`  
- Utilisateur : `ftpuser`  
- Mot de passe : `ftppass`

## ✅ Fonctionnalités

🔒 HTTPS uniquement via NGINX.

🗃️ Volumes persistants pour WordPress et MariaDB.

🔁 Redémarrage automatique des conteneurs.

🔄 Aucun hack de type sleep infinity ou tail -f.

🔧 Dockerfiles écrits manuellement pour chaque service.

🔐 Aucun mot de passe en dur : variables d’environnement ou secrets.

🧠 Redis intégré pour optimiser le cache de WordPress.

📂 FTP opérationnel sur le volume WordPress.

👨‍💻 Interface Adminer pour gestion MySQL.

🌐 Site personnel statique.

📊 Monitoring en temps réel avec Grafana, Prometheus et cAdvisor.

## 📏 Contraintes respectées

✅ Pas de latest tag.

✅ Aucun mot de passe en clair dans les Dockerfiles.

✅ Nom de domaine local personnalisé : login.42.fr.

✅ Utilisation des variables d’environnement et fichiers .env.

