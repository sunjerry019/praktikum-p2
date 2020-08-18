#!/usr/bin/env gnuplot

set term epslatex color size 6in, 4in
set output "tv1-plot.tex"
# set term epscairo color size 6in, 4in
# set output "tv1.eps"
set decimalsign locale 'de_DE.UTF-8'

set title "Erwärmung von Wasser im Kalorimeter"
set ylabel "Temperatur $\\theta$ ($\\si{\\celsius}$)"
set xlabel "Zeit $t$ ($\\si{\\second}$)"

set mxtics
set mytics
set samples 10000

f(x) = m*x + c

# (x, y, xdelta, ydelta)
fit f(x) "tv1.dat" u 1:2:(0.2):(0.3) xyerrors via m,c

# Linien
set key top left Left spacing 1.3

titel = "$".gprintf("%.5f", m)."t + ".gprintf("%.5f", c)."$"
plot f(x) title titel lc rgb 'dark-magenta', \
	"tv1.dat" u 1:2:(0.2):(0.3) with xyerrorbars title "Messpunkte" pointtype 2 lc rgb 'dark-goldenrod'
