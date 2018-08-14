namespace :offers do

  desc "Update affiliate offer permalinks"
  task :slug => :environment do

    Offer.all.each do |offer|
      slug=offer.title.downcase.gsub(" ","-")
      offer.update_attribute(:slug, slug)
    end

  end
end