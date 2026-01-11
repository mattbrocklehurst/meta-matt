# meta-matt

A custom OpenEmbedded/Yocto layer providing compatibility fixes and recipe appends for the Java ecosystem on modern Linux distributions.

## Overview

This layer was developed to address build regressions introduced by **GCC 14** and modern toolchains when compiling legacy Java suites. It focuses on resolving issues related to:
* Strict pointer type-safety requirements (pointer-to-integer casts).
* Implicit function declarations.
* Header file refactoring in modern GLIBC/Toolchain environments.

## Key Fixes

### OpenJDK 8 & IcedTea Bootstrap
The build process for OpenJDK 8 involves a complex multi-stage bootstrap. This layer manages the "Phase 2" target build while tracking upstream fixes for the "Phase 1" tools:

* **Subsystem Patching:** Addresses regressions in AWT, JPEG, and Security libraries within the JDK 8 source tree.
* **Architectural Isolation:** Uses `.bbappend` files to inject fixes without modifying upstream `meta-java` include files, maintaining a clean separation of concerns.

### Upstream Contributions
The fixes for the initial IcedTea7 bootstrap process have been submitted to the official `meta-java` maintainers to assist the community with the GCC 14 transition:

* **PR #63:** [Fix GCC 14 compatibility for IcedTea7-Native](https://github.com/meta-java/meta-java/pull/63)

### Additional Components
Includes maintenance appends for supporting libraries and tools:
* **Cacao & Classpath:** Adjustments for initial-native bootstrap compatibility.
* **Jakarta Libs:** Source URI and build-path fixes for legacy XML and logging frameworks.
* **Xalan-J:** Version-specific compatibility tweaks for modern builds.

## Dependencies

This layer depends on:
* **URI:** `git://git.yoctoproject.org/poky` (Branch: Scarthgap or newer)
* **URI:** `git://git.yoctoproject.org/meta-java`

## Usage

Add this layer to your `conf/bblayers.conf`:

```bash
BBLAYERS += "path/to/layers/meta-matt"
