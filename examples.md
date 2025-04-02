# Spack Examples for HPC Development

This document provides additional examples and recipes specifically for HPC developers working with MPI and CUDA.

## Common MPI Installation Patterns

```bash
# Install OpenMPI with thread multiple support and Slurm integration
spack install openmpi+thread_multiple+legacylaunchers schedulers=slurm

# Install MPICH with Infiniband support
spack install mpich fabrics=mrail device=ch4 netmod=ofi

# Install Intel MPI
spack install intel-mpi@2019.10.317
```

## CUDA Toolkit and Libraries

```bash
# Install CUDA toolkit with specific architecture support
spack install cuda@11.7.0 +dev +profiler cuda_arch=70,80

# Install cuDNN with CUDA 11.x
spack install cudnn^cuda@11.7.0

# Install NCCL for multi-GPU communication
spack install nccl^cuda@11.7.0
```

## HPC Application Dependencies

```bash
# Install HDF5 with parallel I/O support (uses MPI)
spack install hdf5+mpi+fortran+hl

# Install PETSc with CUDA and MPI
spack install petsc+cuda+mpi

# Install OpenBLAS with OpenMP support
spack install openblas+openmp threads=openmp
```

## Complete Environment Example

Here's a complete `spack.yaml` file for an HPC application development environment:

```yaml
spack:
  specs:
  - cmake@3.23.1
  - openmpi@4.1.4 fabrics=ofi
  - cuda@11.7.0 +dev
  - hdf5@1.12.2+mpi+fortran
  - fftw@3.3.10+mpi+openmp+cuda cuda_arch=80
  - boost@1.79.0+mpi+python
  - python@3.9.12
  - py-numpy
  - py-mpi4py^openmpi@4.1.4

  view: true
  concretizer:
    unify: true
```

## Common Troubleshooting

1. **MPI Issues**
   ```bash
   # See which MPI implementation is being used
   spack find --paths mpi

   # Check which packages depend on MPI
   spack find --dependents mpi
   ```

2. **CUDA Version Conflicts**
   ```bash
   # Force consistent CUDA version
   spack install myapp ^cuda@11.4.0
   ```

3. **Compiler Selection**
   ```bash
   # Use specific compiler for all builds
   spack install --no-checksum myapp%gcc@10.3.0
   ```

## Custom Package Example for MPI+CUDA Application

Create a file `my_hpc_app/package.py`:

```python
from spack import *

class MyHpcApp(CMakePackage, CudaPackage):
    """Example HPC application with MPI and CUDA support."""

    homepage = "https://example.com/my_hpc_app"
    url      = "https://example.com/my_hpc_app-1.0.tar.gz"

    # Versions
    version('1.0.0', sha256='...')
    version('0.9.0', sha256='...')

    # Variants
    variant('mpi', default=True, description='Build with MPI support')
    variant('openmp', default=True, description='Build with OpenMP support')
    variant('debug', default=False, description='Build in debug mode')

    # Dependencies
    depends_on('mpi', when='+mpi')
    depends_on('cuda@11:', when='+cuda')
    depends_on('hdf5+mpi', when='+mpi')
    depends_on('fftw+mpi+openmp+cuda', when='+mpi+openmp+cuda')

    # Build dependencies
    depends_on('cmake@3.18:', type='build')

    def cmake_args(self):
        args = [
            self.define_from_variant('ENABLE_MPI', 'mpi'),
            self.define_from_variant('ENABLE_OPENMP', 'openmp'),
            self.define_from_variant('ENABLE_CUDA', 'cuda'),
            self.define_from_variant('CMAKE_BUILD_TYPE', 'debug', 'Debug', 'Release'),
        ]

        if '+cuda' in self.spec:
            args.append(self.define('CMAKE_CUDA_ARCHITECTURES',
                                   self.cuda_arch_list()))

        if '+mpi' in self.spec:
            args.append(self.define('MPI_HOME', self.spec['mpi'].prefix))

        return args

    @run_after('install')
    @on_package_attributes(run_tests=True)
    def test(self):
        if '+mpi' in self.spec:
            mpirun = self.spec['mpi'].prefix.bin.mpirun
            test_exe = join_path(self.prefix.bin, 'hpc_app_test')
            self.run_test(mpirun, options=['-n', '4', test_exe],
                         purpose='MPI functionality test')
```
