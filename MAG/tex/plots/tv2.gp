#!/usr/bin/env gnuplot

set term epslatex color size 6in, 4in
set output "tv2-plot.tex"
# set term epscairo color size 6in, 4in
# set output "tv2-plot.eps"
set decimalsign locale 'de_DE.UTF-8'

set title "Torsionswinkel $\\varphi$ gegen $\\sin(\\alpha/\\si{\\degree})$"
set ylabel "Torsionswinkel $\\varphi$ ($\\si{\\degree}$)"
set xlabel "$\\sin(\\alpha/\\si{\\degree})$"

set mxtics
set mytics
set samples 10000

set xrange[0.1:1.05]

f(x) = m*x + c

# (x, y, xdelta, ydelta)
fit f(x) "tv2.dat" u (sin((($1)/180)*pi)):2:(cos((($1)/180)*pi)*2*(pi/180)):(2.5) xyerrors via m,c

# (cos((($1)/180)*pi)*(2/180)*pi)

# Linien
set key top right spacing 1.3

titel = "$".gprintf("%.5f", m)." \\sin(\\alpha/\\si{\\degree}) + (".gprintf("%.5f", c).")$"
plot f(x) title titel lc rgb 'dark-magenta', \
	"tv2.dat" u (sin((($1)/180)*pi)):2:(cos((($1)/180)*pi)*2*(pi/180)):(2.5) with xyerrorbars title "Messpunkte" pointtype 0 lc rgb 'dark-goldenrod'