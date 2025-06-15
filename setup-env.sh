#!/bin/bash

echo "📥 Instalando Python 3.11.9 com pyenv..."
brew install pyenv
pyenv install 3.11.9
pyenv local 3.11.9

echo "⚙️  Criando ambiente virtual..."
python3 -m venv venv
source venv/bin/activate

echo "📦 Instalando dependências..."
pip install --upgrade pip setuptools wheel py2app
