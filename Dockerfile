FROM scratch


WORKDIR /

ADD vmlinux vmlinux
ADD initrd-generic initrd-generic

