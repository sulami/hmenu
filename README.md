hmenu
=====

a fuzzy finder and launcher for your command line.

Building / Installing
---------------------

hmenu can be built using `stack` or `cabal`. If you build using cabal, you will
need to install GHC and [missingH][mh].

#### Stack

```sh
stack build
stack install
```

#### Cabal

```sh
cabal sandbox init # recommended
cabal install MissingH
cabal build
cabal install
```

You can also install it directly from [hackage][hack].

Usage
-----

hmenu will scan all directories in your `$PATH` and collect executables from
there. You then can just start typing substrings of the program you want to
run. hmenu will always show you the up to five best matches, and if you press
return at any point, it will execute the best match and exit.

Matches are ordered by distance of the matched substrings from each other
within the program name and distance of the first match from the beginning of
the name.

[mh]: https://hackage.haskell.org/package/MissingH
[hack]: https://hackage.haskell.org/package/hmenu

