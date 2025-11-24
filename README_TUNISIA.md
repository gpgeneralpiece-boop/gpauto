# 🇹🇳 GP AUTO - Site E-commerce de Pièces Automobiles (Tunisie)

Site e-commerce moderne pour GP AUTO - Général Pièces Autos, spécialisé dans la vente de pièces automobiles en Tunisie.

## 🎨 **Modifications Majeures Implémentées**

### **1. Nouvelle Charte Graphique GP AUTO**
- **Logo personnalisé** : Adaptation selon votre logo avec couleurs bleu-vert foncé
- **Palette de couleurs** : 
  - Couleur principale : `#1F4F5A` (bleu-vert professionnel)
  - Fond : `#F8F8F8` (gris très clair)
  - Texte : `#333333` (gris foncé optimisé)
- **Design premium** : Style moderne et professionnel

### **2. Adaptation Tunisie**
- **Devise locale** : Tous les prix en **Dinars Tunisiens (TND)**
- **Véhicules populaires Tunisie** : Ajout de modèles comme :
  - Dacia Logan, Sandero, Duster
  - Renault Clio Tunisia
  - Peugeot 208 Tunisia
  - Citroën C3 Tunisia
- **Livraison locale** : Livraison en Tunisie avec options adaptées

### **3. Système de Recherche Avancé**
- **Barre de recherche** : Recherche dans :
  - ✏️ **Désignation produit**
  - 🔢 **Référence article (SKU)**
  - 🔍 **Référence OE** (Original Equipment)
- **Recherche intelligente** : Correspondances partielles et complètes
- **Interface moderne** : Barre de recherche avec icône et autocomplete

### **4. Références OE Complètes**
- **Chaque produit** contient 1 à plusieurs références OE
- **Recherche par OE** : Entrée officielle d'origine
- **Compatibilité garantie** : Références vérifiées
- **Exemples** : 
  - Filtre à huile : `1201E7`, `1567A4`
  - Plaquettes frein : `1609253180`, `1609253980`

### **5. Livraison Gratuite Intelligente**
- **Seuil gratuit** : Livraison gratuite à partir de **200 TND**
- **Frais standards** : 5 TND en dessous du seuil
- **Affichage dynamique** : 
  - "Livraison gratuite !" (en vert) au-dessus de 200 TND
  - "5 TND" en dessous de 200 TND
- **Retrait magasin** : Toujours gratuit

### **6. Checkout Simplifié**
- **Formulaire minimaliste** : Nom, téléphone uniquement
- **Adresse conditionnelle** : Demande l'adresse seulement si livraison choisie
- **Options claires** :
  - Livraison à domicile (5 TND - GRATUIT à partir de 200 TND)
  - Retrait en magasin (Gratuit)
- **Calculs automatiques** : Totaux mis à jour en temps réel

### **7. Optimisation Vercel**
- **Configuration Vercel** : Fichier `vercel.json` prêt pour déploiement
- **Performance optimisée** : Images, CSS, JS optimisés
- **SEO Tunisia** : Métadonnées adaptées au marché tunisien

## 🚀 **Déploiement sur Vercel**

### **Option 1 : Déploiement Manuel**
1. Aller sur [vercel.com](https://vercel.com)
2. Importer le projet
3. Vercel détecte automatiquement `vercel.json`
4. Déploiement instantané

### **Option 2 : Git Integration**
```bash
# Si vous avez un repo Git
git remote add vercel [VOTRE_VERCEL_REPO_URL]
git push vercel main
```

### **Commandes Vercel CLI**
```bash
# Installer Vercel CLI
npm i -g vercel

# Déployer
vercel

# Déployer en production
vercel --prod
```

## 🛠️ **Configuration APIs**

### **Google Images API (pour import automatique)**
```javascript
// Dans scripts/image-api.js
const imageAPIConfig = {
    googleApiKey: 'VOTRE_CLE_API_GOOGLE',
    googleCseId: 'VOTRE_ID_MOTEUR_RECHERCHE',
    // ... autres configs
};
```

### **Apis Fournisseurs Tunisiens**
```javascript
// Dans data/config.json
{
  "suppliers": [
    {
      "name": "Fournisseur Tunisie 1",
      "apiEndpoint": "https://api.fournisseur-tunisie.com",
      "imageEndpoint": "https://images.fournisseur-tunisie.com"
    }
  ]
}
```

## 🎯 **Fonctionnalités E-commerce**

### **Catalogue Intelligent**
- **6 catégories** : Moteur, Freinage, Suspension, Électrique, Carrosserie, Intérieur
- **Images automatiques** : Import depuis Google Images
- **Stock temps réel** : Badges de disponibilité
- **Responsive** : Mobile, tablette, desktop

### **Panier Avancé**
- **Quantités ajustables** : +/- sur chaque article
- **Calculs automatiques** : Totaux et frais de livraison
- **Persistance** : Sauvegarde dans localStorage
- **Notifications** : Feedback utilisateur en temps réel

### **Processus de Commande**
1. **Sélection véhicule** ou recherche directe
2. **Ajout panier** avec notifications
3. **Checkout simplifié** : Informations minimales
4. **Choix livraison** : Livraison ou retrait
5. **Confirmation** : Email/SMS automatique

## 📊 **Données Produit Enrichies**

### **Structure Complète**
```json
{
  "sku": "PF-001",
  "name": "Plaquettes de frein avant",
  "oeReferences": ["1609253180", "1609253980"],
  "price": 107.97,
  "category": "brake",
  "categoryName": "Freinage",
  "inStock": true,
  "imageUrl": "auto-loaded"
}
```

### **Références OE Réelles**
- **Peugeot** : 1201E7, 1609253180, 1609253280
- **Renault** : 5751G2, 1348Q3, 1348S3  
- **BMW** : 1231675, 1231705, 2231685
- **Volkswagen** : 4E0807221A, 4E0823059A

## 🎨 **Design System**

### **Variables CSS**
```css
:root {
    --primary-color: #1F4F5A;
    --secondary-bg: #F8F8F8;
    --text-primary: #333333;
    --success-color: #198754;
    --error-color: #DC3545;
}
```

### **Composants Modulaires**
- **Boutons** : Primary, Secondary, Success
- **Cartes** : Produit, Panier, Modal
- **Formulaires** : Inputs, Selects, Radio
- **Navigation** : Header, Filtres, Recherche

## 🔧 **Configuration Avancée**

### **Prix et TVA**
- **Devise** : TND (Dinars Tunisiens)
- **TVA** : 19% (configurable)
- **Remises** : Système de promotions
- **Frais** : Livraison, service

### **Zones de Livraison**
- **Tunis** : Centre-ville (gratuit >200 TND)
- **Ariena** : Banlieue (+5 TND)
- **Autres gouvernorats** : Sur devis

## 📈 **Analytics et SEO**

### **Métriques Intégrées**
- **Recherches** : Termes les plus demandés
- **Conversions** : Taux d'ajout au panier
- **Produits** : Plus vendus par catégorie
- **Géolocalisation** : Villes avec plus de commandes

### **SEO Tunisia**
- **Métadonnées** : Titre, description en français
- **Schema.org** : Données structurées
- **Sitemap** : Pages et produits
- **Canonical** : URLs optimisées

## 🚨 **Points d'Attention**

### **Production Ready**
- ✅ Charte graphique GP AUTO appliquée
- ✅ Devise TND partout
- ✅ Références OE intégrées
- ✅ Recherche par OE/SKU/nom
- ✅ Livraison gratuite >200 TND
- ✅ Checkout simplifié
- ✅ Configuration Vercel

### **À Configurer en Production**
- 🔧 **Clés API** : Google Images, fournisseurs
- 🔧 **Base de données** : Articles et stock
- 🔧 **Paiement** : Mobile Money, CB tunisienne
- 🔧 **Email/SMS** : Notifications commandes
- 🔧 **Analytics** : Google Analytics Tunisia

## 📞 **Support GP AUTO**

- **Téléphone** : +216 XX XXX XXX
- **Email** : contact@gp-auto.tn
- **Adresse** : [Votre adresse en Tunisie]
- **Horaires** : Lun-Sam 8h-18h

---

**Site développé pour GP AUTO - Général Pièces Autos**  
*Votre expert en pièces automobiles en Tunisie*

🇹🇳 **Fait avec ❤️ pour le marché tunisien**