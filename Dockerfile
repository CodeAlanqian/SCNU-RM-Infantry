FROM ros:humble-ros-base

# create workspace
WORKDIR /

# clone projects
RUN git clone https://github.com/CodeAlanqian/SCNU-RM-Infantry.git
WORKDIR /SCNU-RM-Infantry

# RUN cd /SCNU-RM-Infantry

# install dependencies anSd some tools
RUN apt-get update
RUN rosdep install --from-paths src --ignore-src -r -y
RUN apt-get install ros-humble-foxglove-bridge wget htop vim -y && \
    rm -rf /var/lib/apt/lists/*

# setup zsh
RUN sh -c "$(wget -O- https://github.com/deluan/zsh-in-docker/releases/download/v1.1.5/zsh-in-docker.sh)" -- \
    -t jispwoso -p git \
    -p https://github.com/zsh-users/zsh-autosuggestions \
    -p https://github.com/zsh-users/zsh-syntax-highlighting && \
    chsh -s /bin/zsh && \
    rm -rf /var/lib/apt/lists/*

# build
RUN . /opt/ros/humble/setup.sh && colcon build --symlink-install --parallel-workers 1

# setup .zshrc
RUN echo 'export TERM=xterm-256color\n\
source /SCNU-RM-Infantry/install/setup.zsh\n\
eval "$(register-python-argcomplete3 ros2)"\n\
eval "$(register-python-argcomplete3 colcon)"\n'\
>> /root/.zshrc

# source entrypoint setup
RUN sed --in-place --expression \
      '$isource "/SCNU-RM-Infantry/install/setup.bash"' \
      /ros_entrypoint.sh