**This repo is supposed to used as config by NvChad users!**

- The main nvchad repo (NvChad/NvChad) is used as a plugin by this repo.
- So you just import its modules , like `require "nvchad.options" , require "nvchad.mappings"`
- So you can delete the .git from this repo ( when you clone it locally ) or fork it :)

# Credits

1) Lazyvim starter https://github.com/LazyVim/starter as nvchad's starter was inspired by Lazyvim's . It made a lot of things easier!

# Cheatsheet

This is not meant to be comprehensive, it's list of useful ones which I tend to forget!
NOTE: some of these don't work now that the config sets `vim.opt.scrolloff = 999`, which keeps the cursor centred e.g. `zz`

1. Switch tab right/left: <Tab> <S-Tab>
2. Toggle between sidebar and tabs: <C-w>w
3. Goto definition: gd
4. Close tab: <leader> x
5. Jump to end of line and enter insert mode: A
6. Jump to end/start of line visual mode: $ 0
7. Undo/Redo a change: u <C-r>
8. Show diagnostic: <leader> d
9. Show code actions: <leader> a
10. Jump to end/start of line in insert mode: <C-e> <C-o>0
11. Find all references (opens a quickfix list): grr
12. Go to next/previous item in (quickfix) list: :cn :cp
13. Spelling suggestions: z=
14. Jump to next/previous misspelled word: ]s [s
15. Comment/Uncomment code (after selecting): <leader>/
16. Rename/delete/add a file or directory: r d a (add a trailing slash to create a directory e.g. src/)
17. Move to start/end of document: gg G
18. Word search (this will interpret word as a regex): /word
19. Word search literal: /\Vword 
20. Search for word under the cursor: *
21. Next previous word: n N
22. Ignore/No ignore case: set:ignorecase set:noignorecase
23. Centre/top/bottom the cursor on the screen: zz zt zb
24. Get github permalink: :GitHubLink
25. Move cursor to the top/bottom: H L
26. Open a file for editing: :e filename
27. Expand/shrink file explorer: <C-Right <C-Left>> 
28. Copy full path of the current buffer to the system clipboard: <leader> cp
29. Find and replace all matches on the current line: :s/foo/bar/g
30. Find and replace all matches in the file: :%s/foo/bar/g
31. Find and replace all matches in the file with confirmation: :%s/foo/bar/gc
32. Jump to line x: :x
33. Go the next/previous diagnsotic: ]d [d
34. Hover (e.g. show documentation): K 
35. Jump to last insert exit: <leader> i
36. Rename a symbol: <leader> rn
37. Set a mark named g: mg
38. Jump to mark g (<backtick> shows all marks): <backtick>g
39. Jump to last edit: <backtick>.
40. Close the popup menu: <C-e>
41. Collapse all in neo tree: z
42. Delete/yank/select symbol under cursor: diw di{ yiw yi{ viw vi{
43. Enter visual line mode: V 
44. Set text width: :set textwidth=100
45. Reflow paragraph: gqap
46. Reflow selection: gq
47. Jump to column 50: 50|
