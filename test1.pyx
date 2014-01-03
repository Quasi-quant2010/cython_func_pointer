import numpy as np
cimport numpy as np
cimport cython

ctypedef int (*filter_ptr)(int (*func_ptr)(int), 
                           long*, long*, int)

cdef int even(int val):
    if val % 2==1:
        return 1
    else:
        return 0

cdef int odd(int val):
    cdef int i,j,k
    if val % 2==0:
        return 1
    else:
        return 0

cdef int filter_func(int (*func_ptr)(int), long *items, long *results, int n):
    cdef int i,j=0
    for i in xrange(n):
        if func_ptr(items[i]):
            print i, func_ptr(items[i])
            j += 1
            results[j] = items[i]
    return j


def main():
    cdef long[::1] items = np.zeros(9, np.intp)
    cdef long[::1] odds = np.zeros(9, np.intp)
    cdef long[::1] evens = np.zeros(9, np.intp)
    cdef long[::1] results = np.zeros(9, np.intp)
    cdef int i, n
    ascontig = np.ascontiguousarray

    for i in xrange(9):
        items[i] = i + 1
        
    print ascontig(items,dtype=np.intp)

    cdef long *iptr = &items[0]    
    cdef long *rptr = &results[0]
    cdef filter_ptr dist_func
    dist_func = &filter_func
    print '奇数'
    n = dist_func(odd, iptr, rptr, 9) 
    print '偶数'
    n = dist_func(even, iptr, rptr, 9) 
    
