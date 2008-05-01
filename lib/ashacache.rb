$:.unshift File.dirname(__FILE__)
%w( rubygems active_resource ).each { |lib| require lib }

SITE = "http://ashacache.com"
rc = File.expand_path('~/.ashacacherc')
eval File.read(rc) if File.file? rc

def auth () (defined?USER and defined?PASS) ? [USER,PASS] : nil end
ActiveResource::Base.site = "http://#{ auth.join ':' }@ashacache.com"

def doc path
  require 'hpricot'
  Hpricot html(path)
end
def html path
  require 'open-uri'
  domain = (path['http://']) ? nil : SITE
  open "#{domain}#{path}", :http_basic_authentication => auth
end

module Ashacache

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
      file = File.join dir, File.basename(image).sub(/\?\d+$/,'')
      FileUtils.mkdir_p dir unless File.directory? dir
      FileUtils.mv html(image).path, file unless File.file? file
      file
    end
  end

end
