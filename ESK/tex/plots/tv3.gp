#!/usr/bin/env gnuplot

set term epslatex color size 6in, 4in
set output "tv3-plot.tex"
# set term epscairo color size 6in, 4in
# set output "tv3.eps"
set decimalsign locale 'de_DE.UTF-8'

set title "Ausgangsspannung des Helipots gegen Skalenwerte des Helipots"
set ylabel "Spannung $U$ ($\\si{\\volt}$)"
set xlabel "Skala $x$ (Schritt)"

set mxtics
set mytics
set samples 10000

f(x) = m*x + c

# (x, y, xdelta, ydelta)
fit f(x) "tv3.dat" u 1:2:(0.5):(0.005*$2 + 0.01) xyerrors via m,c

# Linien
set key bottom right spacing 1.3

titel = "$".gprintf("%.5f", m)."x + ".gprintf("%.5f", c)."$"
plot f(x) title titel lc rgb 'dark-magenta', \
	"tv3.dat" u 1:2:(0.5):(0.005*$2 + 0.01) with xyerrorbars title "Ausgangsspannung des Helipots" pointtype 0 lc rgb 'dark-goldenrod', \
	"tv3.dat" u 1:3:(0.5):(0.005*$2 + 0.01) with xyerrorbars title "Ausgangsspannung des Netzgeräts" pointtype 0 lc rgb 'dark-green'
