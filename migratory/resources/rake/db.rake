require 'rake'
require'active_record'
require'active_support'
require 'yaml'

namespace :db do
  
  desc "Migrate the database through scripts in db/migrate, targeting specific version with VERSION=x when necessary."
  task :migrate => :environment do
    ActiveRecord::Migrator.migrate( 'db/migrate', ENV["VERSION"] ? ENV["VERSION"].to_i : nil )  
  end
   
  # Set up the ActiveRecord environment
  task :environment do
    env = ENV['ENV']
    env = 'development' if env.nil?
    yaml_file_name = File.join(File.dirname(__FILE__), "..", "db", "config", "database.yml")

    if File.exists?( yaml_file_name )
      config = YAML::load( File.open( yaml_file_name ) )
    else
      abort "\n[abort] You need to create the #{yaml_file_name}.  If you are using Grails, try the grails:make_db_yml task.\n\n"
    end
  
    ActiveRecord::Base.establish_connection( config[ env ] )
    ActiveRecord::Base.logger = Logger.new( File.open( File.join( File.dirname( __FILE__ ), "..", "db", "database.log" ), 'a' ) )
  end
  
  namespace :gen do
    
    desc "Generates a new migration flie with the NAME variable provided by user."
    task :migration do
      name = ENV['NAME']
      abort "\n[abort] You must supply a name for you new migration class with the NAME variable.  Usage 'NAME=create_users'.\n\n" if name.nil?

      migration_dir = File.join( File.dirname( __FILE__ ), "..", "db", "migrate" )
      
      # Check for files with the same name part (without timestamp considered)
      files = Dir.new( migration_dir ).entries
      files.each do |f|
        unless File.directory?( f )
          abort "\n[abort] The name '#{name}' is already used in the migration '#{f}'.  Please choose another name.\n\n" if f.include?( name )
        end
      end

      timestamp = DateTime.now.to_formatted_s( :number )
      mig_file_name = "#{timestamp}_#{name}.rb"
      mig_file_path = File.join( migration_dir, mig_file_name )
      
      content = <<-FILE
class #{name.camelize} < ActiveRecord::Migration
  def self.up
    
  end
  
  def self.down
    
  end
end
      FILE
      
      puts "\n[add] Creating file #{mig_file_path}\n\n"
      
      File.open( mig_file_path, "w" ) { |f| f.write( content ) }
    end
    
    desc "Generates a new create table migration using the TABLE variable specified by the user to create the name of the migration."
    task :create do
      
      table = ENV['TABLE']
      abort "\n[abort] You must supply a name for you new migration class with the TABLE variable.  Usage 'TABLE=users'.\n\n" if table.nil?
      name = "create_#{table.downcase}"

      migration_dir = File.join( File.dirname( __FILE__ ), "..", "db", "migrate" )
      
      # Check for files with the same name part (without timestamp considered)
      files = Dir.new( migration_dir ).entries
      files.each do |f|
        unless File.directory?( f )
          abort "\n[abort] The name '#{name}' is already used in the migration '#{f}'.  Please choose another name.\n\n" if f.include?( name )
        end
      end

      timestamp = DateTime.now.to_formatted_s( :number )
      mig_file_name = "#{timestamp}_#{name}.rb"
      mig_file_path = File.join( migration_dir, mig_file_name )
      
      content = <<-FILE
class #{name.camelize} < ActiveRecord::Migration
  def self.up
    create_table :#{table} do |t|
      
      t.integer :lock_version, :default => 0
      t.timestamps
    end
  end
  
  def self.down
    drop_table :#{table}
  end
end
      FILE
      
      puts "\n[add] Creating file #{mig_file_path}\n\n"
      
      File.open( mig_file_path, "w" ) { |f| f.write( content ) }
      
    end
    
  end
  
end