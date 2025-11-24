# 🚗 GP AUTO - Site E-commerce Pièces Détachées

## 📋 Description

GP AUTO est un site e-commerce moderne pour la vente de pièces automobiles en Tunisie. Le site comprend un catalogue public et un panel d'administration complet avec les nouvelles fonctionnalités demandées.

## ✨ Fonctionnalités

### 🛍️ Catalogue Public
- **Affichage des produits** avec images, prix en TND
- **Catégories organisées** (freins, filtres, moteur, etc.)
- **Recherche par compatibilité** véhicule/pièce
- **Interface responsive** (mobile-friendly)

### 🔧 Panel Admin Amélioré
- **Gestion des véhicules** avec motorisations multiples ✅ NOUVEAU
- **Gestion des pièces** avec compatibilités précises ✅ NOUVEAU
- **Interface intuitive** pour non-développeurs
- **Relations N:N** pièces ↔ véhicules

### 🏗️ Architecture
- **Frontend** : HTML/CSS/JavaScript (vanilla)
- **Backend** : Node.js + Express + Supabase PostgreSQL
- **Déploiement** : Vercel + Supabase (100% Gratuit)

## 🚀 Déploiement Rapide

### ⭐ Option Recommandée : Vercel + Supabase (GRATUIT)

**Avantages :**
- ✅ **100% Gratuit** (100GB bandwidth + 500MB DB)
- ✅ **Performance** : CDN global ultra-rapide
- ✅ **Simplicité** : Déploiement automatique
- ✅ **Moderne** : PostgreSQL + Edge functions
- ✅ **Évolutif** : Upgrade facile selon croissance

**Déploiement en 20 minutes :**
1. **Créer projet Supabase** → Tables + données d'exemple
2. **Upload sur GitHub** → Repository créé
3. **Déployer sur Vercel** → Configuration automatique
4. **Configurer variables** → SUPABASE_URL + SUPABASE_ANON_KEY
5. **Tester et utiliser** → Site en ligne !

📖 **Guide complet** : [`DEPLOIEMENT_VERCEL_SUPABASE.md`](./DEPLOIEMENT_VERCEL_SUPABASE.md)
⚡ **Commandes rapides** : [`COMMANDES_VERCEL_SUPABASE.md`](./COMMANDES_VERCEL_SUPABASE.md)

### Alternative : DigitalOcean (5$/mois)
📖 **Guide** : [`DEPLOIEMENT_DIGITALOCEAN.md`](./DEPLOIEMENT_DIGITALOCEAN.md)

### Vérification Pré-Déploiement
```bash
# Pour Vercel + Supabase
bash verify_vercel_supabase.sh

# Pour DigitalOcean
bash verify_deployment.sh
```

## 📁 Structure du Projet

```
gp-auto/
├── 📄 index.html              # Site public
├── 📄 admin.html              # Panel d'administration
├── 📄 vercel.json             # Configuration Vercel (Supabase)
├── 📁 backend/
│   ├── 📄 server-supabase.js  # Serveur API pour Supabase
│   ├── 📄 server.js           # Serveur API SQLite (legacy)
│   ├── 📄 package-supabase.json # Dépendances Supabase
│   ├── 📄 package.json        # Dépendances SQLite (legacy)
│   ├── 📄 migrate_to_new_structure.js  # Migration SQLite
│   └── 📄 create_sample_db.js # Données d'exemple SQLite
├── 📁 styles/
│   ├── 📄 main.css            # Styles site public
│   └── 📄 admin.css           # Styles panel admin
├── 📁 scripts/
│   ├── 📄 main.js             # Logique site public
│   ├── 📄 admin.js            # Logique panel admin avec nouvelles features
│   └── 📄 api-client.js       # Client API unifié (Vercel + Supabase)
├── 📁 .do/
│   └── 📄 app.yaml            # Configuration DigitalOcean (legacy)
└── 📄 DOCUMENTATION/
    ├── 📄 NOUVELLES_FONCTIONNALITES.md
    ├── 📄 DEPLOIEMENT_VERCEL_SUPABASE.md    # ⭐ Guide principal
    ├── 📄 COMMANDES_VERCEL_SUPABASE.md      # ⭐ Commandes rapides
    ├── 📄 verify_vercel_supabase.sh         # ⭐ Vérification
    ├── 📄 DEPLOIEMENT_DIGITALOCEAN.md       # Alternative payante
    ├── 📄 COMMANDES_RAPIDES.md
    └── 📄 CHECKLIST_DEPLOIEMENT.md
```

## 🔧 Nouvelles Fonctionnalités Implémentées

### ✅ Véhicules Améliorés
- **Réutilisation de marques existantes** : Dropdown avec marques créées + option nouvelle
- **Motorisations multiples** : Ajout/suppression dynamique de motorisations par véhicule
- **Interface progressive** : Sélection marque → modèle → années → motorisations
- **Base de données normalisée** : Table `engines` séparée pour flexibilité

### ✅ Pièces Compatibles
- **Sélection de véhicules** depuis catégories créées
- **Affichage organisé** : Véhicules groupés par marque avec toutes leurs motorisations
- **Relations précises** : Table de jonction `part_vehicle_relations`
- **Interface checkbox** : Sélection multiple intuitive

### 🗄️ Restructuration Base de Données
- **vehicles** : brand, model, year_from, year_to
- **engines** : vehicle_id, engine, fuel_type (N:1 vers vehicles)
- **parts** : données principales des pièces
- **part_vehicle_relations** : compatibilités (N:N parts ↔ vehicles)

## 🌐 URL du Site

### Vercel + Supabase (Recommandé)
Après déploiement, votre site sera accessible à :

- **Public** : `https://gp-auto-tunisia-xxxx.vercel.app`
- **Admin** : `https://gp-auto-tunisia-xxxx.vercel.app/admin.html`
- **API** : `https://gp-auto-tunisia-xxxx.vercel.app/api`

### DigitalOcean (Alternative)
- **Public** : `https://gp-auto-tunisia-xxxx.ondigitalocean.app`
- **Admin** : `https://gp-auto-tunisia-xxxx.ondigitalocean.app/admin.html`
- **API** : `https://gp-auto-tunisia-xxxx.ondigitalocean.app/api`

## 📊 APIs Disponibles

### Véhicules
- `GET /api/admin/vehicles` : Liste avec motorisations groupées
- `POST /api/vehicles` : Créer véhicule + motorisations multiples
- `PUT /api/vehicles/:id` : Modifier véhicule + motorisations

### Pièces
- `GET /api/admin/parts` : Liste pièces
- `POST /api/parts` : Créer pièce + compatibilités
- `PUT /api/parts/:id` : Modifier pièce + compatibilités

### Système
- `GET /api/health` : Statut serveur

## 💡 Utilisation

### Ajout de Véhicules
1. Panel Admin → "Véhicules"
2. **Sélectionner marque existante** ou créer nouvelle
3. **Sélectionner modèle existant** ou créer nouveau
4. Définir années (optionnel)
5. **Ajouter une ou plusieurs motorisations** :
   - Motorisation (ex: 1.2L, 1.5L dCi)
   - Type carburant (Essence, Diesel, GPL, Hybride, Électrique)
   - Bouton ➕ pour ajouter, 🗑️ pour supprimer
6. Sauvegarder

### Ajout de Pièces
1. Panel Admin → "Pièces"
2. Remplir informations (nom, SKU, prix, stock...)
3. **Cocher "Véhicules compatibles"**
4. **Sélectionner véhicules** depuis la liste organisée par marque
5. Chaque véhicule affiche ses motorisations disponibles
6. Sauvegarder

### Recherche Client
- Parcourir catégories
- Sélectionner véhicule ou moteur
- Voir pièces compatibles
- Ajouter au panier

## 🔄 Migration et Données

### Script de Migration
```bash
cd backend
node migrate_to_new_structure.js
```

### Données d'Exemple
```bash
cd backend
node create_sample_db.js
```

**Inclut** :
- 8 véhicules avec 16 motorisations
- 10 pièces avec compatibilités
- Marques : Renault, Peugeot, Citroën, Dacia

## 💰 Coût d'Exploitation

### Vercel + Supabase (Recommandé)
- **100% GRATUIT** au démarrage
- **Inclus** :
  - ✅ SSL/HTTPS automatique
  - ✅ CDN global ultra-rapide
  - ✅ 100GB bande passante/mois
  - ✅ Base PostgreSQL 500MB
  - ✅ 50,000 API calls/jour
  - ✅ Surveillance automatique
  - ✅ Déploiements illimités

### DigitalOcean (Alternative)
- **5$/mois** minimum
- **Inclus** :
  - SSL/HTTPS automatique
  - Surveillance 24/7
  - CDN global
  - 1TB bande passante
  - Support technique
  - Déploiements illimités

## 📱 Screenshots Fonctionnalités

### Panel Véhicules
- Sélecteur marque avec option nouvelle
- Sélecteur modèle avec option nouveau
- Liste dynamique de motorisations
- Boutons ➕ et 🗑️ pour gestion

### Panel Pièces
- Checkbox "Afficher véhicules compatibles"
- Liste organisée par marque
- Chaque véhicule montre ses motorisations
- Sélection multiple facile

## 🔄 Mises à Jour

Le déploiement automatique met à jour le site quand vous faites :
```bash
git add .
git commit -m "Description des changements"
git push origin main
```

## 📞 Support et Documentation

- [`DEPLOIEMENT_DIGITALOCEAN.md`](./DEPLOIEMENT_DIGITALOCEAN.md) : Guide complet déploiement
- [`COMMANDES_RAPIDES.md`](./COMMANDES_RAPIDES.md) : Étapes essentielles
- [`CHECKLIST_DEPLOIEMENT.md`](./CHECKLIST_DEPLOIEMENT.md) : Vérifications avant/ après
- [`NOUVELLES_FONCTIONNALITES.md`](./NOUVELLES_FONCTIONNALITES.md) : Détail des modifications

## 🎯 Résultat Final

### Vercel + Supabase (Recommandé)
**Votre site GP AUTO sera :**
- ✅ **100% Gratuit** au démarrage
- ✅ **Ultra-rapide** avec CDN global
- ✅ **Moderne** avec PostgreSQL
- ✅ **Accessible 24/7** depuis la Tunisie
- ✅ **Sécurisé** avec HTTPS automatique
- ✅ **Évolutif** selon la croissance
- ✅ **Administrable** facilement
- ✅ **Compatible** mobile et desktop

### DigitalOcean (Alternative)
**Votre site GP AUTO sera :**
- ✅ Accessible 24/7 depuis la Tunisie
- ✅ Sécurisé avec HTTPS automatique
- ✅ Rapide (serveur européen Amsterdam)
- ✅ Évolutif selon la croissance
- ✅ Administrable facilement
- ✅ Compatible mobile et desktop

---

**🎉 Site GP AUTO prêt pour production en 20 minutes !**

**Vercel + Supabase : 0$/mois (gratuit)**
**DigitalOcean : 5$/mois (alternative)**