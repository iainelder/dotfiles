# Fix a duplicate workflow name

A worked example.

Check for duplicate workflow names.

```console
$ grep -hoP '(?<=^name: ).*$' .github/workflows/* | sort | uniq -d
Anki
jd
```

Show the file names of the duplicate workflow names.

$ grep -oP '(?<=^name: )(Anki|jd)$' .github/workflows/*
.github/workflows/anki.yml:Anki
.github/workflows/duckdb.yml:jd
.github/workflows/htmlq.yml:Anki
.github/workflows/identitystorelister.yml:Anki
.github/workflows/jd.yml:jd

Edit the metadata in the installers of `duckdb`, `htmlq`, and `identitystorelister`.

Run `./generate_ci.bash`.

Check for duplicate workflow names again.

Now there are none.
