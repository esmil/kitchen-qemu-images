MAKEFLAGS += -rR

RM = rm -f
KITCHEN = kitchen
QEMU_IMG = qemu-img
SIZE = 4G

WORKIMG = /tmp/new.qcow2

targets = wheezy jessie trusty freebsd10

$(WORKIMG):
	$(QEMU_IMG) create -f qcow2 '$@' $(SIZE)

../%.qcow2: $(WORKIMG)
	$(RM) '$@'
	$(QEMU_IMG) convert -O qcow2 -f qcow2 '$<' '$@'

$(targets): $(WORKIMG)
	$(KITCHEN) converge $@-default
	$(KITCHEN) destroy  $@-default
	$(QEMU_IMG) convert -O qcow2 -f qcow2 '$(WORKIMG)' '../$@.qcow2'

clean:
	$(KITCHEN) destroy
	$(RM) '$(WORKIMG)'
