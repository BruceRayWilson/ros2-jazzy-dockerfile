# Small (690.31 MB)
# FROM osrf/ros:jazzy-simulation
# FROM osrf/ros:jazzy-simulation-noble
# Medium (1.13 GB)
# FROM osrf/ros:jazzy-desktop
# FROM osrf/ros:jazzy-desktop-noble
# Large (1.28 GB)
# FROM osrf/ros:jazzy-desktop-full
FROM osrf/ros:jazzy-desktop-full-noble


# Example of installing programs
RUN apt-get update \
    && apt-get install -y \
    nano \
    vim \
    && rm -rf /var/lib/apt/lists/*


# Example of copying a file
COPY config/ /site_config/


# Create a non-root user
ARG USERNAME=ubuntu
ARG USER_UID=1000
ARG USER_GID=$USER_UID

RUN mkdir /home/$USERNAME/.config && chown $USER_UID:$USER_GID /home/$USERNAME/.config


# Set up sudo
RUN apt-get update \
  && apt-get install -y sudo \
  && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME\
  && chmod 0440 /etc/sudoers.d/$USERNAME \
  && rm -rf /var/lib/apt/lists/*


# Copy the entrypoint and bashrc scripts so we have 
# our container's environment set up correctly
COPY entrypoint.sh /entrypoint.sh
# <deleted>COPY bashrc /home/${USERNAME}/.bashrc </deleted>


# Set up entrypoint and default command
#ENTRYPOINT [<deleted>"/bin/bash", </deleted>"/entrypoint.sh"]
ENTRYPOINT ["/entrypoint.sh"]
CMD ["bash"]
