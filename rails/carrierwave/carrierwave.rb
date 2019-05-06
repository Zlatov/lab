# Gemfile
gem 'carrierwave', '~> 1.0'

# $
bundle install
rails generate uploader Image

# app/models/model.rb
mount_uploader :field_name_image, ImageUploader
