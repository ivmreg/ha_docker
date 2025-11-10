FROM alpine:latest

# Install chrony
RUN apk add --no-cache chrony

# Create chrony run directory
RUN mkdir -p /var/run/chrony

# Copy custom chrony configuration
COPY chrony.conf /etc/chrony/chrony.conf

# Expose NTP port
EXPOSE 123/udp

# Run chrony in foreground
CMD ["/usr/sbin/chronyd", "-d", "-f", "/etc/chrony/chrony.conf"]
