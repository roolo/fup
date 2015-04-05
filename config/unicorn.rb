rails_env = ENV['RACK_ENV'] || 'production'

@app_dir = '/home/deploy/Projects/fup/current'

worker_processes 2
working_directory @app_dir

# This loads the application in the master process before forking
# worker processes
# Read more about it here:
# http://unicorn.bogomips.org/Unicorn/Configurator.html
preload_app true

timeout 300

# This is where we specify the socket.
# We will point the upstream Nginx module to this socket later on
listen  @app_dir + '/tmp/unicorn.fup.sock', :backlog => 64
pid     @app_dir + '/tmp/unicorn.fup.pid'

# pid '/var/rails/testapp/tmp/pids/unicorn.pid'

# Set the path of the log files inside the log folder of the testapp
stderr_path @app_dir + '/log/unicorn.stderr.log'
stdout_path @app_dir + '/log/unicorn.stdout.log'

before_fork do |server, worker|
# This option works in together with preload_app true setting
# What is does is prevent the master process from holding
# the database connection
  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.connection.disconnect!
end

after_fork do |server, worker|
# Here we are establishing the connection after forking worker
# processes
  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.establish_connection
end
