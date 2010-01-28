module GAlreadyGrid
  module ViewHelpers
    
    # GUIlded element.  This is a grid that is utilizing the already grid jQuery plugin.  It is
    # a progressively enhanced table.
    # 
    # *parameters*
    # +ar_col+ (required) An ActiveRecord collection.
    # +options+ As follows.
    # 
    # *options*
    # +id+ (required) The id of the element.  Must be unique on the page.
    # +cols+ (required) An array of column names to include in the table.  Each position of
    #   the array can be a symbol, string, or hash with 1 entry.  The hash entry is the
    #   database field name as a key and the name to use in the gird as the value.  Each
    #   key and value in the hash can be a symbol or string.
    # +skin+ The name of the skin to use for this Guilded element.  Defaults to default => which is default.css.
    # +exclude_css+ A boolean indicating if Guilded should create a stylesheet inlcude tag for 
    #   this element.  Defaults to false.
    # +empty_msg+ a message to display when the ar_col is empty or nil.  Defaults to 'No matching records'.
    # +actions+ Action links to include in the action column of grid.  A boolean or Array of symbols.  When 
    #   boolean, if true, add show, edit and delete actions.  When boolean, if false, hide actions column.  
    #   When Array of symbols, add only actions present in array.
    # +paginate+ A boolean indicating whether to output pagination controls.  Defaults to 
    #   true.  Utilizes will_paginate plugin features.
    # +polymorphic_type+ The type of this polymorphic record.  Should be a string representing the class name.
    # +polymorphic_as+ The as used for the polymorphic type.  Can be a symbol or string.
    # +use_polymorphic_path+ When true, uses hte polymorphic path helper to determine the AR objects path from it's type (STI),
    #   otherwise, does not.  Defaults to false.
    # +namespace+ A string or symbol that is the namespace this collection is under.
    # +scoped_by+ The active record object that the objects in the ar_col is scoped by.
    # +shallow+ True if this collection is nested shallow, otherwise, false.
    # +clickable+ Set to false in order to avoid rows linking to show action.  Defaults to true.
    # +adaptable_url+ True in order to make the index url automagically adapt to :get collection routes, otherwise false.
    #
    def g_already_grid( ar_col, *args )
      options = args.extract_options!
      raise ArgumentError, "'cols' option required" unless options.include?( :cols )
      raise ArgumentError, "'cols' option must be an array of columns" unless options[:cols].is_a? Array
      
      Guilded::Guilder.instance.add( :already_grid, options, [ 'jquery/jquery-already_grid-0.1.min.js' ] )

      return "<span class=\"list-empty-msg\">#{options[:empty_msg] || 'No matching records'}</span>" if ar_col.nil? || ar_col.empty?
      
      options[:grid_class] ||= 'already-grid'
      options[:checkbox_class] ||= "chk"
      options[:check_all_class] ||= "checkAll"
      options[:date_format] ||= :default
      options[:del_confirmation] ||= 'Are you sure you would like to delete this record?'
      options[:clickable] = true if options[:clickable].nil?
      
      options[:cols], options[:col_titles] = Guilded::Rails::Helpers.resolve_field_methods_and_titles( options[:cols], ar_col[0] )
      path_helpers = Guilded::Rails::Helpers.resolve_rest_path_helpers( ar_col, options )
      
      scoped_by = options.delete( :scoped_by )
      
      # Resolve sorting
      if options[:sort]
        if options[:sort].is_a?( Array )
          sort_by = options[:sort].map { |a| a.to_sym }
        elsif options[:sort].is_a?( Symbol ) || options[:sort].is_a?( String )
          sort_by = Array.new << options[:sort].to_sym
        else
          throw "Option 'sort' must be a string, symbol or an array of strings or symbols."
        end
      end
      sort_by = Array.new unless sort_by
      
      if options[:actions].is_a?( TrueClass )
        options[:actions] = [ :show, :edit, :delete ]
      elsif options[:actions].nil?
        options[:actions] = []
      end

      # Resolve pagination
      do_paginate = true
      begin
        if options[:paginate] == false || options[:paginate] == 'false'
          do_paginate = false
        end
      rescue => e
        if e.is_a? NoMethodError # This just means no will_paginate methods are present.
          do_paginate = false
        else
          raise e
        end
      end

      options[:checkboxes] = true if options[:checkboxes].nil?
      
      total_columns = options[:cols].size
      total_columns = total_columns + 1 if options[:checkboxes]
      total_columns = total_columns + 1 unless options[:actions].empty?
      options[:total_columns] = total_columns
      
      vars = { 
        :options => options, :ar_col => ar_col, :do_paginate => do_paginate, :sort_by => sort_by, :path_helpers => path_helpers
      }

      @g_already_grid_options = options
      path = File.dirname(__FILE__)
      full_path = "#{path}/templates/guilded.already_grid.html.erb"
      self.render( :file => full_path, :use_full_path => false, :locals => vars )
    end
    
  private
  
    # Creates a link to sort this column of a table.  Utilizes the link_to helper, 
    # but resolves sort by, direction and adds correct CSS classes for UI elements to 
    # be displayed.
    # 
    # *parameters*
    # +name+ The text to use for the link
    # +method+ The actual name of this column's field.
    # +path+ (Symbol) The name of the path method to call from routing.
    # +already_grid_options+ The options hash from the already grid view helper.
    # +options+ see link_to helper.
    #
    def sortable_header( name, method, path, scoping_args, already_grid_options, options={} )
      is_sorted_link = ( method.to_s == params[:order].to_s )

      if is_sorted_link
        if params[:direction] == "ASC"
          options.merge! :class => "sort-asc"
        elsif params[:direction] == "DESC"
          options.merge! :class => "sort-desc"
        end
      end

      direction = "ASC"
      direction = "DESC" if params[:direction] == "ASC"

      sort_options = { :order => method, :direction => direction }
      sort_options.merge!( :filter => params[:filter] ) if params[:filter]
      unsorted_options = { :order => method, :direction => 'ASC' } # always sort ascending on first sort
      unsorted_options.merge!( :filter => params[:filter] ) if params[:filter]
      
      path = path.to_sym unless path.is_a?( Symbol )
      path_args = [] + scoping_args
      
      if is_sorted_link
        # Handle the currently sorted by link
        path_args << sort_options
        path = @controller.send( path, *path_args )
      else
        # Handle the the other currently unsorted by links (we will always sort in 
        # an ASC direction the first time)
        path_args << unsorted_options
        path = @controller.send( path, *path_args )
      end
      
      # Try to adapt to get collection rest methods
      if already_grid_options[:adaptable_url]
        path_parts = path.split( '?' )
        match = request.path_info.match( /#{path_parts[0]}\/(\w*)/ ) unless path_parts.blank?
        left_overs = match[1] unless match.nil?
        if left_overs == params[:action]
          path = "#{request.path_info}?#{path_parts[1]}"  # path.gsub( /#path_parts[0]/, request.request_uri )
        end
      end
      
      # Load the params to an args array to send to the link_to helper
      args = []
      args << name << path << options

      link_to( *args )
    end
    
  end
end