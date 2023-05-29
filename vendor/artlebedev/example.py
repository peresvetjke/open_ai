# -*- encoding: windows-1251 -*-

from RemoteTypograf import RemoteTypograf

rt = RemoteTypograf('windows-1251')
#rt = RemoteTypograf() # UTF-8

rt.htmlEntities()
rt.br(1)
rt.p(1)
rt.nobr(3)
print rt.processText('"Вы все еще кое-как верстаете в "Ворде"? - Тогда мы идем к вам!"')


