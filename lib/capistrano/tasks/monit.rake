namespace :monit do

  namespace :upstart do

    desc 'Starts Monit (Upstart)'
    task :start do
      on roles :app do
        execute :sudo, "/etc/init.d/monit start"
      end
    end

    desc 'Stops Monit (Upstart)'
    task :stop do
      on roles :app do
        execute :sudo, "/etc/init.d/monit stop"
      end
    end

    desc 'Restarts Monit (Upstart)'
    task :restart do
      on roles :app do
        execute :sudo, "/etc/init.d/monit restart"
      end
    end

  end

  namespace :systemd do

    desc 'Starts Monit (Systemd)'
    task :start do
      on roles :app do
        execute :sudo, "systemctl start monit"
      end
    end

    desc 'Starts Monit (Systemd)'
    task :stop do
      on roles :app do
        execute :sudo, "systemctl stop monit"
      end
    end

    desc 'Starts Monit (Systemd)'
    task :restart do
      on roles :app do
        execute :sudo, "systemctl restart monit"
      end
    end


  end


  desc 'Monit status'
  task :status do
    on roles :app do
      puts capture :sudo, :monit, :status
    end
  end

  desc 'Start all processes'
  task :start do
    all_processes_do :start
  end

  desc 'Stop all processes'
  task :stop do
    all_processes_do :stop
  end

  desc 'Restart all processes'
  task :restart do
    all_processes_do :restart
  end

  def monit_do(*args)
    on roles :app do
      execute :sudo, :monit, *args
    end
  end

  def all_processes_do(cmd)
    on roles :app do
      output = capture :sudo, :monit, :status
      processes = output.lines.grep(/^Process '/).grep(/#{fetch(:application)}/)
      processes.each do |process|
        process_name = process.split(/\s+/).last.delete "'"
        monit_do cmd, process_name
      end
    end
  end
end
