import shutil
import os
from utils.helpers import safe_remove

CACHE_PATHS = [
    os.path.expanduser("~/Library/Caches"),
    "/Library/Caches"
]

def clean():
    print("\n[Cache Cleaner] Limpando caches...")
    for path in CACHE_PATHS:
        safe_remove(path)
