# >_ Root the Box
Root the Box is a real-time capture the flag (CTF) scoring engine for computer wargames where hackers can practice and learn. The application can be easily configured and modified for any CTF style game. The platform allows you to engage novice and experienced players alike by combining a fun game-like environment with realistic challenges that convey knowledge applicable to the real-world, such as penetration testing, incident response, digital forensics and threat hunting.

Like traditional CTF games, each team or player can target challenges of varying difficulty and sophistication, attempting to collect flags. But Root the Box brings additional options to the game.  It has built-in support for "botnets", allowing players to upload a small bot program to target machines that grant periodic rewards for each bot in the botnet.  You have the option to use a banking system, where (in-game) money can be used to unlock new levels, buy hints to flags, download a target's source code, or even "SWAT" other players.  Password hashes for player bank accounts can also be publically displayed, allowing competitors to crack them and steal each other's money.

![example](static/images/example.png)

Features
-------------
* [Distributed under the Apache License, Version 2.0](http://www.apache.org/licenses/LICENSE-2.0)
* Team Play or Individual Play
* Real-time scoreboard graphs using websockets
* Real-time status updates using websockets
* Flag Types: Static, Regex, Datetime, Multiple Choice, File - w/options for case senstivity
* Options for Penalties, Hints, Level Bonuses, Dynamic Scoring, Categories and more
* Built-in team based file/text sharing and Admin game material distirbution
* Freeze Scores at a specific time allowing for end game countdown
* Optional [in-game Botnets](https://github.com/moloch--/RootTheBox/wiki/Features) or wall of sheep displaying cracked passwords
* Unlocks and upgrades as users capture flags
* Export and share Boxes/Flags
* Other cool stuff

Setup
-------------------
**BEFORE Going any further, please follow these steps:**
  
  1. Download and install [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
  1. Download and install [Vagrant](https://www.vagrantup.com/downloads.html)
  1. In the project directory, run: `vagrant up`
  1. If all goes well, navigate to http://localhost:8080
  1. To stop the VM: `vagrant halt`
  1. To destroy and create a fresh copy: `vagrant destroy`, then: `vagrant up`
  1. To make changes to the provisioner script and REPROVISION the SAME host without creating a new one: `vagrant provision`


See the [Root the Box Wiki](https://github.com/moloch--/RootTheBox/wiki)

Platform Requirements
-------------------------
* [Python 2.7.x](https://www.python.org/) or [Pypy 2.x](http://pypy.org/)
* Install scripts are for [Ubuntu](http://www.ubuntu.com/) (or [Debian](https://www.debian.org/)) but the application should work on any Linux, BSD, or OSX system.
* Internet Explorer is *NOT* supported, any compatability with IE is purely coincidental. Please use the latest release of [Firefox](https://www.mozilla.org/en-US/), [Chrome](https://www.google.com/chrome/), [Opera](http://www.opera.com/), or any other browser that supports open standards.

Avatar Packs
-------------------
* [Marvel User Pack](https://drive.google.com/open?id=100my3UEBXAFDHAAsl-5By5TPk6JrZ1LO}) (pw: rootthebox)
* [Assorted Team Pack](https://drive.google.com/open?id=1aeAeAuNulJVd2w5ADhBlmP1WqdpzDpjz) (pw: rootthebox)

Questions? Problems?
-------------------------------
Open a ticket on GitHub and I'd be happy to help you out with setup/configuration/edits.

Feature Requests
----------------------
Open a ticket on GitHub, and I'll see what I can do for you.  I'm always brainstorming new ideas, and looking for cool stuff to add!
