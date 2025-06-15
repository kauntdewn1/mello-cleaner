# mello-cleaner
# 🧼 Flow Cleaner

**Flow Cleaner** é uma aplicação simples para macOS que remove arquivos temporários, logs e esvazia a lixeira — ajudando a liberar espaço e melhorar a performance do seu Mac.

---

## ⚙️ Requisitos

- macOS
- Python 3.11+ com suporte ao `tkinter`
- `pyenv`, `brew`, `py2app` instalados

---

## 🧪 Instalação (Ambiente Local)

```bash
git clone https://github.com/seu-usuario/mello-cleaner.git
cd mello-cleaner

# Setup ambiente virtual
pyenv install 3.11.9
pyenv local 3.11.9
python -m venv venv
source venv/bin/activate
pip install --upgrade pip setuptools wheel py2app
🚀 Executar limpeza
bash
Copiar
Editar
source venv/bin/activate
python main.py
🛠️ Build do App (.app e .dmg)
bash
Copiar
Editar
make clean
make build
make dmg
O arquivo final estará em dist/Flow-Cleaner.dmg.

📝 Observações
Algumas ações de limpeza exigem sudo e permissões do sistema.

A interface gráfica usa tkinter (certifique-se de que o Python foi compilado com suporte ao Tcl/Tk).

A lixeira do sistema também é esvaziada via AppleScript.

📦 Contribuição
Pull requests e melhorias são bem-vindas!

🧠 Desenvolvido por MELLØ