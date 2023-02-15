# ROCm Toolchain Installer

Install selected version of ROCm toolchain to the host system.

The package installation in performed within a Docker container, and the target folder is exposed to the host system. This way the host system is not spoiled by multiple (and potentially conflicting) ROCm repositories. The resulting installations are fully functional in the host system, given that the host system has provided a compatible GPU driver.

## Example

```
./rocm-install.sh 5.3.3
./rocm-install.sh 5.4.3
```

## Environment Modules

TODO

