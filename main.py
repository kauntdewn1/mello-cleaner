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
    print(f"[DEBUG] Executando comando: {command}")
    try:
        subprocess.run(command, shell=True, check=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        print(f"[DEBUG] Comando executado com sucesso: {command}")
        return True
    except subprocess.CalledProcessError as e:
        print(f"[ERRO] Falha ao executar comando: {command} - {e}")
        return False

def clean_path(path, requires_sudo=False):
    print(f"[DEBUG] Iniciando limpeza do caminho: {path} {'(sudo)' if requires_sudo else ''}")
    log = f"[INFO] Limpando: {path} {'(sudo)' if requires_sudo else ''}\n"
    deleted = 0
    if not os.path.exists(path):
        print(f"[SKIP] Caminho inexistente: {path}")
        return f"[SKIP] Caminho inexistente: {path}\n"

    try:
        for item in os.listdir(path):
            item_path = os.path.join(path, item)
            try:
                if requires_sudo:
                    print(f"[DEBUG] Removendo com sudo: {item_path}")
                    run_command(f"sudo rm -rf '{item_path}'")
                else:
                    print(f"[DEBUG] Removendo: {item_path}")
                    if os.path.isdir(item_path):
                        shutil.rmtree(item_path)
                    else:
                        os.remove(item_path)
                log += f"[OK] Removido: {item_path}\n"
                deleted += 1
            except Exception as e:
                print(f"[ERRO] Falha ao remover {item_path}: {e}")
                log += f"[ERRO] Falha ao remover {item_path}: {e}\n"
    except PermissionError:
        print(f"[ERRO] Sem permissão para acessar: {path}")
        log += f"[ERRO] Sem permissão para acessar: {path}\n"
    except Exception as e:
        print(f"[ERRO] Falha inesperada ao acessar {path}: {e}")
        log += f"[ERRO] Falha inesperada ao acessar {path}: {e}\n"

    if deleted == 0:
        print(f"[INFO] Nenhum arquivo removido em: {path}")
        log += "[INFO] Nenhum arquivo removido.\n"
    return log

def run_cleaner():
    print("[FLOW CLEANER] Iniciando limpeza...")
    total_log = "[FLOW CLEANER] Iniciando limpeza...\n\n"
    for path, is_sudo in CLEAN_PATHS:
        print(f"[DEBUG] Limpando caminho: {path}")
        total_log += clean_path(path, requires_sudo=is_sudo)
        total_log += "\n"

    print("[DEBUG] Esvaziando lixeira...")
    total_log += "[INFO] Esvaziando lixeira...\n"
    try:
        subprocess.run(["osascript", "-e", 'tell app "Finder" to empty trash'], check=True)
        print("[DEBUG] Lixeira esvaziada com sucesso.")
        total_log += "[OK] Lixeira esvaziada com sucesso.\n"
    except Exception as e:
        print(f"[ERRO] Falha ao esvaziar lixeira via Finder: {e}")
        total_log += f"[ERRO] Falha ao esvaziar lixeira via Finder: {e}\n"

    total_log += "\n[FINALIZADO] Limpeza concluída.\n"
    print("[FLOW CLEANER] Limpeza concluída.")
    return total_log

def show_log_window(log_text):
    print("[DEBUG] Exibindo janela de log.")
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
