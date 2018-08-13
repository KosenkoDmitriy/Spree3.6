# Egar loading concerns
Dir.glob(File.join(Rails.root, "app/**/concerns/*.rb")) do |r|
  require r
end
