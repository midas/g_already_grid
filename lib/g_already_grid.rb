$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'g_already_grid/view_helpers'

module GAlreadyGrid
  VERSION = '1.0.7'
end

if defined?( ActionView::Base )
  ActionView::Base.send( :include, GAlreadyGrid::ViewHelpers ) unless ActionView::Base.include?( GAlreadyGrid::ViewHelpers )
end