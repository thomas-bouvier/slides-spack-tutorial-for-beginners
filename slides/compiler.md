## Compiler configuration

Spack won't install a compiler by default, it will use the compiler from the _system_ automatically.

```ansi
$ spack compiler list
[1;34m==>[0m Available compilers
-- [0;32mgcc[0m ubuntu24.04-x86_64 ---------------------------------------
gcc@13.3.0
```

```ansi
$ spack compiler info gcc@13.3.0
gcc[0;36m@=13.3.0[0m[0;94m languages='c,c++'[0m[0;35m arch=linux-ubuntu24.04-x86_64[0m:
  prefix: /usr
  compilers:
    c: /usr/bin/gcc
    cxx: /usr/bin/g++
```


