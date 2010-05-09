$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'g_already_grid/view_helpers'

module GAlreadyGrid
  VERSION = '2.0.0'
end

if defined?( ActionView::Base )
  ActionView::Base.send( :include, GAlreadyGrid::ViewHelpers ) unless ActionView::Base.include?( GAlreadyGrid::ViewHelpers )
end