#!/usr/bin/env bash

tailscale_tag="tag:amp-demo"
tailscale_hostname="amp-er-${HOSTNAME##*-}"

tailscale_require_configuration() {
  if [ -z "${TAILSCALE_CLIENT_ID:-}" ] || [ -z "${TAILSCALE_TRUST_AUDIENCE:-}" ]; then
    echo "TAILSCALE_CLIENT_ID and TAILSCALE_TRUST_AUDIENCE must be configured for remote orbs." >&2
    return 1
  fi
}

tailscale_enroll() {
  local timeout="$1"
  local identity_token

  if ! identity_token="$(
    amp orb id-token --audience "$TAILSCALE_TRUST_AUDIENCE" --ttl-seconds 600
  )"; then
    echo "Amp workload identity is unavailable; rerun setup from an Amp-managed orb." >&2
    return 1
  fi

  if ! sudo tailscale up \
    --timeout="$timeout" \
    --client-id="${TAILSCALE_CLIENT_ID}?ephemeral=true&preauthorized=true" \
    --id-token="$identity_token" \
    --advertise-tags="$tailscale_tag" \
    --hostname="$tailscale_hostname"; then
    unset identity_token
    echo "Tailscale enrollment failed. Configure the Amp OIDC trust credential and $tailscale_tag policy before rerunning setup." >&2
    return 1
  fi

  unset identity_token
}

tailscale_wait() {
  timeout "$1" sudo tailscale wait --timeout="$1"
}
