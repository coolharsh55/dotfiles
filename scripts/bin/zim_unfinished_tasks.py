#!/usr/bin/env python3
# author: Harshvardhan Pandit

# List unfinished tasks in Zim
# list all tasks that are unfinished in the last XX period

# unfinished tasks
# - which have been marked as unfinished or left empty
# - which have not been marked as complete in any other future pages

# period
# - can be anything from days to weeks to months

# tasklist
# - by default, get tasks from *this* week, so a way to get the dates from
#   start of this week, which is Monday, to today
# - an option to get tasks from the last X days
# - parse folder by year/month/date structure to get tasks if they exist
# - put them in done or notdone list based on how they are marked
# - remove tasks from notdone list which are in the done list

from datetime import datetime, timedelta
from dateutil import rrule
import os
import re

regex_task_done = re.compile(r"^\[\*\] (.*)$")
regex_task_nodone = re.compile(r"^\[x\] (.*)$")


def remove_finished_tasks(tasks_done, tasks_notdone):
    return set(
        task for task in tasks_notdone
        if task not in tasks_done)


def get_tasks_from_file(filepath):
    if not os.path.isfile(filepath):
        return [], []
    with open(filepath, 'r') as f:
        lines = f.readlines()
    tasks_done = []
    tasks_notdone = []
    for line in lines:
        match = regex_task_done.search(line)
        if match:
            tasks_done.append(match.group(1))
            continue
        match = regex_task_nodone.search(line)
        if match:
            tasks_notdone.append(match.group(1))
            continue
    return tasks_done, tasks_notdone


def get_filepaths_for_dates(start_date, end_date):
    filepaths = []
    for date in rrule.rrule(rrule.DAILY, dtstart=start_date, until=end_date):
        filepaths.append(
                '{y}/{m:02d}/{d:02d}'.format(
                    y=date.year, m=date.month, d=date.day))
    return filepaths


if __name__ == "__main__":
    filepath = "/home/harsh/Dropbox/Notebooks/Journal/Journal/2017/06/23.txt"
    done, notdone = get_tasks_from_file(filepath)

    end_date = datetime.now() + timedelta(days=-1)
    start_date = end_date + timedelta(days=-30)
    filepaths = get_filepaths_for_dates(start_date, end_date)

    basepath = "/home/harsh/Dropbox/Notebooks/Journal/Journal/"
    donelist = set()
    notdonelist = set()
    for filepath in filepaths:
        filepath = basepath + filepath + '.txt'
        done, notdone = get_tasks_from_file(filepath)
        for task in done:
            donelist.add(task)
        for task in notdone:
            notdonelist.add(task)
    notdonelist = remove_finished_tasks(donelist, notdonelist)
    for task in notdonelist:
        print(task)
