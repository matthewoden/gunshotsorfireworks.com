# Grab elixir
FROM trenpixster/elixir:1.4.0


# create working directory.
RUN mkdir /gunshots
WORKDIR /gunshots


ENV MIX_ENV prod

# get elixir deps
ADD mix.* ./

RUN mix local.rebar
RUN mix local.hex --force
ADD http://www.random.org/strings/?num=10&len=8&digits=on&upperalpha=on&loweralpha=on&unique=on&format=plain&rnd=new uuid
RUN mix deps.get --only prod


# compile app.
ADD . .
RUN MIX_ENV=prod mix compile

# expose port to host machine
EXPOSE 4000

# migrate db and start the server
CMD MIX_ENV=prod mix phoenix.server
