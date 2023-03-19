## This Repo Is Based On [SurfaceDuoPkg](https://github.com/Woa-Project/SurfaceDuoPkg/) and [msmnilePkg](https://github.com/woa-msmnile/msmnilePkg/)

* Thanks for [Gustave](https://github.com/gus33000)'s instructions!
* Thanks for [sunflower2333](https://github.com/sunflower2333)'s instructions!

# [Project Mu](https://microsoft.github.io/mu/) UEFI Implementation for MSM8998 Devices

## Build

### Minimum System Requirements

- At least 2 cores x86_64 processor running at 2Ghz or higher implementing the X86 ISA with 64 bit AMD extensions (AMD64) (Currently, building on any other ISA is not supported. In other words, do. not. build. this. on. a. phone. running. android. please.)
- SSD
- A linux environment capable of running below tool stack:
  - Bash
  - Python 3.10 or higher (python3.10, python3.10-venv, python3.10-pip)
  - mono-devel
  - git-core, git
  - build-essential
  - PowerShell Core 7
  - clang38 (or higher), llvm, ggc-aarch64-linux-gnu
- Exported CLANG38_BIN environment variable pointing to LLVM 10 binary folder
- Exported CLANG38_AARCH64_PREFIX variable equalling to aarch64-linux-gnu-

### Build Instructions

- Clone this repository to a reasonable location on your disk (There is absolutely no need to initialize submodules, stuart will do it for you later on)
- Run the following commands in order, with 0 typo, and without copy pasting all of them blindly all at once:

1. Setup Base environment

```
./setup_env.sh
pip install --upgrade -r pip-requirements.txt
```

*Alternatively, use docker if you don't have Ubuntu 20.04 environment*

```
docker build -t mu:v1 .
docker run -it mu:v1 -v ./:/build/
```

*Then finish the following process in docker environment*

2. Activate Workspace

```
python3 -m venv SurfaceDuo
source SurfaceDuo/bin/activate
```

3. Setup MU environment

```
./setup_uefi.sh
```

4. Stamp build
```
python3 ./Platforms/SurfaceDuo1Pkg/StampBuild.py
```
*or*
```
./build_releaseinfo.ps1
```

5. Build UEFI
> Usage: build_uefi_msm8998.sh -d \<target-device\>  

```
./build_uefi_msm8998.sh -d <target-name>
```
- You will see Build/\<target-device\>.img if it builds successfully.

## Target list

| Device             | Target name            | DSDT Support    | Maintainers                                        |
|--------------------|------------------------|-----------------|----------------------------------------------------|
| OnePlus 5          | oneplus-cheeseburger   | ✅              | [qaz6750](https://github.com/qaz6750)                 |

## Acknowledgements

- Andrei Warkentin and his [RaspberryPiPkg](https://github.com/andreiw/RaspberryPiPkg)
- Sarah Purohit
- [Googulator](https://github.com/Googulator/)
- [Ben (Bingxing) Wang](https://github.com/imbushuo/)
- Samuel Tulach and his [Rainbow Patcher](https://github.com/SamuelTulach/rainbow)
- [Renegade Project](https://github.com/edk2-porting/)
- Lemon ICE

## License

All code except drivers in `GPLDriver` directory are licensed under BSD 2-Clause.
GPL Drivers are licensed under GPLv2 license.
