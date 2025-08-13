.PHONY: setup clean build dmg run test install

setup:
	@echo "🔧 Configurando ambiente..."
	chmod +x setup-env.sh
	./setup-env.sh

install:
	@echo "📦 Instalando dependências..."
	pip install -r requirements.txt

run:
	@echo "🚀 Executando Flow Cleaner..."
	python main.py

test:
	@echo "🧪 Executando testes..."
	python -m pytest tests/ -v

clean:
	@echo "🧹 Limpando arquivos de build..."
	rm -rf build dist *.egg-info icon.iconset "Flow Cleaner.app"

build: clean
	@echo "🏗️ Construindo aplicativo..."
	python setup.py py2app -A

build-release: clean
	@echo "🏗️ Construindo aplicativo para release..."
	python setup.py py2app

dmg:
	@echo "💿 Gerando .dmg com create-dmg..."
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

help:
	@echo "📋 Comandos disponíveis:"
	@echo "  setup        - Configura ambiente virtual e instala dependências"
	@echo "  install      - Instala dependências Python"
	@echo "  run          - Executa o aplicativo"
	@echo "  test         - Executa testes"
	@echo "  build        - Constrói aplicativo para desenvolvimento"
	@echo "  build-release- Constrói aplicativo para release"
	@echo "  clean        - Remove arquivos de build"
	@echo "  dmg          - Gera arquivo .dmg para distribuição"
	@echo "  help         - Mostra esta ajuda"
