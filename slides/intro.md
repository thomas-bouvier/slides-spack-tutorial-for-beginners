---
layout: center
---

# Why package managers? Why Spack?


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
    border: 2px solid rgb(121, 121, 121);
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
