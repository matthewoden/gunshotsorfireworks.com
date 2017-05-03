FROM bitwalker/alpine-elixir:1.4.2

RUN apk update && \
    apk --no-cache --update add \
      curl libgcc libstdc++ \
      git make g++ certbot \
      nodejs python && \
    rm -rf /var/cache/apk/*

EXPOSE 443

ENV APP=gunshots \
    VERSION=0.1.0 \
    PORT=4000 \
    MIX_ENV=prod \
    CERT_PATH=priv/cert.pem \
    KEY_PATH=priv/keyfile.key\
    CACERT_PATH=priv/cacert.crt

RUN mkdir /.cert


# Cache elixir deps
COPY mix.exs mix.lock ./
RUN mix do deps.get, deps.compile

# Copy app
COPY . .

RUN mix do compile

# Cache node deps
RUN cd apps/gunshots_ui/ && \
    npm install && \
    node_modules/brunch/bin/brunch b -p && \
    mix phoenix.digest

RUN \
    mix do release --verbose --env=prod && \
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