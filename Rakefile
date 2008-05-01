require 'rake'

namespace :gems do

  desc 'Install Required Gems'
  task :install do
    sudo = (RUBY_PLATFORM[/windows/i]) ? nil : 'sudo'
    gems = %w( remi-simplecli ).join ' '
    puts "Installing gems ... ( please be patient )"
    puts `#{ sudo } gem install #{ gems } --source http://gems.github.com`
  end

end
