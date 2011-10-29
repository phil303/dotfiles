# write gemfile
# run bundle install

# if rspec is installed run 'rails generate rspec:install'

# if cucumber and rspec/capybara is installed run 'rails generate cucumber:install --capybara --rspec'

# if spork and guard-spork is installed, run 'spork --bootstrap'
#   - Move contents of original spec_helper into prefork block
#   - if factory_girl_rails is installed add 'FactoryGirl.reload' to each_run block

# run 'guard init spork/rspec/cucumber' to all that apply

# in guardfile change rspec line to look like this:
#   guard 'rspec', :version => 2, :cli => '--drb' do


# if annotate is in gemfile write annotate task in lib/task

# if pry is installed add pry configuration to config/environments/development.rb 

# if haml is installed haml scaffold config to config/application.rb:
#     config.generators do |g|
#       g.template_engine :haml
#     end
