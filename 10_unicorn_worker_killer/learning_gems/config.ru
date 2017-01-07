# This file is used by Rack-based servers to start the application.

# Unicorn self-process killer
require 'unicorn/worker_killer'
# Max requests per worker
use Unicorn::WorkerKiller::MaxRequests, 10_000, 12_000
# Max memory size (RSS) per worker
use Unicorn::WorkerKiller::Oom, (220*(1024**2)), (250*(1024**2)) # 220MB ~ 250MB

require_relative 'config/environment'

run Rails.application
