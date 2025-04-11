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

<h1 class="font-black">Spack tutorial</h1>

## NumPEx WP3 / WP4


Fernando Ayats

---

<Toc maxDepth="1" />

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
- ⚙️ Commands: install, uninstall, find, etc.
- 📌 Package versions are fixed in your Spack clone.
- 🤝 Integrates system packages with Spack packages.
- 🎛️ Package specs allow options like <code class="color-purple">+cuda</code>.
- 🌍 Environments enable global package installations.


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

## Some Spack commands

| Command | Description |
|---------|-------------|
| `spack list` | List **available** packages |
| `spack find` | List **installed** packages |
| `spack info` | Display information about a package |
| `spack env` | Manage **environments** |
| `spack install` | Install packages |
| `spack spec` | Display the dependency graph for a package |


---

## Finding a package

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

[1;34mPreferred version:  [0m
[0;36m    4.5.01     [0mhttps://github.com/kokkos/kokkos/releases/download/4.5.01/kokkos-4.5.01.tar.gz
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
kokkos <span class="color-green">@4.5.01</span> <span class="color-purple">~aggressive_vectorization</span> ...
</code>

---

Spec documentation: https://spack.readthedocs.io/en/latest/basic_usage.html#specs-dependencies

- <code>kokkos</code>: Package name
- <code class="color-green">@4.5.01</code>: [Version specifier](https://spack.readthedocs.io/en/latest/basic_usage.html#version-specifier).
  - Spack concretizes packages to a fixed version <code class="color-green">@X.Y.Z</code>.
  - As a user, you can specify a version range, e.g:
    - <code class="color-green">@4.5:</code>: Take <code class="color-green">@4.5.0</code>, <code class="color-green">@4.5.1</code>, etc.
- <code class="color-purple">~aggressive_vectorization</code>: Variant specifier.
  - <code class="color-purple">+</code> means the feature is enabled.
  - <code class="color-purple">~</code> (or <code class="color-purple">-</code>) means the feature is disabled.
  - Variants can also be <code class="color-purple">name=value</code> pairs.
- <code class="color-blue">target=x86_64</code>: Target specifier.
  - Similar to variants, but present in all packages.
  - Allows you to target some compiler microarhitecture, e.g. <code class="color-blue">target=haswell</code>

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

Spack's concretizer also considers external dependencies from the system, while Guix is completely isolated down to `libc`.

<div class="flex justify-center">
  <img src="./guix-v-spack.svg" class="h-80 rounded-xl">
</div>



---

Spack uses the **concretizer** will try to reconcile all specification bounds, using a [SAT solver (clingo)](https://github.com/potassco/clingo).

- Package A requires <code>hdf5<span class="color-green">@1.10.0:</span><span class="color-purple">+mpi</span></code>
- Package B requires <code>hdf5<span class="color-green">@1.14.0:</span></code>
- **Result**: Spack will use <code>hdf5<span class="color-green">@1.14.0:</span><span class="color-purple">+mpi</span></code>

<br/>

- Package A requires <code>bazel<span class="color-green">@6</span></code>
- Package B requires <code>bazel<span class="color-green">@7</span></code>
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
src: ./slides/compiler.md
---



---
layout: center
---

# Writing a package definition



















---

# Exploring Dependencies

View dependency information before installing:

```bash
# See resolved dependencies without installing
$ spack spec -I hdf5+mpi

# Visualize dependency graph
$ spack graph --dot hdf5+mpi | dot -Tpng > hdf5_deps.png
```

<div class="flex justify-center">
  <div class="p-2 bg-slate-100 dark:bg-slate-800 rounded">
    <pre>hdf5@1.12.2%gcc@10.3.0+mpi
    └─ openmpi@4.1.4%gcc@10.3.0
        ├─ hwloc@2.8.0%gcc@10.3.0
        │   └─ libpciaccess@0.16%gcc@10.3.0
        └─ openssh@9.0p1%gcc@10.3.0</pre>
  </div>
</div>

---

# Spack Environments

Environments help manage collections of packages:

```bash
# Create a new environment
$ spack env create myproject

# Activate the environment
$ spack env activate myproject

# Add packages to the environment
(myproject) $ spack add openmpi cuda hdf5+mpi

# Install everything in the environment
(myproject) $ spack install

# Deactivate when done
(myproject) $ spack env deactivate
```

---

# Environment Files (spack.yaml)

Create reproducible environments with a YAML file:

```yaml
# Example spack.yaml for MPI+CUDA application
spack:
  specs:
  - openmpi@4.1.4
  - cuda@11.4.0
  - hdf5+mpi
  - fftw+mpi+cuda
  concretizer:
    unify: true
  view: true
```

```bash
# Create and install from file
$ spack env create cuda-mpi-env spack.yaml
$ spack env activate cuda-mpi-env
$ spack install
```

---

# Compiler Configuration

View available compilers:

```bash
$ spack compilers
==> Available compilers
-- gcc centos7-x86_64 ------------------------------
gcc@10.3.0  gcc@8.5.0

-- intel centos7-x86_64 -----------------------------
intel@19.0.4
```

Add a new compiler:

```bash
# Auto-detect compilers
$ spack compiler find

# Add compiler manually
$ spack compiler add /path/to/custom/compiler
```

---

# Compiler Configuration File

Manual configuration in `~/.spack/linux/compilers.yaml`:

```yaml
compilers:
- compiler:
    spec: gcc@10.3.0
    paths:
      cc: /opt/gcc/10.3.0/bin/gcc
      cxx: /opt/gcc/10.3.0/bin/g++
      f77: /opt/gcc/10.3.0/bin/gfortran
      fc: /opt/gcc/10.3.0/bin/gfortran
    flags:
      cflags: -O3
      cxxflags: -O3
    operating_system: centos7
    target: x86_64
```

---

# Package Flags and Options

Customize compiler flags for specific packages:

```yaml
# ~/.spack/packages.yaml
packages:
  openmpi:
    compiler: [gcc@10.3.0]
    variants: +thread_multiple fabrics=ofi,ucx
  all:
    compiler: [gcc, intel, nvhpc]
    providers:
      mpi: [openmpi, mpich, intel-mpi]
      blas: [openblas, intel-mkl]
```

```bash
# Install with specific flags
$ spack install hdf5 cflags="-O3 -ffast-math" cxxflags="-O3"
```

---

# Writing a Package Definition

Basic structure of a package definition (`package.py`):

```python
from spack import *

class MyPackage(CMakePackage):
    """Description of the package"""

    homepage = "https://example.com/mypackage"
    url      = "https://example.com/mypackage-1.0.tar.gz"

    version('1.0', sha256='abc123...')

    variant('mpi', default=True, description='Build with MPI support')
    variant('cuda', default=False, description='Build with CUDA support')

    depends_on('mpi', when='+mpi')
    depends_on('cuda', when='+cuda')

    def cmake_args(self):
        args = []
        if '+mpi' in self.spec:
            args.append('-DUSE_MPI=ON')
        if '+cuda' in self.spec:
            args.append('-DUSE_CUDA=ON')
        return args
```

---

# Package Definition - Build Systems

Spack supports multiple build systems through base classes:

- `CMakePackage`: for CMake-based packages
- `AutotoolsPackage`: for autotools-based packages
- `PythonPackage`: for Python packages
- `MakefilePackage`: for Makefile-based projects
- `CudaPackage`: helper for CUDA packages

```python
# Example for MPI library using Autotools
class MyMpiLib(AutotoolsPackage):
    def configure_args(self):
        args = ['--enable-shared']
        if '+cuda' in self.spec:
            args.append('--with-cuda={0}'.format(self.spec['cuda'].prefix))
        return args
```

---

# MPI-specific Package Example

```python
class MpiApplication(CMakePackage, CudaPackage):
    """Example MPI application with CUDA support"""

    depends_on('mpi')
    depends_on('cuda@11:', when='+cuda')
    depends_on('hdf5+mpi')

    def cmake_args(self):
        args = [
            self.define('MPI_HOME', self.spec['mpi'].prefix),
            self.define('HDF5_ROOT', self.spec['hdf5'].prefix)
        ]

        if '+cuda' in self.spec:
            args.extend([
                self.define('ENABLE_CUDA', True),
                self.define('CMAKE_CUDA_ARCHITECTURES', self.cuda_arch_list())
            ])

        return args
```

---

# Testing Your Package

Add tests to verify correct installation:

```python
class MyMpiApp(CMakePackage):
    # ... other package definitions ...

    # Add test that runs after installation
    @run_after('install')
    @on_package_attributes(run_tests=True)
    def test_install(self):
        test_exe = join_path(self.prefix.bin, 'myapp_test')
        self.run_test(test_exe, options=['--simple-test'],
                     expected=['Test passed'])

        # MPI test with 4 ranks
        mpiexe = self.spec['mpi'].prefix.bin.mpirun
        self.run_test(mpiexe, options=['-n', '4', test_exe, '--mpi-test'],
                     expected=['MPI test passed'])
```

To run tests during installation: `spack install --test=root myapp`

---
layout: center
---

# Questions?

---
src: ./slides/sources.md
---
