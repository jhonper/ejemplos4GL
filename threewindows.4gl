##############################################################################
## Module: @(#)threewindows.4gl	version: 1.0     Date: 10/1/2021
## Author: Lester Knutsen  Contact: lester@advancedatatools.com
## Copyright: Advanced DataTools Corporation - 2021
## Description: Informix 4GL for Developers Training Class Example Lab
##############################################################################

main

define ans char(1)

open window window1 at 5,10 with 10 rows, 30 columns
attribute ( border , prompt line last )
display "Window 1" at 1,2

open window window2 at 5,45 with 10 rows, 30 columns
attribute ( border , prompt line last )
display "Window 2" at 1,2

open window window3 at 18,25 with 10 rows, 30 columns
attribute ( border , prompt line last )
display "Window 3" at 1,2

while ( true )
    prompt "Window 1, 2, 3 or Q to Quit" for char ans
	case 
	when ans = 1
		current window is window1
		exit case
	when ans = 2
		current window is window2
		exit case
	when ans = 3
		current window is window3
		exit case
	when ans = "q" or ans = "Q"
		exit while
	end case
end while

end main

