# Grab elixir
FROM trenpixster/elixir:1.4.0


# create working directory.
RUN mkdir /gunshots
WORKDIR /gunshots

# get elixir deps
ADD mix.* ./
RUN MIX_ENV=prod mix local.rebar
RUN MIX_ENV=prod mix local.hex --force
ADD http://www.random.org/strings/?num=10&len=8&digits=on&upperalpha=on&loweralpha=on&unique=on&format=plain&rnd=new uuid
RUN MIX_ENV=prod mix deps.get


# compile app.
ADD . .
RUN MIX_ENV=prod mix compile

# expose port to host machine
EXPOSE 4000

# migrate db and start the server
CMD MIX_ENV=prod mix phoenix.server
