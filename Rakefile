require 'rake'

namespace :gems do

  desc 'Install Required Gems'
  task :install do
    sudo = (RUBY_PLATFORM[/windows/i]) ? nil : 'sudo'
    
    puts "Installing gems from rubyforge ... ( please be patient )"
    puts `#{ sudo } gem install activeresource`

    puts "Installing gems from github ... ( please be patient )"
    puts `#{ sudo } gem install remi-simplecli --source http://gems.github.com`
  end

end
