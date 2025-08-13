# 🧹 Flow Cleaner

**Flow Cleaner** é uma aplicação simples para macOS que remove arquivos temporários, logs e esvazia a lixeira — ajudando a liberar espaço e melhorar a performance do seu Mac.

---

## ⚙️ Requisitos

* macOS
* Python 3.7+ (com suporte a `tkinter`)
* Ambiente virtual Python

---

## 🚀 Instalação Rápida

```bash
# Clone o repositório
git clone https://github.com/seu-usuario/mello-cleaner.git
cd mello-cleaner

# Setup automático do ambiente
make setup

# Ou manualmente:
chmod +x setup-env.sh
./setup-env.sh
```

---

## 🎯 Comandos Principais

```bash
# Configurar ambiente
make setup

# Executar aplicativo
make run

# Construir aplicativo (.app)
make build

# Construir para release
make build-release

# Gerar arquivo .dmg
make dmg

# Ver todos os comandos
make help
```

---

## 🏃‍♂️ Execução Manual

```bash
# Ativar ambiente virtual
source venv/bin/activate

# Executar
python main.py

# Ou usar o comando make
make run
```

---

## 🏗️ Build da Aplicação

```bash
# Build para desenvolvimento (mais rápido)
make build

# Build para release (otimizado)
make build-release

# Gerar .dmg para distribuição
make dmg
```

O arquivo final `.dmg` estará em `dist/Flow-Cleaner.dmg`.

---

## 📁 Estrutura do Projeto

```
mello-cleaner/
├── main.py              # Aplicativo principal
├── cleaners/            # Módulos de limpeza
├── utils/               # Utilitários
├── requirements.txt     # Dependências Python
├── setup.py            # Configuração py2app
├── Makefile            # Comandos de automação
└── setup-env.sh        # Script de configuração
```

---

## 📜 Observações

* Algumas ações de limpeza exigem permissões de sistema (`sudo`)
* A interface gráfica usa `tkinter` (incluído no Python do macOS)
* A lixeira do sistema é esvaziada via AppleScript
* O projeto usa apenas bibliotecas padrão do Python

---

## 🧪 Desenvolvimento

```bash
# Instalar dependências de desenvolvimento
pip install pytest black flake8

# Executar testes
make test

# Formatar código
black .

# Verificar qualidade
flake8 .
```

---

## 📦 Contribuição

Pull requests e melhorias são muito bem-vindas! 💜

---

## 🧠 Desenvolvido por

**MELLO** – [@mello_.mkt](https://www.instagram.com/mello_.mkt)
Em parceria com [FlowOFF](https://www.flowoff.xyz) · Agência de Inovação e Web3
