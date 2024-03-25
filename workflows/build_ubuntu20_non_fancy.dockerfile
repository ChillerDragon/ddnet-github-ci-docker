FROM ubuntu:20.04

RUN apt-get update -y && apt-get install -y sudo
RUN sudo apt-get install \
	pkg-config cmake ninja-build libfreetype6-dev libnotify-dev libsdl2-dev libsqlite3-dev libvulkan-dev glslang-tools spirv-tools libavcodec-dev libavformat-dev libavutil-dev libswresample-dev libswscale-dev libx264-dev libpng-dev valgrind gcovr -y

# Our minimum supported Rust version (MSRV)
RUN rustup default 1.63.0
RUN sudo rm -rf /var/lib/mysql/ /var/run/mysqld
RUN sudo mkdir /var/lib/mysql/ /var/run/mysqld/
RUN sudo chown mysql:mysql /var/lib/mysql/ /var/run/mysqld/
RUN sudo mysqld --initialize-insecure --user=mysql --basedir=/usr --datadir=/var/lib/mysql/
RUN sudo /usr/bin/mysqld_safe --basedir=/usr --datadir='/var/lib/mysql/' & \
        sleep 10 \
        sudo mysql <<EOF \
        CREATE DATABASE ddnet; \
        CREATE USER 'ddnet'@'localhost' IDENTIFIED BY 'thebestpassword'; \
        GRANT ALL PRIVILEGES ON ddnet.* TO 'ddnet'@'localhost'; \
        FLUSH PRIVILEGES; \
        EOF

