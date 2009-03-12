namespace :grails do
  
  namespace :db do
  
    desc "Generates a database.yml file from the Grails DataSource.groovy file."
    task :make_yml do

      grails_db_name = File.join(File.dirname(__FILE__), "..", "grails-app", "conf", "DataSource.groovy")
      yaml_file_name = File.join(File.dirname(__FILE__), "..", "db", "config", "database.yml")
      # abort "\nThe Grails #{grails_db_name} file does not exist.\n\n" unless File.exists?( grails_db_name )
      #     abort "\nThe #{yaml_file_name} already exists.  Please remove it if you wish to generate a new one.\n\n" if File.exists?( yaml_file_name )
      #     
      #     found_ds = false
      #     
      #     File.open( grails_db_name ) do |file|
      #       while line = file.gets
      #         
      #         if line =~ /dataSource {/
      #           found_ds
      #         elsif found_ds && line =~ /driverClassName/
      #           if line =~ /mysql/
      #             provider = "mysql"
      #           end
      #         end
      #         
      #       end
      #     end

      provider = "mysql"
      db = { 
        'development' => { 
          'database' => "ticket_system_development", 
          'username' => "ticket_system", 
          'password' => "iberon",
          'adapter' => provider, 
          'host' => "localhost",
          'socket' => "/opt/local/var/run/mysql5/mysqld.sock",
          'encoding' => "UTF8"
        },
        'test' => { 
          'database' => "ticket_system_test", 
          'username' => "ticket_system", 
          'password' => "iberon",
          'adapter' => provider, 
          'host' => "localhost",
          'socket' => "/opt/local/var/run/mysql5/mysqld.sock",
          'encoding' => "UTF8"
        },
        'production' => { 
          'database' => "ticket_system_production", 
          'username' => "ticket_system", 
          'password' => "iberon",
          'adapter' => provider, 
          'host' => "localhost",
          'socket' => "/opt/local/var/run/mysql5/mysqld.sock",
          'encoding' => "UTF8"
        }
      }

      content = YAML::dump( db )

      #indentation = content[/\A\s*/]
      #content.strip.gsub(/^#{indentation}/, "")

      dashes = /--- \n/
      content.gsub!( dashes, "" )

      File.open( yaml_file_name, "w" ) { |f| f.write( content ) }

    end
    
    namespace :gen do

      desc "Generates a new Grails create table migration using the TABLE variable specified by the user to create the name of the migration."
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

      t.integer :version, :default => 0
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
  
end