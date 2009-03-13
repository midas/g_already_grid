class AlreadyGridAssetsGenerator < Rails::Generator::Base
  def initialize(runtime_args, runtime_options = {})
    super
  end

  def manifest
    record do |m|
      m.file "guilded.already_grid.js", "public/javascripts/guilded.already_grid.js"
      m.file "guilded.already_grid.min.js", "public/javascripts/guilded.already_grid.min.js"
      m.directory "public/javascripts/jquery"
      m.file "jquery-already_grid-0.1.js", "public/javascripts/jquery/jquery-already_grid-0.1.js"
      m.file "jquery-already_grid-0.1.min.js", "public/javascripts/jquery/jquery-already_grid-0.1.min.js"
      m.directory "public/stylesheets/guilded/already_grid"
      m.directory "public/stylesheets/guilded/already_grid/default"
      m.file "default.css", "public/stylesheets/guilded/already_grid/default.css"
      m.file "gridHeadBg.gif", "public/stylesheets/guilded/already_grid/default/gridHeadBg.gif"
      m.file "gridSort.gif", "public/stylesheets/guilded/already_grid/default/gridSort.gif"
      m.file "gridSortAsc.gif", "public/stylesheets/guilded/already_grid/default/gridSortAsc.gif"
      m.file "gridSortDesc.gif", "public/stylesheets/guilded/already_grid/default/gridSortDesc.gif"
    end
  end
end