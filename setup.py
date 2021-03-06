# -*- coding: utf-8 -*-

from distutils.core import setup
from distutils.extension import Extension
from Cython.Distutils import build_ext
import numpy as np
import sys, os, shutil
import itertools


path = os.getenv('PATH').split(':')
ld_library_path = os.getenv('LD_LIBRARY_PATH').split(':')
man_path = os.getenv('MANPATH').split(':')
cplus_include_path = os.getenv('CPLUS_INCLUDE_PATH').split(':')

# clean previous build
for root, dirs, files in os.walk('.',topdown=False):
    for name in files:
        if name.endswith('.so'):
            os.remove(os.path.join(root,name))
    for name in dirs:
        if (name=='build'):
            shutil.rmtree(name)

# build

ext1 = Extension(
    'test1', ['test1.pyx'],
    include_dirs = [element for element in itertools.chain([np.get_include()], cplus_include_path)],
    library_dirs = [element for element in itertools.chain(ld_library_path, man_path)],
    libraries=['gsl','openblas'],
    extra_compile_args=['-fopenmp','-O3']
    )

setup(ext_modules=[ext1],
      cmdclass = {'build_ext': build_ext})
