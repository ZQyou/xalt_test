#!/usr/bin/env python3
import sys

keylog, log, out = sys.argv[1:]
print(keylog, log, out)

with open(keylog, "r") as f:
  key_lines = f.readlines()
  f.close()

with open(log, "r") as f:
  lines = f.readlines()
  f.close()

with open(out, "a") as f:
  for line in lines:
    skip = False
    for k in key_lines:
      if k in line:
        skip = True
        break

    if not skip:
      f.write(line)
      #print(line)
  
  f.close()
