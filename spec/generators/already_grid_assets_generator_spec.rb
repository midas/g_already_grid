require 'spec_helper'
require 'generators/already_grid_assets/already_grid_assets_generator'

describe AlreadyGridAssetsGenerator do
  before :each do
    @destination = File.join 'tmp', 'test_app'
    @source = AlreadyGridAssetsGenerator.source_root
    AlreadyGridAssetsGenerator.start '', :destination_root => @destination
  end
  
  after :each do
    FileUtils.rm_rf @destination
  end
  
  {"guilded.already_grid.js" => "public/javascripts/guilded.already_grid.js",
   "guilded.already_grid.min.js" => "public/javascripts/guilded.already_grid.min.js",
   "jquery-already_grid-0.1.js" => "public/javascripts/jquery/jquery-already_grid-0.1.js",
   "jquery-already_grid-0.1.min.js" => "public/javascripts/jquery/jquery-already_grid-0.1.min.js",
   "default.css" => "public/stylesheets/guilded/already_grid/default.css",
   "gridHeadBg.gif" => "public/stylesheets/guilded/already_grid/default/gridHeadBg.gif",
   "gridSort.gif" => "public/stylesheets/guilded/already_grid/default/gridSort.gif",
   "gridSortAsc.gif" => "public/stylesheets/guilded/already_grid/default/gridSortAsc.gif",
   "gridSortDesc.gif" => "public/stylesheets/guilded/already_grid/default/gridSortDesc.gif"}.each do |file, path|  
    
    it "should copy '#{file}' to '#{path}'" do
      File.exists?( File.join( @destination, path ) ).should be_true
    end
    
    it "should agree that the contents of '#{file}' are identical to '#{path}'" do
      File.read( File.join( @source, file ) ).should eql File.read( File.join( @destination, path ) )
    end
  end
end