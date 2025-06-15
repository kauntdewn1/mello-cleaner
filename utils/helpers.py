import shutil
import os

def safe_remove(path):
    if os.path.exists(path):
        print(f" - Removendo: {path}")
        shutil.rmtree(path, ignore_errors=True)
    else:
        print(f" - Não encontrado: {path}")