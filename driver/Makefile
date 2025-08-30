obj-m += test.o

all:
	echo $(PWD)
	make -C ../linux-6.12.43 M=$(PWD)/driver modules

clean:
	make -C /lib/modules/$(shell uname -r)/build M=$(PWD) clean
