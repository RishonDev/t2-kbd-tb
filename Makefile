KDIR ?= /lib/modules/$(shell uname -r)/build
KVER ?= $(shell uname -r)
MODDEST ?= /lib/modules/$(KVER)/updates
PWD := $(shell pwd)

obj-m += hid-apple.o
obj-m += hid-appletb-bl.o
obj-m += hid-appletb-kbd.o

ccflags-y += -I$(srctree)/drivers/hid

all:
	$(MAKE) -C $(KDIR) M=$(PWD) modules

install: all
	install -d $(MODDEST)
	install -m 0644 hid-apple.ko $(MODDEST)/
	install -m 0644 hid-appletb-bl.ko $(MODDEST)/
	install -m 0644 hid-appletb-kbd.ko $(MODDEST)/
	depmod -a $(KVER)

clean:
	$(MAKE) -C $(KDIR) M=$(PWD) clean
