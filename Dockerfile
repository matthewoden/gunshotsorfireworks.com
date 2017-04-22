# Grab elixir
FROM trenpixster/elixir:1.4.0

ENV MIX_ENV prod

# Compile app
RUN mkdir /app
WORKDIR /app

# Install Elixir Deps
ADD mix.* .
RUN mix local.rebar --force
RUN mix local.hex --force
RUN mix deps.get

# Install app
ADD . .
RUN MIX_ENV=prod mix compile


# Exposes this port from the docker container to the host machine
EXPOSE 4000

# The command to run when this image starts up
CMD mix phoenix.server