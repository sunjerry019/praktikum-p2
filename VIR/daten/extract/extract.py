#!/usr/bin/env python3

import subprocess as sp

mainfile = "20200816_150122.h264.mp4"
basename = "20200816_150122.h264"
processes = []

with open("stamps.txt","r") as f:
	for line in f:
		start, end = line.strip().split("\t")
		print(start, end)

		processes.append(sp.Popen(['ffmpeg', "-i", f"{mainfile}", "-ss", f"{start}", "-to" , f"{end}", f"{basename}.{start.replace(':', '.')}_{end.replace(':', '.')}.mp4"]))

[x.wait() for x in processes]

# Using -ss as input option together with -c:v copy might not be accurate since ffmpeg is forced to only use/split on i-frames. Though it will—if possible—adjust the start time of the stream to a negative value to compensate for that. Basically, if you specify "second 157" and there is no key frame until second 159, it will include two seconds of audio (with no video) at the start, then will start from the first key frame. So be careful when splitting and doing codec copy. 