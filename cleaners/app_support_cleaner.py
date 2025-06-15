import os
from utils.helpers import safe_remove

APP_SUPPORT_PATH = "/Library/Application Support"

EXCLUDE = ["Apple", "Adobe"]  # editáveis

def clean():
    print("\n[AppSupport Cleaner] Verificando...")
    for item in os.listdir(APP_SUPPORT_PATH):
        if item not in EXCLUDE:
            safe_remove(os.path.join(APP_SUPPORT_PATH, item))