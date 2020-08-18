#!/usr/bin/env python3

import mpmath as mp 

arr = ["1.04", "1.04", "1.065", "1.025", "1.05", "1.05", "1.055", "1.055", "1.05", "1.07", "1.08", "1.055", "1.055", "1.07", "1.055", "1.025", "1.04"]
mparr = [ mp.mpf(x) for x in arr ]

s = mp.fsum(mparr)
mittelwert = mp.fdiv(s, len(mparr))

difference = [mp.fsub(x, mittelwert) for x in mparr]
stdev = mp.sqrt(mp.fdiv(mp.fsum(difference, squared=True), mp.fsub(len(mparr), 1)))

print("Mittelwert:\t\t", mittelwert)
print("Standardabweichung:\t", stdev)