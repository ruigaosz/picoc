## @file
#   Intel(r) UEFI Application Development Kit for EDK II.
#   This package contains applications which depend upon Standard Libraries
#   from the StdLib package.
#
#   See the comments in the [LibraryClasses.IA32] and [BuildOptions] sections
#   for important information about configuring this package for your
#   environment.
#
##

[Defines]
  PLATFORM_NAME                  = picoc
  PLATFORM_GUID                  = 4bf3e0ae-4825-4c14-b67c-b83e8cf11196
  PLATFORM_VERSION               = 1.00
  DSC_SPECIFICATION              = 0x00010006
  OUTPUT_DIRECTORY               = Build/$(PLATFORM_NAME)
  SUPPORTED_ARCHITECTURES        = X64
  BUILD_TARGETS                  = DEBUG|RELEASE
  SKUID_IDENTIFIER               = DEFAULT

[LibraryClasses]
  #
  # Entry point
  #
  UefiApplicationEntryPoint|MdePkg/Library/UefiApplicationEntryPoint/UefiApplicationEntryPoint.inf
  ShellCEntryLib|ShellPkg/Library/UefiShellCEntryLib/UefiShellCEntryLib.inf
  UefiDriverEntryPoint|MdePkg/Library/UefiDriverEntryPoint/UefiDriverEntryPoint.inf
  #
  # Common Libraries
  #
  BaseLib|MdePkg/Library/BaseLib/BaseLib.inf
  BaseMemoryLib|MdePkg/Library/BaseMemoryLib/BaseMemoryLib.inf
  UefiLib|MdePkg/Library/UefiLib/UefiLib.inf
  PrintLib|MdePkg/Library/BasePrintLib/BasePrintLib.inf
  PcdLib|MdePkg/Library/BasePcdLibNull/BasePcdLibNull.inf
  MemoryAllocationLib|MdePkg/Library/UefiMemoryAllocationLib/UefiMemoryAllocationLib.inf
  UefiBootServicesTableLib|MdePkg/Library/UefiBootServicesTableLib/UefiBootServicesTableLib.inf
  UefiRuntimeServicesTableLib|MdePkg/Library/UefiRuntimeServicesTableLib/UefiRuntimeServicesTableLib.inf
  !if $(DEBUG_ENABLE_OUTPUT)
    DebugLib|MdePkg/Library/UefiDebugLibConOut/UefiDebugLibConOut.inf
    DebugPrintErrorLevelLib|MdePkg/Library/BaseDebugPrintErrorLevelLib/BaseDebugPrintErrorLevelLib.inf
  !else   ## DEBUG_ENABLE_OUTPUT
    DebugLib|MdePkg/Library/BaseDebugLibNull/BaseDebugLibNull.inf
  !endif  ## DEBUG_ENABLE_OUTPUT

  DevicePathLib|MdePkg/Library/UefiDevicePathLib/UefiDevicePathLib.inf
  PeCoffGetEntryPointLib|MdePkg/Library/BasePeCoffGetEntryPointLib/BasePeCoffGetEntryPointLib.inf
  IoLib|MdePkg/Library/BaseIoLibIntrinsic/BaseIoLibIntrinsic.inf
  PciCf8Lib|MdePkg/Library/BasePciCf8Lib/BasePciCf8Lib.inf
  PciExpressLib|MdePkg/Library/BasePciExpressLib/BasePciExpressLib.inf
  PciLib|MdePkg/Library/BasePciLibPciExpress/BasePciLibPciExpress.inf
  SynchronizationLib|MdePkg/Library/BaseSynchronizationLib/BaseSynchronizationLib.inf
  UefiRuntimeLib|MdePkg/Library/UefiRuntimeLib/UefiRuntimeLib.inf
  HiiLib|MdeModulePkg/Library/UefiHiiLib/UefiHiiLib.inf
  UefiHiiServicesLib|MdeModulePkg/Library/UefiHiiServicesLib/UefiHiiServicesLib.inf
  PerformanceLib|MdeModulePkg/Library/DxePerformanceLib/DxePerformanceLib.inf
  HobLib|MdePkg/Library/DxeHobLib/DxeHobLib.inf
  FileHandleLib|MdePkg/Library/UefiFileHandleLib/UefiFileHandleLib.inf
  SortLib|MdeModulePkg/Library/UefiSortLib/UefiSortLib.inf

  ShellLib|ShellPkg/Library/UefiShellLib/UefiShellLib.inf

  CacheMaintenanceLib|MdePkg/Library/BaseCacheMaintenanceLib/BaseCacheMaintenanceLib.inf

###################################################################################################
#
# Components Section - list of the modules and components that will be processed by compilation
#                      tools and the EDK II tools to generate PE32/PE32+/Coff image files.
#
# Note: The EDK II DSC file is not used to specify how compiled binary images get placed
#       into firmware volume images. This section is just a list of modules to compile from
#       source into UEFI-compliant binaries.
#       It is the FDF file that contains information on combining binary files into firmware
#       volume images, whose concept is beyond UEFI and is described in PI specification.
#       Binary modules do not need to be listed in this section, as they should be
#       specified in the FDF file. For example: Shell binary (Shell_Full.efi), FAT binary (Fat.efi),
#       Logo (Logo.bmp), and etc.
#       There may also be modules listed in this section that are not required in the FDF file,
#       When a module listed here is excluded from FDF file, then UEFI-compliant binary will be
#       generated for it, but the binary will not be put into any firmware volume.
#
###################################################################################################

[Components]
  !include StdLib/StdLib.inc
  $(PLATFORM_NAME)/picocpkg.inf
