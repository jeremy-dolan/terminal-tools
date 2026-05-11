Some command-line utilities I've written and continue to find useful.

Public domain (under CC0, https://creativecommons.org/publicdomain/zero/1.0/).
Use them however you like.

### [showcolors](showcolors)
Test "ANSI color" and other SGR control sequences. (Python)

![showcolors output](example-output/showcolors.png)


### [ssh-diff](ssh-diff)
Diff two files, allowing scp-like paths of the form `[user@]ssh-host:path`.
(bash; wraps `diff` and `ssh`)

```
% ssh-diff sandbox:dev/file host:deploy/file
...
```

### [flac2mp3](flac2mp3)
Convert FLAC files to high-quality VBR MP3. (POSIX sh; requires `ffmpeg`)


### [logininfo](logininfo)
Pretty print some system and terminal info on login. (bash; uses `figlet` if
available)

![logininfo output](example-output/logininfo.png)
