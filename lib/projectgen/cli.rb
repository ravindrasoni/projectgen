require 'thor'
require 'projectgen'

module ProjectGen
  class CLI < Thor
  	default_task :gen

	desc "gen", "Generate project from template"
	method_option :github_url, aliases: "-g", :desc => "provide github_url with the mappings"
	def gen
	    puts ProjectGen::Generator.generate_project(options[:github_url])
	end

  end
end