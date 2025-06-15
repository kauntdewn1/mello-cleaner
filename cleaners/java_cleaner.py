import shutil

JAVA_PATH = "/Library/Java"

def clean():
    print("\n[Java Cleaner] Removendo Java (se existir)...")
    shutil.rmtree(JAVA_PATH, ignore_errors=True)