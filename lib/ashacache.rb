$:.unshift File.dirname(__FILE__)

%w( rubygems activeresource yaml ).each { |lib| require lib }

http_basic_authentication_yml = File.join File.dirname(__FILE__), 'config', 'http_basic_authentication.yml'
http_basic_authentication = YAML::load File.read(http_basic_authentication_yml)

SITE = "http://ashacache.com"
USER = http_basic_authentication[:username]
PASS = http_basic_authentication[:password]
ActiveResource::Base.site = "http://#{USER}:#{PASS}@ashacache.com"

module Ashacache

  def doc path
    require 'hpricot'
    Hpricot html(path)
  end
  def html path
    require 'open-uri'
    domain = (path['http://']) ? nil : SITE
    open "#{domain}#{path}", :http_basic_authentication => [USER, PASS]
  end

  class Member < ActiveResource::Base
    def hunts
      Hunt.find(:all).select { |h| h.member_id == id }
    end
    def self.find_by_name name
      Member.find(:all).find { |m| m.name == name }
    end
  end

  class Hunt < ActiveResource::Base
    def member
      @member ||= Member.find member_id
    end
    def image
      @image ||= SITE + ( doc("/hunts/#{id}") / 'div#showHuntImageCol>img ').first['src']
    end

    def local_image
      require 'fileutils'
      dir  = File.join 'tmp', File.dirname(image).sub('http://','')
      file = File.join dir, File.basename(image)
      FileUtils.mkdir_p dir unless File.directory? dir
      FileUtils.mv html(image).path, file unless File.file? file
      file
    end
  end

  # Comments are not currently available
  class Comment; end

end

# for testing
include Ashacache
