#!/bin/bash

echo "🗑️ REMOVENDO APLICATIVOS - REMOÇÃO SEGURA"
echo "========================================="
echo ""

APPLICATIONS="/Applications"
BACKUP_DIR="/Users/nettomello/Desktop/📁 Apps Removidos"

# Criar pasta de backup
mkdir -p "$BACKUP_DIR"

echo "📱 Escolha o que fazer:"
echo ""
echo "1. 🔍 Ver análise de aplicativos"
echo "2. 🗑️ Remover aplicativo específico"
echo "3. 🧹 Limpeza automática (aplicativos antigos)"
echo "4. ❌ Sair"
echo ""

read -p "Digite sua escolha (1-4): " choice

case $choice in
    1)
        echo "🔍 Executando análise..."
        ./clean_applications.sh
        ;;
    2)
        echo "🗑️ Remoção de aplicativo específico"
        echo "===================================="
        echo ""
        echo "Digite o nome do aplicativo (sem .app):"
        read -p "Nome: " app_name
        
        if [ -d "$APPLICATIONS/$app_name.app" ]; then
            echo ""
            echo "📱 Aplicativo encontrado: $app_name"
            echo "📊 Tamanho: $(du -sh "$APPLICATIONS/$app_name.app" | cut -f1)"
            echo "📅 Última modificação: $(stat -f "%Sm" -t "%d/%m/%Y" "$APPLICATIONS/$app_name.app")"
            echo ""
            echo "⚠️  ATENÇÃO: Esta ação moverá o aplicativo para a pasta de backup"
            echo "📁 Backup será salvo em: $BACKUP_DIR"
            echo ""
            read -p "Confirma a remoção? (s/N): " confirm
            
            if [[ "$confirm" =~ ^[Ss]$ ]]; then
                echo "🔄 Movendo para backup..."
                mv "$APPLICATIONS/$app_name.app" "$BACKUP_DIR/"
                echo "✅ Aplicativo movido para backup: $app_name"
                echo "📁 Localização: $BACKUP_DIR/$app_name.app"
                echo ""
                echo "💡 DICA: Se precisar restaurar, mova de volta para /Applications/"
            else
                echo "❌ Remoção cancelada"
            fi
        else
            echo "❌ Aplicativo não encontrado: $app_name"
        fi
        ;;
    3)
        echo "🧹 Limpeza automática de aplicativos antigos"
        echo "============================================"
        echo ""
        echo "⚠️  ATENÇÃO: Esta ação removerá aplicativos com mais de 6 meses"
        echo "📁 Todos serão movidos para backup antes da remoção"
        echo ""
        read -p "Confirma a limpeza automática? (s/N): " confirm
        
        if [[ "$confirm" =~ ^[Ss]$ ]]; then
            echo "🔍 Procurando aplicativos antigos..."
            
            # Encontrar aplicativos com mais de 6 meses
            find "$APPLICATIONS" -name "*.app" -maxdepth 1 -mtime +180 | while read app; do
                app_name=$(basename "$app" .app)
                
                # Pular aplicativos do sistema
                if [[ "$app_name" =~ ^(Safari|Mail|Messages|FaceTime|Photos|Music|TV|Podcasts|News|Stocks|Weather|Clock|Calculator|Calendar|Contacts|Maps|Reminders|Notes|Voice Memos|Home|Shortcuts|System Preferences)$ ]]; then
                    echo "  ⚙️ Pulando sistema: $app_name"
                    continue
                fi
                
                echo "  📅 Aplicativo antigo encontrado: $app_name"
                echo "  📊 Tamanho: $(du -sh "$app" | cut -f1)"
                echo "  📅 Última modificação: $(stat -f "%Sm" -t "%d/%m/%Y" "$app")"
                echo "  🔄 Movendo para backup..."
                
                mv "$app" "$BACKUP_DIR/"
                echo "  ✅ Movido: $app_name"
                echo ""
            done
            
            echo "🎉 Limpeza automática concluída!"
            echo "📁 Aplicativos movidos para: $BACKUP_DIR"
        else
            echo "❌ Limpeza cancelada"
        fi
        ;;
    4)
        echo "👋 Saindo..."
        exit 0
        ;;
    *)
        echo "❌ Opção inválida"
        exit 1
        ;;
esac

echo ""
echo "📊 Verificando resultado..."
echo "=========================="

if [ -d "$BACKUP_DIR" ]; then
    backup_count=$(find "$BACKUP_DIR" -name "*.app" | wc -l)
    echo "📁 Aplicativos em backup: $backup_count"
    echo "📁 Localização: $BACKUP_DIR"
fi

echo ""
echo "💡 DICAS:"
echo "- Aplicativos em backup podem ser restaurados movendo de volta para /Applications/"
echo "- Use 'make analyze' para ver o estado atual do sistema"
echo "- Aplicativos do sistema nunca são removidos automaticamente"
