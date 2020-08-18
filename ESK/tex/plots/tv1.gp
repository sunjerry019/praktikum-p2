#!/usr/bin/env gnuplot

set term epslatex color size 6in, 4in
set output "tv1-plot.tex"
# set term epscairo color size 6in, 4in
# set output "tv1.eps"
set decimalsign locale 'de_DE.UTF-8'

set title "Klemmenspannung einer galvanischen Zelle gegen den Belastungsstrom"
set ylabel "Spannung $U$ ($\\si{\\volt}$)"
set xlabel "Belastungsstrom $I$ ($\\si{\\milli\\ampere}$)"

set mxtics
set mytics
set samples 10000

f(x) = m*x + c

# (x, y, xdelta, ydelta)
fit f(x) "tv1.dat" u 1:2:(0.008*$1 + 0.001):(0.005*$2 + 0.001) xyerrors via m,c

set xrange [0:40]

# Linien
set key top right spacing 1.3

titel = "$".gprintf("%.5f", m)."I + ".gprintf("%.5f", c)."$"
plot f(x) title titel lc rgb 'dark-magenta', \
	"tv1.dat" u 1:2:(0.008*$1 + 0.001):(0.005*$2 + 0.001) with xyerrorbars title "Messpunkte" pointtype 0 lc rgb 'dark-goldenrod'
