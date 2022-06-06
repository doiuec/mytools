#!/usr/bin/python

import subprocess
import RPi/GPIO as GPIO
import cpustate
import os
import time
import datetime
from multiprocessing import Process

def cpu():
    coustate.cpu()

def omo():
    while True:
        timer = datetime .datetime.now()
	if timer.second % 10 == 0:
	    time.sleep(5)
	else:
	    4*4

def mainloop():
    p0 = Process(target=cpu)
    p1 = Process(target=omo)
    p2 = Process(target=omo)
    p3 = Process(target=omo)
    p0.start()
    p1.start()
    p2.start()
    p3.start()

mainloop()