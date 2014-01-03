# !/bin/sh


python setup.py build_ext --inplace

python -c "import test1 as t1; t1.main()"