require 'thor'
require 'cookiegen'

module ProjectGen
  class CLI < Thor
	desc "gen", "Generate cookie_cutter"
	method_option :jsonpath, aliases: "-p", :desc => "provide json file path with mapping"
	def gen
	    puts ProjectGen::Generator.create_cookie(options[:jsonpath])
	end

	desc "gen1", "Generate cookie_cutter"
	method_option :githuburl, aliases: "-p", :desc => "provide github url"
	def gen

	end

  end
end