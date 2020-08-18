#!/usr/bin/env gnuplot

# set term epslatex color size 6in, 4in
# set output "tv1-plot.tex"
set term epscairo color size 6in, 4in
set output "tv1-plot.eps"
set decimalsign locale 'de_DE.UTF-8'

set title "Torsionswinkel $\\phi$ gegen $\\sin{\alpha/\\si{\\degree}}$"
set ylabel "Torsionswinkel $\\phi$ ($\\si{\\degree}$)"
set xlabel "Belastungsstrom $I$ ($\\si{\\milli\\ampere}$)"

set mxtics
set mytics
set samples 10000

set style data lines

# Linien
set key top right spacing 1.3

Shadecolor = "#80E0A080"
plot "tv1-ng.dat" u 1:2:3:(0.005*$2 + 0.001) with xyerrorbars title "Messpunkte" pointtype 0 lc rgb 'dark-goldenrod', \
     '' using 1:2 smooth mcspline lw 2 lc rgb 'dark-magenta' title "glatter Spline durch Daten"

# "" u 1:($2 + (0.005*$2 + 0.001)):($2 - (0.005*$2 + 0.001)) with filledcurve fc rgb Shadecolor notitle, \