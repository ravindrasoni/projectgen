require 'json'

$search_folder=`pwd`.chomp

module CookieGen
  class Generator
    def self.cookiecutter_string(key)
      return "{{ cookiecutter.#{key} }}"
    end

    def self.should_ignore_path(path, ignore)
      intersection = ignore & path.split("/")
      return intersection.length > 0
    end

    def self.change_path(path, replacements)
      path_arr = path.split("/")
      last_path = path_arr.pop
      path_suffix = $search_folder.chomp + (path_arr.length > 0 ? "/" + path_arr.join("/") : "")
      replacements.keys.each do |key|
        old_last_path = last_path.dup
        while last_path.include? key
          start_index = last_path.index(key)
          last_path[start_index, key.length] = Generator.cookiecutter_string(replacements[key])
          old_path = path_suffix + "/" + old_last_path
          new_path = path_suffix + "/" + last_path
          puts "\nUpdating Path:"
          puts "From: #{old_path}"
          puts "To: #{new_path}"
          File.rename "#{old_path}", "#{new_path}"
          old_last_path = last_path.dup
        end
      end
      return path_suffix + "/" + last_path
    end

    def self.update_files(replacements, ignore)
      # Fetch list of all files in the folder, rejecting all the ignored files
      # 'reverse' is to make sure we're updating subfolders/subfiles before main folders
      list_of_files = Dir.glob("**/*", File::FNM_DOTMATCH).reverse.reject do |path|
        Generator.should_ignore_path(path, ignore)
      end
      list_of_files.each do |path|
        changed_path = Generator.change_path(path, replacements)
        if !File.directory?(changed_path)
          puts "\nFile: #{changed_path}"
          replacements.keys.each do |key|
            begin
              text = File.read(changed_path)
              new_contents = text.gsub(/#{key}/, "#{Generator.cookiecutter_string(replacements[key])}")
              # To write changes to the file, use:
              File.open(changed_path, "w") {|file| file.puts new_contents }
            rescue => e
              puts "\nError modifying file: #{changed_path}"
              puts "Error: #{e}"
              next        
            end
          end
        end
      end
    end

    def self.create_cookie(json_path)
      json_file = File.read(json_path)
      jsonHash = JSON.parse(json_file)
      replacements = jsonHash["replace"]
      ignore = jsonHash["ignore"]
      Generator.update_files(replacements, ignore)
    end

  end
end

# IOSCookie::Cookie.create_cookie('/Users/soni/scripts/ios/ios.json')




