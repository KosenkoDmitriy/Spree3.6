server "119.9.23.182", :app, :web, :db, :primary => true
set :application, "soulpad.com.au"
set :user, 'deploy'
set :runner, 'deploy'
set :use_sudo, false
set :rails_env, "production"
set :branch, "master"
set :deploy_to, "/var/www/#{application}"
set :keep_releases, 5
set :local_shared_files, %w(config/database.yml config/unicorn.rb .env)

namespace :foreman do
	desc "Export the Procfile to Ubuntu's upstart scripts"
	task :export, :roles => :app do
		run "cd #{release_path} && sudo foreman export upstart /etc/init -a #{application} -u #{user} -l #{shared_path}/log"
	end

	desc 'Start the application services'
	task :start, :roles => :app do
		sudo "sudo start #{application}"
	end

	desc 'Stop the application services'
	task :stop, :roles => :app do
		sudo "sudo stop #{application}"
	end

	desc 'Restart the application services'
	task :restart, :roles => :app do
		run "sudo start #{application} || sudo restart #{application}"
	end
end

after 'deploy:create_symlink', 'foreman:export'
after 'deploy:create_symlink', 'foreman:restart'
