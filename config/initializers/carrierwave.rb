CarrierWave.configure do |config|
  config.storage = :file
  # config.storage = :fog
  # config.fog_credentials = {
  #   provider: 'AWS',
  #   aws_access_key_id: ENV['S3_KEY'],
  #   aws_secret_access_key: ENV['S3_SECRET'],
  #   region: 'eu-central-1'
  # }
  # config.cache_dir = "#{Rails.root}/tmp/uploads"
  # config.fog_directory = ENV['S3_BUCKET']
end
