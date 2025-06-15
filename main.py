import os
import shutil
import subprocess
import tkinter as tk
from tkinter.scrolledtext import ScrolledText
from pathlib import Path

CLEAN_PATHS = [
    (str(Path.home() / "Library" / "Caches"), False),
    (str(Path.home() / "Library" / "Logs"), False),
    (str(Path.home() / ".Trash"), False),
    ("/Library/Caches", True),
    ("/private/var/folders", True),
]

def run_command(command):
    try:
        subprocess.run(command, shell=True, check=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        return True
    except subprocess.CalledProcessError:
        return False

def clean_path(path, requires_sudo=False):
    log = f"[INFO] Limpando: {path} {'(sudo)' if requires_sudo else ''}\n"
    deleted = 0
    if not os.path.exists(path):
        return f"[SKIP] Caminho inexistente: {path}\n"

    try:
        for item in os.listdir(path):
            item_path = os.path.join(path, item)
            try:
                if requires_sudo:
                    run_command(f"sudo rm -rf '{item_path}'")
                else:
                    if os.path.isdir(item_path):
                        shutil.rmtree(item_path)
                    else:
                        os.remove(item_path)
                log += f"[OK] Removido: {item_path}\n"
                deleted += 1
            except Exception as e:
                log += f"[ERRO] Falha ao remover {item_path}: {e}\n"
    except PermissionError:
        log += f"[ERRO] Sem permissão para acessar: {path}\n"
    except Exception as e:
        log += f"[ERRO] Falha inesperada ao acessar {path}: {e}\n"

    if deleted == 0:
        log += "[INFO] Nenhum arquivo removido.\n"
    return log

def run_cleaner():
    total_log = "[FLOW CLEANER] Iniciando limpeza...\n\n"
    for path, is_sudo in CLEAN_PATHS:
        total_log += clean_path(path, requires_sudo=is_sudo)
        total_log += "\n"

    total_log += "[INFO] Esvaziando lixeira...\n"
    try:
        subprocess.run(["osascript", "-e", 'tell app "Finder" to empty trash'], check=True)
        total_log += "[OK] Lixeira esvaziada com sucesso.\n"
    except Exception as e:
        total_log += f"[ERRO] Falha ao esvaziar lixeira via Finder: {e}\n"

    total_log += "\n[FINALIZADO] Limpeza concluída.\n"
    return total_log

def show_log_window(log_text):
    window = tk.Tk()
    window.title("Flow Cleaner - Log de Limpeza")
    window.geometry("700x500")

    text_area = ScrolledText(window, wrap=tk.WORD, font=("Courier", 10))
    text_area.pack(padx=10, pady=10, fill=tk.BOTH, expand=True)
    text_area.insert(tk.END, log_text)
    text_area.configure(state="disabled")

    btn_close = tk.Button(window, text="Fechar", command=window.destroy)
    btn_close.pack(pady=10)

    window.mainloop()

if __name__ == "__main__":
    log = run_cleaner()
    show_log_window(log)
