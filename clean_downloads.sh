#!/bin/bash

echo "📥 LIMPANDO PASTA DOWNLOADS - 2.3GB"
echo "===================================="

DOWNLOADS="/Users/nettomello/Downloads"
cd "$DOWNLOADS"

# Criar estrutura de organização
mkdir -p "📁 Organizados/Imagens"
mkdir -p "📁 Organizados/PDFs"
mkdir -p "📁 Organizados/Vídeos"
mkdir -p "📁 Organizados/Arquivos"
mkdir -p "📁 Organizados/Instaladores"
mkdir -p "📁 Para Deletar"
mkdir -p "📁 Antigos (6+ meses)"

echo "📁 Estrutura criada!"

# Mover arquivos por tipo
echo "🖼️ Organizando imagens..."
find . -maxdepth 1 -name "*.png" -o -name "*.jpg" -o -name "*.jpeg" -o -name "*.gif" | while read file; do
    if [[ "$file" != "./📁"* ]]; then
        mv "$file" "📁 Organizados/Imagens/" 2>/dev/null
        echo "  ✅ $(basename "$file")"
    fi
done

echo "📄 Organizando PDFs..."
find . -maxdepth 1 -name "*.pdf" | while read file; do
    if [[ "$file" != "./📁"* ]]; then
        mv "$file" "📁 Organizados/PDFs/" 2>/dev/null
        echo "  ✅ $(basename "$file")"
    fi
done

echo "🎬 Organizando vídeos..."
find . -maxdepth 1 -name "*.mp4" -o -name "*.mov" -o -name "*.avi" | while read file; do
    if [[ "$file" != "./📁"* ]]; then
        mv "$file" "📁 Organizados/Vídeos/" 2>/dev/null
        echo "  ✅ $(basename "$file")"
    fi
done

echo "📦 Organizando instaladores..."
find . -maxdepth 1 -name "*.dmg" -o -name "*.pkg" -o -name "*.zip" -o -name "*.rar" | while read file; do
    if [[ "$file" != "./📁"* ]]; then
        mv "$file" "📁 Organizados/Instaladores/" 2>/dev/null
        echo "  ✅ $(basename "$file")"
    fi
done

# Identificar arquivos antigos (6+ meses)
echo "📅 Identificando arquivos antigos..."
find . -maxdepth 1 -type f -mtime +180 | while read file; do
    if [[ "$file" != "./📁"* ]]; then
        mv "$file" "📁 Antigos (6+ meses)/" 2>/dev/null
        echo "  📅 $(basename "$file") - $(stat -f "%Sm" -t "%d/%m/%Y" "$file")"
    fi
done

# Identificar arquivos muito pequenos (provavelmente lixo)
echo "🗑️ Identificando arquivos pequenos..."
find . -maxdepth 1 -type f -size -1k | while read file; do
    if [[ "$file" != "./📁"* ]]; then
        mv "$file" "📁 Para Deletar/" 2>/dev/null
        echo "  🗑️ $(basename "$file") - $(stat -f "%z" "$file") bytes"
    fi
done

echo ""
echo "🎉 DOWNLOADS ORGANIZADOS!"
echo ""

# Mostrar estatísticas
echo "📊 ESTATÍSTICAS:"
echo "=================="
echo "📁 Imagens: $(ls "📁 Organizados/Imagens/" 2>/dev/null | wc -l) arquivos"
echo "📄 PDFs: $(ls "📁 Organizados/PDFs/" 2>/dev/null | wc -l) arquivos"
echo "🎬 Vídeos: $(ls "📁 Organizados/Vídeos/" 2>/dev/null | wc -l) arquivos"
echo "📦 Instaladores: $(ls "📁 Organizados/Instaladores/" 2>/dev/null | wc -l) arquivos"
echo "📅 Antigos: $(ls "📁 Antigos (6+ meses)/" 2>/dev/null | wc -l) arquivos"
echo "🗑️ Para deletar: $(ls "📁 Para Deletar/" 2>/dev/null | wc -l) arquivos"

echo ""
echo "💾 Tamanho atual:"
du -sh "$DOWNLOADS"

echo ""
echo "⚠️  PRÓXIMOS PASSOS:"
echo "1. Revisar pasta '📁 Antigos (6+ meses)' - pode deletar"
echo "2. Revisar pasta '📁 Para Deletar' - arquivos pequenos"
echo "3. Mover arquivos importantes para Documents"
