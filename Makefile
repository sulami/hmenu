HC=ghc
HFLAGS=--make -O2

all:
	$(HC) $(HFLAGS) hmenu.hs

