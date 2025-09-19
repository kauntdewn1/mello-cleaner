#!/bin/bash

echo "🔍 ANÁLISE PRÉVIA - REVISAR ANTES DE ORGANIZAR"
echo "=============================================="
echo ""

# Função para mostrar arquivos por data
show_files_by_date() {
    local folder="$1"
    local title="$2"
    
    echo "📁 $title"
    echo "----------------------------------------"
    
    if [ -d "$folder" ]; then
        # Mostrar arquivos mais recentes primeiro
        find "$folder" -maxdepth 1 -type f -exec ls -lt {} + | head -20 | while read line; do
            if [[ "$line" =~ ^- ]]; then
                size=$(echo "$line" | awk '{print $5}')
                date=$(echo "$line" | awk '{print $6, $7, $8}')
                file=$(echo "$line" | awk '{print $9}' | sed "s|^$folder/||")
                
                # Converter tamanho para formato legível
                if [ "$size" -gt 1048576 ]; then
                    size_human=$(echo "scale=1; $size/1048576" | bc -l)"MB"
                elif [ "$size" -gt 1024 ]; then
                    size_human=$(echo "scale=1; $size/1024" | bc -l)"KB"
                else
                    size_human="${size}B"
                fi
                
                echo "  📄 $file ($size_human) - $date"
            fi
        done
        
        # Contar total
        total=$(find "$folder" -maxdepth 1 -type f | wc -l)
        echo "  📊 Total: $total arquivos"
    else
        echo "  ❌ Pasta não encontrada"
    fi
    echo ""
}

# Função para mostrar arquivos por tamanho
show_large_files() {
    local folder="$1"
    local title="$2"
    
    echo "📁 $title - ARQUIVOS GRANDES (>10MB)"
    echo "----------------------------------------"
    
    if [ -d "$folder" ]; then
        find "$folder" -maxdepth 1 -type f -size +10M -exec ls -lh {} + | sort -k5 -hr | head -10 | while read line; do
            if [[ "$line" =~ ^- ]]; then
                size=$(echo "$line" | awk '{print $5}')
                file=$(echo "$line" | awk '{print $9}' | sed "s|^$folder/||")
                date=$(echo "$line" | awk '{print $6, $7, $8}')
                echo "  🔥 $file ($size) - $date"
            fi
        done
    fi
    echo ""
}

# Função para mostrar arquivos por tipo
show_files_by_type() {
    local folder="$1"
    local title="$2"
    
    echo "📁 $title - POR TIPO DE ARQUIVO"
    echo "----------------------------------------"
    
    if [ -d "$folder" ]; then
        echo "  🖼️  Imagens:"
        find "$folder" -maxdepth 1 -name "*.png" -o -name "*.jpg" -o -name "*.jpeg" -o -name "*.gif" | wc -l | xargs echo "    PNG/JPG/GIF:"
        find "$folder" -maxdepth 1 -name "*.pdf" | wc -l | xargs echo "  📄 PDFs:"
        find "$folder" -maxdepth 1 -name "*.mp4" -o -name "*.mov" -o -name "*.avi" | wc -l | xargs echo "  🎬 Vídeos:"
        find "$folder" -maxdepth 1 -name "*.mp3" -o -name "*.wav" -o -name "*.aac" | wc -l | xargs echo "  🎵 Áudios:"
        find "$folder" -maxdepth 1 -name "*.zip" -o -name "*.rar" -o -name "*.dmg" | wc -l | xargs echo "  📦 Arquivos compactados:"
        find "$folder" -maxdepth 1 -name "*.doc" -o -name "*.docx" -o -name "*.txt" | wc -l | xargs echo "  📝 Documentos:"
        find "$folder" -maxdepth 1 -name ".*" | wc -l | xargs echo "  ⚙️  Arquivos ocultos:"
    fi
    echo ""
}

# Análise do Desktop
echo "🖥️  DESKTOP (19GB!)"
echo "==================="
show_files_by_date "/Users/nettomello/Desktop" "Arquivos mais recentes"
show_large_files "/Users/nettomello/Desktop" "Arquivos grandes"
show_files_by_type "/Users/nettomello/Desktop" "Por tipo"

# Análise do Downloads
echo "📥 DOWNLOADS (2.3GB)"
echo "===================="
show_files_by_date "/Users/nettomello/Downloads" "Arquivos mais recentes"
show_large_files "/Users/nettomello/Downloads" "Arquivos grandes"
show_files_by_type "/Users/nettomello/Downloads" "Por tipo"

# Análise do Documents
echo "📄 DOCUMENTS (541MB)"
echo "===================="
show_files_by_date "/Users/nettomello/Documents" "Arquivos mais recentes"
show_large_files "/Users/nettomello/Documents" "Arquivos grandes"

# Análise de Movies
echo "🎬 MOVIES (8.6GB)"
echo "================="
show_files_by_date "/Users/nettomello/Movies" "Arquivos mais recentes"
show_large_files "/Users/nettomello/Movies" "Arquivos grandes"

echo "🎯 PRÓXIMOS PASSOS:"
echo "==================="
echo "1. 📋 Revisar a lista acima e identificar o que NÃO precisa mais"
echo "2. 🗂️  Decidir onde mover os arquivos importantes"
echo "3. 🗑️  Marcar arquivos para deletar"
echo "4. ▶️  Executar scripts de organização"
echo ""
echo "💡 DICA: Arquivos com mais de 6 meses provavelmente podem ser movidos/deletados"
