# MiniMods
Extension for the `Mods` package for very small moduli.

## Everything is the same, just smaller

The `MiniMods` module defines the `MiniMod` type that operates
exactly the same as `Mod` (from the `Mods` module) except that 
moduli are restricted to lie between 2 and 127. In this way, a
`MiniMod` only takes up one byte of memory, whereas a `Mod` uses 
eight. 

I have not thoroughly tested this module. When I'm reasonably 
satisfied, I'll advance the version number to 0.1.0 and register.