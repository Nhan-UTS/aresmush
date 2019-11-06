---
toc: 4 - Writing the Story
summary: Private emotes and whispers.
order: 1
aliases:
- pemit
- whispers
---

## Private Emits / Whispers

The `pemit` command lets you make a private emit only to certain characters. This will appear like an emit, but with an OOC notice in front telling who it came from. It will also echo back to the sender of the pemit. *You cannot pemit to players in the scene via the web-portal scene system and the pemit will not show up in the log*.

`pemit <list of names>=<message>` - Make a private emit.

You can also `whisper` to another character. This is functionaly the exact same as a pemit, but it is "flavored" as a whisper, instead of an untitled private emit. It will say it is a whisper and show who it is from/to. The room doesn't see anything. *You cannot whisper to players in the scene via the web-portal scene system and the whisper will not show up in the log*.

`whisper <name>=<message>` - Whisper to someone.

Whisper will always output like: **Bob to Tom: <message>**
