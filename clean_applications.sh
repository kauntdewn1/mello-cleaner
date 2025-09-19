#!/bin/bash

echo "📱 LIMPANDO APLICATIVOS - REVISAR APPS NÃO UTILIZADOS"
echo "===================================================="
echo ""

APPLICATIONS="/Applications"
BACKUP_DIR="/Users/nettomello/Desktop/📁 Apps Removidos"

# Criar pasta de backup
mkdir -p "$BACKUP_DIR"

echo "📊 Analisando aplicativos instalados..."
echo ""

# Listar todos os aplicativos
echo "📱 APLICATIVOS INSTALADOS:"
echo "=========================="

# Contar total
total_apps=$(find "$APPLICATIONS" -name "*.app" -maxdepth 1 | wc -l)
echo "Total de aplicativos: $total_apps"
echo ""

# Mostrar aplicativos com tamanho
echo "📱 Aplicativos por tamanho (maiores primeiro):"
echo "----------------------------------------------"

find "$APPLICATIONS" -name "*.app" -maxdepth 1 -exec du -sh {} \; | sort -hr | head -20 | while read size app; do
    app_name=$(basename "$app" .app)
    echo "  📦 $app_name ($size)"
done

echo ""
echo "📱 Aplicativos por data de modificação (mais antigos primeiro):"
echo "--------------------------------------------------------------"

find "$APPLICATIONS" -name "*.app" -maxdepth 1 -exec ls -lt {} \; | head -20 | while read line; do
    if [[ "$line" =~ ^d ]]; then
        date=$(echo "$line" | awk '{print $6, $7, $8}')
        app=$(echo "$line" | awk '{print $9}' | sed 's|/Applications/||' | sed 's|.app||')
        echo "  📅 $app - $date"
    fi
done

echo ""
echo "🔍 Aplicativos suspeitos (nomes estranhos ou duplicados):"
echo "--------------------------------------------------------"

# Procurar por aplicativos com nomes suspeitos
find "$APPLICATIONS" -name "*.app" -maxdepth 1 | while read app; do
    app_name=$(basename "$app" .app)
    
    # Verificar se tem números no nome (pode ser versão antiga)
    if [[ "$app_name" =~ [0-9] ]]; then
        echo "  🔢 $app_name (contém números)"
    fi
    
    # Verificar se tem "Copy" ou similar
    if [[ "$app_name" =~ -[0-9]|Copy|copy|BACKUP|backup ]]; then
        echo "  📋 $app_name (possível duplicata)"
    fi
done

echo ""
echo "📱 Aplicativos do sistema (NÃO REMOVER):"
echo "---------------------------------------"

# Listar aplicativos do sistema que não devem ser removidos
system_apps=("Safari" "Mail" "Messages" "FaceTime" "Photos" "Music" "TV" "Podcasts" "News" "Stocks" "Weather" "Clock" "Calculator" "Calendar" "Contacts" "Maps" "Reminders" "Notes" "Voice Memos" "Home" "Shortcuts" "System Preferences" "Activity Monitor" "AirPort Utility" "Audio MIDI Setup" "Bluetooth File Exchange" "Boot Camp Assistant" "ColorSync Utility" "Console" "Digital Color Meter" "Disk Utility" "Font Book" "Grapher" "Keychain Access" "Migration Assistant" "Network Utility" "System Information" "Terminal" "VoiceOver Utility")

for app in "${system_apps[@]}"; do
    if [ -d "$APPLICATIONS/$app.app" ]; then
        echo "  ⚙️ $app (Sistema)"
    fi
done

echo ""
echo "🎯 PRÓXIMOS PASSOS:"
echo "==================="
echo "1. Revisar a lista acima"
echo "2. Identificar aplicativos que não usa mais"
echo "3. Executar remoção seletiva"
echo ""
echo "💡 DICA: Aplicativos com números no nome podem ser versões antigas"
echo "💡 DICA: Aplicativos muito antigos (6+ meses) provavelmente não são usados"
echo ""
echo "⚠️  CUIDADO: NÃO remova aplicativos do sistema (Safari, Mail, etc.)"
