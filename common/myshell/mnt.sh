#!/bin/sh

mkdir /media/mdj982/Shared &> /dev/null
if [ -z "$(ls /media/mdj982/Shared)" ]; then
	sudo ntfsfix /dev/nvme0n1p4 &&
       	mount -t auto -v /dev/nvme0n1p4 /media/mdj982/Shared
fi

