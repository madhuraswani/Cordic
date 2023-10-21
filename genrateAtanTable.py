import math


def float_bin(number, places = 3):

	# split() separates whole number and decimal 
	# part and stores it in two separate variables
	dec = int(number*2**(places))
	res = '{0:011b}'.format(dec)
	return "0_"+res


def create_tan_table(x):
	
    tan = {}
    for i in range(1,x):
        tan[2**(-i)] = float_bin(number=float('%.4f'%((math.atan(2**(-i))))),places=11)
    return tan

tan = create_tan_table(12)
print(tan)
