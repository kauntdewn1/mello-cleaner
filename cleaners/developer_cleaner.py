import os
from utils.helpers import safe_remove

DERIVED_DATA = os.path.expanduser("~/Library/Developer/Xcode/DerivedData")

def clean():
    print("\n[Developer Cleaner] Limpando arquivos de desenvolvimento...")
    safe_remove(DERIVED_DATA)