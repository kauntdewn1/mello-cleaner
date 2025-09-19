#!/bin/bash

echo "🗂️ ORGANIZANDO DESKTOP - 19GB de arquivos!"
echo "================================================"

# Criar estrutura de pastas no Desktop
DESKTOP="/Users/nettomello/Desktop"
cd "$DESKTOP"

# Criar pastas de organização
mkdir -p "📁 Arquivos por Tipo/Imagens"
mkdir -p "📁 Arquivos por Tipo/PDFs"
mkdir -p "📁 Arquivos por Tipo/Vídeos"
mkdir -p "📁 Arquivos por Tipo/Audios"
mkdir -p "📁 Arquivos por Tipo/Documentos"
mkdir -p "📁 Arquivos por Tipo/Arquivos de Sistema"
mkdir -p "📁 Projetos Ativos"
mkdir -p "📁 Projetos Antigos"
mkdir -p "📁 Para Revisar"
mkdir -p "📁 Lixeira Desktop"

echo "📁 Estrutura de pastas criada!"

# Mover imagens
echo "🖼️ Movendo imagens..."
find . -maxdepth 1 -name "*.png" -o -name "*.jpg" -o -name "*.jpeg" -o -name "*.gif" -o -name "*.bmp" -o -name "*.tiff" | while read file; do
    if [[ "$file" != "./📁"* ]]; then
        mv "$file" "📁 Arquivos por Tipo/Imagens/" 2>/dev/null
        echo "  ✅ Movido: $(basename "$file")"
    fi
done

# Mover PDFs
echo "📄 Movendo PDFs..."
find . -maxdepth 1 -name "*.pdf" | while read file; do
    if [[ "$file" != "./📁"* ]]; then
        mv "$file" "📁 Arquivos por Tipo/PDFs/" 2>/dev/null
        echo "  ✅ Movido: $(basename "$file")"
    fi
done

# Mover vídeos
echo "🎬 Movendo vídeos..."
find . -maxdepth 1 -name "*.mp4" -o -name "*.mov" -o -name "*.avi" -o -name "*.mkv" -o -name "*.wmv" | while read file; do
    if [[ "$file" != "./📁"* ]]; then
        mv "$file" "📁 Arquivos por Tipo/Vídeos/" 2>/dev/null
        echo "  ✅ Movido: $(basename "$file")"
    fi
done

# Mover áudios
echo "🎵 Movendo áudios..."
find . -maxdepth 1 -name "*.mp3" -o -name "*.wav" -o -name "*.aac" -o -name "*.m4a" | while read file; do
    if [[ "$file" != "./📁"* ]]; then
        mv "$file" "📁 Arquivos por Tipo/Audios/" 2>/dev/null
        echo "  ✅ Movido: $(basename "$file")"
    fi
done

# Mover documentos
echo "📝 Movendo documentos..."
find . -maxdepth 1 -name "*.doc" -o -name "*.docx" -o -name "*.txt" -o -name "*.rtf" | while read file; do
    if [[ "$file" != "./📁"* ]]; then
        mv "$file" "📁 Arquivos por Tipo/Documentos/" 2>/dev/null
        echo "  ✅ Movido: $(basename "$file")"
    fi
done

# Mover arquivos de sistema
echo "⚙️ Movendo arquivos de sistema..."
find . -maxdepth 1 -name ".*" | while read file; do
    if [[ "$file" != "./📁"* ]]; then
        mv "$file" "📁 Arquivos por Tipo/Arquivos de Sistema/" 2>/dev/null
        echo "  ✅ Movido: $(basename "$file")"
    fi
done

# Mover arquivos com números (provavelmente antigos)
echo "🔢 Movendo arquivos numerados..."
find . -maxdepth 1 -name "[0-9]*" | while read file; do
    if [[ "$file" != "./📁"* ]]; then
        mv "$file" "📁 Para Revisar/" 2>/dev/null
        echo "  ✅ Movido: $(basename "$file")"
    fi
done

echo ""
echo "🎉 DESKTOP ORGANIZADO!"
echo "📊 Verificando resultado..."
echo ""

# Mostrar resultado
echo "📁 Estrutura final:"
ls -la "📁 Arquivos por Tipo/"
echo ""
echo "📁 Para Revisar:"
ls -la "📁 Para Revisar/" | head -5
echo ""

# Mostrar tamanho atual
echo "💾 Tamanho atual do Desktop:"
du -sh "$DESKTOP"
