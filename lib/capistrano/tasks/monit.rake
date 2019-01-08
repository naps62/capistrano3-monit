namespace :monit do

  desc 'Monit status'
  task :status do
    on roles :app do
      puts sudo_if_needed :capture, :monit, :status
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
    sudo_if_needed :execute, :monit, *args
  end

  def all_processes_do(cmd)
    on roles :app do
      output = sudo_if_needed :capture, :monit, :status
      processes = output.lines.grep(/^Process '/).grep(/#{fetch(:application)}/)
      processes.each do |process|
        process_name = process.split(/\s+/).last.delete "'"
        monit_do cmd, process_name
      end
    end
  end

  def sudo_if_needed(action, *args)
    if fetch(:execute_monit_without_sudo)
      send action, *args
    else
      send action, :sudo, *args
    end
  end
end
