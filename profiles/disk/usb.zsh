#
# disk/usb.zsh
#

for dev (/sys/devices/pci*/*/usb*/*/*/host*/target*/*/block/*sd[a-z](/N))
	echo noop  >$dev/queue/scheduler

#
# vim:fenc=utf-8:ft=zsh:ci:pi:sts=0:sw=4:ts=4:
#
