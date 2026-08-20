# Set up gems listed in the Gemfile.
ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', __FILE__)

require 'bundler/setup' if File.exist?(ENV['BUNDLE_GEMFILE'])

# Speeds up boot by caching expensive require/load-path lookups to disk.
# Development only (see Gemfile) - not installed in :test/:production.
require 'bootsnap/setup' if (ENV['RAILS_ENV'] || 'development') == 'development'
