## Test environments
- R-hub windows-x86_64-devel (r-devel)
- R-hub ubuntu-gcc-release (r-release)
- R-hub fedora-clang-devel (r-devel)

## R CMD check results

There were no ERRORs or WARNINGs.

NOTES:

1. Possibly misspelled words in DESCRIPTION

```{r}
  On windows-x86_64-devel (r-devel)
  checking CRAN incoming feasibility ... NOTE
  Maintainer: 'Jorge Mestre <jormart2@alumni.uv.es>'
  
  New submission
  
  Possibly misspelled words in DESCRIPTION:
    Overthink (3:14)
```

Ignore

2. Only found in windows-x86_64-devel

```{r}
  On windows-x86_64-devel (r-devel)
  checking for non-standard things in the check directory ... NOTE
    ''NULL''
  Found the following files/directories:
```

This could be due to a bug/crash in miktex and can be ignored ([R-hub issue #503](https://github.com/r-hub/rhub/issues/503)).

3. Only found in windows-x86_64-devel

```{r}
  On windows-x86_64-devel (r-devel)
  checking for detritus in the temp directory ... NOTE
  Found the following files/directories:
    'lastMiKTeXException'
```

This could be due to a bug/crash in miktex and can be ignored ([R-hub issue #560](https://github.com/r-hub/rhub/issues/560)).

4. New submission

```{r}
  On ubuntu-gcc-release (r-release)
  checking CRAN incoming feasibility ... [5s/10s] NOTE
  Maintainer: ‘Jorge Mestre <jormart2@alumni.uv.es>’
  
  New submission
```

```{r}
  On fedora-clang-devel (r-devel)
  checking CRAN incoming feasibility ... [6s/14s] NOTE
  Maintainer: ‘Jorge Mestre <jormart2@alumni.uv.es>’
  
  New submission
```

Submitting a new package.

5. No 'tidy' installed

```{r}
  On ubuntu-gcc-release (r-release), fedora-clang-devel (r-devel)
  checking HTML version of manual ... NOTE
  Skipping checking HTML validation: no command 'tidy' found
```
