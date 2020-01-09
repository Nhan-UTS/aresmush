---
toc: ~admin~ Managing the Game
summary: Creating admin-only player notes.
aliases:
- anote
- admin_note
---
# Admin and Story Notes

Admins with the `manage_notes` permission can set notes on players that are only visible to other admins.  These notes are stored separately from the player-managed notes that they set themselves.

Admins can also add "story notes", which can only be added by an admin, but will be visible to the player when they use the `notes` command.

`notes <player>` - Shows a player's admin notes.
`note/add <player>=<note name>/<text>` - Create or update a story note.
`note/add <player>/admin=<note name>/<text>` - Create or update an admin note.
`note/delete <player>=<note name>` - Deletes a story note.
`note/delete <player>/admin=<note name>` - Deletes an admin note.