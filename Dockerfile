FROM fedora
MAINTAINER http://fedoraproject.org/wiki/Cloud

RUN dnf -y update && dnf clean all
RUN dnf -y install nginx && dnf clean all
RUN dnf install -y libguestfs libguestfs-tools-c virt-v2v \
                   libvirt-daemon libvirt-daemon-config-network

RUN echo "daemon off;" >> /etc/nginx/nginx.conf
RUN echo "nginx on Fedora" > /usr/share/nginx/html/index.html
# https://bugzilla.redhat.com/show_bug.cgi?id=1045069

# This is required for virt-v2v because neither systemd nor
# root libvirtd runs, and therefore there is no virbr0, and
# therefore virt-v2v cannot set up the network through libvirt.
ENV LIBGUESTFS_BACKEND direct

EXPOSE 80

CMD [ "/usr/sbin/nginx" ]
