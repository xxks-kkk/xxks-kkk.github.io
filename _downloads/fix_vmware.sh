#!/bin/bash

tar -xvf /usr/lib/vmware/modules/source/vmblock.tar
tar -xvf /usr/lib/vmware/modules/source/vmnet.tar
patch -p0 -i /home/iidev20/Downloads/vmblock-9.0.2-5.0.2-3.10.diff
patch -p0 -i /home/iidev20/Downloads/vmnet-9.0.2-5.0.2-3.10.patch
tar -cf vmblock.tar vmblock-only
tar -cf vmnet.tar vmnet-only
rm -rf vmblock-only
rm -rf vmnet-only
vmware-modconfig --console --install-all
