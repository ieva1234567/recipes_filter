# config valid for current version and patch releases of Capistrano
lock "~> 3.18.0"

set :application, "receptu_filtras"
set :repo_url, "git@github.com:ieva1234567/recipes_filter_shakapacker.git"
set :migration_role, :app
set :use_sudo, false

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

set :branch, "master"

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, "/home/deploy/receptu_filtras"

set :rbenv_prefix, "/usr/bin/rbenv exec"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, 
# Default value for :linked_files is []
append :linked_files, "config/database.yml", "config/master.key", "config/app_environment_variables.rb", ".env"

# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system", "vendor", "storage"
append :linked_dirs, "config/credentials"

set :nvm_type, :user
set :nvm_node,  "v18.18.0"
set :nvm_map_bins, %w{node npm yarn}

set :yarn_flags, %w{--silent}

set :migration_role, :db
set :migration_command, "db:migrate"

# Defaults to false
# Skip migration if files in db/migrate were not modified
set :conditionally_migrate, true

set :assets_roles, [:web, :app]

namespace :deploy do
    desc 'run assets precompile'
    namespace :assets do
      task :precompile do
        on roles(:app, :web) do
            execute "cd #{release_path} && RAILS_ENV=#{fetch(:stage)} /usr/bin/rbenv exec bundle exec rake assets:precompile"
        end
      end
    end
end

after 'deploy:finishing', 'restart_puma'
task :restart_puma do
    on roles(:app, :web), in: :sequence, wait: 5 do
        execute 'sudo /bin/systemctl restart puma.service'
        sleep(30)
    end
end

=begin
namespace :deploy do
    desc 'run assets precompile'
    namespace :assets do
        task :precompile do
            on roles(:app) do
                within "#{release_path}" do
                    with rails_env: "#{fetch(:stage)}" do
                        run "bundle exec rake assets:precompile"
                    end
                end
            end
        end
    end
end
=end

# Defaults to 'assets'
# This should match config.assets.prefix in your rails config/application.rb
# set :assets_prefix, 'prepackaged-assets'

# Defaults to ["/path/to/release_path/public/#{fetch(:assets_prefix)}/.sprockets-manifest*", "/path/to/release_path/public/#{fetch(:assets_prefix)}/manifest*.*"]
# This should match config.assets.manifest in your rails config/application.rb
# set :assets_manifests, ['app/assets/config/manifest.js']

set :rails_assets_groups, :assets

####EXAMPLE FOR PUMA#####
#after 'deploy:finishing', 'restart_apiservice'
#task :restart_apiservice do
#  on roles(:app), in: :sequence, wait: 5 do
#    execute 'sudo /bin/systemctl restart apiservice.service'
#    sleep(30)
#  end
#end

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
# set :keep_releases, 5

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure

set :keep_releases, 5