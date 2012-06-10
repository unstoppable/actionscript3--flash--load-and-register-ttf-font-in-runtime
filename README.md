actionscript3--flash--load-and-register-ttf-font-in-runtime
===========================================================

# Why need to load ttf font directly?
Editors like text processors, T-Shirt editors and others, can allow user to upload and use their own fonts.

# How it was done?
The steps are: 
*  The ttf font file  is loaded and parsed by FontReader
*  Generate a SWF file in memory that include  the pasred  TTF font data by as3swf
*  Loader the generated SWF to the application domain
*  Register the font which is included in the generated SWF
 
# Dependency
 * FontReader
Convert True Type fonts in graphics with Flex. http://www.sephiroth.it/weblog/archives/2007/07/fontreader_convert_truetype_fonts_in.php
 * as3swf
A low level Actionscript 3 library to parse, create, modify and publish SWF files.
https://github.com/claus/as3swf/tree/

Blog
http://portfolio.raisedtech.com/archives/as3-load-and-register-ttf-font-in-runtime/