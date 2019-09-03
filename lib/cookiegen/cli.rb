require 'thor'
require 'cookiegen'

module CookieGen
  class CLI < Thor
	desc "gen", "Generate cookie_cutter"
	method_option :jsonpath, aliases: "-p", :desc => "provide json file path with mapping"
	def gen
	    puts CookieGen::Generate.create_cookie(options[:jsonpath])
	end
  end
end