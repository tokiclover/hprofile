#
# disk/usb.bash
#

for dev in /sys/devices/pci*/*/usb*/*/*/host*/target*/*/block/*(sd[a-z])
do
	case "$(< $dev/removable)" in
		(1) echo noop >$dev/queue/scheduler;;
		(0) echo cfq >$dev/queue/scheduler;;
	esac
done

#
# vim:fenc=utf-8:ft=sh:ci:pi:sts=0:sw=4:ts=4:
#
