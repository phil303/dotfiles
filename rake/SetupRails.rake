require 'rake'

desc "Set up new Rails projects"
task :newrails do
  # Gemfile Operations
  if File.exist? "Gemfile"
    @rails_version = File.open('Gemfile', 'r').readlines.
      grep(/gem 'rails'/).to_s.match(/\d+.\d+.\d+(.\w+)?/)[0]
    gemfile = File.open('Gemfile', 'r').readlines
      puts "Writing Gemfile..."
      puts "Rails version to be written: #{@rails_version}"
      append_gemfile(gemfile)
      f = File.open('Gemfile', 'w')
      f.puts gemfile
      f.close
      system %Q{bundle install --without production}
  end

  # Create list of gems
  ## Should I search Gemfile.lock instead?
  @gem_list = `gem list`.split("\n").map { |gem| gem.match(/^\S+/).to_s }

  check_list = %w[rspec cucumber capybara spork guard-spork guard-rspec
                    factory_girl_rails annotate pry haml haml-rails]
  gem_exist?(check_list)

  # RSpec Operations
  if @exist_list["rspec"]
    puts "Generating RSpec files..."
    system %Q{rails generate rspec:install}
    if @exist_list["cucumber"] && @exist_list["capybara"]
      puts "Generating Cucumber files..."
      system %Q{rails generate cucumber:install --capybara --rspec}
    end
  end

  # Spork Operations
  if @exist_list["spork"] && @exist_list["guard-spork"]
    system %Q{spork --bootstrap}
    if File.exist?("./spec/spec_helper.rb")
      spec_helper = File.open("./spec/spec_helper.rb", "r").readlines
      prefork_start = spec_helper.index("ENV[\"RAILS_ENV\"] ||= 'test'\n")
      prefork = spec_helper[prefork_start..-1].join("\t")
      @exist_list["factory_girl_rails"]
      if @exist_list["factory_girl_rails"]
        each_run = "\n\tFactoryGirl.reload"
      else
        each_run = ""
      end
      File.open("./spec/spec_helper.rb", "w") do |f|
        puts "Writing new spec_helper file..."
        f.puts(new_spork(prefork, each_run))
        f.close
        puts "New spec_helper file written."
      end
    end
  end

  # Guard Operations
  if @exist_list["guard-rspec"]
    if @exist_list["spork"] && @exist_list["guard-spork"]
      system %Q{bundle exec guard init spork}
    end
    if @exist_list["rspec"]
      system %Q{bundle exec guard init rspec}
    end
    if @exist_list["cucumber"]
      system %Q{bundle exec guard init cucumber}
    end
    guardfile = File.open("Guardfile", "r").readlines
    guardfile[guardfile.index("guard 'rspec', :version => 2 do\n")] = 
      "guard 'rspec', :version => 2, :cli => '--drb' do"
    f = File.open("Guardfile", "w")
    f.puts guardfile
    f.close
  end

  # Annotation Operations
  if @exist_list["annotate"]
    puts "Writing lib/tasks/annotations.rake..."
    f = File.open("./lib/tasks/annotations.rake", "w+")
    f.puts annotations
    f.close
  end

  # Pry Operations
  if @exist_list["pry"]
    puts "Setting up pry to start with 'rails console'..."
    pry_add = File.open("./config/environments/development.rb", "r").readlines
    pry_add[pry_add.index("end\n") - 1] << pry_contents
    f = File.open("./config/environments/development.rb", "w")
    f.puts pry_add
    f.close
  end

  # Haml Operations
  #if @exist_list["haml"] && @exist_list["haml-rails"]
    #puts "Setting up scaffold generator to generate haml views..."
    #haml_add = File.open("./config/application.rb", "r").readlines
    #haml_add[haml_add.index("  end\n")-1] << haml_contents
    #f = File.open("./config/application.rb", "w")
    #f.puts haml_add
    #f.close
  #end
end

def haml_contents
"
   # Creates haml scaffolding
    config.generators do |g|
      g.template_engine :haml
    end"
end

def pry_contents
"
  # Add pry as default for 'rails console'
  silence_warnings do
    begin
      require 'pry'
      IRB = Pry
    rescue LoadError
    end
  end"
end

def annotations
"# Added in to make annotations run automatically
namespace :db do
  task :migrate do
    unless Rails.env.production?
      require \"annotate/annotate_models\"
      AnnotateModels.do_annotations(:position_in_class => 'before',
                                    :position_in_fixture => 'before')
    end
  end

  namespace :migrate do
    [:up, :down, :reset, :redo].each do |t|
      task t do
        unless Rails.env.production?
          require \"annotate/annotate_models\"
          AnnotateModels.do_annotations(:position_in_class => 'before',
                                        :position_in_fixture => 'before')
        end
      end
    end
  end
end"
end

def new_spork(prefork, each_run)
"require 'rubygems'
require 'spork'

Spork.prefork do
  # Loading more in this block will cause your tests to run faster. However,
  # if you change any configuration or code from libraries loaded here, you'll
  # need to restart spork for it take effect.
  #{prefork}
end

Spork.each_run do
  # This code will be run each time you run your specs.#{each_run}
end

# --- Instructions ---
# Sort the contents of this file into a Spork.prefork and a Spork.each_run
# block.
#
# The Spork.prefork block is run only once when the spork server is started.
# You typically want to place most of your (slow) initializer code in here, in
# particular, require'ing any 3rd-party gems that you don't normally modify
# during development.
#
# The Spork.each_run block is run each time you run your specs.  In case you
# need to load files that tend to change during development, require them here.
# With Rails, your application modules are loaded automatically, so sometimes
# this block can remain empty.
#
# Note: You can modify files loaded *from* the Spork.each_run block without
# restarting the spork server.  However, this file itself will not be reloaded,
# so if you change any of the code inside the each_run block, you still need to
# restart the server.  In general, if you have non-trivial code in this file,
# it's advisable to move it into a separate file so you can easily edit it
# without restarting spork.  (For example, with RSpec, you could move
# non-trivial code into a file spec/support/my_helper.rb, making sure that the
# spec/support/* files are require'd from inside the each_run block.)
#
# Any code that is left outside the two blocks will be run during preforking
# *and* during each_run -- that's probably not what you want.
#
# These instructions should self-destruct in 10 seconds.  If they don't, feel
# free to delete them."
end

def gem_exist?(check_list)
  @exist_list = {}
  check_list.each do |gem|
    @exist_list[gem] = @gem_list.include?(gem)
  end
end

def append_gemfile(gemfile)
  gemfile << "\ngem 'haml', :group => [:development, :test]"
  gemfile << "gem 'haml-rails', :group => [:development, :test]"
  gemfile << "\ngem 'heroku'\n\n"
  gemfile << "group :development do\n\tgem 'rspec-rails'\n\tgem 'annotate', '~> 2.4.1.beta'\n\tgem 'pry'\n\tgem 'sqlite3'\nend"
  gemfile << "group :test do\n\tgem 'rspec'\n\tgem 'capybara'\n\tgem 'factory_girl_rails'\n\tgem 'sqlite3'\n\tgem 'spork', '> 0.9.0.rc'\n\tgem 'guard-spork'\n\tgem 'guard-rspec'\n\tgem 'faker', :require => false\n\n\tgroup :darwin do\n\tgem 'rb-fsevent', :require => false\n\tgem 'growl', :require => false\n\tend\nend\n\ngroup :production do\n\tgem 'pg'        # for heroku depoloyment\nend"
end
