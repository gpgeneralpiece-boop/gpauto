#!/bin/bash

# GP AUTO - Script de Vérification Déploiement
# Usage: bash verify_deployment.sh

echo "🔍 Vérification du projet GP AUTO pour déploiement..."
echo "================================================="

# Couleurs pour l'affichage
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Fonction de vérification
check_file() {
    if [ -f "$1" ]; then
        echo -e "${GREEN}✅ $1${NC}"
        return 0
    else
        echo -e "${RED}❌ $1 MANQUANT${NC}"
        return 1
    fi
}

check_dir() {
    if [ -d "$1" ]; then
        echo -e "${GREEN}✅ Dossier $1${NC}"
        return 0
    else
        echo -e "${RED}❌ Dossier $1 MANQUANT${NC}"
        return 1
    fi
}

echo "📁 Fichiers Principaux:"
check_file "index.html"
check_file "admin.html"

echo -e "\n📁 Backend:"
check_dir "backend"
check_file "backend/server.js"
check_file "backend/package.json"
check_file "backend/migrate_to_new_structure.js"

echo -e "\n📁 Assets:"
check_dir "styles"
check_dir "scripts"
check_file "styles/main.css"
check_file "scripts/main.js"

echo -e "\n📁 Configuration:"
check_file ".do/app.yaml"

echo -e "\n🔧 Vérification Node.js:"
if command -v node >/dev/null 2>&1; then
    echo -e "${GREEN}✅ Node.js installé : $(node --version)${NC}"
else
    echo -e "${RED}❌ Node.js non installé${NC}"
fi

echo -e "\n📦 Vérification npm:"
if command -v npm >/dev/null 2>&1; then
    echo -e "${GREEN}✅ npm installé : $(npm --version)${NC}"
else
    echo -e "${RED}❌ npm non installé${NC}"
fi

echo -e "\n🔄 Vérification Git:"
if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    echo -e "${GREEN}✅ Repository Git initialisé${NC}"
    echo -e "${YELLOW}📋 Branch actuelle : $(git branch --show-current)${NC}"
else
    echo -e "${RED}❌ Repository Git non initialisé${NC}"
fi

echo -e "\n📋 Checklist de Déploiement:"
echo "1. ✅ Créer compte DigitalOcean"
echo "2. ✅ Créer repository GitHub"
echo "3. ✅ Upload sur GitHub (git push)"
echo "4. ✅ Configurer .do/app.yaml avec votre username"
echo "5. ✅ Déployer sur DigitalOcean"
echo "6. ✅ Mettre à jour les URLs dans les scripts JS"

echo -e "\n🚀 Commandes Rapides:"
echo "# Initialiser Git (si pas fait)"
echo "git init && git add . && git commit -m 'Initial GP Auto'"
echo ""
echo "# Lier GitHub (remplacer VOTRE-USERNAME)"
echo "git remote add origin https://github.com/VOTRE-USERNAME/gp-auto.git"
echo "git branch -M main && git push -u origin main"
echo ""
echo "# Tester après déploiement"
echo "curl https://VOTRE-APP-URL.ondigitalocean.app/api/health"

echo -e "\n${GREEN}🎯 Prêt pour le déploiement !${NC}"
echo "Suivez le guide : DEPLOIEMENT_DIGITALOCEAN.md"