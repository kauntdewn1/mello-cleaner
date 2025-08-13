#!/bin/bash

echo "🔧 Configurando ambiente para Flow Cleaner..."

# Verificar se Python 3 está instalado
if ! command -v python3 &> /dev/null; then
    echo "❌ Python 3 não encontrado. Instale o Python 3 primeiro."
    exit 1
fi

# Criar ambiente virtual se não existir
if [ ! -d "venv" ]; then
    echo "📦 Criando ambiente virtual..."
    python3 -m venv venv
fi

# Ativar ambiente virtual
echo "🚀 Ativando ambiente virtual..."
source venv/bin/activate

# Atualizar pip
echo "⬆️ Atualizando pip..."
pip install --upgrade pip

# Instalar dependências
echo "📥 Instalando dependências..."
pip install -r requirements.txt

echo "✅ Ambiente configurado com sucesso!"
echo "💡 Para ativar o ambiente virtual: source venv/bin/activate"
echo "🚀 Para executar: python main.py"
echo "🏗️ Para build: make build"
