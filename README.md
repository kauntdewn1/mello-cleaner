# 🛄 Flow Cleaner

**Flow Cleaner** é uma aplicação simples para macOS que remove arquivos temporários, logs e esvazia a lixeira — ajudando a liberar espaço e melhorar a performance do seu Mac.

---

## ⚙️ Requisitos

* macOS
* Python 3.11+ com suporte a `tkinter`
* Ferramentas instaladas: `brew`, `pyenv`, `py2app`

---

## 💪 Instalação (Ambiente Local)

```bash
git clone https://github.com/seu-usuario/mello-cleaner.git
cd mello-cleaner

# Setup do ambiente Python
pyenv install 3.11.9
pyenv local 3.11.9
python -m venv venv
source venv/bin/activate
pip install --upgrade pip setuptools wheel py2app
```

---

## 🚀 Executar Limpeza

```bash
source venv/bin/activate
python main.py
```

---

## 🛠️ Build da Aplicação (.app e .dmg)

```bash
make clean
make build
make dmg
```

O arquivo final `.dmg` estará em `dist/Flow-Cleaner.dmg`.

---

## 📜 Observações

* Algumas ações de limpeza exigem permissões de sistema (`sudo`).
* A interface gráfica usa `tkinter`. Verifique se seu Python foi compilado com suporte ao Tcl/Tk.
* A lixeira do sistema é esvaziada via AppleScript.

---

## 📦 Contribuição

Pull requests e melhorias são muito bem-vindas! 💜

---

## 🧠 Desenvolvido por

**MELLO** – [@mello\_.mkt](https://www.instagram.com/mello_.mkt)
Em parceria com [FlowOFF](https://www.flowoff.xyz) · Agência de Inovação e Web3
