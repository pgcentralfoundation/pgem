source 'https://rubygems.org'

# rails-assets requires >= 1.8.4
if Gem::Version.new(Bundler::VERSION) < Gem::Version.new('1.8.4')
  abort "Bundler version >= 1.8.4 is required"
end

# as web framework
gem 'rails', '~> 4.2.11.3'

gem 'braintree'
gem 'gon', '~> 5.1.2'

# respond_to methods have been extracted to the responders gem
# http://edgeguides.rubyonrails.org/upgrading_ruby_on_rails.html#responders
gem 'responders', '~> 2.0'

# comment the mysql gem above if using Postgres
gem 'pg'

#support for Django password hashes
gem 'pbkdf2_password_hasher'

# for observing records
gem 'rails-observers'

# for tracking data changes
gem 'paper_trail'

# for upload management
gem 'carrierwave'
gem 'mini_magick', '>= 4.9.4'
gem 'carrierwave-bombshelter'
gem 'better_tempfile'

# for internationalizing
gem 'rails-i18n', '~> 4.0.0'

# as authentification framework
gem 'devise',  '>= 4.8.0'
gem 'devise_ichain_authenticatable'
gem 'devise-passwordless'
# prevent bot registrations
gem "recaptcha", require: "recaptcha/rails"

# for openID authentication
gem 'omniauth', '2.0.4'
gem 'omniauth-facebook', '8.0.0'
gem 'omniauth-openid', '2.0.1'
gem 'omniauth-google-oauth2', '1.0.0'
gem 'omniauth-github', '2.0.0'
gem 'omniauth-rails_csrf_protection', '~> 1.0'

# as authorization framework
gem 'cancancan'

# for roles
gem 'rolify'

# to show flash messages from ajax requests
gem 'unobtrusive_flash', '>=3'

# as state machine
gem 'transitions', :require => %w( transitions active_record/transitions )

# for comments
gem 'awesome_nested_set', '~> 3.0.0'
gem 'acts_as_commentable_with_threading'

# as templating language
gem 'haml-rails'

# for stylesheets
gem 'sass-rails', '>= 4.0.2'

# as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# as the front-end framework
gem 'mini_racer'
gem 'bootstrap-sass', '~> 3.4.1'
gem 'autoprefixer-rails'
gem 'formtastic-bootstrap'
gem 'formtastic', '~> 3.1.5'
gem 'cocoon'
# gem 'pdfjs_viewer-rails'#, :git => 'https://github.com/TinderBox/pdfjs_viewer-rails.git', :branch => 'pdfjs-1.5.188'

# as the JavaScript library
gem 'jquery-rails'
gem 'jquery-ui-rails', '~> 5.0.0'

# for languages validation
gem 'iso-639'

#website pagination
gem 'will_paginate-bootstrap'

#conference archival
gem 'soft_deletion'

#for automated RSS blog impoprt
gem 'feedjira'

# frontend javascripts
source 'https://rails-assets.org' do
  gem 'rails-assets-jquery'
  # for placeholder images
  gem 'rails-assets-holderjs'
  # for formating dates
  gem 'rails-assets-date.format'
  # for or parsing, validating, manipulating, and formatting dates
  gem 'rails-assets-momentjs'
  # for smooth scrolling
  gem 'rails-assets-jquery-smooth-scroll'
  # as color picker
  gem 'rails-assets-spectrum'
  # for color manipulation
  gem 'rails-assets-tinycolor'
  # for drawing triangle backgrounds
  gem 'rails-assets-trianglify'
  # for scroll way points
  gem 'rails-assets-waypoints'
  # for markdown editors
  gem 'rails-assets-bootstrap-markdown'
  gem 'rails-assets-to-markdown'
  gem 'rails-assets-markdown'
  gem 'rails-assets-chartjs'
end

# as date picker
gem 'bootstrap3-datetimepicker-rails', '~> 3.0.2'


gem 'jquery-datatables-rails', '~> 2.2.1'
# datatables server-side processing
gem 'ajax-datatables-rails'

# for charts
gem 'groupdate'
gem 'hightop'
gem "chartkick"
gem 'rails_pdf'

# for displaying maps
gem 'leaflet-rails'

# for user avatars
gem 'gravtastic'

# for country selects
gem 'country_select'

# as PDF generator
gem 'prawn', '~> 1.3.0'
gem 'prawn_rails'
gem 'rqrcode'
gem 'prawn-qrcode', '~> 0.2.2.1'
gem 'invoice_printer'

# to render XLS spreadsheets
gem 'caxlsx_rails'
gem 'caxlsx'

gem 'rubyzip', '>= 1.3.0'

# to make links faster
gem 'turbolinks'

# for JSON serialization of our API
gem 'active_model_serializers'

# as icon font
gem 'font-awesome-rails', '>= 4.7.0'

# for markdown
gem 'redcarpet', '>= 3.5.1'

# FIXME: do we really need an alternative JSON parser?
gem 'yajl-ruby', '~> 1.2', '>= 1.2.1'

# as rdoc generator
gem 'rdoc-generator-fivefish', '~> 0.4.0'

# for visitor tracking
gem 'ahoy_matey', '~> 2'

# offline geoip database for ahoy
gem 'maxminddb'

# gem 'activeuuid'
gem 'uuidtools'
gem 'piwik_analytics', '~> 1.0.1'

# for recurring jobs
gem 'whenever', :require => false
gem 'delayed_job_active_record'

# to run scripts
gem 'daemons'

# to encapsulate money in objects
gem 'money-rails'

# for lists
gem 'acts_as_list'

# for switch checkboxes
gem 'bootstrap-switch-rails', '~> 3.0.0'

# for parsing OEmbed data
gem 'ruby-oembed', '~> 0.14.0'

# for uploading images to the cloud
gem 'cloudinary'

# for setting app configuration in the environment
gem 'dotenv-rails'

# Both are not in a group as we use it also for rake data:demo
# for fake data
gem 'faker'
# for seeds
gem 'factory_girl_rails'

# for integrating Stripe payment gateway
gem 'stripe'

# for multiple speakers select on proposal/event forms
gem 'selectize-rails'

# metadata for reach search results on google pages
gem 'schema_dot_org', git: 'https://github.com/eug3nix/schema-dot-org', branch: 'pgem_entities'

# event social sharing bootstrap buttons
gem 'bootstrap-social-rails'

# for readable propopsal urls
gem 'friendly_id', '~> 5.1.0'

# for calendars
gem 'simple_calendar', '~> 2.4'

#for carousel
gem 'jquery-slick-rails'

#for survey
gem 'survey'

#for iCal schedules
gem 'icalendar'

gem 'humanize'

#for integration with Sched
gem 'sched', '~> 0.1.13'

#for REST calls to external sources
gem 'rest-client'
gem 'rest-client-logger'

# event tags
gem 'acts-as-taggable-on'

# used by many dependencies, enforce reasonably fresh version
gem "nokogiri", ">= 1.11.0"

#To make SOAP calls to the PayU API
gem 'httpclient', '~> 2.8', '>= 2.8.3'
gem 'lolsoap', '~> 0.9.0'
gem 'akami', '~> 1.3', '>= 1.3.1'

# Use guard and spring for testing in development
group :development do
  # to launch specs when files are modified
  gem 'guard-rspec', '~> 4.2.8'
  gem 'spring-commands-rspec'
  # for static code analisys
  gem 'rubocop', require: false
  # to silence rack assests messages
  gem 'quiet_assets'
  # to open mails
  gem 'letter_opener'
  # to open mails in browser
  gem 'letter_opener_web'
  # as deployment system
  gem 'mina'
  # as debugger on error pages
  gem 'web-console', '~> 2.0'
  # to dump CMS cofiguration
  gem 'seed_dump'
  # webrick threads misbehave in the current setup
  gem 'puma'
end

group :test do
  # as test framework
  gem 'rspec-rails'
  gem 'database_cleaner'
  gem 'capybara'
  gem 'poltergeist'
  gem 'phantomjs', :require => 'phantomjs/poltergeist'
  # for measuring test coverage
  gem 'coveralls', require: false
  # for describing models
  gem 'shoulda-matchers', require: false
  # for stubing/mocking models
  gem 'rspec-activemodel-mocks'
  # to freeze time
  gem 'timecop'
  # for mocking external requests
  gem 'webmock'
  # for mocking Stripe responses in tests
  gem 'stripe-ruby-mock'
  # For validating JSON schemas
  gem 'json-schema'
end

group :development, :test do
  # as debugger
  gem 'byebug', '~> 11.1.3'
  gem "better_errors"
  # dependency
  gem "binding_of_caller"
  #gem 'sqlite3'
end

group :production do
  gem 'exception_notification'
end

# IMPORTANT - refinery stuff should come last in gemfile
gem 'refinerycms', '~> 3.0.0'
gem 'refinerycms-search', git: 'https://github.com/refinery/refinerycms-search', branch: '3-0-stable'
gem 'refinerycms-blog', git: 'https://github.com/refinery/refinerycms-blog', branch: 'master'
gem 'refinerycms-dynamicfields', :git => 'https://github.com/jfalameda/refinerycms-dynamicfields.git'
gem 'refinerycms-tinymce', git: 'https://github.com/ghoppe/refinerycms-tinymce'

gem 'refinerycms-team_members', path: 'vendor/extensions'
gem 'refinerycms-sponsors', path: 'vendor/extensions'

gem 'refinerycms-meetups', path: 'vendor/extensions'
gem 'refinerycms-community_events', path: 'vendor/extensions'