## Externals

* **External packages**: Pre-installed software that Spack can use instead of building
* **Use cases**: System MPI, vendor-optimized libraries, licensed software


```bash
# Detect externals automatically
$ spack external find openmpi

# See configured externals
$ spack external list
```


```yaml
packages:
  openmpi:
    externals:
    - spec: "openmpi@4.1.2"
      prefix: /opt/openmpi-4.1.2
    buildable: false  # Optional: prevents Spack from building its own
```



