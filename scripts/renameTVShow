#!/usr/bin/python3
# Only works with filenames with format name.episode.[whatever^2].ext
# Renames to format 'name - episode.ext'

import os
import logging

logging.basicConfig(level=logging.INFO,
                    format='%(asctime)s - %(message)s',
                    datefmt='%Y-%m-%d %H:%M:%S')

os.chdir('/home/dennis/downloads/tmr/')

for f in os.listdir():
    fileName, fileExt = os.path.splitext(f)
    nameList = fileName.split('.')
    if (nameList[0] == 'the' or nameList[0] == 'The'):
        nameList[0] = nameList[0].capitalize()
        nameList[1] = nameList[1].capitalize()
        nameList[2] = nameList[2].upper()
        newName = f'{nameList[0]} {nameList[1]} - {nameList[2]}{fileExt}'
    else:
        nameList[0] = nameList[0].capitalize()
        nameList[1] = nameList[1].upper()
        newName = f'{nameList[0]} - {nameList[1]}{fileExt}'
    os.rename(f, newName)
    logging.info(newName)
