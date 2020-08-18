#!/usr/bin/env gnuplot

set term epslatex color size 6in, 4in
set output "tv2-plot.tex"
# set term epscairo color size 6in, 4in
# set output "tv2.eps"
set decimalsign locale 'de_DE.UTF-8'

set title "Temperaturverlauf vor und nach Eintauchen von Probekörpern"
set ylabel "Temperatur $\\theta$ ($\\si{\\celsius}$)"
set xlabel "Zeit $t$ ($\\si{\\second}$)"

set mxtics
set mytics
set samples 10000

f(x) = m*x + c
g(x) = n*x + d

# (x, y, xdelta, ydelta)
fit [-20:0] f(x) "tv2-1.dat" u 1:2:(0.5):(0.5) xyerrors via m,c
fit [0:400] g(x) "tv2-1.dat" u 1:2:(0.5):(0.5) xyerrors via n,d

titelaone = "1: $".gprintf("%.5f", m)."x + (".gprintf("%.5f", c).")$"
titelatwo = "1: $".gprintf("%.5f", n)."x + (".gprintf("%.5f", d).")$"

h(x) = p*x + o
q(x) = j*x + k

fit [-20:0] h(x) "tv2-2.dat" u 1:2:(0.5):(0.5) xyerrors via p,o
fit [0:400] q(x) "tv2-2.dat" u 1:2:(0.5):(0.5) xyerrors via j,k

titelbone = "2: $".gprintf("%.5f", p)."x + (".gprintf("%.5f", o).")$"
titelbtwo = "2: $".gprintf("%.5f", j)."x + (".gprintf("%.5f", k).")$"

# Linien
set key bottom right spacing 1.3

set yrange [22:34]

plot f(x) title titelaone, \
	 g(x) title titelatwo, \
	 h(x) title titelbone, \
	 q(x) title titelbtwo, \
	"tv2-1.dat" u 1:2:(0.5):(0.5) with xyerrorbars title "Körper 1" pointtype 0, \
	"tv2-2.dat" u 1:2:(0.5):(0.5) with xyerrorbars title "Körper 2" pointtype 0

# plot "tv5.dat" u (($1 + 273.15)**4 - (29+273.15)**4):2:(4*0.1*sqrt(($1+273.15)**6 + (29+273.15)**6)):(0.1) with xyerrorbars title "Messpunkte" pointtype 2 lc rgb 'dark-goldenrod'
