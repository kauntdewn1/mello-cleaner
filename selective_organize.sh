#!/bin/bash

echo "🎯 ORGANIZAÇÃO SELETIVA - VOCÊ ESCOLHE O QUE MANTER"
echo "=================================================="
echo ""

# Função para mostrar arquivos e permitir seleção
select_files() {
    local folder="$1"
    local title="$2"
    local keep_folder="$3"
    local delete_folder="$4"
    
    echo "📁 $title"
    echo "----------------------------------------"
    
    if [ ! -d "$folder" ]; then
        echo "❌ Pasta não encontrada: $folder"
        return
    fi
    
    # Criar pastas de destino
    mkdir -p "$keep_folder"
    mkdir -p "$delete_folder"
    
    # Listar arquivos e permitir seleção
    find "$folder" -maxdepth 1 -type f | while read file; do
        if [[ "$file" != "$folder" ]]; then
            filename=$(basename "$file")
            size=$(stat -f "%z" "$file" 2>/dev/null || echo "0")
            date=$(stat -f "%Sm" -t "%d/%m/%Y" "$file" 2>/dev/null || echo "N/A")
            
            # Converter tamanho
            if [ "$size" -gt 1048576 ]; then
                size_human=$(echo "scale=1; $size/1048576" | bc -l)"MB"
            elif [ "$size" -gt 1024 ]; then
                size_human=$(echo "scale=1; $size/1024" | bc -l)"KB"
            else
                size_human="${size}B"
            fi
            
            echo ""
            echo "📄 $filename ($size_human) - $date"
            echo "   [1] Manter e organizar"
            echo "   [2] Deletar"
            echo "   [3] Pular (deixar onde está)"
            echo "   [4] Ver detalhes do arquivo"
            echo -n "   Escolha (1-4): "
            
            read -r choice
            
            case $choice in
                1)
                    echo "   ✅ Movendo para pasta organizada..."
                    mv "$file" "$keep_folder/" 2>/dev/null
                    echo "   ✅ Movido: $filename"
                    ;;
                2)
                    echo "   🗑️ Movendo para lixeira..."
                    mv "$file" "$delete_folder/" 2>/dev/null
                    echo "   🗑️ Marcado para deletar: $filename"
                    ;;
                3)
                    echo "   ⏭️ Pulando: $filename"
                    ;;
                4)
                    echo "   📋 Detalhes:"
                    ls -la "$file" 2>/dev/null
                    echo "   📋 Tamanho: $(du -h "$file" 2>/dev/null | cut -f1)"
                    echo "   📋 Última modificação: $(stat -f "%Sm" -t "%d/%m/%Y %H:%M" "$file" 2>/dev/null)"
                    echo "   📋 Tipo: $(file "$file" 2>/dev/null | cut -d: -f2-)"
                    echo ""
                    echo "   [1] Manter e organizar"
                    echo "   [2] Deletar"
                    echo "   [3] Pular"
                    echo -n "   Escolha (1-3): "
                    read -r choice2
                    
                    case $choice2 in
                        1)
                            mv "$file" "$keep_folder/" 2>/dev/null
                            echo "   ✅ Movido: $filename"
                            ;;
                        2)
                            mv "$file" "$delete_folder/" 2>/dev/null
                            echo "   🗑️ Marcado para deletar: $filename"
                            ;;
                        3)
                            echo "   ⏭️ Pulando: $filename"
                            ;;
                    esac
                    ;;
                *)
                    echo "   ❌ Opção inválida, pulando..."
                    ;;
            esac
        fi
    done
}

# Menu principal
echo "🎯 Escolha o que organizar:"
echo ""
echo "1. 🖥️  Desktop (19GB - CRÍTICO!)"
echo "2. 📥 Downloads (2.3GB)"
echo "3. 📄 Documents (541MB)"
echo "4. 🎬 Movies (8.6GB)"
echo "5. 🔍 Ver análise completa primeiro"
echo "6. ❌ Sair"
echo ""

read -p "Escolha uma opção (1-6): " main_choice

case $main_choice in
    1)
        echo "🖥️ Organizando Desktop..."
        select_files "/Users/nettomello/Desktop" "Desktop" "/Users/nettomello/Desktop/📁 Organizados" "/Users/nettomello/Desktop/📁 Para Deletar"
        ;;
    2)
        echo "📥 Organizando Downloads..."
        select_files "/Users/nettomello/Downloads" "Downloads" "/Users/nettomello/Downloads/📁 Organizados" "/Users/nettomello/Downloads/📁 Para Deletar"
        ;;
    3)
        echo "📄 Organizando Documents..."
        select_files "/Users/nettomello/Documents" "Documents" "/Users/nettomello/Documents/📁 Organizados" "/Users/nettomello/Documents/📁 Para Deletar"
        ;;
    4)
        echo "🎬 Organizando Movies..."
        select_files "/Users/nettomello/Movies" "Movies" "/Users/nettomello/Movies/📁 Organizados" "/Users/nettomello/Movies/📁 Para Deletar"
        ;;
    5)
        echo "🔍 Executando análise completa..."
        /Users/nettomello/CODIGOS/mello-cleaner/analyze_files.sh
        ;;
    6)
        echo "👋 Saindo..."
        exit 0
        ;;
    *)
        echo "❌ Opção inválida. Tente novamente."
        echo ""
        echo "🎯 Escolha o que organizar:"
        echo ""
        echo "1. 🖥️  Desktop (19GB - CRÍTICO!)"
        echo "2. 📥 Downloads (2.3GB)"
        echo "3. 📄 Documents (541MB)"
        echo "4. 🎬 Movies (8.6GB)"
        echo "5. 🔍 Ver análise completa primeiro"
        echo "6. ❌ Sair"
        echo ""
        read -p "Escolha uma opção (1-6): " main_choice
        ;;
esac

echo ""
echo "🎉 Organização concluída!"
echo ""
echo "📊 Verificando resultado..."
echo "=========================="

# Mostrar estatísticas finais
if [ -d "/Users/nettomello/Desktop/📁 Organizados" ]; then
    echo "📁 Desktop organizado: $(ls "/Users/nettomello/Desktop/📁 Organizados" 2>/dev/null | wc -l) arquivos"
fi

if [ -d "/Users/nettomello/Desktop/📁 Para Deletar" ]; then
    echo "🗑️ Desktop para deletar: $(ls "/Users/nettomello/Desktop/📁 Para Deletar" 2>/dev/null | wc -l) arquivos"
fi

echo ""
echo "⚠️  PRÓXIMOS PASSOS:"
echo "1. Revisar pastas '📁 Para Deletar' antes de deletar definitivamente"
echo "2. Mover arquivos importantes para pastas apropriadas"
echo "3. Executar limpeza final"
