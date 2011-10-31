# write gemfile DONE
# run 'bundle install --without production' DONE

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

require 'rake'

desc "Set up new Rails projects"
task :newrails do
  # Write and install Gemfile
  if File.exist? "Gemfile"
    @rails_version = File.open('Gemfile', 'r').readlines.
      grep(/gem 'rails'/).to_s.scan(/\d+.\d+.\d+/).first
    File.open('Gemfile', 'w') do |f|
      puts "Writing Gemfile"
      puts "Rails version to be written: #{@rails_version}"
      f.puts(gemfile_contents)
      f.close
      puts "Gemfile written."
    end
    system %Q{bundle install --without production}

    # Search gem list for gems (rspec and rspec-rails, cucumber, spork and guard-spork,
    # annotate, pry, haml and haml-rails)
    ## Should I search Gemfile.lock instead?
    @gem_list = `gem list`.split("\n").map { |gem| gem.match(/^\S+/).to_s }

    rspec_bool = gem_exist?("rspec", "rspec-rails")
    cucumber_bool = gem_exist?("cucumber")
    capybara_bool = gem_exist?("capybara")
    spork_bool = gem_exist?("spork", "guard-spork")
    factory_girl_bool = gem_exist?("factory_girl_rails")
    pry_bool = gem_exist?("pry")
    haml_bool = gem_exist?("haml", "haml-rails")
  end


end

# not working, just returning the first evaluation
def gem_exist?(*gem)
  gem.each do |gem|
    return @gem_list.include? gem
  end
end

def gemfile_contents
"source 'http://rubygems.org'

gem 'rails', '#{@rails_version}'
gem 'sqlite3'
gem 'heroku'

group :assets do
  gem 'sass-rails',   '~> 3.1.4'
  gem 'coffee-rails', '~> 3.1.1'
  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'
gem 'haml', :group => [:development, :test]
gem 'haml-rails', :group => [:development, :test]

group :development do
  gem 'rspec-rails'
  gem 'annotate'
  gem 'pry'
  gem 'sqlite3'
end

group :test do 
  gem 'rspec'
  gem 'capybara'
  gem 'factory_girl_rails'
  gem 'sqlite3'
  gem 'spork', '> 0.9.0.rc'
  gem 'guard-spork'
  gem 'guard-rspec'
  gem 'faker', :require => false

  group :darwin do
    gem 'rb-fsevent', :require => false
    gem 'growl', :require => false
  end
end

group :production do
  gem 'pg'        # for heroku depoloyment
end"
end
