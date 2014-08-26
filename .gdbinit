set disassembly-flavor intel
set pagination off

set print pretty on

set history save on
set history size 100000
set history filename ~/.gdb_history
set history expansion on

source ~/tool/peda/peda.py

define cs
    checksec
end
