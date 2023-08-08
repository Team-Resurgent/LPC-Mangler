# LPC Mangler
 
A WIP/Concept Mod for original xbox. Designed by Members from Team Resurgent.
It intercepts the LPC commands between the chipset and an LPC flash chip, rewriting the command and address bits so you can use larger, later chips that don't normally reside at the same addresses as typical LPC flash chips used in simpler mods like the Aladdin , and does so while adding as few extra clock cycles as possible to the transaction

Would love for the community to contribute & complete the design

Currently supports upto 4MB Flashes. Also has ability for serial output etc.

Requires Lframe to be implemented to work with higher rev xbox possibly.

