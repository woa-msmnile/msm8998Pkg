## @file
#
#  Copyright (c) 2011-2015, ARM Limited. All rights reserved.
#  Copyright (c) 2014, Linaro Limited. All rights reserved.
#  Copyright (c) 2015 - 2016, Intel Corporation. All rights reserved.
#  Copyright (c) 2018, Bingxing Wang. All rights reserved.
#
#  SPDX-License-Identifier: BSD-2-Clause-Patent
#
##

!ifndef TARGET_DEVICE
  !error "TARGET_DEVICE must be defined"
!endif

################################################################################
#
# Defines Section - statements that will be processed to create a Makefile.
#
################################################################################
[Defines]
  PLATFORM_NAME                  = Msm8998
  PLATFORM_GUID                  = b6325ac2-9f3f-4b1d-b129-ac7b35ddde62
  PLATFORM_VERSION               = 0.1
  DSC_SPECIFICATION              = 0x00010005
  OUTPUT_DIRECTORY               = Build/Msm8998-$(ARCH)
  SUPPORTED_ARCHITECTURES        = AARCH64
  BUILD_TARGETS                  = DEBUG|RELEASE
  SKUID_IDENTIFIER               = DEFAULT
  FLASH_DEFINITION               = Msm8998Pkg/Msm8998.fdf

  # Notice: TRUE == 1, FALSE == 0
  SECURE_BOOT_ENABLE             = 1
  USE_PHYSICAL_TIMER             = 1
  USE_SCREEN_FOR_SERIAL_OUTPUT   = 1
  USE_UART_FOR_SERIAL_OUTPUT     = 0
  USE_MEMORY_FOR_SERIAL_OUTPUT   = 0
  SEND_HEARTBEAT_TO_SERIAL       = 0
  USE_SIMPLEFBDXE                = 1

!include Msm8998Pkg/Device/$(TARGET_DEVICE)/Defines.dsc.inc

[BuildOptions.common]

GCC:*_*_AARCH64_CC_FLAGS = -DSILICON_PLATFORM=8998

[PcdsFixedAtBuild.common]
  # Platform-specific
  gArmTokenSpaceGuid.PcdSystemMemorySize|0xF0000000            # 4GB

[Components.common]
  # Graphics Driver
!if $(USE_SIMPLEFBDXE) == TRUE
  SurfaceDuoFamilyPkg/Driver/SimpleFbDxe/SimpleFbDxe.inf
!endif

  # Device Specific Drivers
!include Msm8998Pkg/Device/$(TARGET_DEVICE)/DXE.dsc.inc

[LibraryClasses.common]
  # Move PlatformMemoryMapLib to Device/<device>/Library
  PlatformMemoryMapLib|Msm8998Pkg/Device/$(TARGET_DEVICE)/Library/PlatformMemoryMapLib/PlatformMemoryMapLib.inf


# Suggest you updating them to your device's dsc.inc.
[PcdsDynamicDefault.common]
  gEfiMdeModulePkgTokenSpaceGuid.PcdVideoHorizontalResolution|1080
  gEfiMdeModulePkgTokenSpaceGuid.PcdVideoVerticalResolution|2340
  gEfiMdeModulePkgTokenSpaceGuid.PcdSetupVideoHorizontalResolution|1080
  gEfiMdeModulePkgTokenSpaceGuid.PcdSetupVideoVerticalResolution|2340
  gEfiMdeModulePkgTokenSpaceGuid.PcdSetupConOutRow|120 # 94.73
  gEfiMdeModulePkgTokenSpaceGuid.PcdSetupConOutColumn|90 # 168.75
  gEfiMdeModulePkgTokenSpaceGuid.PcdConOutRow|120 # 94.73
  gEfiMdeModulePkgTokenSpaceGuid.PcdConOutColumn|90 # 168.75

!include QcomPkg/QcomPkg.dsc.inc
!include Msm8998Pkg/Device/$(TARGET_DEVICE)/PcdsFixedAtBuild.dsc.inc
!include SurfaceDuoFamilyPkg/SurfaceDuoFamily.dsc.inc
!include SurfaceDuoFamilyPkg/Frontpage.dsc.inc
