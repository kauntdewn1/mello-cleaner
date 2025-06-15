```makefile
.PHONY: clean build dmg

clean:
	rm -rf build dist *.egg-info icon.iconset "Flow Cleaner.app"

build:
	python setup.py py2app -A

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
