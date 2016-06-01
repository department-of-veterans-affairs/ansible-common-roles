#!/usr/bin/env puma

environment ENV['RALIS_ENV'] || ENV['RACK_ENV'] || 'development'

pidfile '{{app_src}}/tmp/pids/puma.pid'

state_path '{{app_src}}/tmp/pids/puma.state'

stdout_redirect '{{app_src}}/log/{{ name }}.out', '{{app_src}}/log/{{ name }}.out'

threads {{min_threads}}, {{max_threads}}

{% if num_workers > 1 %}
workers {{num_workers}}
{% endif %}

bind 'tcp://0.0.0.0:{{rails_port}}'

preload_app!

tag '{{name}}'

worker_timeout {{worker_timeout_seconds}}
worker_boot_timeout {{worker_timeout_seconds}}
