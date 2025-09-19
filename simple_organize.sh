#!/bin/bash

echo "🎯 ORGANIZAÇÃO SIMPLES - ESCOLHA UMA OPÇÃO"
echo "=========================================="
echo ""

while true; do
    echo "🎯 Escolha o que organizar:"
    echo ""
    echo "1. 🖥️  Desktop (19GB - CRÍTICO!)"
    echo "2. 📥 Downloads (2.3GB)"
    echo "3. 📄 Documents (541MB)"
    echo "4. 🎬 Movies (8.6GB)"
    echo "5. 🔍 Ver análise completa primeiro"
    echo "6. ❌ Sair"
    echo ""
    
    read -p "Digite sua escolha (1-6): " choice
    
    case $choice in
        1)
            echo "🖥️ Organizando Desktop..."
            ./organize_desktop.sh
            break
            ;;
        2)
            echo "📥 Organizando Downloads..."
            ./clean_downloads.sh
            break
            ;;
        3)
            echo "📄 Organizando Documents..."
            echo "Criando estrutura para Documents..."
            mkdir -p "/Users/nettomello/Documents/📁 Organizados/Imagens"
            mkdir -p "/Users/nettomello/Documents/📁 Organizados/PDFs"
            mkdir -p "/Users/nettomello/Documents/📁 Organizados/Audios"
            mkdir -p "/Users/nettomello/Documents/📁 Organizados/Outros"
            echo "✅ Estrutura criada em Documents!"
            break
            ;;
        4)
            echo "🎬 Organizando Movies..."
            echo "Criando estrutura para Movies..."
            mkdir -p "/Users/nettomello/Movies/📁 Organizados/Vídeos Pessoais"
            mkdir -p "/Users/nettomello/Movies/📁 Organizados/Projetos"
            mkdir -p "/Users/nettomello/Movies/📁 Organizados/Downloads"
            echo "✅ Estrutura criada em Movies!"
            break
            ;;
        5)
            echo "🔍 Executando análise completa..."
            ./analyze_files.sh
            echo ""
            echo "Pressione Enter para continuar..."
            read
            ;;
        6)
            echo "👋 Saindo..."
            exit 0
            ;;
        *)
            echo "❌ Opção inválida. Digite um número de 1 a 6."
            echo ""
            ;;
    esac
done

echo ""
echo "🎉 Organização concluída!"
echo ""
echo "📊 Verificando resultado..."
echo "=========================="

# Mostrar estatísticas finais
if [ -d "/Users/nettomello/Desktop/📁 Arquivos por Tipo" ]; then
    echo "📁 Desktop organizado: $(find "/Users/nettomello/Desktop/📁 Arquivos por Tipo" -type f 2>/dev/null | wc -l) arquivos"
fi

if [ -d "/Users/nettomello/Downloads/📁 Organizados" ]; then
    echo "📁 Downloads organizados: $(find "/Users/nettomello/Downloads/📁 Organizados" -type f 2>/dev/null | wc -l) arquivos"
fi

echo ""
echo "⚠️  PRÓXIMOS PASSOS:"
echo "1. Revisar as pastas organizadas"
echo "2. Mover arquivos importantes para locais apropriados"
echo "3. Deletar arquivos desnecessários"
echo ""
echo "💡 DICA: Use 'make analyze' para ver o estado atual dos arquivos"
