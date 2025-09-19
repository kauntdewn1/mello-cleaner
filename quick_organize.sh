#!/bin/bash

echo "🎯 ORGANIZAÇÃO RÁPIDA - ESCOLHA UMA OPÇÃO"
echo "========================================"
echo ""

echo "1. 🖥️  Desktop (19GB - CRÍTICO!)"
echo "2. 📥 Downloads (2.3GB)"
echo "3. 📄 Documents (541MB)"
echo "4. 🎬 Movies (8.6GB)"
echo "5. 🔍 Ver análise completa"
echo "6. ❌ Sair"
echo ""

read -p "Digite sua escolha (1-6): " choice

case $choice in
    1)
        echo "🖥️ Organizando Desktop automaticamente..."
        ./organize_desktop.sh
        ;;
    2)
        echo "📥 Organizando Downloads automaticamente..."
        ./clean_downloads.sh
        ;;
    3)
        echo "📄 Criando estrutura para Documents..."
        mkdir -p "/Users/nettomello/Documents/📁 Organizados/Imagens"
        mkdir -p "/Users/nettomello/Documents/📁 Organizados/PDFs"
        mkdir -p "/Users/nettomello/Documents/📁 Organizados/Audios"
        mkdir -p "/Users/nettomello/Documents/📁 Organizados/Outros"
        echo "✅ Estrutura criada em Documents!"
        ;;
    4)
        echo "🎬 Criando estrutura para Movies..."
        mkdir -p "/Users/nettomello/Movies/📁 Organizados/Vídeos Pessoais"
        mkdir -p "/Users/nettomello/Movies/📁 Organizados/Projetos"
        mkdir -p "/Users/nettomello/Movies/📁 Organizados/Downloads"
        echo "✅ Estrutura criada em Movies!"
        ;;
    5)
        echo "🔍 Executando análise completa..."
        ./analyze_files.sh
        ;;
    6)
        echo "👋 Saindo..."
        exit 0
        ;;
    *)
        echo "❌ Opção inválida. Execute novamente."
        exit 1
        ;;
esac

echo ""
echo "🎉 Processo concluído!"
echo ""
echo "💡 DICA: Use 'make analyze' para ver o estado atual dos arquivos"
