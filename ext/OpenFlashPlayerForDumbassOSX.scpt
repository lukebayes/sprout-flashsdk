
on run argv
    set flash_player to item 1 of argv as text
    set swf_file to item 2 of argv as text
    tell application flash_player to activate
    tell application flash_player to open swf_file
    repeat
      if application flash_player is not running then exit repeat
      delay 0.1
    end repeat

end run


