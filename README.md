# gimp-resynthesizer
## This project aims at easing the process of using the lastest version of the amazing resynthesizer plugin on Macs.

## How do I do it?
The process is simple. Install MacPorts, install the gimp-resynthesizer port, and execute a shell script.

## How does it work?
In short, the script does the following:
* Make sure everything is set up, e.g., the resynthesizer port is installed, etc.
* Create the required directory structure
* Copy all of the required files

## How to do it
### Install MacPorts
Go to the MacPorts [home page](https://www.macports.org) and install MacPorts. This document isn't designed to serve as a MacPorts tutorial so I am relying on you to figure this out for yourself.

### Install the required ports
I installed the following ports, just to make sure I have any development libraries I need.
* gimp2-devel
* gimp-resynthesizer

### Execute the script
The script will do everything for you. These are the steps.
* prepare
  * Make sure `gimp-resynthesizer` is installed via ports and exit if it isn't
  * Determine the plugin version
  * Check to see if the path `./gimp-resynthesizer/lib/gimp/2.0/plug-ins` exists and exit if it does
  * Create the directory structure
  * `cd` to the directory structure
* process_files
  * Copy the `resynthesizer` and `resynthesizer_gui` binaries to the root of the directory structure
  * Copy all of the required python scripts to the root of the directory structure
* compress
  * Switch to the directory you executed the script from
  * Switch to the gimp-resynthesizer directory
  * Compress everything under that directory as `gimp-resynthesizer-<version>-<platform>-<arch>.tgz`, e.g., `gmic-gimp-3.3.5-darwin-arm64.tgz`
 
### How do I use it?
Once the process has completed you will have a directory structure that looks like this: `./some/path/gmic-gimp/lib/gimp/2.0/plug-ins`. You will now need to go configure GIMP to use the plugin.
1) Navigate to GIMP settings
2) Expand `Folders`
3) Click `Plug-ins`
4) In the right pane, select the icon that looks like a piece of paper wit a plus sign in the top left corner
5) Open the file selector to navigate to your directory structure, drilling down to `plug-ins`. In other words, if your ran the script from ~/Desktop, you will have the structure `/Users/bob/Desktop/gmic-gimp/lib/gimp/2.0/plug-ins`. You will select that path.
6) Restart GIMP so that it can re-read the plugins.
