FROM scratch


WORKDIR /

ADD out/vmlinux vmlinux
ADD out/initrd-generic initrd-generic

