# System
## Window
### Macのタスク切り替えで、最小化されたウィンドウを表示する方法

<kbd>Command</kbd> + <kbd>Tab</kbd> でアプリを選択した後、<kbd>Option</kbd>を押して<kbd>Command</kbd>を離す


## Mac Dock Navigation Keyboard Shortcuts
Here are eight must-know keystrokes for navigating the Mac Dock. Note you must first summon the Dock with the keyboard navigation enabled, which is the first tip. From then on, you can use the additional keyboard navigation tricks.

* <kbd>Control</kbd>+<kbd>Function</kbd>+<kbd>F3</kbd> to summon the Dock with keyboard navigation enabled, works even if the Dock is hidden by default
* <kbd>&larr;</kbd> & <kbd>&rarr;</kbd> to move within the Dock items
* <kbd>&uarr;</kbd> to pull open the Dock items menu, the same as right-click
* Return key to launch the currently selected app
* Use keyboard letters to jump to apps by first letter of the app name
* Hold <kbd>Option</kbd> key while navigating to, then hit the Up Arrow key to access Force Quit
* <kbd>Command</kbd>+<kbd>Return</kbd> to reveal the Dock item in the Finder
* <kbd>Command</kbd>+<kbd>Option</kbd>+<kbd>Return</kbd> to hide all other apps and windows except for the selected Dock item

## Prevent sleep
* `caffeinate` may work [here](https://computers.tutsplus.com/tutorials/quick-tip-how-to-stop-your-mac-from-sleeping-using-the-command-line--mac-50905)

```
$ caffeinate
R
```

* Type `caffeinate` before starting `R` or `Python` may work

# Apps
## iWORK
### Download older versions of iWORK
[here](https://discussions.apple.com/thread/253442218)

If you had Pages/Numbers/Keynote installed prior to the upgrade to Catalina, you might be able to get the latest compatible version for Catalina.
Launch the Mac App Store with the same Apple ID as you used to obtain these applications previously. Press <kbd>cmd</kbd>+<kbd>0</kbd> (zero) to open the Purchased panel.
If the above method does not work, there will be no means to get Pages v10.2 - v11.1 for Catalina, and you will need to use Pages for iCloud, or compatible Pages for your iOS/iPadOS installation.


# External devices
## Anker bluetooth keyboard
* Pairing: <kbd>fn</kbd> + <kbd>z</kbd>

# Misc

## How to prevent creation of .DS_Store files on network volumes
* After running the following command, reboot your Mac to apply the changes

```
$ defaults write com.apple.desktopservices DSDontWriteNetworkStores true
```