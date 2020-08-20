#!/usr/bin/env gnuplot

set term epslatex color size 6in, 4in
set output "tv5-plot.tex"
# set term epscairo color size 6in, 4in
# set output "tv5-plot.eps"
set decimalsign locale 'de_DE.UTF-8'

set title "Entladekurve eines Kondensators"
set ylabel "$\\ln U_C / \\si{\\volt}$"
set xlabel "Zeit $t/\\si{\\second}$"

set mxtics
set mytics
set samples 10000

f(x) = m*x + c

# (x, y, xdelta, ydelta)
fit f(x) "tv5.dat" u ($1/1000):(log($2)):($3/1000):(0.02/$2) xyerrors via m,c

set key top right spacing 1.3

titel = "$".gprintf("%.5f", m)."t + ".gprintf("%.5f", c)."$"
plot f(x) title titel lc rgb 'dark-magenta', \
	"tv5.dat" u ($1/1000):(log($2)):($3/1000):(0.02/$2) with xyerrorbars title "Messpunkte" pointtype 0 lc rgb 'dark-goldenrod'