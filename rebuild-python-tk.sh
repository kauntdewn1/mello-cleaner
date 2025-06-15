#!/bin/bash

echo "🔧 Instalando dependências via Homebrew..."
brew install tcl-tk

export TKPATH="$(brew --prefix tcl-tk)"
export LDFLAGS="-L$TKPATH/lib"
export CPPFLAGS="-I$TKPATH/include"
export PKG_CONFIG_PATH="$TKPATH/lib/pkgconfig"
export PATH="$TKPATH/bin:$PATH"

echo "📦 Reinstalando Python 3.11.9 com suporte ao Tkinter..."
env \
  PYTHON_CONFIGURE_OPTS="--with-tcltk-includes='-I$TKPATH/include' --with-tcltk-libs='-L$TKPATH/lib -ltcl8.6 -ltk8.6'" \
  pyenv install --force 3.11.9

echo "✅ Reinstalação concluída. Agora execute:"
echo ""
echo "pyenv local 3.11.9"
echo "python -m venv venv"
echo "source venv/bin/activate"
echo "python -c \"import tkinter; print('✅ Tkinter funcionando!')\""
