---
# You can also start simply with 'default'
theme: seriph
colorSchema: auto
# random image from a curated Unsplash collection by Anthony
# like them? see https://unsplash.com/collections/94734566/slidev
# background: https://cdn.jsdelivr.net/gh/slidevjs/slidev-covers@main/static/tZr3_JuURZA.webp
background: https://images.pexels.com/photos/11047223/pexels-photo-11047223.jpeg?cs=srgb&dl=pexels-vlad-samoylik-173187996-11047223.jpg&fm=jpg&w=1920&h=1282
# some information about your slides (markdown enabled)
title: Spack tutorial
info: |
  ## Slidev Starter Template
  Presentation slides for developers.

  Learn more at [Sli.dev](https://sli.dev)
# apply unocss classes to the current slide
class: text-center
# https://sli.dev/features/drawing
drawings:
  persist: false
# slide transition: https://sli.dev/guide/animations.html#slide-transitions
transition: slide-left
# enable MDC Syntax: https://sli.dev/features/mdc
mdc: false
# open graph
# seoMeta:
#  ogImage: https://cover.sli.dev
fonts:
  mono: iosevka-normal
  local: iosevka-normal
favicon: https://numpex-pc5.gitlabpages.inria.fr/tutorials/images/favicon.png

hideInToc: true
---

<div class="flex flex-row items-center justify-center gap-12">
  <img src="./Logo_France_2030.svg" width=150 class="bg-white rounded-full">
  <div class="flex flex-col items-start">
    <h1 class="font-black">Spack tutorial</h1>
    <h3>NumPEx WP3 / WP4</h3>
    <h3>Fernando Ayats Llamas</h3>
  </div>
</div>





---
src: ./slides/intro.md
---

---
hideInToc: true
layout: center
---

# Getting started with Spack

---

## The mental model

These are some of the key insights to understand how Spack works:

- 📦 Install Spack by cloning the [repo](https:://github.com/spack/spack). Multiple installations allowed.
- ✅ Activate Spack to run commands.
- 📌 Available versions depend on your Spack clone.
- 🤝 Integrates system packages with "externals".
- 🎛️ Package specs allow options like <code class="color-blue">+cuda</code>.
<!-- - 🌍 Environments enable global package installations. -->

---

## Running example: Kokkos + CUDA on Grid'5000


Connection guide: https://www.grid5000.fr/w/Getting_Started#Recommended_tips_and_tricks_for_an_efficient_use_of_Grid.275000
```ssh-config
# ~/.ssh/config
Host g5k
  User login
  Hostname access.grid5000.fr
  ForwardAgent no
Host *.g5k
  User login
  ProxyCommand ssh g5k -W "$(basename %h .g5k):%p"
  ForwardAgent no
```

```
$ ssh lille.g5k
```


---


To install Spack, we must clone the repo

```ansi
[0;90m# Clone Spack[0m
$ git clone https://github.com/spack/spack

[0;90m# Filter to get less files (310M -> 194M), and optimize for slow disks[0m
$ git clone -c feature.manyFiles=true --filter=blob:none https://github.com/spack/spack
```

<v-click>

```ansi
[0;90m# Activate Spack[0m
$ . spack/share/spack/setup-env.sh
[0;90m# If you use fish: source spack/share/spack/setup-env.fish[0m
```

</v-click>


<v-click>

```
$ spack --version
1.0.0.dev0 (199133fca402022a27002a54f25d735e7a27cce5)
```

The Spack executable and the versions for all packages are **self-contained** in the Spack folder.

</v-click>


---

## Finding a package

Web interface: https://packages.spack.io

```ansi
$ spack list kokkos
hpx-kokkos  kokkos  kokkos-kernels  kokkos-kernels-legacy  kokkos-legacy  kokkos-nvcc-wrapper  kokkos-tools  py-pennylane-lightning-kokkos  py-pykokkos-base
[1;34m==>[0m 9 packages
```

<v-click>

```ansi
$ spack info kokkos
[1;34mCMakePackage:   [0mkokkos

[1;34mDescription:[0m
    Kokkos implements a programming model in C++ for writing performance
    portable applications targeting all major HPC platforms.

[1;34mHomepage: [0mhttps://github.com/kokkos/kokkos
```

</v-click>

---


## Package specs

```ansi{1,2}
$ spack spec kokkos
[0;90m - [0m  kokkos[0;36m@4.5.01[0m[0;94m~aggressive_vectorization~alloc_async~cmake_lang~compiler_warnings+complex_align+cuda~cuda_constexpr~cuda_lambda~cuda_ldg_intrinsic~cuda_relocatable_device_code~cuda_uvm~debug~debug_bounds_check~debug_dualview_modify_check~deprecated_code~examples~hip_relocatable_device_code~hpx~hpx_async_dispatch~hwloc~ipo~memkind~numactl~openmp~openmptarget~pic~rocm+serial+shared~sycl~tests~threads~tuning~wrapper build_system=cmake build_type=Release cuda_arch=120 cxxstd=17 generator=make intel_gpu_arch=none[0m[0;35m arch=linux-ubuntu24.04-icelake[0m
[0;32m[+][0m      ^cmake[0;36m@3.31.6[0m[0;94m~doc+ncurses+ownlibs~qtgui build_system=generic build_type=Release[0m[0;35m arch=linux-ubuntu24.04-icelake[0m
[0;32m[+][0m          ^curl[0;36m@8.11.1[0m[0;94m~gssapi~ldap~libidn2~librtmp~libssh~libssh2+nghttp2 build_system=autotools libs=shared,static tls=openssl[0m[0;35m arch=linux-ubuntu24.04-icelake[0m
[0;32m[+][0m              ^nghttp2[0;36m@1.65.0[0m[0;94m build_system=autotools[0m[0;35m arch=linux-ubuntu24.04-icelake[0m
[0;32m[+][0m                  ^diffutils[0;36m@3.10[0m[0;94m build_system=autotools[0m[0;35m arch=linux-ubuntu24.04-icelake[0m
[0;32m[+][0m              ^openssl[0;36m@3.4.1[0m[0;94m~docs+shared build_system=generic certs=mozilla[0m[0;35m arch=linux-ubuntu24.04-icelake[0m
[0;32m[+][0m                  ^ca-certificates-mozilla[0;36m@2025-02-25[0m[0;94m build_system=generic[0m[0;35m arch=linux-ubuntu24.04-icelake[0m
...
```



Instead of package names, Spack uses **package specs**:

<code>
kokkos <span class="color-cyan">@4.5.01</span> <span class="color-blue">~aggressive_vectorization build_type=Release</span> ...
</code>

---

Spec documentation: https://spack.readthedocs.io/en/latest/basic_usage.html#specs-dependencies

- <code>kokkos</code>: Package name
- <code class="color-cyan">@4.5.01</code>: [Version specifier](https://spack.readthedocs.io/en/latest/basic_usage.html#version-specifier).
  - Spack concretizes packages to a fixed version <code class="color-cyan">@X.Y.Z</code>.
  - As a user, you can specify a version range, e.g:
    - <code class="color-cyan">@4.5:</code>: Take <code class="color-cyan">@4.5.0</code>, <code class="color-cyan">@4.5.1</code>, etc.
- <code class="color-blue">~aggressive_vectorization</code>: Variant specifier.
  - <code class="color-blue">+</code> means the feature is enabled.
  - <code class="color-blue">~</code> (or <code class="color-blue">-</code>) means the feature is disabled.
  - Variants can also be <code class="color-blue">name=value</code> pairs.
- <code class="color-pink">target=x86_64</code>: Target specifier.
  - Similar to variants, but present in all packages.
  - Allows you to target some compiler microarhitecture, e.g. <code class="color-pink">target=haswell</code>

---

```ansi{1,2,9}
$ spack spec kokkos +cuda cuda_arch=120
[0;90m - [0m  kokkos[0;36m@4.5.01[0m[0;94m~aggressive_vectorization~alloc_async~cmake_lang~compiler_warnings+complex_align+cuda~cuda_constexpr~cuda_lambda~cuda_ldg_intrinsic~cuda_relocatable_device_code~cuda_uvm~debug~debug_bounds_check~debug_dualview_modify_check~deprecated_code~examples~hip_relocatable_device_code~hpx~hpx_async_dispatch~hwloc~ipo~memkind~numactl~openmp~openmptarget~pic~rocm+serial+shared~sycl~tests~threads~tuning~wrapper build_system=cmake build_type=Release cuda_arch=120 cxxstd=17 generator=make intel_gpu_arch=none[0m[0;35m arch=linux-ubuntu24.04-icelake[0m
[0;32m[+][0m      ^cmake[0;36m@3.31.6[0m[0;94m~doc+ncurses+ownlibs~qtgui build_system=generic build_type=Release[0m[0;35m arch=linux-ubuntu24.04-icelake[0m
[0;32m[+][0m          ^curl[0;36m@8.11.1[0m[0;94m~gssapi~ldap~libidn2~librtmp~libssh~libssh2+nghttp2 build_system=autotools libs=shared,static tls=openssl[0m[0;35m arch=linux-ubuntu24.04-icelake[0m
...
[0;32m[+][0m          ^ncurses[0;36m@6.5[0m[0;94m~symlinks+termlib abi=none build_system=autotools patches=7a351bc[0m[0;35m arch=linux-ubuntu24.04-icelake[0m
[0;32m[+][0m          ^zlib-ng[0;36m@2.2.3[0m[0;94m+compat+new_strategies+opt+pic+shared build_system=autotools[0m[0;35m arch=linux-ubuntu24.04-icelake[0m
[0;32m[+][0m      ^compiler-wrapper[0;36m@1.0[0m[0;94m build_system=generic[0m[0;35m arch=linux-ubuntu24.04-icelake[0m
[0;90m - [0m      ^cuda[0;36m@12.8.0[0m[0;94m~allow-unsupported-compilers~dev build_system=generic[0m[0;35m arch=linux-ubuntu24.04-icelake[0m
[0;32m[+][0m          ^libxml2[0;36m@2.13.5[0m[0;94m~http+pic~python+shared build_system=autotools[0m[0;35m arch=linux-ubuntu24.04-icelake[0m
[0;32m[+][0m              ^libiconv[0;36m@1.17[0m[0;94m build_system=autotools libs=shared,static[0m[0;35m arch=linux-ubuntu24.04-icelake[0m
[0;32m[+][0m              ^xz[0;36m@5.6.3[0m[0;94m~pic build_system=autotools libs=shared,static[0m[0;35m arch=linux-ubuntu24.04-icelake[0m
[0;32m[e][0m      ^gcc[0;36m@13.3.0[0m[0;94m~binutils+bootstrap~graphite~mold~nvptx~piclibs~profiled~strip build_system=autotools build_type=RelWithDebInfo languages='c,c++,fortran'[0m[0;35m arch=linux-ubuntu24.04-icelake[0m
...
```

Now we build the **CUDA-enabled Kokkos** tweaked for the `120` CUDA architecture.

---

## Package installation

So, we're going to install Kokkos and some other packages, how do we do it?

```
$ spack install kokkos
...
```

<v-click>

...but let's use <span v-mark.red="1">environments</span> instead!


- 📦 Declarative -- run a single install command for everything.
- 👥 Shareable -- share the environment file with your colleagues.
- 🔒 Isolated -- environments won't conflict between each other.

</v-click>

---

## Spack environments

From the [official documentation](https://spack.readthedocs.io/en/latest/environments.html):

<blockquote>

An environment is used to group a set of specs intended for some purpose to be built, rebuilt, and deployed in a coherent fashion. Environments define aspects of the installation of the software, such as:
  - which specs to install;
  - how those specs are configured; and
  - where the concretized software will be installed.

</blockquote>

<br/>

```ansi
$ spack env create --dir /tmp	/test
[1;34m==>[0m Created independent environment in: [0;36m/tmp/test[0m
[1;34m==>[0m Activate with: [0;36mspack env activate /tmp/test[0m

$ spack env activate ~/myenv
```

---
hideInToc: true
---

The generated environment will look like the following:

```yaml
# ~/myenv/spack.yaml
spack:
  specs: []
  view: true
  concretizer:
    unify: true
```

- <span v-mark.red="-1"><code>specs</code>: List of packages to install.</span>

Less importantly:
- `view`: Whether the packages are exposed to the user.
- `concretizer:unify`: Run a single pass of the "concretizer" (more on that later).

---

To add packages to the environment, we have 2 options:

- Manually edit the `spack.yaml` file.
- Call `spack add <spec>`, which will edit the environment for us.

```ansi
$ spack add kokkos
[1;34m==>[0m Adding kokkos to environment /home/ubuntu/myenv
```

<br/>

```yaml
spack:
  specs:
  - kokkos
  view: true
  concretizer:
    unify: true
```

---

## Environment concretization

<br/>

<div class="w-full flex flex-row justify-center">

```mermaid {scale: 1.0}
flowchart LR
  A[spack add] --> B[spack concretize] --> C[spack install]
```

</div>

Concretization checks the system environment and the requested versions of the
packages to calculate the graph of dependencies.

This will generate a `spack.lock` file that should be committed alongside the `spack.yaml`. It
will lock every version of every package in place.

```ansi
$ spack concretize

[0;90m# To force concretization and ignore existing packages[0m
$ spack concretize -Uf
```

---

```ansi {1,2}
fayatsllamas@chifflot-2 $ spack spec
[0;90m - [0m  cmake[0;36m@3.31.6[0m[0;94m~doc+ncurses+ownlibs~qtgui build_system=generic build_type=Release[0m[0;35m arch=linux-debian11-skylake_avx512[0m
[0;90m - [0m      ^compiler-wrapper[0;36m@1.0[0m[0;94m build_system=generic[0m[0;35m arch=linux-debian11-skylake_avx512[0m
[0;90m - [0m      ^curl[0;36m@8.11.1[0m[0;94m~gssapi~ldap~libidn2~librtmp~libssh~libssh2+nghttp2 build_system=autotools libs:=shared,static tls:=openssl[0m[0;35m arch=linux-debian11-skylake_avx512[0m
[0;90m - [0m          ^nghttp2[0;36m@1.65.0[0m[0;94m build_system=autotools[0m[0;35m arch=linux-debian11-skylake_avx512[0m
[0;90m - [0m              ^diffutils[0;36m@3.10[0m[0;94m build_system=autotools[0m[0;35m arch=linux-debian11-skylake_avx512[0m
[0;90m - [0m                  ^libiconv[0;36m@1.17[0m[0;94m build_system=autotools libs:=shared,static[0m[0;35m arch=linux-debian11-skylake_avx512[0m
[0;90m - [0m          ^openssl[0;36m@3.4.1[0m[0;94m~docs+shared build_system=generic certs=mozilla[0m[0;35m arch=linux-debian11-skylake_avx512[0m
[0;90m - [0m              ^ca-certificates-mozilla[0;36m@2025-02-25[0m[0;94m build_system=generic[0m[0;35m arch=linux-debian11-skylake_avx512[0m
[0;90m - [0m              ^perl[0;36m@5.40.0[0m[0;94m+cpanm+opcode+open+shared+threads build_system=generic[0m[0;35m arch=linux-debian11-skylake_avx512[0m
[0;90m - [0m                  ^berkeley-db[0;36m@18.1.40[0m[0;94m+cxx~docs+stl build_system=autotools patches:=26090f4,b231fcc[0m[0;35m arch=linux-debian11-skylake_avx512[0m
[0;90m - [0m                  ^bzip2[0;36m@1.0.8[0m[0;94m~debug~pic+shared build_system=generic[0m[0;35m arch=linux-debian11-skylake_avx512[0m
[0;90m - [0m                  ^gdbm[0;36m@1.23[0m[0;94m build_system=autotools[0m[0;35m arch=linux-debian11-skylake_avx512[0m
[0;90m - [0m                      ^readline[0;36m@8.2[0m[0;94m build_system=autotools patches:=1ea4349,24f587b,3d9885e,5911a5b,622ba38,6c8adf8,758e2ec,79572ee,a177edc,bbf97f1,c7b45ff,e0013d9,e065038[0m[0;35m arch=linux-debian11-skylake_avx512[0m
[0;90m - [0m          ^pkgconf[0;36m@2.3.0[0m[0;94m build_system=autotools[0m[0;35m arch=linux-debian11-skylake_avx512[0m
[0;95m[e][0m      ^gcc[0;36m@10.2.1[0m[0;94m~binutils+bootstrap~graphite~nvptx~piclibs~profiled~strip build_system=autotools build_type=RelWithDebInfo languages:='c,c++,fortran' patches:=0d13622,2c18531,b5e049d,bd4828c,cc6112d[0m[0;35m arch=linux-debian11-skylake_avx512[0m
[0;90m - [0m      ^gcc-runtime[0;36m@10.2.1[0m[0;94m build_system=generic[0m[0;35m arch=linux-debian11-skylake_avx512[0m
[0;95m[e][0m      ^glibc[0;36m@2.31[0m[0;94m build_system=autotools[0m[0;35m arch=linux-debian11-skylake_avx512[0m
[0;90m - [0m      ^gmake[0;36m@4.4.1[0m[0;94m~guile build_system=generic[0m[0;35m arch=linux-debian11-skylake_avx512[0m
[0;90m - [0m      ^ncurses[0;36m@6.5[0m[0;94m~symlinks+termlib abi=none build_system=autotools patches:=7a351bc[0m[0;35m arch=linux-debian11-skylake_avx512[0m
[0;90m - [0m      ^zlib-ng[0;36m@2.2.4[0m[0;94m+compat+new_strategies+opt+pic+shared build_system=autotools[0m[0;35m arch=linux-debian11-skylake_avx512[0m
[0;90m - [0m  kokkos[0;36m@4.6.00[0m[0;94m~aggressive_vectorization~cmake_lang~compiler_warnings+complex_align~cuda~debug~debug_bounds_check~debug_dualview_modify_check~deprecated_code~examples~hip_relocatable_device_code~hpx~hpx_async_dispatch~hwloc~ipo~memkind~numactl~openmp~openmptarget~pic~rocm+serial+shared~sycl~tests~threads~tuning~wrapper build_system=cmake build_type=Release cxxstd=17 generator=make intel_gpu_arch=none[0m[0;35m arch=linux-debian11-skylake_avx512[0m
```

<br/>

- <code class="text-pink">arch=linux-debian11-skylake_avx512</code> When concretized on the machine `chifflot-2`.
- <code class="text-pink">arch=linux-ubuntu24.04-icelake</code> When concretized on my laptop.

<style>
pre {
  max-height: 300px;
}
</style>

---

## Locking the concretizer arch

Locking the environment to the least common denominator of the machines to use:

```yaml
spack:
  specs:
  - kokkos
  - cmake
  view: true
  concretizer:
    unify: true
  packages: # [!code ++]
    all: # [!code ++]
      require: target=x86_64 # [!code ++]
```


```
$ spack concretize -Uf
```

---

Spack's concretizer also considers external dependencies from the system, while Guix is completely isolated down to `libc`.

<div class="flex justify-center">
  <img src="./guix-v-spack.svg" class="h-80 rounded-xl">
</div>



---

Spack uses the **concretizer** will try to reconcile all specification bounds, using a [SAT solver (clingo)](https://github.com/potassco/clingo).

- Package A requires <code>hdf5<span class="color-cyan">@1.10.0:</span><span class="color-blue">+mpi</span></code>
- Package B requires <code>hdf5<span class="color-cyan">@1.14.0:</span></code>
- **Result**: Spack will use <code>hdf5<span class="color-cyan">@1.14.0:</span><span class="color-blue">+mpi</span></code>

<br/>

- Package A requires <code>bazel<span class="color-cyan">@6</span></code>
- Package B requires <code>bazel<span class="color-cyan">@7</span></code>
- **Result**: Concretization error. May be worked around by allowing 2 different Bazel's in the dependency graph, etc.




---

`spack concretize` will generate the `spack.lock` alongside your `spack.yaml`.
If skip the concretization step, `spack install` will concretize for each run (which takes time), and won't save it to the `spack.lock`.

**Important**: you should always commit your lockfiles.


```json
// spack.lock
{
  "_meta": {
    "file-type": "spack-lockfile",
    "lockfile-version": 6,
    "specfile-version": 5
  },
  "spack": {
    "version": "1.0.0.dev0",
    "type": "git",
    "commit": "199133fca402022a27002a54f25d735e7a27cce5"
  },
  "roots": [
    {
      "hash": "ylsnhrukizj6kfprn5rbawyaophnkwgw",
      "spec": "kokkos"
    }
  ],
  "concrete_specs": {
    "ylsnhrukizj6kfprn5rbawyaophnkwgw": {
      "name": "kokkos",
// ...
```

<style>
pre {
  font-size: 0.5rem !important;
  line-height: 0.5rem !important;
}
</style>


---

## Preparing a development environment

Let's add other tools to the environment before installation.

```ansi
$ spack add cmake
[1;34m==>[0m Adding cmake to environment /home/ubuntu/myenv

$ spack concretize -Uf
[1;34m==>[0m Concretized 2 specs:
[0;32m[+][0m  [0;90mse36owz[0m  cmake[0;36m@3.31.6[0m[0;94m~doc+ncurses+ownlibs~qtgui build_system=generic build_type=Release[0m[0;35m arch=linux-ubuntu24.04-icelake[0m
     ...
[1;34m==>[0m Updating view at /home/ubuntu/myenv/.spack-env/view
$
```

---

We can use the `spack spec` command to show a spec. If you don't provide a spec, it will print the spec for the
activated environment.


```ansi
[0;32m[+][0m  cmake[0;36m@3.31.6[0m[0;94m~doc+ncurses+ownlibs~qtgui build_system=generic build_type=Release[0m[0;35m arch=linux-ubuntu24.04-icelake[0m
[0;32m[+][0m      ^compiler-wrapper[0;36m@1.0[0m[0;94m build_system=generic[0m[0;35m arch=linux-ubuntu24.04-icelake[0m
[0;31m[-][0m          ^openssl[0;36m@3.4.1[0m[0;94m~docs+shared build_system=generic certs=mozilla[0m[0;35m arch=linux-ubuntu24.04-icelake[0m
[0;32m[+][0m              ^ca-certificates-mozilla[0;36m@2025-02-25[0m[0;94m build_system=generic[0m[0;35m arch=linux-ubuntu24.04-icelake[0m
[0;32m[+][0m              ^perl[0;36m@5.40.0[0m[0;94m+cpanm+opcode+open+shared+threads build_system=generic[0m[0;35m arch=linux-ubuntu24.04-icelake[0m
[0;32m[+][0m          ^pkgconf[0;36m@2.3.0[0m[0;94m build_system=autotools[0m[0;35m arch=linux-ubuntu24.04-icelake[0m
[0;32m[+][0m      ^zlib-ng[0;36m@2.2.3[0m[0;94m+compat+new_strategies+opt+pic+shared build_system=autotools[0m[0;35m arch=linux-ubuntu24.04-icelake[0m
[0;90m - [0m  kokkos[0;36m@4.5.01[0m[0;94m~aggressive_vectorization~cmake_lang~compiler_warnings+complex_align~cuda~debug~debug_bounds_check~debug_dualview_modify_check~deprecated_code~examples~hip_relocatable_device_code~hpx~hpx_async_dispatch~hwloc~ipo~memkind~numactl~openmp~openmptarget~pic~rocm+serial+shared~sycl~tests~threads~tuning~wrapper build_system=cmake build_type=Release cxxstd=17 generator=make intel_gpu_arch=none[0m[0;35m arch=linux-ubuntu24.04-icelake[0m
...
```

- <code class="text-green">[+]</code>: already installed.
- <code class="text-gray whitespace-pre"> - </code> or <code class="text-red">[-]</code>: not installed or uninstalled.

---

```ansi
$ spack install
    ...
[1;34m==>[0m kokkos: Executing phase: 'install'
[1;34m==>[0m kokkos: Successfully installed kokkos-4.5.01-ylsnhrukizj6kfprn5rbawyaophnkwgw
  Stage: 0.06s.  Cmake: 0.31s.  Build: 4.76s.  Install: 0.11s.  Post-install: 0.09s.  Total: 5.38s
[1;32m[+][0m /home/ubuntu/.spack/install/[padded-to-128-chars]/linux-icelake/kokkos-4.5.01-ylsnhrukizj6kfprn5rbawyaophnkwgw
[1;34m==>[0m Updating view at /home/ubuntu/myenv/.spack-env/view
```

<div class="second">

```ansi
$ spack spec
[0;32m[+][0m  cmake[0;36m@3.31.6[0m[0;94m~doc+ncurses+ownlibs~qtgui build_system=generic build_type=Release[0m[0;35m arch=linux-ubuntu24.04-icelake[0m
[0;32m[+][0m      ^compiler-wrapper[0;36m@1.0[0m[0;94m build_system=generic[0m[0;35m arch=linux-ubuntu24.04-icelake[0m
[0;32m[+][0m      ^curl[0;36m@8.11.1[0m[0;94m~gssapi~ldap~libidn2~librtmp~libssh~libssh2+nghttp2 build_system=autotools libs=shared,static tls=openssl[0m[0;35m arch=linux-ubuntu24.04-icelake[0m
[0;32m[+][0m          ^nghttp2[0;36m@1.65.0[0m[0;94m build_system=autotools[0m[0;35m arch=linux-ubuntu24.04-icelake[0m
[0;32m[+][0m              ^diffutils[0;36m@3.10[0m[0;94m build_system=autotools[0m[0;35m arch=linux-ubuntu24.04-icelake[0m
[0;32m[+][0m                  ^libiconv[0;36m@1.17[0m[0;94m build_system=autotools libs=shared,static[0m[0;35m arch=linux-ubuntu24.04-icelake[0m
[0;32m[+][0m          ^openssl[0;36m@3.4.1[0m[0;94m~docs+shared build_system=generic certs=mozilla[0m[0;35m arch=linux-ubuntu24.04-icelake[0m
[0;32m[+][0m              ^ca-certificates-mozilla[0;36m@2025-02-25[0m[0;94m build_system=generic[0m[0;35m arch=linux-ubuntu24.04-icelake[0m
[0;32m[+][0m              ^perl[0;36m@5.40.0[0m[0;94m+cpanm+opcode+open+shared+threads build_system=generic[0m[0;35m arch=linux-ubuntu24.04-icelake[0m
[0;32m[+][0m                  ^berkeley-db[0;36m@18.1.40[0m[0;94m+cxx~docs+stl build_system=autotools patches=26090f4,b231fcc[0m[0;35m arch=linux-ubuntu24.04-icelake[0m
[0;32m[+][0m                  ^bzip2[0;36m@1.0.8[0m[0;94m~debug~pic+shared build_system=generic[0m[0;35m arch=linux-ubuntu24.04-icelake[0m
[0;32m[+][0m                  ^gdbm[0;36m@1.23[0m[0;94m build_system=autotools[0m[0;35m arch=linux-ubuntu24.04-icelake[0m
[0;32m[+][0m                      ^readline[0;36m@8.2[0m[0;94m build_system=autotools patches=1ea4349,24f587b,3d9885e,5911a5b,622ba38,6c8adf8,758e2ec,79572ee,a177edc,bbf97f1,c7b45ff,e0013d9,e065038[0m[0;35m arch=linux-ubuntu24.04-icelake[0m
[0;32m[+][0m          ^pkgconf[0;36m@2.3.0[0m[0;94m build_system=autotools[0m[0;35m arch=linux-ubuntu24.04-icelake[0m
[0;32m[e][0m      ^gcc[0;36m@13.3.0[0m[0;94m~binutils+bootstrap~graphite~mold~nvptx~piclibs~profiled~strip build_system=autotools build_type=RelWithDebInfo languages='c,c++,fortran'[0m[0;35m arch=linux-ubuntu24.04-icelake[0m
[0;32m[+][0m      ^gcc-runtime[0;36m@13.3.0[0m[0;94m build_system=generic[0m[0;35m arch=linux-ubuntu24.04-icelake[0m
[0;32m[e][0m      ^glibc[0;36m@2.39[0m[0;94m build_system=autotools[0m[0;35m arch=linux-ubuntu24.04-icelake[0m
[0;32m[+][0m      ^gmake[0;36m@4.4.1[0m[0;94m~guile build_system=generic[0m[0;35m arch=linux-ubuntu24.04-icelake[0m
[0;32m[+][0m      ^ncurses[0;36m@6.5[0m[0;94m~symlinks+termlib abi=none build_system=autotools patches=7a351bc[0m[0;35m arch=linux-ubuntu24.04-icelake[0m
[0;32m[+][0m      ^zlib-ng[0;36m@2.2.3[0m[0;94m+compat+new_strategies+opt+pic+shared build_system=autotools[0m[0;35m arch=linux-ubuntu24.04-icelake[0m
[0;32m[+][0m  kokkos[0;36m@4.5.01[0m[0;94m~aggressive_vectorization~cmake_lang~compiler_warnings+complex_align~cuda~debug~debug_bounds_check~debug_dualview_modify_check~deprecated_code~examples~hip_relocatable_device_code~hpx~hpx_async_dispatch~hwloc~ipo~memkind~numactl~openmp~openmptarget~pic~rocm+serial+shared~sycl~tests~threads~tuning~wrapper build_system=cmake build_type=Release cxxstd=17 generator=make intel_gpu_arch=none[0m[0;35m arch=linux-ubuntu24.04-icelake[0m
```

</div>

<style>
.second pre  {
  max-height: 200px;
}
</style>

---

## Building our App


```
$ git clone https://gitlab.inria.fr/numpex-pc5/wp3/kokkos-hello-world ~/kokkos-hello-world
$ cd ~/kokkos-hello-world
$ cmake -B build
$ cmake --build build
```

<br/>

```cmake
cmake_minimum_required(VERSION 3.16)
project(MyProject LANGUAGES CXX)

find_package(Kokkos REQUIRED)
add_executable(myapp main.cpp)
target_link_libraries(myapp PRIVATE Kokkos::kokkos)
```

---

## Running our App

For development, if we used `kokkos ~cuda`, we can run it directly. For the GPU version, go into a GPU node:

```ansi
[0;90m# Interactive shell on a [0;33mCPU[0m partition[0m
$ oarsub --project lab-2025-numpex-exadi-spack -t allowed=special -I -p [0;33mchiclet[0m -l /host=1

[0;90m# Interactive shell on a [0;32mGPU[0m node[0m
$ oarsub --project lab-2025-numpex-exadi-spack -t allowed=special -I -p [0;32mchifflot[0m -l /host=1

[0;90m# Interactive shell on a [0;32mGPU[0m node with only 1 GPU[0m
$ oarsub --project lab-2025-numpex-exadi-spack -t allowed=special -I -p [0;32mchifflot[0m -l /host=1
```

```
$ ./build/myapp
```

---

# Recommended workflow

For local development:
- Clone Spack and activate.
- Create an environment and add your project's dependencies. For a Python project, you might want to use Spack instead of Pip.

For deployment on the supercomputer:
- Clone Spack and activate, as locally.
- You may need to create a new `spack.yaml` with the specifics of the computer (<code class="text-blue">+cuda</code>, <code class="text-blue">+rocm</code>, <code class="text-blue">cuda_arch</code>, etc).
- If you need to cut down compilation times, use a Binary Cache.


---
src: ./slides/compiler.md
---



---

#  Writing a package definition

- https://spack-tutorial.readthedocs.io/en/latest/tutorial_packaging.html



- `spack create`: Generate a new package definition in the **active Spack installation**.
- `spack edit`: Open the python file for a package.
- `spack checksum`: Generate the checksum for some source tarball.












---
src: ./slides/sources.md
---
