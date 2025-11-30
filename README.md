# Tech Support System Repair Script

This repository contains a PowerShell script designed to automate a series of common system repair and maintenance tasks for Windows operating systems. It aims to diagnose and fix various issues related to system file integrity, disk errors, driver problems, temporary file accumulation, and network configurations, providing a comprehensive first-line defense for technical support scenarios.

## Key Features

*   **System Image Repair**: Utilizes DISM to restore the integrity of the Windows system image.
*   **System File Checker (SFC)**: Scans and repairs corrupted Windows system files.
*   **Disk Error Checking (CHKDSK)**: Verifies and repairs file system errors on the disk.
*   **Driver Management**: Lists installed drivers to help identify potential issues.
*   **Temporary File Cleanup**: Cleans up temporary files that can cause system slowdowns or conflicts.
*   **Windows Update Integration**: Initiates Windows Update to ensure drivers and the operating system are up-to-date.
*   **Registry Integrity Check**: Performs a health scan of the Windows registry.
*   **Event Log Cleanup**: Clears old error logs from the Event Viewer.
*   **Network Configuration Reset**: Resets Winsock and IP configurations, useful for resolving network connectivity issues.

## Tech Stack

*   **Language**: PowerShell
*   **Operating System**: Windows (utilizes built-in Windows command-line utilities)
*   **Core Utilities**:
    *   `dism.exe`
    *   `sfc.exe`
    *   `chkdsk.exe`
    *   `pnputil.exe`
    *   `cleanmgr.exe`
    *   `wevtutil.exe`
    *   `netsh.exe`
    *   `Install-WindowsUpdate` (PowerShell module, typically available on modern Windows versions or via PSGallery)

## Getting Started

### Prerequisites

*   A computer running **Windows 7 or newer**.
*   **PowerShell 3.0 or higher** (usually pre-installed on modern Windows versions).
*   **Administrative privileges** are required to run the script, as it executes system-level commands.
*   Internet connection for Windows Update functionality.

### Installation

No installation is required beyond downloading the script.

1.  **Clone the repository** (or download the `image_repair.ps1` file directly):
    ```bash
    git clone https://github.com/sousadevelop/Tech_Support.git
    cd Tech_Support
    ```
2.  Locate the `image_repair.ps1` file.

## Usage Guide

To run the script, you must open PowerShell with administrative privileges.

1.  **Open PowerShell as Administrator**:
    *   Search for "PowerShell" in the Start Menu.
    *   Right-click on "Windows PowerShell" and select "Run as administrator".
    *   Confirm the User Account Control (UAC) prompt if it appears.

2.  **Navigate to the script's directory**:
    ```powershell
    cd C:\Path\To\Your\Tech_Support_Folder
    ```
    (Replace `C:\Path\To\Your\Tech_Support_Folder` with the actual path where you saved the script.)

3.  **Execute the script**:
    ```powershell
    .\image_repair.ps1
    ```

The script will then execute each command sequentially, displaying messages in the console about the current operation. Some operations, like `CHKDSK`, may require a system reboot to complete.

**Important Notes:**
*   The script will pause for each command to complete. Some commands (e.g., DISM, SFC, CHKDSK) can take a significant amount of time.
*   The `Install-WindowsUpdate` command might trigger a system reboot if updates are installed.
*   It is recommended to back up important data before running any system repair scripts.

## Architecture Overview

The project consists of a single, monolithic PowerShell script (`image_repair.ps1`). It follows a sequential execution model, where each line or block of code performs a specific system maintenance or repair task. The script leverages built-in Windows command-line utilities and PowerShell cmdlets to interact with the operating system at a low level.

The flow is straightforward:
1.  Display a message indicating the current task.
2.  Execute a system command using `Start-Process` or a PowerShell cmdlet.
3.  Wait for the command to complete (`-Wait` parameter for `Start-Process`).
4.  Proceed to the next task.

This design makes it easy to understand and modify, but also means that if one command fails, the script will generally continue to the next task unless a critical error prevents further execution.

## API Reference

This project does not expose a traditional API in the sense of web services or libraries. Instead, it acts as an automation script that utilizes the "APIs" of the Windows operating system through its command-line utilities. Below are the primary commands executed by the script and their general purpose:

*   **`dism.exe /online /cleanup-image /restorehealth`**
    *   **Purpose**: Repairs the Windows Component Store corruption using Windows Update as the source.
*   **`sfc.exe /scannow`**
    *   **Purpose**: Scans and verifies the integrity of all protected system files and replaces incorrect, corrupted, changed, or damaged versions with correct versions.
*   **`chkdsk.exe /f /r`**
    *   **Purpose**: Scans the hard drive for errors and attempts to fix them (`/f`) and locate bad sectors and recover readable information (`/r`). May require a reboot.
*   **`pnputil.exe /enum-drivers`**
    *   **Purpose**: Lists all currently installed third-party drivers. Useful for diagnosing driver-related issues.
*   **`cmd.exe /c cleanmgr /sagerun:1`**
    *   **Purpose**: Executes Disk Cleanup with a predefined set of options (often configured via `cleanmgr /sageset:1`) to remove temporary files, system logs, and other unnecessary data.
*   **`Install-WindowsUpdate -MicrosoftUpdate -AcceptAll -AutoReboot`**
    *   **Purpose**: Installs all available updates from Microsoft Update, accepting all licenses, and automatically reboots if necessary. This cmdlet is part of the PSWindowsUpdate module.
*   **`dism.exe /online /cleanup-image /scanhealth`**
    *   **Purpose**: Scans the Windows Component Store for corruption without performing any repairs.
*   **`wevtutil el | Foreach-Object { wevtutil cl $_ }`**
    *   **Purpose**: Enumerates all event logs and then clears each one, removing old error and system logs.
*   **`netsh winsock reset`**
    *   **Purpose**: Resets the Winsock Catalog to a clean state, which can resolve various network connectivity problems.
*   **`netsh int ip reset`**
    *   **Purpose**: Resets TCP/IP settings, including IP addresses, DNS servers, and routing tables, to their default configurations.
