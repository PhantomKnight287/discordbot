FROM  archlinux
ENV TZ=Asia/Kolkata
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN \
    pacman -Syu &&\
    pacman --noconfirm curl git npm ffmpeg python3 python3-pip nodejs && \
    pip install --upgrade pip
WORKDIR /app
COPY . /app/
RUN npm install
RUN npm run generate
RUN npm run build:prod
EXPOSE 3001
CMD [ "node","./build/src/web/server.js"]
