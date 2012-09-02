#iOSInstalledApps

Utility functions to fetch installed apps on iOS by a combination of reading running processes &amp; investigating custom URL schemes implemented.

## Background

Unlike Android & other mobile operating systems, iOS doesnt let you query for a list of installed applications. Developers have had to resort to circumventing this by a few techniques:

* reading running processes & maintaining a map to their iTunes data
* examining whether it is possible to launch an installed iOS app via the custom URL schemes that are publicly available, and thereby infer that it is installed

This repo provides a few utility functions that you can use for both these approaches in conjunction with your dataset mappings (not included).

## Usage

Refer to a simple example in the App Delegate
