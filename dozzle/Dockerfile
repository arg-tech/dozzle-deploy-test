FROM amir20/dozzle:v6.4.5 as dozzle-base

# Running Dozzle on top of Alpine to add a shell, and override its entrypoint with the command in compose.yml
FROM alpine:3
COPY --from=dozzle-base . .
COPY users.yml /data/
