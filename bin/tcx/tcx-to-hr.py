#!/usr/bin/env python

# Convert a TCX file (argument) to a CSV file containing just the heart
# rate bit (out.csv).

import untangle
from dateutil import parser
import codecs
import sys
import time

if __name__ == "__main__":

    filename = sys.argv[1]
    o = untangle.parse(filename)

    outfile = codecs.open("out.csv", 'w', "utf-8")
    
    for lap in o.TrainingCenterDatabase.Activities.Activity.Lap:
        for point in lap.Track.Trackpoint:
            try:
                t = point.Time.cdata
                hr = point.HeartRateBpm.Value.cdata

                dt = parser.parse(t)

                outfile.write(str(time.mktime(dt.timetuple())) + u"," + hr + u"\n")
            except IndexError:
                print "fuck"
                continue
            

                
