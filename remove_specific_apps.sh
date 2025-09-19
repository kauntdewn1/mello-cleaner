#!/bin/bash

echo "🗑️ REMOVENDO APLICATIVOS ESPECÍFICOS"
echo "===================================="
echo ""

APPLICATIONS="/Applications"
BACKUP_DIR="/Users/nettomello/Desktop/📁 Apps Removidos"

# Lista de aplicativos para remover
APPS_TO_REMOVE=(
    "AnyDesk"
    "Ollama"
    "010 Editor"
    "Postman"
    "GitHub Desktop"
    "Dropbox"
    "Streamlabs Desktop"
)

# Criar pasta de backup
mkdir -p "$BACKUP_DIR"

echo "📱 Aplicativos que serão removidos:"
echo "=================================="
for app in "${APPS_TO_REMOVE[@]}"; do
    if [ -d "$APPLICATIONS/$app.app" ]; then
        size=$(du -sh "$APPLICATIONS/$app.app" | cut -f1)
        date=$(stat -f "%Sm" -t "%d/%m/%Y" "$APPLICATIONS/$app.app")
        echo "  ✅ $app ($size) - $date"
    else
        echo "  ❌ $app (não encontrado)"
    fi
done

echo ""
echo "⚠️  ATENÇÃO:"
echo "- Todos os aplicativos serão movidos para backup"
echo "- Backup será salvo em: $BACKUP_DIR"
echo "- Você pode restaurar movendo de volta para /Applications/"
echo ""

read -p "Confirma a remoção destes aplicativos? (s/N): " confirm

if [[ "$confirm" =~ ^[Ss]$ ]]; then
    echo ""
    echo "🔄 Iniciando remoção..."
    echo "======================="
    
    removed_count=0
    total_size=0
    
    for app in "${APPS_TO_REMOVE[@]}"; do
        if [ -d "$APPLICATIONS/$app.app" ]; then
            echo ""
            echo "🗑️ Removendo: $app"
            
            # Calcular tamanho
            size=$(du -sh "$APPLICATIONS/$app.app" | cut -f1)
            echo "  📊 Tamanho: $size"
            
            # Mover para backup
            echo "  🔄 Movendo para backup..."
            mv "$APPLICATIONS/$app.app" "$BACKUP_DIR/"
            
            if [ $? -eq 0 ]; then
                echo "  ✅ Removido com sucesso: $app"
                ((removed_count++))
            else
                echo "  ❌ Erro ao remover: $app"
            fi
        else
            echo "  ⏭️ Pulando: $app (não encontrado)"
        fi
    done
    
    echo ""
    echo "🎉 REMOÇÃO CONCLUÍDA!"
    echo "===================="
    echo "📊 Aplicativos removidos: $removed_count"
    echo "📁 Backup salvo em: $BACKUP_DIR"
    echo ""
    
    # Mostrar conteúdo do backup
    echo "📁 Conteúdo do backup:"
    ls -la "$BACKUP_DIR" | grep ".app" | while read line; do
        if [[ "$line" =~ ^d ]]; then
            app_name=$(echo "$line" | awk '{print $9}' | sed 's|.app||')
            size=$(echo "$line" | awk '{print $5}')
            echo "  📦 $app_name.app"
        fi
    done
    
    echo ""
    echo "💡 DICAS:"
    echo "- Para restaurar: mv '$BACKUP_DIR/NomeApp.app' '/Applications/'"
    echo "- Para deletar definitivamente: rm -rf '$BACKUP_DIR/NomeApp.app'"
    echo "- Use 'make analyze-apps' para ver aplicativos restantes"
    
else
    echo "❌ Remoção cancelada"
fi

echo ""
echo "📊 Verificando espaço liberado..."
echo "================================"

# Calcular espaço liberado
if [ -d "$BACKUP_DIR" ]; then
    backup_size=$(du -sh "$BACKUP_DIR" | cut -f1)
    echo "💾 Espaço em backup: $backup_size"
    echo "💾 Espaço liberado no /Applications: $backup_size"
fi
