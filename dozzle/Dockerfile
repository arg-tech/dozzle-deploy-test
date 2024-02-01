ARG admin_password

# Interim build stage that calculates the hash of the password and produces the complete config file for Dozzle
FROM mikefarah/yq:4.40.5 as configure
WORKDIR /workdir
COPY users.yml .
# Substituting secrets using build args is usually insecure, but because this is a multi-stage build, the interim stages will not be saved
ARG admin_password
RUN hash=$(echo -n "${admin_password}" | sha256sum | cut -f1 -d' ') && yq -i ".users.admin.password = \"${hash}\"" users.yml

# Final build stage
FROM amir20/dozzle:v6.1.1
COPY --from=configure /workdir/users.yml /data/
