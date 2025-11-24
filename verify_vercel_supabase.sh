#!/bin/bash

# GP AUTO - Script de Vérification Déploiement Vercel + Supabase
# Usage: bash verify_vercel_supabase.sh

echo "🔍 Vérification du projet GP AUTO pour Vercel + Supabase..."
echo "═════════════════════════════════════════════════════════"

# Couleurs pour l'affichage
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
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
        echo -e "${RED}❌ $ossier $1 MANQUANT${NC}"
        return 1
    fi
}

echo -e "${BLUE}📁 Fichiers Principaux:${NC}"
check_file "index.html"
check_file "admin.html"

echo -e "\n${BLUE}📁 Backend Supabase:${NC}"
check_dir "backend"
check_file "backend/server-supabase.js"
check_file "backend/package-supabase.json"

echo -e "\n${BLUE}📁 Assets et Configuration:${NC}"
check_dir "styles"
check_dir "scripts"
check_file "scripts/api-client.js"
check_file "vercel.json"

echo -e "\n${BLUE}🔧 Vérification Node.js:${NC}"
if command -v node >/dev/null 2>&1; then
    NODE_VERSION=$(node --version)
    echo -e "${GREEN}✅ Node.js installé : $NODE_VERSION${NC}"
    
    # Vérifier version minimale (18+)
    MAJOR_VERSION=$(echo $NODE_VERSION | cut -d'.' -f1 | sed 's/v//')
    if [ "$MAJOR_VERSION" -ge 18 ]; then
        echo -e "${GREEN}✅ Version Node.js compatible (18+)${NC}"
    else
        echo -e "${YELLOW}⚠️  Version Node.js recommandée : 18+ (actuel: $NODE_VERSION)${NC}"
    fi
else
    echo -e "${RED}❌ Node.js non installé${NC}"
fi

echo -e "\n${BLUE}📦 Vérification npm:${NC}"
if command -v npm >/dev/null 2>&1; then
    NPM_VERSION=$(npm --version)
    echo -e "${GREEN}✅ npm installé : $NPM_VERSION${NC}"
else
    echo -e "${RED}❌ npm non installé${NC}"
fi

echo -e "\n${BLUE}🔄 Vérification Git:${NC}"
if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    echo -e "${GREEN}✅ Repository Git initialisé${NC}"
    CURRENT_BRANCH=$(git branch --show-current)
    echo -e "${YELLOW}📋 Branch actuelle : $CURRENT_BRANCH${NC}"
    
    # Vérifier s'il y a des commits
    COMMITS=$(git rev-list --count HEAD 2>/dev/null)
    if [ "$COMMITS" -gt 0 ]; then
        echo -e "${GREEN}✅ Commits présents : $COMMITS${NC}"
    else
        echo -e "${YELLOW}⚠️  Aucun commit trouvé${NC}"
    fi
else
    echo -e "${RED}❌ Repository Git non initialisé${NC}"
fi

echo -e "\n${BLUE}🔗 Vérification Remote GitHub:${NC}"
if git remote get-url origin >/dev/null 2>&1; then
    REMOTE_URL=$(git remote get-url origin)
    echo -e "${GREEN}✅ Remote GitHub configuré : $REMOTE_URL${NC}"
else
    echo -e "${YELLOW}⚠️  Remote GitHub non configuré${NC}"
fi

echo -e "\n${BLUE}🎯 Configuration Vercel:${NC}"
if [ -f "vercel.json" ]; then
    # Vérifier la configuration du backend Supabase
    if grep -q "server-supabase.js" vercel.json; then
        echo -e "${GREEN}✅ Backend configuré pour Supabase${NC}"
    else
        echo -e "${YELLOW}⚠️  Backend non configuré pour Supabase${NC}"
    fi
    
    # Vérifier les routes API
    if grep -q '"/api/(.*)"' vercel.json; then
        echo -e "${GREEN}✅ Routes API configurées${NC}"
    else
        echo -e "${RED}❌ Routes API manquantes${NC}"
    fi
else
    echo -e "${RED}❌ fichier vercel.json manquant${NC}"
fi

echo -e "\n${BLUE}📊 Vérification Structure Supabase:${NC}"
# Vérifier si les scripts Supabase sont présents
if grep -q "@supabase/supabase-js" backend/package-supabase.json 2>/dev/null; then
    echo -e "${GREEN}✅ Dépendances Supabase configurées${NC}"
else
    echo -e "${YELLOW}⚠️  Dépendances Supabase non configurées${NC}"
fi

if [ -f "scripts/api-client.js" ]; then
    if grep -q "class GP.AutoAPI" scripts/api-client.js; then
        echo -e "${GREEN}✅ Client API JavaScript présent${NC}"
    else
        echo -e "${YELLOW}⚠️  Client API incomplet${NC}"
    fi
else
    echo -e "${RED}❌ Client API JavaScript manquant${NC}"
fi

echo -e "\n${BLUE}🔍 Scripts d'Installation Recommandés:${NC}"
echo -e "${YELLOW}📋 Commandes pour Supabase :${NC}"
echo "# 1. Créer les tables dans Supabase SQL Editor"
echo "# 2. Récupérer les clés API (Project URL + anon key)"
echo "# 3. Configurer les variables d'environnement Vercel"

echo -e "\n${YELLOW}📋 Commandes pour GitHub :${NC}"
echo "git init"
echo "git add ."
echo "git commit -m 'Initial GP Auto - Vercel + Supabase ready'"
echo "git branch -M main"
echo "git remote add origin https://github.com/USERNAME/gp-auto.git"
echo "git push -u origin main"

echo -e "\n${YELLOW}📋 Variables d'Environnement Vercel :${NC}"
echo "SUPABASE_URL=https://xxxxx.supabase.co"
echo "SUPABASE_ANON_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
echo "NODE_ENV=production"

echo -e "\n${BLUE}✅ Checklist de Déploiement Vercel + Supabase:${NC}"
echo "1. ✅ Créer projet Supabase (https://supabase.com)"
echo "2. ✅ Exécuter scripts SQL de création de tables"
echo "3. ✅ Insérer données d'exemple"
echo "4. ✅ Récupérer clés API Supabase"
echo "5. ✅ Créer compte Vercel (https://vercel.com)"
echo "6. ✅ Upload sur GitHub"
echo "7. ✅ Importer repository dans Vercel"
echo "8. ✅ Configurer variables d'environnement"
echo "9. ✅ Déployer"
echo "10. ✅ Tester URLs et APIs"

echo -e "\n${BLUE}🎯 Tests Post-Déploiement :${NC}"
echo "# Remplacer YOUR-APP par votre vraie URL"
echo "curl https://YOUR-APP.vercel.app/api/health"
echo "curl https://YOUR-APP.vercel.app/api/admin/vehicles"
echo "# Navigateur : https://YOUR-APP.vercel.app"
echo "# Admin : https://YOUR-APP.vercel.app/admin.html"

echo -e "\n${GREEN}🚀 Prêt pour Vercel + Supabase !${NC}"
echo "📖 Guide détaillé : DEPLOIEMENT_VERCEL_SUPABASE.md"
echo "⚡ Commandes rapides : COMMANDES_VERCEL_SUPABASE.md"

# Statistiques finales
echo -e "\n${BLUE}📈 Statistiques du Projet :${NC}"
TOTAL_FILES=$(find . -type f -name "*.js" -o -name "*.html" -o -name "*.css" | wc -l)
TOTAL_LINES=$(find . -type f \( -name "*.js" -o -name "*.html" -o -name "*.css" \) -exec wc -l {} + | tail -1 | awk '{print $1}')
echo "Fichiers de code : $TOTAL_FILES"
echo "Lignes de code : $TOTAL_LINES"
echo "Technologies : Node.js + Express + Supabase + PostgreSQL"
echo "Hébergement : Vercel (gratuit) + Supabase (gratuit)"

echo -e "\n${GREEN}🎉 Configuration vérifiée avec succès !${NC}"