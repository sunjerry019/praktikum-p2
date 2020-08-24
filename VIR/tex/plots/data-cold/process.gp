#!/usr/bin/env gnuplot

# Version >= 5.2

# set term epslatex color size 29.7cm,21cm
# set output "tv1-plot-cold.tex"
set term epscairo color size 29.7cm,21cm
set output "tv1-plot-cold.eps"
set decimalsign ","

set title "Aufstiegsverlauf der Blasen (Kalt)"
set ylabel "Vertikale Position $y/\\si{\\milli\\meter}$"
set xlabel "Zeit $t/\\si{\\second}$"

set mxtics
set mytics
set samples 10000

f(x) = m*x + c # Linear fit

array A_m[10]
array A_m_err[10]
array A_c[10]
array A_c_err[10]
array chisq[10]
array titel[10]
array input_mp[10]
array titel_mp[10]

# https://stackoverflow.com/a/17884635
do for [t=1:10] {
	inp = "B".t.".dat"
	input_mp[t] = inp
	titel_mp[t] = "Blase ".t

	m = 1; c = 1;
	fit f(x) inp u 1:($2 * 1000) via m,c  # Change to mm
	A_m[t] = m
	A_m_err[t] = m_err
	A_c[t] = c
	A_c_err[t] = c_err
	chisq[t] = FIT_STDFIT**2
	titel[t] = "$".gprintf("%.5f", m)."t + (".gprintf("%.5f", c).")$"
}

set key top left Left spacing 1.3

plot for [i=1:10] input_mp[i] u 1:($2 * 1000) title titel_mp[i] pointtype 0 lc i, for [i=1:10] A_m[i]*x+A_c[i] title titel[i] lc i

print A_m
print A_m_err

# LaTeX table output
print "\\toprule"
print "\\Blase Nr. & $m/\\si{\\milli\\meter\\per\\second}$ & $c/\\si{\\milli\\meter}$ & $\\Chi^2_\\text{red}$ \\\\"
print "\\midrule"
do for [t=1:10] {
	print "\t$".t."$ & \\num{".gprintf("%.5f", A_m[t])."(".gprintf("%.0f", A_m_err[t]*10**5).")} & \\num{".gprintf("%.5f", A_c[t])."(".gprintf("%.0f", A_c_err[t]*10**5).")}"." & \\num{".gprintf("%.5f", chisq[t])."} \\\\"
}
print "\\bottomrule"
