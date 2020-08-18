#!/usr/bin/env gnuplot

set term epslatex color size 6in, 4in
set output "tv5-plot.tex"
# set term epscairo color size 6in, 4in
# set output "tv5.eps"
set decimalsign locale 'de_DE.UTF-8'

set title "Strahlung eines Hohlraumstrahlers"
set ylabel "Thermopannung $V$ ($\\si{\\micro\\volt}$)"
set xlabel "Temperatur $(\\theta^4 - T_0^4)$ ($\\times 10^{10} \\si{\\kelvin^4}$)"

set mxtics
set mytics
set samples 10000

f(x) = m*x + c

# (x, y, xdelta, ydelta)
fit f(x) "tv5.dat" u ((($1 + 273.15)**4 - (29+273.15)**4)/10**10):2:((4*0.1*sqrt(($1+273.15)**6 + (29+273.15)**6))/10**10):(2) xyerrors via m,c

# Linien
set key top left Left spacing 1.3

titel = "$".gprintf("%.5f", m)."x + (".gprintf("%.5f", c).")$"
plot f(x) title titel lc rgb 'dark-magenta', \
	"tv5.dat" u ((($1 + 273.15)**4 - (29+273.15)**4)/10**10):2:((4*0.1*sqrt(($1+273.15)**6 + (29+273.15)**6))/10**10):(2) with xyerrorbars title "Messpunkte" pointtype 0 lc rgb 'dark-goldenrod'

# plot "tv5.dat" u (($1 + 273.15)**4 - (29+273.15)**4):2:(4*0.1*sqrt(($1+273.15)**6 + (29+273.15)**6)):(0.1) with xyerrorbars title "Messpunkte" pointtype 2 lc rgb 'dark-goldenrod'
