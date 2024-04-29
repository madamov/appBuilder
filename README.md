
# Building 4D applications using Github actions

This repository is companion to 4D Method (4D user group)  [Master Action Building with GitHub](https://4dmethod.com/2024/04/24/master-action-building-with-github-milan-adamov/) presentation.

It demonstrates how can combination of bash scripts, Windows BAT files, 4D code and power of GitHub actions be used to build and upload final archives and dmg files to SFTP destination.

If you are going to fork it, here is the list of repository secrets you need to define:

| Secret name                | Description                                                  |
| :------------------------- | :----------------------------------------------------------- |
| **BINARIES_PASSWORD**      | Password to access location where 4D binaries are uploaded   |
| **BINARIES_USER**          | Username for above                                           |
| **UPLOAD_USER**            | Username of destination SFTP server for releases             |
| **UPLOAD_PASSWORD**        | Password for above                                           |
| **UPLOAD_USER**            | Username of destination SFTP server for test releases        |
| **UPLOAD_PASSWORD**        | Password for above                                           |
| **MILANTOK**               | GitHub token for GitHub account                              |
| **DEV_MAC**                | Base64 encoded zip archive of 4D Developer Professional licenses (macOS) |
| **DEV_WIN**                | Base64 encoded zip archive of 4D Developer Professional licenses (Windows) |
| **MY_APPLE_CERTIFICATE**   | Base64 encoded Apple Developer Certificate                   |
| **MY_APPLE_CERT_PASSWORD** | Password for Apple Developr certificate                      |
| **KEYCHAIN_PASSWORD**      | Password for temporary keychain file                         |

Here is the list of repository variables used in workflow for build and version numbers you need to define:

| Variable             | Description                                                  |
| -------------------- | ------------------------------------------------------------ |
| **APP_BUILD_NUMBER** | Current build number, it will be automatically increased after each successful build |
| **APP_VERSION**      | Application version                                          |

