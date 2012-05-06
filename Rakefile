require "rake"

desc "Symlink dotfiles into home directory."
task :sync do
  puts
  puts "========================================"
  puts "Dotfiles"
  puts "Files in this directory will be"
  puts "symlinked into your home directory."
  puts "========================================"

  # Files to skip. Hidden files are already ignored.
  skip = %w(README.md Rakefile)

  # Get file list and remove 'skip' files.
  files = Dir.glob('*')
  files -= skip

  # Link each file to the home directory
  # Symlinks are created interactively
  # to allow for overriding existing files
  files.each do |file|
    if `ln -si #{Dir.pwd}/#{file} ~/.#{file}`
      puts "Linked #{Dir.pwd}/#{file} to ~/.#{file}"
    end
  end

end

task :default => 'sync'

