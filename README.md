# K Board Games Server
[![Server Status](https://img.shields.io/pingpong/status/sp_7241145592d44ae2bd4c2a9c4558a0ef?label=kboardgames.com&style=for-the-badge)](https://kboardgames.com)
[![Discord](https://img.shields.io/discord/878790325261434923?color=%236b7ff5&label=Discord&style=for-the-badge)](https://discord.gg/7gF8t3yNDU)

The server for KBoardGames. Use this software to host games.

<p>Play 8x8 board games online with other players using the client software. Main features are <a href="https://kboardgames.com/forum/events">scheduled events</a>, signature game, game statistics, daily quests and a <a href="https://kboardgames.com/forum/viewtopic.php?f=4&t=3">isometric house side game</a>. Currently, the board games that you can play online against other players are <a href="/forum/viewtopic.php?f=10&amp;t=15">chess</a>, <a href="/forum/viewtopic.php?f=10&amp;t=14">checkers</a>, <a href="/forum/viewtopic.php?f=10&amp;t=17">snakes and ladders</a>, <a href="/forum/viewtopic.php?f=10&amp;t=16">reversi</a> and a signature game called <a href="/forum/viewtopic.php?f=10&amp;t=18">wheel estate</a>, game.</p>

## Summary
* Room lock feature. No back doors.
* Anti-cheating of player statistics.
* Player activity <a href="https://kboardgames.com/forum/viewtopic.php?f=4&t=33">server logging.</a>
* Built-in server anti-hammering feature.

## Dependencies
For compilation you will need:

* Haxe 4.0.0-rc.2
* Haxeflixel (See haxelib commands below.)
* MySQL

Here are the libraries needed to build Haxeflixel games. Note that newer versions of these libraries will break the libraries found in the vendor folder.

* haxelib install actuate 1.8.9
* haxelib install flixel-addons 2.7.5
* haxelib install flixel-demos 2.7.0
* haxelib install flixel-templates 2.6.1
* haxelib install flixel-tools 1.4.4
* haxelib install flixel-ui 2.3.2
* haxelib install flixel 4.6.1
* haxelib install hxcpp 4.0.8
* haxelib install lime-tools 1.5.7
* haxelib install lime 7.3.0
* haxelib install openfl 8.9.0
* haxelib install msgpack-haxe 1.15.1
* haxelib run lime setup

## Compilation
```
haxe Build.hxml
```

## License disclaimer

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see https://www.gnu.org/licenses/.