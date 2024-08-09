FROM ruby:3.3.4-alpine3.20

ENV BUNDLE_DEPLOYMENT="1" \
    BUNDLE_PATH="/usr/local/bundle" \
    BUNDLE_WITHOUT="development"

COPY . /exporter/
WORKDIR /exporter
RUN bundle install

ARG UID=10001
RUN adduser \
    --disabled-password \
    --gecos "" \
    --home "/nonexistent" \
    --shell "/sbin/nologin" \
    --no-create-home \
    --uid "${UID}" \
    appuser

USER appuser

EXPOSE 19900
CMD ["bundle", "exec", "rackup", "--host", "0.0.0.0", "-p", "19900"]
