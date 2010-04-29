require 'rails/generators'

class AlreadyGridAssetsGenerator < Rails::Generators::Base
  def self.source_root
    File.join( File.dirname(__FILE__), 'templates' )
  end
  
  def install_already_grid_assets
    copy_file "guilded.already_grid.js", "public/javascripts/guilded.already_grid.js"
    copy_file "guilded.already_grid.min.js", "public/javascripts/guilded.already_grid.min.js"
    copy_file "jquery-already_grid-0.1.js", "public/javascripts/jquery/jquery-already_grid-0.1.js"
    copy_file "jquery-already_grid-0.1.min.js", "public/javascripts/jquery/jquery-already_grid-0.1.min.js"
    copy_file "default.css", "public/stylesheets/guilded/already_grid/default.css"
    copy_file "gridHeadBg.gif", "public/stylesheets/guilded/already_grid/default/gridHeadBg.gif"
    copy_file "gridSort.gif", "public/stylesheets/guilded/already_grid/default/gridSort.gif"
    copy_file "gridSortAsc.gif", "public/stylesheets/guilded/already_grid/default/gridSortAsc.gif"
    copy_file "gridSortDesc.gif", "public/stylesheets/guilded/already_grid/default/gridSortDesc.gif"
  end
end