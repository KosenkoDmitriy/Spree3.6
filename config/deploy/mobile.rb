server "162.13.158.50", :app, :web, :db, :primary => true
set :application, "soulpad"
set :user, "deploy"
set :runner, "deploy"

set :rails_env, "mobile"
set :branch, "master"
set :deploy_to, "/var/www/html/mobile.soulpad.co.uk"
set :keep_releases, 5 
set :local_shared_files, %w(config/database.yml .env)

require "rvm/capistrano"
set :rvm_ruby_string, '1.9.3-p392@global'
set :rvm_type, :system
set :rvm_path, "/usr/local/rvm"
set :user, "deploy"
set :runner, "deploy"

# Overrides for passenger deployment
namespace :deploy do
	desc "Restarting mod_rails with restart.txt"
	task :restart, :roles => :app, :except => { :no_release => true } do
		run "touch #{current_path}/tmp/restart.txt"
	end

	[:start, :stop].each do |t|
		desc "#{t} task is a no-op with mod_rails"
		task t, :roles => :app do ; end
	end
end
