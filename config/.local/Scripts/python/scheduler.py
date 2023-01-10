#!/usr/bin/env python3

import sys
import runpy
from apscheduler.schedulers.background import BackgroundScheduler


def job():
    runpy.run_path('creation.py')

sched = BackgroundScheduler(daemon=True)
sched.add_job(lambda : job(), 'interval', seconds=5)
sched.start()
