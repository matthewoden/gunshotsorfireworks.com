# Grab elixir
FROM trenpixster/elixir:1.4.0

ENV MIX_ENV prod

# Compile app
RUN mkdir /app
WORKDIR /app

# Install Elixir Deps
ADD mix.* ./
RUN mix do local.rebar, local.hex --force
RUN mix deps.get

# Install app
ADD . .
RUN mix do compile


# Exposes this port from the docker container to the host machine
EXPOSE 4000

# The command to run when this image starts up
CMD ["mix", "phoenix.server"]