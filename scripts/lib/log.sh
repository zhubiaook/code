#!/bin/env bash

# log levels
# Debug: 5
# Info:  4
# Warn:  3
# Error: 2
# Panic: 1
# Fatal: 0

# log level
LOG_LEVEL=${LOG_LEVEL:-5}
now=$(date +"%F %T")

PROJECT_ROOT=$(dirname "${BASH_SOURCE[0]}")/..
source $PROJECT_ROOT/lib/color.sh

log_info() {
  local prompt="INFO:"
  if [[ $LOG_LEVEL -lt 4 ]]; then
    return
  fi

  for msg; do
    green_echo "$now $prompt $msg"
  done
}

log_error() {
  local prompt="ERROR:"
  if [[ $LOG_LEVEL -lt 2 ]]; then
    return
  fi

  for msg; do
    red_echo "$now $prompt $msg" >&2
  done
}

log_fatal() {
  local prompt="FATAL:"
  for msg; do
    red_echo "$now $prompt $msg" >&2
  done
  red_echo "$now $prompt exit 1" >&2
  exit 1
}
