#!/bin/bash

echo "🗑️ DELETANDO APLICATIVOS DO BACKUP DEFINITIVAMENTE"
echo "================================================="
echo ""

BACKUP_DIR="/Users/nettomello/Desktop/📁 Apps Removidos"

if [ ! -d "$BACKUP_DIR" ]; then
    echo "❌ Pasta de backup não encontrada: $BACKUP_DIR"
    exit 1
fi

echo "📁 Aplicativos em backup:"
echo "========================="

# Listar aplicativos no backup
app_count=0
total_size=0

find "$BACKUP_DIR" -name "*.app" -maxdepth 1 | while read app; do
    if [ -d "$app" ]; then
        app_name=$(basename "$app" .app)
        size=$(du -sh "$app" | cut -f1)
        date=$(stat -f "%Sm" -t "%d/%m/%Y" "$app")
        echo "  📦 $app_name ($size) - $date"
        ((app_count++))
    fi
done

echo ""
echo "⚠️  ATENÇÃO:"
echo "- Esta ação DELETARÁ DEFINITIVAMENTE os aplicativos"
echo "- NÃO será possível recuperar após a deleção"
echo "- Certifique-se de que não precisa mais deles"
echo ""

read -p "Confirma a deleção DEFINITIVA? (digite 'DELETE' para confirmar): " confirm

if [[ "$confirm" == "DELETE" ]]; then
    echo ""
    echo "🗑️ Iniciando deleção definitiva..."
    echo "=================================="
    
    deleted_count=0
    total_size_freed=0
    
    find "$BACKUP_DIR" -name "*.app" -maxdepth 1 | while read app; do
        if [ -d "$app" ]; then
            app_name=$(basename "$app" .app)
            size=$(du -sh "$app" | cut -f1)
            
            echo "🗑️ Deletando: $app_name ($size)"
            
            # Deletar aplicativo
            rm -rf "$app"
            
            if [ $? -eq 0 ]; then
                echo "  ✅ Deletado: $app_name"
                ((deleted_count++))
            else
                echo "  ❌ Erro ao deletar: $app_name"
            fi
        fi
    done
    
    echo ""
    echo "🎉 DELEÇÃO CONCLUÍDA!"
    echo "===================="
    echo "📊 Aplicativos deletados: $deleted_count"
    echo "💾 Espaço liberado: $(du -sh "$BACKUP_DIR" 2>/dev/null | cut -f1 || echo "Calculando...")"
    
    # Verificar se a pasta está vazia
    remaining=$(find "$BACKUP_DIR" -name "*.app" | wc -l)
    if [ "$remaining" -eq 0 ]; then
        echo "📁 Pasta de backup está vazia"
        echo "🗑️ Removendo pasta de backup..."
        rmdir "$BACKUP_DIR" 2>/dev/null
        echo "✅ Pasta de backup removida"
    else
        echo "📁 Aplicativos restantes em backup: $remaining"
    fi
    
else
    echo "❌ Deleção cancelada"
    echo "💡 DICA: Os aplicativos continuam em backup e podem ser restaurados"
fi

echo ""
echo "📊 Verificando espaço liberado..."
echo "================================"

# Calcular espaço total liberado
if [ -d "$BACKUP_DIR" ]; then
    backup_size=$(du -sh "$BACKUP_DIR" 2>/dev/null | cut -f1 || echo "0B")
    echo "💾 Espaço restante em backup: $backup_size"
else
    echo "💾 Backup removido completamente"
fi

echo ""
echo "💡 DICAS:"
echo "- Use 'make analyze-apps' para ver aplicativos restantes"
echo "- Use 'make organize' para organizar arquivos"
echo "- O espaço foi liberado do seu sistema"
