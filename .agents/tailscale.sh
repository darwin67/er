#!/usr/bin/env bash

tailscale_tag="tag:amp-demo"
tailscale_hostname="amp-er-${HOSTNAME##*-}"

tailscale_require_configuration() {
  if [ -z "${TAILSCALE_CLIENT_ID:-}" ] || [ -z "${TAILSCALE_TRUST_AUDIENCE:-}" ]; then
    echo "TAILSCALE_CLIENT_ID and TAILSCALE_TRUST_AUDIENCE must be configured for remote orbs." >&2
    return 1
  fi
}

tailscale_authenticate() {
  local command="$1"
  local timeout="$2"
  local identity_token

  if ! identity_token="$(
    timeout "$timeout" amp orb id-token --audience "$TAILSCALE_TRUST_AUDIENCE" --ttl-seconds 600
  )"; then
    echo "Amp workload identity is unavailable; rerun setup from an Amp-managed orb." >&2
    return 1
  fi

  if ! printf '%s' "$identity_token" | timeout "$timeout" sudo tailscale "$command" \
    --timeout="$timeout" \
    --client-id="${TAILSCALE_CLIENT_ID}?ephemeral=true&preauthorized=true" \
    --id-token=file:/dev/stdin \
    --advertise-tags="$tailscale_tag" \
    --hostname="$tailscale_hostname"; then
    unset identity_token
    echo "Tailscale enrollment failed. Configure the Amp OIDC trust credential and $tailscale_tag policy before rerunning setup." >&2
    return 1
  fi

  unset identity_token
}

tailscale_enroll() {
  tailscale_authenticate up "$1"
}

tailscale_login() {
  tailscale_authenticate login "$1"
}

tailscale_wait() {
  timeout "$1" sudo tailscale wait --timeout="$1"
}

tailscale_enroll_and_wait() {
  local deadline="$1"
  local enrollment_timeout="$2"
  local readiness_timeout="$3"

  timeout "$deadline" bash -c '
    set -euo pipefail
    source "$1"
    tailscale_enroll "$2"
    tailscale_wait "$3"
  ' bash "${BASH_SOURCE[0]}" "$enrollment_timeout" "$readiness_timeout"
}

tailscale_login_and_wait() {
  local deadline="$1"
  local enrollment_timeout="$2"
  local readiness_timeout="$3"

  timeout "$deadline" bash -c '
    set -euo pipefail
    source "$1"
    tailscale_login "$2"
    tailscale_wait "$3"
  ' bash "${BASH_SOURCE[0]}" "$enrollment_timeout" "$readiness_timeout"
}
