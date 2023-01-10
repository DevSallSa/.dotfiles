#!/usr/bin/env python3

from os import mkdir
from os import makedirs
from sys import argv


if len(argv) == 1:
    project_name = input("Enter the project name: ")
else:
    project_name = argv[1]
# print("Creating the project {0} ".format(project_name))
# need pyinstaller
try:
    print("Creating the project", project_name)
    makedirs(project_name + "/src")
    makedirs(project_name + "/lib")
    makedirs(project_name + "/test")
    print("Creation finished !!!")
except FileExistsError:
    print("The", project_name, "project already exist.")
