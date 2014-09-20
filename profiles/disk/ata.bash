#
#
#

shopt -qs extglob
shopt -qs nullglob

echo /sys/devices/pci*/*/ata*/host*/target*/*/block/*(sd[a-z])

#
# vim:fenc=utf-8:ft=sh:ci:pi:sts=0:sw=4:ts=4:
#
