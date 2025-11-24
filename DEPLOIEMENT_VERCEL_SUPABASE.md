# 🚀 Déploiement GP AUTO - Vercel + Supabase

## 🎯 Pourquoi Vercel + Supabase ?

### ✅ Avantages
- **Gratuit** : 100GB de données + base de données PostgreSQL gratuite
- **Performance** : CDN global ultra-rapide
- **Simplicité** : Déploiement automatique depuis GitHub
- **Moderne** : Technologies cloud natives
- **Évolutif** : Upgrade facile selon vos besoins

### 📊 Comparaison des Coûts
- **DigitalOcean** : 5$/mois minimum
- **Vercel + Supabase** : **GRATUIT** (limite : 100GB + 50MB DB)
- **Upgrade futur** : Vercel Pro 20$/mois ou Supabase Pro 25$/mois

---

## 🏗️ Architecture du Déploiement

```
GP AUTO Déploiement
├── Vercel (Frontend + Backend API)
│   ├── index.html (site public)
│   ├── admin.html (panel admin)
│   ├── styles/, scripts/ (assets)
│   └── /api routes (Node.js functions)
└── Supabase (Base de Données PostgreSQL)
    ├── tables: vehicles, engines, parts, part_vehicle_relations
    ├── API endpoints automatiques
    └── Auth (optionnel)
```

---

## 📋 Étape 1 : Préparation Supabase

### 1.1 Créer Compte Supabase
1. Aller sur [supabase.com](https://supabase.com)
2. Cliquer "Start your project"
3. Créer compte avec GitHub/Google
4. Créer nouveau projet :
   - **Nom** : `gp-auto-tunisia`
   - **Mot de passe DB** : `votre-mot-de-passe-securise`
   - **Region** : Europe West (Ireland) - le plus proche de la Tunisie

### 1.2 Créer les Tables
Dans l'interface Supabase → SQL Editor, exécuter :

```sql
-- Table des véhicules
CREATE TABLE vehicles (
    id SERIAL PRIMARY KEY,
    brand VARCHAR(50) NOT NULL,
    model VARCHAR(100) NOT NULL,
    year_from INTEGER,
    year_to INTEGER,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT TIMEZONE('utc'::text, NOW())
);

-- Table des motorisations
CREATE TABLE engines (
    id SERIAL PRIMARY KEY,
    vehicle_id INTEGER REFERENCES vehicles(id) ON DELETE CASCADE,
    engine VARCHAR(50) NOT NULL,
    fuel_type VARCHAR(20) NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT TIMEZONE('utc'::text, NOW())
);

-- Table des pièces
CREATE TABLE parts (
    id SERIAL PRIMARY KEY,
    name VARCHAR(200) NOT NULL,
    sku VARCHAR(50) UNIQUE NOT NULL,
    category VARCHAR(50) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    stock INTEGER DEFAULT 0,
    description TEXT,
    image_url TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT TIMEZONE('utc'::text, NOW()),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT TIMEZONE('utc'::text, NOW())
);

-- Table des relations pièces-véhicules
CREATE TABLE part_vehicle_relations (
    part_id INTEGER REFERENCES parts(id) ON DELETE CASCADE,
    vehicle_id INTEGER REFERENCES vehicles(id) ON DELETE CASCADE,
    PRIMARY KEY (part_id, vehicle_id),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT TIMEZONE('utc'::text, NOW())
);

-- Index pour les performances
CREATE INDEX idx_vehicles_brand ON vehicles(brand);
CREATE INDEX idx_engines_vehicle_id ON engines(vehicle_id);
CREATE INDEX idx_parts_category ON parts(category);
CREATE INDEX idx_part_vehicle_relations_part ON part_vehicle_relations(part_id);
CREATE INDEX idx_part_vehicle_relations_vehicle ON part_vehicle_relations(vehicle_id);
```

### 1.3 Insérer les Données d'Exemple
```sql
-- Véhicules
INSERT INTO vehicles (brand, model, year_from, year_to) VALUES
('Renault', 'Clio', 1990, 2019),
('Renault', 'Megane', 1995, 2022),
('Peugeot', '208', 2012, 2022),
('Citroën', 'C3', 2002, 2022),
('Dacia', 'Sandero', 2009, 2022),
('Dacia', 'Duster', 2009, 2022),
('Peugeot', '308', 2007, 2021);

-- Motorisations
INSERT INTO engines (vehicle_id, engine, fuel_type) 
SELECT v.id, '1.2L', 'Essence' FROM vehicles v WHERE v.brand = 'Renault' AND v.model = 'Clio'
UNION ALL
SELECT v.id, '1.5L dCi', 'Diesel' FROM vehicles v WHERE v.brand = 'Renault' AND v.model = 'Clio'
UNION ALL
SELECT v.id, '1.6L', 'Essence' FROM vehicles v WHERE v.brand = 'Renault' AND v.model = 'Megane'
UNION ALL
SELECT v.id, '1.2L', 'Essence' FROM vehicles v WHERE v.brand = 'Peugeot' AND v.model = '208'
UNION ALL
SELECT v.id, '1.5L', 'Diesel' FROM vehicles v WHERE v.brand = 'Peugeot' AND v.model = '208'
UNION ALL
SELECT v.id, '1.2L', 'Essence' FROM vehicles v WHERE v.brand = 'Citroën' AND v.model = 'C3'
UNION ALL
SELECT v.id, '1.0L', 'Essence' FROM vehicles v WHERE v.brand = 'Dacia' AND v.model = 'Sandero'
UNION ALL
SELECT v.id, '1.5L dCi', 'Diesel' FROM vehicles v WHERE v.brand = 'Dacia' AND v.model = 'Duster';

-- Pièces
INSERT INTO parts (name, sku, category, price, stock, description) VALUES
('Plaquettes de frein avant', 'PF001', 'freins', 35.99, 50, 'Plaquettes de frein avant pour véhicules compacts'),
('Filtre à huile', 'FH001', 'moteur', 12.50, 100, 'Filtre à huile moteur haute performance'),
('Bougies d''allumage', 'BA001', 'moteur', 8.75, 200, 'Jeu de 4 bougies d''allumage'),
('Disque de frein avant', 'DF001', 'freins', 65.00, 25, 'Disque de frein ventilé avant'),
('Amortisseur avant', 'AM001', 'suspension', 89.99, 30, 'Amortisseur avant droit/gauche'),
('Batterie auto 12V', 'BT001', 'electrique', 120.00, 15, 'Batterie 12V 60Ah Start-Stop'),
('Essuie-glace avant', 'EG001', 'carrosserie', 15.00, 75, 'Essuie-glace avant 60cm'),
('Pneus 195/65R15', 'PN001', 'pneumatiques', 180.00, 40, 'Pneu été 195/65R15 91V'),
('Courroie de distribution', 'CD001', 'moteur', 45.50, 20, 'Kit courroie de distribution + galets'),
('Feu arrière droit', 'FR001', 'electrique', 55.00, 35, 'Feu arrière droit complet');
```

### 1.4 Récupérer les Clés API Supabase
Dans Supabase → Settings → API :
- **Project URL** : `https://xxxxx.supabase.co`
- **anon public** : `eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...`
- **service_role** : `eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...` (garder secret !)

---

## 🌍 Étape 2 : Déploiement Vercel

### 2.1 Créer Compte Vercel
1. Aller sur [vercel.com](https://vercel.com)
2. Cliquer "Sign Up" → GitHub (recommandé)
3. Se connecter avec GitHub

### 2.2 Upload sur GitHub
Créer repository GitHub et uploader vos fichiers :
```bash
git init
git add .
git commit -m "Initial GP Auto - ready for Vercel + Supabase"
git branch -M main
git remote add origin https://github.com/USERNAME/gp-auto.git
git push -u origin main
```

### 2.3 Déployer sur Vercel
1. Dans Vercel → "New Project"
2. Importer GitHub repository `gp-auto`
3. Configuration automatique détectée :
   - **Framework** : Other
   - **Build Command** : `echo "No build needed"`
   - **Output Directory** : `/`
   - **Install Command** : `npm install`

### 2.4 Configuration des Variables d'Environnement
Dans Vercel → Project Settings → Environment Variables :

```
SUPABASE_URL=https://xxxxx.supabase.co
SUPABASE_ANON_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
NODE_ENV=production
```

### 2.5 URL de Déploiement
Vercel fournit automatiquement :
- **Production** : `https://gp-auto-tunisia.vercel.app`
- **Preview** : URLs temporaires pour tests

---

## 🔧 Étape 3 : Configuration du Backend

### 3.1 Adaptations pour Supabase
Créer `backend/supabase.js` :
```javascript
// backend/supabase.js
const { createClient } = require('@supabase/supabase-js');

const supabaseUrl = process.env.SUPABASE_URL;
const supabaseKey = process.env.SUPABASE_ANON_KEY;

if (!supabaseUrl || !supabaseKey) {
    throw new Error('Missing Supabase configuration');
}

const supabase = createClient(supabaseUrl, supabaseKey);

module.exports = supabase;
```

### 3.2 Nouveau Package.json
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
    "@supabase/supabase-js": "^2.38.0",
    "cors": "^2.8.5"
  },
  "devDependencies": {
    "nodemon": "^3.0.1"
  }
}
```

### 3.3 Adaptation du Server.js
```javascript
// backend/server.js - Adaptation Supabase
const express = require('express');
const cors = require('cors');
const supabase = require('./supabase');

const app = express();
const PORT = process.env.PORT || 3000;

app.use(cors());
app.use(express.json());

// API Routes...
app.get('/api/health', async (req, res) => {
    try {
        const { data, error } = await supabase
            .from('vehicles')
            .select('count', { count: 'exact' })
            .limit(1);
            
        res.json({ 
            status: 'OK', 
            message: 'GP Auto API Server running with Supabase',
            timestamp: new Date().toISOString(),
            database: 'supabase'
        });
    } catch (error) {
        res.status(500).json({ error: 'Database connection failed' });
    }
});

// Vehicle Routes
app.get('/api/admin/vehicles', async (req, res) => {
    try {
        // Récupérer véhicules avec leurs motorisations
        const { data: vehicles, error } = await supabase
            .from('vehicles')
            .select('*, engines(*)')
            .order('brand', { ascending: true });
            
        if (error) throw error;
        
        // Grouper par véhicule
        const vehiclesMap = new Map();
        vehicles.forEach(vehicle => {
            if (!vehiclesMap.has(vehicle.id)) {
                vehiclesMap.set(vehicle.id, {
                    id: vehicle.id,
                    brand: vehicle.brand,
                    model: vehicle.model,
                    year_from: vehicle.year_from,
                    year_to: vehicle.year_to,
                    engines: []
                });
            }
            if (vehicle.engines && vehicle.engines.length > 0) {
                vehiclesMap.get(vehicle.id).engines.push(...vehicle.engines);
            }
        });
        
        res.json(Array.from(vehiclesMap.values()));
    } catch (error) {
        console.error('Error:', error);
        res.status(500).json({ error: 'Failed to fetch vehicles' });
    }
});

app.post('/api/vehicles', async (req, res) => {
    const { brand, model, year_from, year_to, engines } = req.body;
    
    try {
        // Créer le véhicule
        const { data: vehicle, error: vehicleError } = await supabase
            .from('vehicles')
            .insert({ brand, model, year_from, year_to })
            .select()
            .single();
            
        if (vehicleError) throw vehicleError;
        
        // Créer les motorisations
        const enginesData = engines.map(engine => ({
            vehicle_id: vehicle.id,
            engine: engine.engine,
            fuel_type: engine.fuel_type
        }));
        
        const { error: enginesError } = await supabase
            .from('engines')
            .insert(enginesData);
            
        if (enginesError) throw enginesError;
        
        res.json({ 
            success: true, 
            vehicle_id: vehicle.id, 
            engines_count: engines.length 
        });
    } catch (error) {
        console.error('Error:', error);
        res.status(500).json({ error: 'Failed to create vehicle' });
    }
});

// Part Routes
app.post('/api/parts', async (req, res) => {
    const { name, sku, category, price, stock, description, vehicle_ids } = req.body;
    
    try {
        // Créer la pièce
        const { data: part, error: partError } = await supabase
            .from('parts')
            .insert({ name, sku, category, price, stock, description })
            .select()
            .single();
            
        if (partError) throw partError;
        
        // Créer les relations avec véhicules
        if (vehicle_ids && vehicle_ids.length > 0) {
            const relations = vehicle_ids.map(vehicle_id => ({
                part_id: part.id,
                vehicle_id: vehicle_id
            }));
            
            const { error: relationsError } = await supabase
                .from('part_vehicle_relations')
                .insert(relations);
                
            if (relationsError) throw relationsError;
        }
        
        res.json({ 
            success: true, 
            part_id: part.id,
            vehicle_count: vehicle_ids ? vehicle_ids.length : 0
        });
    } catch (error) {
        console.error('Error:', error);
        res.status(500).json({ error: 'Failed to create part' });
    }
});

app.listen(PORT, () => {
    console.log(`GP Auto API Server running on port ${PORT}`);
    console.log(`Database: Supabase PostgreSQL`);
});
```

---

## 🎯 Étape 4 : Configuration Frontend

### 4.1 Modifier les URLs API
Dans `scripts/main.js` et `scripts/admin.js` :

```javascript
// Remplacer par vos URLs Vercel
const API_BASE_URL = 'https://gp-auto-tunisia.vercel.app/api';
```

### 4.2 API Client Helper
Créer `scripts/api-client.js` :
```javascript
// scripts/api-client.js
class GP.AutoAPI {
    constructor() {
        this.baseURL = 'https://gp-auto-tunisia.vercel.app/api';
    }
    
    async request(endpoint, options = {}) {
        const url = `${this.baseURL}${endpoint}`;
        const response = await fetch(url, {
            headers: {
                'Content-Type': 'application/json',
                ...options.headers
            },
            ...options
        });
        
        if (!response.ok) {
            throw new Error(`API Error: ${response.statusText}`);
        }
        
        return response.json();
    }
    
    // Health check
    async health() {
        return this.request('/health');
    }
    
    // Vehicles
    async getVehicles() {
        return this.request('/admin/vehicles');
    }
    
    async createVehicle(data) {
        return this.request('/vehicles', {
            method: 'POST',
            body: JSON.stringify(data)
        });
    }
    
    // Parts
    async getParts() {
        return this.request('/admin/parts');
    }
    
    async createPart(data) {
        return this.request('/parts', {
            method: 'POST',
            body: JSON.stringify(data)
        });
    }
}

GP.AutoAPI = new GP.AutoAPI();
```

---

## ✅ Étape 5 : Tests et Déploiement

### 5.1 Test Local
```bash
cd backend
npm install
export SUPABASE_URL=https://xxxxx.supabase.co
export SUPABASE_ANON_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
node server.js
```

### 5.2 Déploiement
1. Commit et push sur GitHub
2. Vercel déploie automatiquement
3. Tester les URLs

### 5.3 Tests Post-Déploiement
```bash
# Test santé
curl https://gp-auto-tunisia.vercel.app/api/health

# Test véhicules
curl https://gp-auto-tunisia.vercel.app/api/admin/vehicles

# Test création véhicule
curl -X POST https://gp-auto-tunisia.vercel.app/api/vehicles \
  -H "Content-Type: application/json" \
  -d '{
    "brand": "Test",
    "model": "Test",
    "year_from": 2020,
    "engines": [{"engine": "1.0L", "fuel_type": "Essence"}]
  }'
```

---

## 💰 Coûts et Limites

### Gratuit Vercel
- **Bande passante** : 100GB/mois
- **Builds** : 100 deploys/mois
- **Functions** : 1000 calls/jour
- **SSL** : ✅ Inclus
- **CDN** : ✅ Global

### Gratuit Supabase
- **Base de données** : 500MB
- **API calls** : 50,000/jour
- **Storage** : 1GB
- **Auth** : 50,000 users
- **Real-time** : ✅ Inclus

### Upgrade Future
- **Vercel Pro** : 20$/mois (inlimité)
- **Supabase Pro** : 25$/mois (8GB DB)

---

## 🎯 Résultat Final

**Votre site GP AUTO sera :**
- ✅ **100% gratuit** au démarrage
- ✅ **Ultra-rapide** (CDN global)
- ✅ **Moderne** (PostgreSQL + Edge functions)
- ✅ **Évolutif** (upgrade facile)
- ✅ **Sécurisé** (HTTPS automatique)

**URLs finales :**
- **Site** : `https://gp-auto-tunisia.vercel.app`
- **Admin** : `https://gp-auto-tunisia.vercel.app/admin.html`
- **API** : `https://gp-auto-tunisia.vercel.app/api`

**🎉 Version 100% moderne et gratuite de votre site GP AUTO !**