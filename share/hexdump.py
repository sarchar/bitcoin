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

