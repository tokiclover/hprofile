#
# disk/usb.zsh
#

for dev (/sys/devices/pci*/*/usb*/*/*/host*/target*/*/block/*sd[a-z](/N))
	case "$(< $dev/removable)" in
		(1) echo noop >$dev/queue/scheduler;;
		(0) echo cfq  >$dev/queue/scheduler;;
	esac

#
# vim:fenc=utf-8:ft=zsh:ci:pi:sts=0:sw=4:ts=4:
#
