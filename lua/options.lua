require "nvchad.options"

-- add yours here!

local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!
-- Set how long to wait before CursorHold triggers (in milliseconds)
-- Default is 4000ms (4 seconds), lower values make it more responsive
o.updatetime = 600 -- 600ms = responsive but avoids keyboard repeat issues (see below)

-- The keyboard repeat delay is the time between when you press and hold
-- a key and when it starts repeating. If the updatetime is less than this
-- then the CursorHold will trigger before the key starts repeating.
-- This will cause the git line info to return, causing a stutter.
