from setuptools import setup, find_packages
import subprocess
import sys
import shutil
import FGPU

setup(
    name = "FGPU",
    version = FGPU.__version__,
    url = 'https://github.com/malkadi/FGPU',
    license = 'All rights reserved.',
    packages = ['FGPU'],
    package_data = {
    '' : ['*.bit','*.so','*.py'],
    },
    description = "FGPU is a soft GPU architecture for general purpose computing on FPGAs"
)
