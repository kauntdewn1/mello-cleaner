# main.py
from cleaners import cache_cleaner, app_support_cleaner, developer_cleaner, java_cleaner

def menu():
    print("\n--- Flow Cleaner ---")
    print("1. Limpar caches")
    print("2. Limpar Application Support")
    print("3. Limpar arquivos de desenvolvimento")
    print("4. Remover Java")
    print("5. Sair")

    escolha = input("Escolha uma opção: ")

    if escolha == "1":
        cache_cleaner.clean()
    elif escolha == "2":
        app_support_cleaner.clean()
    elif escolha == "3":
        developer_cleaner.clean()
    elif escolha == "4":
        java_cleaner.clean()
    else:
        print("Saindo...")

if __name__ == "__main__":
    menu()

# cleaners/cache_cleaner.py
import shutil
import os
from utils.helpers import safe_remove

CACHE_PATHS = [
    os.path.expanduser("~/Library/Caches"),
    "/Library/Caches"
]

def clean():
    print("\n[Cache Cleaner] Limpando caches...")
    for path in CACHE_PATHS:
        safe_remove(path)

# cleaners/app_support_cleaner.py
import os
from utils.helpers import safe_remove

APP_SUPPORT_PATH = "/Library/Application Support"

EXCLUDE = ["Apple", "Adobe"]  # editáveis

def clean():
    print("\n[AppSupport Cleaner] Verificando...")
    for item in os.listdir(APP_SUPPORT_PATH):
        if item not in EXCLUDE:
            safe_remove(os.path.join(APP_SUPPORT_PATH, item))

# cleaners/developer_cleaner.py
import os
from utils.helpers import safe_remove

DERIVED_DATA = os.path.expanduser("~/Library/Developer/Xcode/DerivedData")

def clean():
    print("\n[Developer Cleaner] Limpando arquivos de desenvolvimento...")
    safe_remove(DERIVED_DATA)

# cleaners/java_cleaner.py
import shutil

JAVA_PATH = "/Library/Java"

def clean():
    print("\n[Java Cleaner] Removendo Java (se existir)...")
    shutil.rmtree(JAVA_PATH, ignore_errors=True)

# utils/helpers.py
import shutil
import os

def safe_remove(path):
    if os.path.exists(path):
        print(f" - Removendo: {path}")
        shutil.rmtree(path, ignore_errors=True)
    else:
        print(f" - Não encontrado: {path}")

# requirements.txt
# Dependências opcionais, por enquanto não usamos nenhuma externa

# README.md
"""
# Flow Cleaner

Ferramenta de limpeza estratégica para macOS criada por Mellø e Pai do Digital.

## Funcionalidades
- Limpa caches do sistema e de usuário
- Remove dados de apps desinstalados
- Libera espaço usado por ferramentas de desenvolvimento (Xcode)
- Remove Java se não for utilizado

## Como usar
```bash
python main.py
```

Crie mais scripts em `cleaners/` para personalizar sua faxina.
"""

# setup.py
from setuptools import setup

APP = ['main.py']
DATA_FILES = []
OPTIONS = {
    'argv_emulation': True,
    'iconfile': 'icon.icns',
    'plist': {
        'CFBundleName': 'Flow Cleaner',
        'CFBundleDisplayName': 'Flow Cleaner',
    },
}

setup(
    app=APP,
    data_files=DATA_FILES,
    options={'py2app': OPTIONS},
    setup_requires=['py2app'],
)

# install.sh
#!/bin/bash

echo "📦 Criando ambiente virtual..."
python3 -m venv venv
source venv/bin/activate

echo "⬇️ Instalando dependências..."
pip install -r requirements.txt
pip install py2app

echo "🎨 Gerando ícone .icns..."
mkdir -p icon.iconset
sips -z 512 512 mello-cleanermac-app.png --out icon.iconset/icon_512x512.png
cp icon.iconset/icon_512x512.png icon.iconset/icon_512x512@2x.png
iconutil -c icns icon.iconset -o icon.icns

echo "⚙️ Gerando .app com py2app..."
python setup.py py2app

echo "🔄 Renomeando .app..."
mv dist/main.app dist/Flow\ Cleaner.app

echo "💿 Gerando .dmg com create-dmg..."
create-dmg \
  --volname "Flow Cleaner" \
  --window-pos 200 120 \
  --window-size 500 300 \
  --icon-size 100 \
  --icon "Flow Cleaner.app" 100 100 \
  --hide-extension "Flow Cleaner.app" \
  --app-drop-link 380 100 \
  --background "background.png" \
  dist/Flow-Cleaner.dmg \
  dist/

echo "✅ Tudo pronto! App e DMG gerados em dist/"
