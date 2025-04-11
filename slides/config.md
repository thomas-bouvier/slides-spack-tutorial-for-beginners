# Recommended Spack configuration

```yaml
# ~/.spack/spack.yaml
config:
  install_tree:
    # Merge installation path of different environments
    root: $user_cache_path/install
    # Generated padded paths
    padded_length: 128
  # Build on $TMPDIR
  build_stage:
    - $tempdir/$user/spack-stage
    - $user_cache_path/stage
```

```yaml
# ~/.spack/mirrors.yaml
# $ spack buildcache keys --install --trust
mirrors:
# Use the public Spack build cache
  develop: https://binaries.spack.io/develop
```
