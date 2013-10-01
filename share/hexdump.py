# This file is used in part of the MSVC CMake build
# to replace the unix hexdump & sed calls otherwise
# used.
#
# Unfortunately this creates a dependency on Python
# 2.x, but that's trivial as only a few Win32 
# developers will ever be building...
#
# TODO - figure out another way to generate
# these hexdump files..
import sys

def main():
    with open(sys.argv[1], "rb") as fp:
        data = fp.read()

    with open(sys.argv[2], "wb") as op:
        op.write('namespace {} {{\n'.format(sys.argv[3]))
        op.write('static unsigned char {}[] = {{'.format(sys.argv[4]))

        for c in data[:-1]:
            op.write('0x{:02x}, '.format(ord(c)))

        k = ord(data[-1])
        op.write('0x{:02x}'.format(k))

        op.write(' };};')
            
if __name__ == "__main__":
    main()

