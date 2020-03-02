FROM ubuntu:bionic

RUN apt-get update
RUN apt-get --no-install-recommends --no-install-suggests -y install curl git vim ruby-full rubygems autogen autoconf libtool make nginx
RUN gem update --system 3.0.6
RUN gem install compass

RUN apt-get remove --purge --auto-remove -y

# install `n` - node version control
RUN curl -L https://raw.githubusercontent.com/tj/n/master/bin/n -o n
RUN bash n 5.4.1

RUN npm i -g bower 
RUN npm i -g grunt 

RUN sed -i 's/root \/var\/www\/html;/root \/src\/public_html;/g' /etc/nginx/sites-enabled/default
RUN sed -i 's/try_files $uri $uri\/ =404;/try_files $uri $uri\/ \/index.html;/g' /etc/nginx/sites-enabled/default

RUN echo "{ \"allow_root\": true }" > /root/.bowerrc

WORKDIR /src

CMD ["nginx", "-g", "daemon off;"]
