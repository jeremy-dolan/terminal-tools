Some command-line utilities I've written and continue to find useful.

Public domain (under [CC0](https://creativecommons.org/publicdomain/zero/1.0/)).
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


### [odf-diff](odf-diff)
Diff the content and metadata of two OpenDocument files (.odt, .ods, ...).
Requires `unzip`, `xmllint` (part of libxml2; bundled with macOS), `diff`, and
LibreOffice (or an equivalent `soffice` executable)


### [xml-diff](xml-diff)
Diff two XML files after normalizing line breaks and indentation.
This is a line-based diff of the reformatted output, not a semantic XML diff.
It won't detect cosmetic differences like attribute order and `<a/>` vs `<a></a>`.
Requires `xmllint` from libxml2 (bundled with macOS).


### [json-diff](json-diff)
Diff two JSON files after normalizing whitespace and key order. (bash; requires `jq`)


### [flac2mp3](flac2mp3)
Convert FLAC files to high-quality VBR MP3. (POSIX sh; requires `ffmpeg`)


### [logininfo](logininfo)
Pretty print some system and terminal info on login. (bash; uses `figlet` if
available)

![logininfo output](example-output/logininfo.png)
