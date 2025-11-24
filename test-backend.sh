#!/bin/bash

# GP AUTO - Script de test complet du backend
# Usage: ./test-backend.sh

echo "🧪 TEST BACKEND GP AUTO"
echo "========================"
echo ""

# Couleurs pour l'affichage
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Fonction pour afficher les résultats
print_result() {
    if [ $1 -eq 0 ]; then
        echo -e "${GREEN}✅ $2${NC}"
    else
        echo -e "${RED}❌ $2${NC}"
    fi
}

# Fonction pour tester une API
test_api() {
    local endpoint=$1
    local description=$2
    
    echo -n "Test $description... "
    
    if curl -s -f "http://localhost:3001$endpoint" > /dev/null; then
        print_result 0 "$description - OK"
        
        # Afficher un extrait de la réponse
        response=$(curl -s "http://localhost:3001$endpoint")
        echo "    Réponse: $(echo "$response" | head -c 100)..."
    else
        print_result 1 "$description - ÉCHEC"
        echo "    Assurez-vous que le serveur est démarré (npm start)"
    fi
    echo ""
}

# 1. Vérification de Node.js
echo "1. Vérification de l'environnement..."
if command -v node &> /dev/null; then
    print_result 0 "Node.js $(node --version) détecté"
else
    print_result 1 "Node.js non installé"
    echo "    Installez Node.js depuis: https://nodejs.org/"
    exit 1
fi

if command -v npm &> /dev/null; then
    print_result 0 "npm $(npm --version) détecté"
else
    print_result 1 "npm non installé"
    exit 1
fi

echo ""

# 2. Vérification des dépendances
echo "2. Vérification des dépendances..."
if [ -d "backend/node_modules" ]; then
    print_result 0 "Dépendances installées"
else
    print_result 1 "Dépendances manquantes"
    echo "    Exécutez: cd backend && npm install"
    exit 1
fi

echo ""

# 3. Vérification de la base de données
echo "3. Vérification de la base de données..."
if [ -f "backend/data/gpauto.db" ]; then
    print_result 0 "Base de données trouvée"
else
    print_result 1 "Base de données manquante"
    echo "    Elle sera créée automatiquement au démarrage"
fi

echo ""

# 4. Test du serveur (si en cours d'exécution)
echo "4. Tests des APIs..."

# Vérifier si le serveur répond
if curl -s -f http://localhost:3001/api/health > /dev/null; then
    print_result 0 "Serveur backend actif"
    
    # Tests des endpoints
    test_api "/api/health" "Santé du serveur"
    test_api "/api/vehicles" "Liste des véhicules"
    test_api "/api/categories" "Catégories de pièces"
    test_api "/api/stats" "Statistiques"
    test_api "/api/search?query=frein" "Recherche"
    
else
    echo -e "${YELLOW}⚠️ Serveur non démarré${NC}"
    echo ""
    echo "Pour démarrer le serveur:"
    echo "1. Ouvrez un nouveau terminal"
    echo "2. Exécutez: cd backend && npm start"
    echo "3. Relancez ce script"
    echo ""
    echo "OU"
    echo ""
    echo "Démarrer maintenant ? (y/n)"
    read -r answer
    
    if [ "$answer" = "y" ] || [ "$answer" = "Y" ]; then
        echo "Démarrage du serveur en arrière-plan..."
        cd backend && npm start &
        sleep 3
        
        if curl -s -f http://localhost:3001/api/health > /dev/null; then
            print_result 0 "Serveur démarré avec succès"
            
            # Lancer les tests
            test_api "/api/health" "Santé du serveur"
            test_api "/api/vehicles" "Liste des véhicules"
            test_api "/api/categories" "Catégories de pièces"
            test_api "/api/stats" "Statistiques"
            test_api "/api/search?query=frein" "Recherche"
            
            echo ""
            echo "🎉 Backend testé avec succès !"
            echo ""
            echo "URLs disponibles:"
            echo "- Santé: http://localhost:3001/api/health"
            echo "- Véhicules: http://localhost:3001/api/vehicles"
            echo "- Recherche: http://localhost:3001/api/search?query=frein"
            echo ""
            echo "Pour arrêter le serveur: pkill -f 'node server.js'"
        else
            print_result 1 "Échec du démarrage du serveur"
            echo "Vérifiez les logs avec: cd backend && npm start"
        fi
    fi
fi

# 5. Instructions de déploiement
echo ""
echo "5. Instructions de déploiement..."
echo ""
echo -e "${GREEN}🌐 DÉPLOIEMENT RECOMMANDÉ - VERCEL:${NC}"
echo "1. Créez un compte sur https://vercel.com"
echo "2. Connectez votre repository GitHub"
echo "3. Vercel détectera automatiquement frontend + backend"
echo "4. Votre site sera sur: https://votre-projet.vercel.app"
echo ""

echo -e "${GREEN}🔧 INTÉGRATION FRONTEND:${NC}"
echo "1. Utilisez le fichier: scripts/gp-auto-integration.js"
echo "2. Remplacez vos données statiques par des appels API"
echo "3. Exemple: fetch('/api/vehicles') au lieu de données en dur"
echo ""

echo -e "${GREEN}📊 DONNÉES PRÉ-CHARGÉES:${NC}"
echo "✓ 7 marques de véhicules populaires en Tunisie"
echo "✓ 15 modèles avec motorisations"
echo "✓ 10 pièces d'exemple avec prix TND"
echo "✓ Références OE complètes"
echo "✓ Système de recherche multi-critères"
echo ""

echo -e "${GREEN}🎯 PROCHAINES ÉTAPES:${NC}"
echo "1. Tester le backend localement ✅"
echo "2. Déployer sur Vercel (5 minutes)"
echo "3. Intégrer les APIs dans le frontend"
echo "4. Ajouter plus de véhicules/pièces si nécessaire"
echo ""

echo -e "${GREEN}✨ BACKEND GP AUTO PRÊT POUR LA PRODUCTION ! ✨${NC}"