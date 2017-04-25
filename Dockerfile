FROM bitwalker/alpine-elixir:1.4.2

EXPOSE 4000

ENV APP=gunshots \
    VERSION=0.1.0 \
    PORT=4000 \
    MIX_ENV=prod

COPY . .
RUN \
    mix do deps.get, deps.compile && \
    mix do compile, release --verbose --env=prod && \
    mkdir -p /opt/$APP/log && \
    cp _build/prod/rel/$APP/releases/$VERSION/$APP.tar.gz /opt/$APP/ && \
    cd /opt/$APP && \
    tar -xzf $APP.tar.gz && \
    rm $APP.tar.gz && \
    rm -rf /opt/app/* && \
    chmod -R 777 /opt/app && \
    chmod -R 777 /opt/$APP

WORKDIR /opt/$APP

CMD ./bin/$APP foreground