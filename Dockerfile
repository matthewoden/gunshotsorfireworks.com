FROM trenpixster/elixir:1.4.0


ENV APP="gunshots" \
    VERSION="0.1.0" \
    PORT=4000

RUN mkdir -p /otp/$APP/log/

ADD _build/prod/rel/$APP/releases/$VERSION/$APP.tar.gz /otp/$APP/

EXPOSE 4000

CMD otp/$APP/bin/$APP foreground
