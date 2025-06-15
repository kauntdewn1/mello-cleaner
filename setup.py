from setuptools import setup

APP = ['main.py']
DATA_FILES = []
OPTIONS = {
    'argv_emulation': True,
    'iconfile': 'icon.icns',
    'plist': {
        'CFBundleName': 'Flow Cleaner',
        'CFBundleDisplayName': 'Flow Cleaner',
    },
}

setup(
    name='Flow Cleaner',
    app=APP,
    data_files=DATA_FILES,
    options={'py2app': OPTIONS},
    setup_requires=['setuptools', 'py2app'],
)
