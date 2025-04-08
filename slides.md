---
# You can also start simply with 'default'
theme: seriph
colorSchema: dark
# random image from a curated Unsplash collection by Anthony
# like them? see https://unsplash.com/collections/94734566/slidev
# background: https://cdn.jsdelivr.net/gh/slidevjs/slidev-covers@main/static/tZr3_JuURZA.webp
background: https://images.pexels.com/photos/2473183/pexels-photo-2473183.jpeg?cs=srgb&dl=pexels-nickoloui-2473183.jpg&fm=jpg&w=1920&h=1080
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

<Toc />

---

## Context

**Challenge:**

- Exascale apps are increasingly **difficult to build, deploy, maintain or test**. The complexity of apps grows, as well as the machines’ complexity. Current software deployment doesn’t scale properly with this complexity.

**At stake:**

- Need for **HPC DevOps tools and methodologies**, that enhance productivity, interoperability and portability.

---

## Our target as NumPEx PC5

<div class="grid grid-cols-[1fr_max-content]">
  <div>

  <p>
    <strong v-mark.red="-1">Application developers</strong>
  </p>

  - Ease difficulty in building and developing apps and libraries.
  - Portable solution from a laptop to the supercomputer.
  - CI/CD ready.

  **System administrators**
  - Ease package administration and testing.
  - Align interests of developers and sysadmins.

  **Application users**
  - Provide *turn-key* solutions for deployments.
  - Fearless migrations between machines and updates.


  </div>

  <div class="mr-20 mt-10">

  <image class="flex flex-col items-center">
    <img width="150px" src="https://numpex.org/wp-content/uploads/sites/6/2024/12/Logo-NumPEx-couleurs-etat-v.4-web.png" >
    <strong>PC5 (ExaDI)</strong>
  </image>

  </div>
</div>

---

## Classical way to deploy software

- Manually installing libraries (git clone, CMake, make install, etc.)
  - ❌ Time consuming
  - ❌ Error prone
  - ❌ Automation scripts are fragile
  - ❌ Not very reproducible, with colleagues, other machines or in the future

- `module load <name>`
  - ✅ Cleaner solution than manually installing libraries
  - ❌ Modules are specific to each cluster and not portable
  - ❌ Not reproducible in the future
  - ❌ Limited to the packages and versions provided by the admin team

<style>
ul {
  list-style: none;
}
</style>

---

## Use a package manager!

Package manager are very good at managing your dependencies for you.

- ✅ Easy installation of dependencies
- ✅ Reproducible stack of software, without fragile scripts
- ✅ Adaptable to different platforms
- ✅ CI/CD Ready

<div class="flex flex-row w-full justify-center justify-items-center gap-10 mt-10">
  <img src="https://guix.gnu.org/themes/initial/img/Guix.png">
  <img src="https://computing.llnl.gov/sites/default/files/styles/large/public/2021-03/spack-logo-220-LLNL.png?itok=lfy7ws3W">
  <img src="https://21018705.fs1.hubspotusercontent-na1.net/hubfs/21018705/Logos%20March%20Update/Sylabs/PNG/SingularityLogo.png">
</div>

<style>
  img {
    padding: 1rem;
    border-radius: 20px;
    background-color: white;
    width: 150px;
  }

  ul {
    list-style: none;
  }
</style>

---

# Why Spack for HPC?

<div class="grid grid-cols-[1fr_max-content]">

  <div>

  - 🔬 Designed specifically for scientific HPC applications
  - 🔀 Handles different versions and configurations of the same package
  - 💻 Supports **multiple compilers** simultaneously
  - 📡 Native **MPI** implementation support
  - 🔥 First-class **CUDA** & GPU software stack integration
  - 🔄 Reproducible software stacks across different machines *
  - 😃 Easy user experience, but also powerful

  </div>

  <img class="mr-15" src="https://spack.io/assets/images/spack-logo-white.svg" width=120>
</div>

From https://spack.io:

> Spack is a package manager for **supercomputers**, Linux, and macOS. It makes installing scientific software easy.
> Spack isn’t tied to a particular language; you can build a software stack in Python or R, link to libraries written in C, C++, or Fortran, and easily swap compilers or target specific microarchitectures.


---

## The mental model

These are some of the key insights to understand how Spack works:

- 📦 Spack is installed by cloning the [github.com/spack/spack repository](https:://github.com/spack/spack). You can have multiple Spack installations.
- ✅ Spack must be **activated** to be able to run its commands.
- ⚙️ It has commands for what you expect from a package manager: install, uninstall, find, etc.
- 📌 The versions for the packages are the ones included in your Spack clone, there is no "sync or update" step.
- 🤝 Spack integrates the packages available in the system (externals), with the ones coming from Spack itself.
- 🎛️ Packages **specs**, may have switchable options, for example to enable CUDA support with <code class="color-purple">+cuda</code>.
- 🌍 Spack **environments** allow you to install packages globally.


---

# Getting started with Spack

<span/>

To install Spack, we must clone the repo

```bash
# Clone Spack
$ git clone https://github.com/spack/spack

# Filter to get less files (310M -> 194M), and optimize for slow disks
$ git clone -c feature.manyFiles=true --filter=blob:none https://github.com/spack/spack
```

<v-click>

```bash
# Activate Spack
$ . spack/share/spack/setup-env.sh
# If you use fish: source spack/share/spack/setup-env.fish
```

</v-click>


<v-click>

```bash
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

```
$ spack list kokkos
hpx-kokkos  kokkos  kokkos-kernels  kokkos-kernels-legacy  kokkos-legacy  kokkos-nvcc-wrapper  kokkos-tools  py-pennylane-lightning-kokkos  py-pykokkos-base
==> 9 packages
```

<v-click>

```
$ spack info kokkos
CMakePackage:   kokkos

Description:
    Kokkos implements a programming model in C++ for writing performance
    portable applications targeting all major HPC platforms.

Homepage: https://github.com/kokkos/kokkos

Preferred version:
    4.5.01     https://github.com/kokkos/kokkos/releases/download/4.5.01/kokkos-4.5.01.tar.gz
```

</v-click>

---


## Package specs

```{1,3}
$ spack spec kokkos

 -   kokkos@4.5.01~aggressive_vectorization~cmake_lang~compiler_warnings+complex_align~cuda~debug~debug_bounds_check~debug_dualview_modify_check~deprecated_code~examples~hip_relocatable_device_code~hpx~hpx_async_dispatch~hwloc~ipo~memkind~numactl~openmp~openmptarget~pic~rocm+serial+shared~sycl~tests~threads~tuning~wrapper build_system=cmake build_type=Release cxxstd=17 generator=make intel_gpu_arch=none arch=linux-debian11-x86_64
 -       ^cmake@3.31.6~doc+ncurses+ownlibs~qtgui build_system=generic build_type=Release arch=linux-debian11-x86_64
 -           ^curl@8.11.1~gssapi~ldap~libidn2~librtmp~libssh~libssh2+nghttp2 build_system=autotools libs=shared,static tls=openssl arch=linux-debian11-x86_64
 -               ^nghttp2@1.65.0 build_system=autotools arch=linux-debian11-x86_64
 -                   ^diffutils@3.10 build_system=autotools arch=linux-debian11-x86_64
 -                       ^libiconv@1.17 build_system=autotools libs=shared,static arch=linux-debian11-x86_64
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

```{1,6}
$ spack spec -U kokkos +cuda cuda_arch=120
 -   kokkos@4.5.01~aggressive_vectorization~alloc_async~cmake_lang~compiler_warnings+complex_align+cuda~cuda_constexpr~cuda_lambda~cuda_ldg_intrinsic~cuda_relocatable_device_code~cuda_uvm~debug~debug_bounds_check~debug_dualview_modify_check~deprecated_code~examples~hip_relocatable_device_code~hpx~hpx_async_dispatch~hwloc~ipo~memkind~numactl~openmp~openmptarget~pic~rocm+serial+shared~sycl~tests~threads~tuning~wrapper build_system=cmake build_type=Release cuda_arch=120 cxxstd=17 generator=make intel_gpu_arch=none arch=linux-ubuntu24.04-icelake
 -       ^cmake@3.31.6~doc+ncurses+ownlibs~qtgui build_system=generic build_type=Release arch=linux-ubuntu24.04-icelake
    ...
 -       ^compiler-wrapper@1.0 build_system=generic arch=linux-ubuntu24.04-icelake
 -       ^cuda@12.8.0~allow-unsupported-compilers~dev build_system=generic arch=linux-ubuntu24.04-icelake
 -           ^libxml2@2.13.5~http+pic~python+shared build_system=autotools arch=linux-ubuntu24.04-icelake
 -               ^libiconv@1.17 build_system=autotools libs=shared,static arch=linux-ubuntu24.04-icelake
 -               ^xz@5.6.3~pic build_system=autotools libs=shared,static arch=linux-ubuntu24.04-icelake
[e]      ^gcc@13.3.0~binutils+bootstrap~graphite~mold~nvptx~piclibs~profiled~strip build_system=autotools build_type=RelWithDebInfo languages='c,c++,fortran' arch=linux-ubuntu24.04-icelake
 -       ^gcc-runtime@13.3.0 build_system=generic arch=linux-ubuntu24.04-icelake
[e]      ^glibc@2.39 build_system=autotools arch=linux-ubuntu24.04-icelake
 -       ^gmake@4.4.1~guile build_system=generic arch=linux-ubuntu24.04-icelake
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

```
$ spack env create --dir ~/myenv
==> Created independent environment in: ~/myenv
==> Activate with: spack env activate ~/myenv

$ spack env activate ~/myenv
```

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

```
$ spack add kokkos
==> Adding kokkos to environment ~/myenv
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

# Spack Installation Examples

```bash
# Install latest OpenMPI
$ spack install openmpi

# Install CUDA 11.4.0
$ spack install cuda@11.4.0

# Install HDF5 with MPI support
$ spack install hdf5+mpi

# Install NVIDIA HPC SDK with CUDA support
$ spack install nvhpc+cuda
```



---

# Spack Specs

Specs allow you to be specific about what you want to install:

```
package@version%compiler@version+variant~disabled_variant arch=architecture
```

Examples for HPC developers:

```bash
# OpenMPI 4.1.4 with GCC 10.3.0
$ spack install openmpi@4.1.4%gcc@10.3.0

# CUDA-enabled FFTW using NVHPC compiler
$ spack install fftw%nvhpc+cuda cuda_arch=80

# HDF5 with parallel I/O built with OpenMPI
$ spack install hdf5+mpi^openmpi@4.1.4
```

---

# Spec Syntax - Version Constraints

```bash
# Exact version
$ spack install python@3.10.0

# Version range
$ spack install python@3.7:3.10

# Latest version in range
$ spack install cuda@11:

# Up to a version
$ spack install cuda@:11.4

# Specific patch version with wildcard
$ spack install openmpi@4.1.*
```

---

# Spec Syntax - Dependencies

Control exactly which dependency versions to use:

```bash
# HDF5 built with a specific MPI implementation
$ spack install hdf5+mpi^openmpi@4.1.4

# NAMD with specific CUDA and specific FFTW builds
$ spack install namd^cuda@11.4^fftw+mpi

# Multiple dependency constraints
$ spack install trilinos^openmpi@4.1%gcc@10.3.0^hdf5@1.12+mpi
```

The `^` symbol specifies a dependency constraint.

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

# Spack Resources

- [Official Documentation](https://spack.readthedocs.io/)
- [Spack GitHub Repository](https://github.com/spack/spack)
- [Spack Tutorial](https://spack-tutorial.readthedocs.io/)
- [Spack Slack Channel](https://spackpm.slack.com/)

<div class="flex justify-center">
  <img src="https://spack.io/assets/images/spack-logo.svg" width="200">
</div>

---

# Questions?

<div class="flex h-full items-center justify-center">
  <div class="text-center">
    <h2 class="text-3xl font-bold mb-10">Thank you!</h2>
    <p class="text-xl">Fernando Ayats</p>
    <p>NumPEx WP3 / WP4</p>
  </div>
</div>
