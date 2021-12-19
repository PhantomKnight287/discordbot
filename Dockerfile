FROM ubuntu:impish-20211102
ENV TZ=Asia/Kolkata
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN \
    apt-get update &&\
    apt-get -y upgrade &&\
    apt-get install -y  curl git python3 python3-pip && \
    pip install --upgrade pip

RUN apt-get install -y ffmpeg
RUN curl -fsSL https://deb.nodesource.com/setup_17.x | bash -
RUN apt-get install -y nodejs
WORKDIR /app
COPY . /app/
RUN npm install npx
RUN npx prisma generate
RUN npm install
RUN npm run build:prod
EXPOSE 3001
CMD [ "node","./build/src/web/server.js"]
