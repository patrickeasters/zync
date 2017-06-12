# frozen_string_literal: true
%w(
  .ruby-version
  .rbenv-vars
  tmp/restart.txt
  tmp/caching-dev.txt
).each { |path| Spring.watch(path) }

require 'spring/application'

module QueWorkers
  def disconnect_database
    ::Que.worker_count = 0
    ::Que.mode = :off
    super
  end
end

Spring::Application.prepend(QueWorkers)
