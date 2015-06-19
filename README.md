# Capistrano 3 Monit Wrapper

## Usage

Add the gem to your Gemfile

    gem 'capistrano3-monit', github: 'naps62/capistrano3-monit'

Run `bundle` to update your `Gemfile.lock`
Add the following to your `Capfile`:

    require 'capistrano/monit'

The following tasks will be available to you:

    monit:status  # shows the output of running `monit status` on the server
    monit:start   # sends a start signal to all monitored processes
    monit:stop    # sends a stop signal to all monitored processes
    monit:restart # sends a restart signal to all monitored processes

### Automatic restart

Until version 0.3.0, `monit:restart` would automatically be hooked into your `deploy:restart` task. Starting in 0.4.0, that is no longer the case.

If you want to achieve the same result, you can something like the following to your `config/deploy.rb`:

```ruby
namespace :deploy do
  task :restart => 'monit:restart'
end

after 'deploy:publishing', 'deploy:restart'
```

## How it works

Currently, the `start|stop|restart` tasks assume you only want to handle
monitored processes related to the app being deployed. For this, the name of
each process should contain the name of the application. For example, if you
have the following configuration for your production stage:

    # config/deploy/production.rb
    set :application, 'production'

And if `monit:status` returns the following output:

    Process 'production-puma'
      status             Does not exist
      monitoring status  Monitored
      data collected     Wed, 04 Dec 2013 23:24:51

    Process 'production-redis'
      status             Does not exist
      monitoring status  Monitored
      data collected     Wed, 04 Dec 2013 23:24:51

    Process 'staging-puma'
      status             Does not exist
      monitoring status  Monitored
      data collected     Wed, 04 Dec 2013 23:24:51

    Process 'staging-redis'
      status             Does not exist
      monitoring status  Monitored
      data collected     Wed, 04 Dec 2013 23:24:51

Then launching the `monit:start` task will only handle the `production-puma`
and `production-redis` processes.

# TODO

* Add tasks to manage the monit service itself
* Allow a customizable list of processes to manage, instead of making
  assumptions based on their names

# Contributing

This is a very early work, extracted from a specific project i'm working on.
If you require a new feature, please open an issue, or preferably, a pull request with
a proposed implementation
