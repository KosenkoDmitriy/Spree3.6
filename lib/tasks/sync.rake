namespace :sync do

	desc "Sync all social networking stuff"
	task :all => :environment do
		Rake::Task["facebook:sync"].invoke
		Rake::Task["twitter:sync"].invoke
    Rake::Task["insta:sync"].invoke
	end

end
