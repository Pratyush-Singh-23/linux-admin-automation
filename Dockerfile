# Use Amazon Linux 2023 as the base image
FROM public.ecr.aws/amazonlinux/amazonlinux:2023

# Install required Linux utilities
RUN yum install -y \
    bash \
    procps-ng \
    util-linux \
    shadow-utils \
    findutils \
    grep \
    gawk \
    sed \
    passwd \
    which \
    vim-minimal \
    && yum clean all

# Set working directory inside container
WORKDIR /app

# Copy automation scripts into the image
COPY scripts/ /app/scripts/

# Start the system monitoring script
CMD ["bash", "/app/scripts/system_monitor.sh"]
