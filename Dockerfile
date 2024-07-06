FROM ubuntu:22.04
SHELL ["/bin/bash", "-c"]
USER root
WORKDIR /obscurelyme

RUN apt-get update -y && apt-get install curl zip pkg-config libxcursor-dev libx11-dev libxkbcommon-dev -y
RUN apt-get install libxext-dev libxinerama-dev libxrandr-dev libxi-dev build-essential zlib1g-dev libncurses5-dev libgdm-dev -y
RUN apt-get install libnss3-dev libssl-dev libreadline-dev libffi-dev libsqlite3-dev wget libbz2-dev -y
RUN apt-get install python3-pip -y
RUN apt-get install git -y
# RUN apt-get install python3.12-venv -y
# RUN apt-get install pipx -y
# RUN pipx ensurepath
# RUN pipx install setuptools
# RUN pipx install gdtoolkit
# RUN python3 -m venv obscurelyme
# RUN source obscurelyme/bin/activate
RUN pip install setuptools
RUN pip install gdtoolkit
# RUN apt-get install setuptools
# RUN apt-get install gdtoolkit

RUN curl -L -o butler.zip https://broth.itch.ovh/butler/linux-amd64/LATEST/archive/default
RUN unzip butler.zip
RUN chmod +x butler
RUN mv butler /usr/local/bin/butler 

COPY --chown=root:root Godot_v4.2.2-stable_linux.x86_64 /usr/local/bin/godot
COPY --chown=root:root Godot_v4.2.2-stable_export_templates.tpz /export-templates/Godot_v4.2.2-stable_export_templates.tpz

RUN unzip /export-templates/Godot_v4.2.2-stable_export_templates.tpz
RUN mkdir -v -p ~/.local/share/godot/export_templates/
RUN mv ./templates ~/.local/share/godot/export_templates/4.2.2.stable

WORKDIR /obscurelyme/project
# RUN mkdir -v -p build/windows
# RUN mkdir -v -p build/linux
# COPY --chown=root:root ./test-proj .