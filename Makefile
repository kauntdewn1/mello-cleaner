.PHONY: setup clean build dmg run test install update-deps

setup:
	@echo "🔧 Configurando ambiente..."
	chmod +x setup-env.sh
	./setup-env.sh

install:
	@echo "📦 Instalando dependências..."
	pip install -r requirements.txt

update-deps:
	@echo "🔄 Atualizando dependências..."
	pip install --upgrade -r requirements.txt

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

analyze:
	@echo "🔍 Analisando arquivos do sistema..."
	./analyze_files.sh

organize:
	@echo "🎯 Iniciando organização rápida..."
	./quick_organize.sh

organize-desktop:
	@echo "🖥️ Organizando Desktop automaticamente..."
	./organize_desktop.sh

clean-downloads:
	@echo "📥 Limpando Downloads automaticamente..."
	./clean_downloads.sh

analyze-apps:
	@echo "📱 Analisando aplicativos instalados..."
	./clean_applications.sh

remove-apps:
	@echo "🗑️ Removendo aplicativos não utilizados..."
	./remove_apps.sh

remove-specific-apps:
	@echo "🗑️ Removendo aplicativos específicos..."
	./remove_specific_apps.sh

delete-backup-apps:
	@echo "🗑️ Deletando aplicativos do backup definitivamente..."
	./delete_backup_apps.sh

help:
	@echo "📋 Comandos disponíveis:"
	@echo "  setup        - Configura ambiente virtual e instala dependências"
	@echo "  install      - Instala dependências Python"
	@echo "  update-deps  - Atualiza dependências Python"
	@echo "  run          - Executa o aplicativo"
	@echo "  test         - Executa testes"
	@echo "  build        - Constrói aplicativo para desenvolvimento"
	@echo "  build-release- Constrói aplicativo para release"
	@echo "  clean        - Remove arquivos de build"
	@echo "  dmg          - Gera arquivo .dmg para distribuição"
	@echo ""
	@echo "🗂️ Comandos de Organização:"
	@echo "  analyze      - Analisa arquivos sem mover nada"
	@echo "  organize     - Organização interativa (você escolhe)"
	@echo "  organize-desktop - Organiza Desktop automaticamente"
	@echo "  clean-downloads - Limpa Downloads automaticamente"
	@echo ""
	@echo "📱 Comandos de Aplicativos:"
	@echo "  analyze-apps - Analisa aplicativos instalados"
	@echo "  remove-apps - Remove aplicativos não utilizados"
	@echo "  remove-specific-apps - Remove aplicativos específicos"
	@echo "  delete-backup-apps - Deleta aplicativos do backup definitivamente"
	@echo "  help         - Mostra esta ajuda"
