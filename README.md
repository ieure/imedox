# IMEDox

This is my Ergodox Infinity firmware, with my layout & a modified
default image / LCD color.

It might be useful as an example if you want to customize these
things, too.

## Making your own LCD images

The root has a modified `bitmap2Struct.py`. I found that Pillows was
corrupting images when `.convert(1)` was called, so I modified it so
it only detects black pixels -- any other pixel is treated as white.

If you give it a 128x32 B&W PNG as input, it will output the correct
struct; paste that into `STLcdDefaultImage` (or the appropriate layer)
in [`lcdFuncMapIME.kll`](blob/master/lcdFuncMapIME.kll)

I haven’t been able to get Pillows working correctly on OS X, but it
works fine with Linux.
