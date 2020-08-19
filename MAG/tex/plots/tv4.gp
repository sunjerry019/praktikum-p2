#!/usr/bin/env gnuplot

set term epslatex color size 6in, 4in
set output "tv2-plot.tex"
# set term epscairo color size 6in, 4in
# set output "tv4-plot.eps"
set decimalsign locale 'de_DE.UTF-8'

set title "Induzierte Spannung $U_{\\text{ind}}$ gegen Gradient des Stromfelds $\\displaystyle \\dv{I}{t}$"
set ylabel "Induzierte Spannung $U_{\\text{ind}}$ $(\\si{\\milli\\volt})$"
set xlabel "Gradient des Stromfelds $\\displaystyle \\dv{I}{t}$ $(\\si{\\milli\\ampere\\per\\second})$"

set mxtics
set mytics
set samples 10000

set yrange [30:115]

f(x) = m*x + c

# (x, y, xdelta, ydelta)
fit f(x) "tv4.dat" u 1:2 via m,c

# (cos((($1)/180)*pi)*(2/180)*pi)

# Linien
set key top right spacing 1.3

titel = "$".gprintf("%.5f", m)." \\dv{I}{t} + (".gprintf("%.5f", c).")$"
plot f(x) title titel lc rgb 'orangered4', \
	"tv4.dat" u 1:2 title "Messpunkte" pointtype 1 lc rgb 'midnight-blue'