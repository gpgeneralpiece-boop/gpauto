# ⚡ Commandes Rapides - GP AUTO sur Vercel + Supabase

## 🎯 Setup en 3 Étapes (20 minutes)

### 1️⃣ Supabase (5 minutes)
```sql
-- Dans Supabase SQL Editor
CREATE TABLE vehicles (
    id SERIAL PRIMARY KEY,
    brand VARCHAR(50) NOT NULL,
    model VARCHAR(100) NOT NULL,
    year_from INTEGER,
    year_to INTEGER,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT TIMEZONE('utc'::text, NOW())
);

CREATE TABLE engines (
    id SERIAL PRIMARY KEY,
    vehicle_id INTEGER REFERENCES vehicles(id) ON DELETE CASCADE,
    engine VARCHAR(50) NOT NULL,
    fuel_type VARCHAR(20) NOT NULL
);

CREATE TABLE parts (
    id SERIAL PRIMARY KEY,
    name VARCHAR(200) NOT NULL,
    sku VARCHAR(50) UNIQUE NOT NULL,
    category VARCHAR(50) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    stock INTEGER DEFAULT 0,
    description TEXT,
    image_url TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT TIMEZONE('utc'::text, NOW())
);

CREATE TABLE part_vehicle_relations (
    part_id INTEGER REFERENCES parts(id) ON DELETE CASCADE,
    vehicle_id INTEGER REFERENCES vehicles(id) ON DELETE CASCADE,
    PRIMARY KEY (part_id, vehicle_id)
);

-- Insert sample data
INSERT INTO vehicles (brand, model, year_from, year_to) VALUES
('Renault', 'Clio', 1990, 2019),
('Renault', 'Megane', 1995, 2022),
('Peugeot', '208', 2012, 2022),
('Citroën', 'C3', 2002, 2022),
('Dacia', 'Sandero', 2009, 2022);

-- Motorisations
INSERT INTO engines (vehicle_id, engine, fuel_type) 
SELECT v.id, '1.2L', 'Essence' FROM vehicles v WHERE v.brand = 'Renault' AND v.model = 'Clio'
UNION ALL
SELECT v.id, '1.5L dCi', 'Diesel' FROM vehicles v WHERE v.brand = 'Renault' AND v.model = 'Clio';
```

### 2️⃣ GitHub Upload (2 minutes)
```bash
git init
git add .
git commit -m "Initial GP Auto - Vercel + Supabase ready"
git branch -M main
git remote add origin https://github.com/USERNAME/gp-auto.git
git push -u origin main
```

### 3️⃣ Vercel Deploy (10 minutes)
1. **Aller sur** [vercel.com](https://vercel.com)
2. **Sign Up** → GitHub
3. **New Project** → Import `gp-auto`
4. **Configure** :
   - Framework: Other
   - Build: `echo "No build needed"`
   - Output: `/`
5. **Environment Variables** :
   ```
   SUPABASE_URL=https://xxxxx.supabase.co
   SUPABASE_ANON_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
   ```
6. **Deploy** → Attendre 2-3 minutes

---

## 🔗 URLs Finales

```bash
# Remplacer YOUR-APP par votre vraie URL Vercel
Site Public:     https://YOUR-APP.vercel.app
Panel Admin:     https://YOUR-APP.vercel.app/admin.html  
API Backend:     https://YOUR-APP.vercel.app/api
```

---

## 🔧 Configuration Frontend

### Mise à jour des URLs
Dans `scripts/main.js` et `scripts/admin.js` :

```javascript
// Ajouter au début du fichier
<script src="scripts/api-client.js"></script>

// Utiliser l'API client
GP.AutoAPI.health().then(result => {
    console.log('API Status:', result);
});

// Pour les véhicules
GP.AutoAPI.getVehicles().then(vehicles => {
    console.log('Vehicles:', vehicles);
});

// Pour créer une pièce
GP.AutoAPI.createPart({
    name: 'Plaquettes de frein',
    sku: 'PF001',
    category: 'freins',
    price: 35.99,
    stock: 50,
    vehicle_ids: [1, 2, 3] // IDs des véhicules compatibles
}).then(result => {
    console.log('Part created:', result);
});
```

---

## ✅ Tests Rapides

### 1. Test Santé
```bash
curl https://YOUR-APP.vercel.app/api/health

# Résultat attendu :
# {"status":"OK","message":"GP Auto API Server running with Supabase","database":"supabase"}
```

### 2. Test Véhicules
```bash
curl https://YOUR-APP.vercel.app/api/admin/vehicles

# Résultat attendu :
# Array d'objets avec id, brand, model, engines
```

### 3. Test Création Véhicule
```bash
curl -X POST https://YOUR-APP.vercel.app/api/vehicles \
  -H "Content-Type: application/json" \
  -d '{
    "brand": "BMW",
    "model": "Série 1",
    "year_from": 2020,
    "engines": [
      {"engine": "1.5L", "fuel_type": "Essence"},
      {"engine": "2.0L", "fuel_type": "Diesel"}
    ]
  }'
```

### 4. Test Navigation
- ✅ Site principal : `https://YOUR-APP.vercel.app`
- ✅ Panel admin : `https://YOUR-APP.vercel.app/admin.html`
- ✅ Console navigateur : Pas d'erreurs JS

---

## 🛠️ Debug et Maintenance

### Console Navigateur
```javascript
// Test connexion API
GP_API_TEST();

// Statistiques d'usage
GP_API_STATS();

// Voir les logs API
GP_API_LOGS();
```

### Variables d'Environnement Vercel
```
SUPABASE_URL=https://xxxxx.supabase.co
SUPABASE_ANON_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
NODE_ENV=production
```

### Logs Vercel
1. Dashboard Vercel → Project → Functions
2. Cliquer sur une fonction pour voir les logs
3. Filtrer par niveau (ERROR, INFO, etc.)

---

## 🚨 Problèmes Courants

### ❌ "Missing Supabase configuration"
**Solution** : Vérifier les variables d'environnement Vercel
```
SUPABASE_URL=https://xxxxx.supabase.co
SUPABASE_ANON_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
```

### ❌ "Database connection failed"
**Solution** : 
1. Vérifier la clé API Supabase
2. Regarder les tables dans Supabase Dashboard
3. Tester la connexion dans SQL Editor

### ❌ "Route not found"
**Solution** : Vérifier `vercel.json` configuration
```json
{
  "src": "/api/(.*)",
  "dest": "backend/server-supabase.js"
}
```

### ❌ "Functions timeout"
**Solution** : Réduire le temps de réponse des requêtes
- Optimiser les requêtes SQL
- Ajouter des indexes
- Limiter les données retournées

---

## 📊 Monitoring

### Supabase Dashboard
- **Tables** : Voir données en temps réel
- **API** : Monitor les requêtes
- **Logs** : Erreurs et performances
- **Storage** : Images et fichiers

### Vercel Dashboard  
- **Deployments** : Historique des déploiements
- **Functions** : Logs des APIs
- **Analytics** : Performance et trafic
- **Settings** : Variables d'environnement

---

## 🔄 Mises à Jour

### Code
```bash
git add .
git commit -m "Description des changements"
git push origin main
# Déploiement automatique !
```

### Base de Données
1. Modifier les tables dans Supabase SQL Editor
2. Ou utiliser Supabase CLI pour migrations

### Variables Environment
1. Vercel Dashboard → Project → Settings → Environment Variables
2. Modifier/ajouter les variables
3. Redéployer (optionnel, souvent automatique)

---

## 💰 Coûts Final

### Gratuit Forever
- **Vercel** : 100GB bandwidth + 100 deploys/mois
- **Supabase** : 500MB database + 50k API calls/jour
- **SSL** : ✅ Inclus
- **CDN** : ✅ Global
- **Monitoring** : ✅ Inclus

### Upgrade Options
- **Vercel Pro** : 20$/mois (illimité)
- **Supabase Pro** : 25$/mois (8GB DB)

---

## 🎯 Résultat Final

**Votre site GP AUTO sera :**
- ✅ **100% gratuit** et moderne
- ✅ **Accessible 24/7** avec SSL
- ✅ **Ultra-rapide** avec CDN global
- ✅ **Admin fonctionnel** avec nouvelles features
- ✅ **Base PostgreSQL** évolutive

**Temps total : 20 minutes pour un site e-commerce professionnel !**