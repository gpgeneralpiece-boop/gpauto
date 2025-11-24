# 🚀 Guide de Déploiement GP AUTO - DigitalOcean

## 📋 Prérequis

### Compte DigitalOcean
1. Créer un compte sur [digitalocean.com](https://digitalocean.com)
2. Vérifier votre méthode de paiement
3. Activer l'authentification à deux facteurs (recommandé)

### Outils Locaux
```bash
# 1. Installer Git
# Windows: https://git-scm.com/download/win
# Mac: brew install git
# Linux: sudo apt install git

# 2. Créer un compte GitHub (si pas encore fait)
# https://github.com
```

---

## 📂 Étape 1 : Préparation du Projet

### 1.1 Créer un Repository GitHub
1. Aller sur [GitHub.com](https://github.com)
2. Cliquer sur "New repository"
3. Nom: `gp-auto`
4. Description: `Site e-commerce de pièces auto - Tunisie`
5. Public (ou Privé)
6. Cliquer "Create repository"

### 1.2 Préparer les Fichiers
Dans votre dossier `gp-auto`, créer ces fichiers :

**`.do/app.yaml`** (configuration DigitalOcean) :
```yaml
name: gp-auto-tunisia
services:
- name: backend
  source_dir: /backend
  github:
    repo: VOTRE-USERNAME/gp-auto
    branch: main
  run_command: npm start
  build_command: npm install
  environment_slug: node-js
  instance_count: 1
  instance_size_slug: basic-xxs
  envs:
  - key: NODE_ENV
    value: production
  - key: PORT
    value: 3001
  http_port: 3001
  paths:
  - /api

- name: frontend
  source_dir: /
  github:
    repo: VOTRE-USERNAME/gp-auto
    branch: main
  build_command: echo "Frontend prêt - fichiers statiques"
  run_command: echo "Frontend servi via CDN"
  environment_slug: node-js
  instance_count: 1
  instance_size_slug: basic-xxs
  http_port: 8080
  paths:
  - /
```

**`backend/package.json`** (modifier) :
```json
{
  "name": "gp-auto-backend",
  "version": "1.0.0",
  "main": "server.js",
  "scripts": {
    "start": "node server.js",
    "dev": "nodemon server.js"
  },
  "dependencies": {
    "express": "^4.18.2",
    "sqlite3": "^5.1.6",
    "cors": "^2.8.5"
  },
  "devDependencies": {
    "nodemon": "^3.0.1"
  }
}
```

### 1.3 Structure Finale
```
gp-auto/
├── backend/
│   ├── server.js
│   ├── package.json
│   ├── migrate_to_new_structure.js
│   ├── create_sample_db.js
│   └── database.sqlite
├── admin.html
├── index.html
├── styles/
│   └── main.css
│   └── admin.css
├── scripts/
│   ├── main.js
│   └── admin.js
├── .do/
│   └── app.yaml
└── README.md
```

---

## 🔄 Étape 2 : Upload sur GitHub

### 2.1 Initialiser Git
```bash
# Dans votre dossier gp-auto
git init
git add .
git commit -m "Initial GP Auto site - ready for deployment"
```

### 2.2 Lier à GitHub
```bash
# Remplacer VOTRE-USERNAME par votre vrai nom d'utilisateur
git remote add origin https://github.com/VOTRE-USERNAME/gp-auto.git
git branch -M main
git push -u origin main
```

---

## 🌐 Étape 3 : Déploiement DigitalOcean

### 3.1 Créer l'Application
1. Se connecter à [DigitalOcean](https://cloud.digitalocean.com)
2. Cliquer "Apps" dans le menu gauche
3. Cliquer "Create App"
4. Sélectionner "GitHub" comme source

### 3.2 Configurer le Repository
1. Cliquer sur votre repository `gp-auto`
2. DigitalOcean détecte automatiquement le type d'app
3. Cliquer "Next"

### 3.3 Configurer les Ressources
**Automatiquement détecté :**
- Service Backend : Node.js sur port 3001
- Service Frontend : Static files

**Ajuster si nécessaire :**
- **Region** : Choisir "Amsterdam" (le plus proche de la Tunisie)
- **Size** : Basic 1GB/1CPU (5$/mois)

### 3.4 Variables d'Environnement
Ajouter ces variables dans l'interface :
```
NODE_ENV = production
PORT = 3001
```

### 3.5 Déployer
1. Cliquer "Create Resources"
2. Attendre 3-5 minutes pour le déploiement
3. **URLs générées :**
   - Backend API : `https://gp-auto-tunisia-xxxx.ondigitalocean.app`
   - Frontend : `https://gp-auto-tunisia-xxxx.ondigitalocean.app`

---

## 🔧 Étape 4 : Configuration Post-Déploiement

### 4.1 URL Personnalisée (Optionnel)
1. Dans l'app DigitalOcean
2. Aller à "Settings" > "Domains"
3. Ajouter un domaine personnalisé si vous en avez un
4. Ou utiliser le sous-domaine fourni : `gp-auto-tunisia-xxxx.ondigitalocean.app`

### 4.2 Mise à Jour du Code Frontend
Modifier `scripts/main.js` et `scripts/admin.js` :
```javascript
// Au lieu de localhost:3001, utiliser l'URL de production
const API_BASE_URL = 'https://gp-auto-tunisia-xxxx.ondigitalocean.app';
```

### 4.3 Premier Déploiement
```bash
# Après modification des URLs
git add .
git commit -m "Update API URLs for production"
git push origin main
```

---

## ✅ Étape 5 : Tests et Validation

### 5.1 Tests Backend
```bash
# Tester l'API
curl https://gp-auto-tunisia-xxxx.ondigitalocean.app/api/health

# Devrait retourner :
# {"status":"OK","message":"GP Auto API Server is running","timestamp":"2025-11-24T19:53:29.000Z"}
```

### 5.2 Tests Frontend
1. Aller sur l'URL fournie
2. Vérifier que le site s'affiche
3. Tester le panel admin : `https://gp-auto-tunisia-xxxx.ondigitalocean.app/admin.html`

### 5.3 Tests Fonctionnels
- [ ] Créer une voiture avec motorisations multiples
- [ ] Créer une pièce compatible
- [ ] Vérifier l'affichage du catalogue
- [ ] Tester l'administration

---

## 💰 Coûts et Limitations

### Coût DigitalOcean App Platform
- **Basic 1GB/1CPU** : 5$/mois
- **Basic 2GB/2CPU** : 10$/mois (pour croissance)

### Limitations
- **Bande passante** : 1TB gratuit/mois
- **Stockage** : 25GB inclus
- **Builds** : 100 deployments gratuits/mois

### Upgrade Futur
- Si votre site devient populaire :
  - Upgrader vers 2GB/2CPU (10$/mois)
  - Ajouter CDN personnalisé
  - Monitoring avancé
  - Sauvegardes automatiques

---

## 🛠️ Maintenance et Mises à Jour

### 4.1 Déploiement de Modifications
```bash
# Après modification du code
git add .
git commit -m "Description des changements"
git push origin main

# Le déploiement se fait automatiquement !
```

### 4.2 Monitoring
- **Logs** : Dashboard DigitalOcean > App > Logs
- **Métriques** : CPU, RAM, réseau
- **Alertes** : Configurer notifications

### 4.3 Base de Données
- Le fichier `database.sqlite` est stocké avec l'app
- **Recommandation** : Sauvegarder régulièrement
- **Production** : Migrer vers PostgreSQL plus tard

---

## 🎯 Votre Site GP AUTO Sera Accessible :

- **Frontend Public** : `https://gp-auto-tunisia-xxxx.ondigitalocean.app`
- **Panel Admin** : `https://gp-auto-tunisia-xxxx.ondigitalocean.app/admin.html`
- **API Backend** : `https://gp-auto-tunisia-xxxx.ondigitalocean.app/api`

**Coût total : 5$/mois** pour un site professionnel avec toutes les fonctionnalités demandées !

---

## 🚨 Points Importants

1. **Certificats SSL** : Inclus automatiquement (HTTPS)
2. **Performance** : Serveur européen (Amsterdam) rapide
3. **Disponibilité** : 99.9% de uptime garanti
4. **Évolutivité** : Upgrade facile selon les besoins
5. **Support** : Documentation complète et communauté active

Voulez-vous que je vous aide à créer les fichiers de configuration ou vous avez des questions sur les étapes ?