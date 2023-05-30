#!/usr/bin/env python2.7
# -*- coding: utf-8 -*-

import sys
import re
import base64
import types
from EMT import EMTypograph
import json
import io

def main(source_file, result_file):
    with io.open(source_file,'r',encoding='utf8') as f:
      text = f.read()

      EMT = EMTypograph()
      EMT.set_text(text)
      result = EMT.apply()

      with io.open(result_file,'w',encoding='utf8') as result_f:
        result_f.write(result)

source_file = sys.argv[1]
result_file = sys.argv[2]

if __name__=="__main__":
    main(source_file, result_file)
