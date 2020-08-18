#!/usr/bin/env gnuplot

set term epslatex color size 6in, 4in
set output "tv2-plot.tex"
# set term epscairo color size 6in, 4in
# set output "tv2.eps"
set decimalsign locale 'de_DE.UTF-8'

set title "Abhängigkeit von Strom und Spannung"
set ylabel "Spannung $U$ ($\\si{\\volt}$)"
set xlabel "Strom $I$ ($\\si{\\milli\\ampere}$)"

set mxtics
set mytics
set samples 10000

f(x) = m*x + c

# (x, y, xdelta, ydelta)
fit f(x) "tv2.dat" u 2:1:(0.008*$2 + 0.1):(0.005*$1 + 0.01) xyerrors via m,c

# Linien
set key top left Left spacing 1.3

titel = "$".gprintf("%.5f", m)."I + ".gprintf("%.5f", c)."$"
plot f(x) title titel lc rgb 'dark-magenta', \
	"tv2.dat" u 2:1:(0.008*$2 + 0.1):(0.005*$1 + 0.01) with xyerrorbars title "Messpunkte" pointtype 0 lc rgb 'dark-goldenrod'
