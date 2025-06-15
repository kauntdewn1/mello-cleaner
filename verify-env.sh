#!/bin/bash

version=$(python3 -c "import platform; print(platform.python_version())")
if [[ "$version" =~ 3.12 ]]; then
  echo "❌ Python 3.12 detectado — essa versão não é compatível com o build via py2app."
  echo "✅ Use o script setup-env.sh para ativar Python 3.11.9 via pyenv."
  exit 1
else
  echo "✅ Ambiente Python $version OK para build!"
fi
