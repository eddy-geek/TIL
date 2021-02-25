#!/usr/bin/env python3

import math
import sys


def deg2num(lat_deg, lon_deg, zoom):
    '''lon./lat. to TMS map tile numbers.'''
    lat_rad = math.radians(lat_deg)
    n = 2.0 ** zoom
    xtile = int((lon_deg + 180.0) / 360.0 * n)
    ytile = int(n) - 1 - int((1.0 - math.asinh(math.tan(lat_rad)) / math.pi) / 2.0 * n)
    return (xtile, ytile)



def num2deg(xtile, ytile, zoom):
    '''TMS map tile numbers to lon./lat.'''
    # FIXME this is returning the wrong corner so far
    n = 2.0 ** zoom
    lon_deg = xtile / n * 360.0 - 180.0
    lat_rad = -math.atan(math.sinh(math.pi * (1 + 2 * (1-ytile) / n )))
    lat_deg = math.degrees(lat_rad)
    return (lat_deg, lon_deg)


def test_deg2num_isola():
    x_exp = [0,0,0,0,0,0,0,0,0,266,532,1064,2128,4256,8512,17024,34051]
    y_exp = [0,0,0,0,0,0,0,0,0,326,652,1304,2609,5219,10438,20876,41752]
    for z in range(9,17):
        x, y = deg2num(44.186, 7.052, z)
        assert(x == x_exp[z])
        assert(y == y_exp[z])

# def test_deg2num_clapier():  # got it a bit wrong
#     y_exp = [0,0,0,0,0,0,0,0,0,326,652,1304,2608,5216,10433,20865,41734]
#     for z in range(9,17):
#         x, y = deg2num(44.1152, 7.42, z)
#         print(x, y, y_exp[z], y == y_exp[z])
#         assert(y == y_exp[z])


if __name__ == '__main__':
    print('{} {}'.format(*deg2num(*map(float, sys.argv[1:]))))
