#! /usr/bin/env python

import glob
import os
from aubio import tempo, source

win_s = 512
hop_s = win_s // 2

# remove file if it exists
if os.path.isfile('bpms.txt'):
    os.remove("bpms.txt")


def get_bpm(filename):
    s = source(filename, 0, hop_s)
    samplerate = s.samplerate
    o = tempo("default", win_s, hop_s, samplerate)

    beats = []

    total_frames = 0
    while True:
        samples, read = s()
        is_beat = o(samples)
        if is_beat:
            this_beat = o.get_last_s()
            beats.append(this_beat)
        total_frames += read
        if read < hop_s:
            break

    if len(beats) > 1:
        from numpy import mean, diff
        bpms = 60. / diff(beats)
        bpm = mean(bpms)

        with open('bpms.txt', 'a') as bpm_file:
            bpm_file.write(filename + '||%.2f\n' % (bpm))

        print(filename + ': %.2f' % (bpm))
        print('===========')
    else:
        print(filename + ': %.2f' % (bpm))
        print('===========')


# grt all mp3s in directory
mp3_files = glob.iglob('*.mp3', recursive=False)

# get bpm for each file in collection
for mp3 in mp3_files:
    try:
        get_bpm(mp3)
    except:
        print("Unable to find bpm for file")
        continue
