# -*- encoding: utf-8 -*-

import sys

source_file = sys.argv[1]
result_file = sys.argv[2]

import os

from RemoteTypograf import RemoteTypograf

rt = RemoteTypograf() # UTF-8

rt.htmlEntities()
rt.br(1)
rt.p(1)
rt.nobr(3)

source = open(source_file, "r")
text = source.read()
source.close()

result = open(result_file, "a")
result.write(rt.processText(text))
result.close()
