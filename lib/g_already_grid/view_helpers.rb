module GAlreadyGrid
  module ViewHelpers
    
    # GUIlded element.  This is a grid that is utilizing the already grid jQuery plugin.  It is
    # a progressively enhanced table.
    # 
    # *parameters*
    # ar_col:: (required) An ActiveRecord collection.
    # options:: As follows.
    # 
    # *options*
    # id:: (required) The id of the element.  Must be unique on the page.
    # cols:: (required) An array of column names to include in the table.  Each position of
    #   the array can be a symbol, string, or hash with 1 entry.  The hash entry is the
    #   database field name as a key and the name to use in the gird as the value.  Each
    #   key and value in the hash can be a symbol or string.
    # skin:: The name of the skin to use for this Guilded element.  Defaults to default => which is default.css.
    # exclude_css:: A boolean indicating if Guilded should create a stylesheet inlcude tag for 
    #   this element.  Defaults to false.
    # actions:: Action links to include in the action column of grid.  A boolean or Array of symbols.  When 
    #   boolean, if true, add show, edit and delete actions.  When boolean, if false, hide actions column.  
    #   When Array of symbols, add only actions present in array.
    # paginate:: A boolean indicating whether to output pagination controls.  Defaults to 
    #   true.  Utilizes will_paginate plugin features.
    # polymorphic_type:: The type of this polymorphic record.  Should be a string representing the class name.
    # polymorphic_as:: The as used for the polymorphic type.  Can be a symbol or string.
    #
    def g_already_grid( ar_col, *args )
      options = args.extract_options!
      raise ArgumentError, "'cols' option required" unless options.include?( :cols )
      raise ArgumentError, "'cols' option must be an array of columns" unless options[:cols].is_a? Array

      Guilded::Guilder.instance.add( :already_grid, options, [ 'jquery/jquery-already_grid-0.1.min.js' ] )

      plural_ar_type = ar_col[0].class.to_s.tableize
      singular_ar_type = plural_ar_type.singularize
      polymorphic_as = options[:polymorphic_as]
      polymorphic_type = options[:polymorphic_type]
      plural_polymorphic_type = polymorphic_type.to_s.tableize if polymorphic_type
      singular_polymorphic_type = plural_polymorphic_type.singularize if polymorphic_type
      options[:checkbox_class] = "chk"
      options[:check_all_class] = "checkAll"
      date_format = options[:date_format] || :default
      scoped_by = options.delete( :scoped_by )
      shallow = options.delete( :shallow ) || false
      
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
      
      # Set up the options booleans we need to decide on output HTML
      no_actions = !(options[:actions] == true || options[:actions] == 'true')
      no_actions ||= true
      
      if no_actions
        options[:actions] = [ :show ]
      elsif !options[:actions].is_a?( Array )
        options[:actions] = [ :show, :edit, :delete ]
      end
      
      controller_name_parts = @controller.class.to_s.underscore.split( '/' )
      controller_name_parts.pop
      pre = controller_name_parts.join( '_' )
      
      unless ar_col.empty?
        if options.has_key?( :index_path_helper )
          index_rest_method = options[:index_path_helper].to_s
        elsif scoped_by
          if pre.empty?
            index_rest_method = "#{scoped_by.class.to_s.underscore}_#{plural_ar_type}_path" if ar_col.size > 0
          else
            index_rest_method = "#{pre}_#{scoped_by.class.to_s.underscore}_#{plural_ar_type}_path" if ar_col.size > 0
          end
        elsif pre.empty?
          index_rest_method = "#{plural_ar_type}_path" if ar_col.size > 0
          index_rest_method.gsub!( /#{plural_ar_type}/, "#{plural_polymorphic_type}") if plural_polymorphic_type
        else
          index_rest_method = "#{pre}_#{plural_ar_type}_path" if ar_col.size > 0
          index_rest_method.gsub!( /#{plural_ar_type}/, "#{plural_polymorphic_type}") if plural_polymorphic_type
        end
        
        if options.has_key?( :show_path_helper )
          show_rest_method = options[:show_path_helper].to_s
        elsif scoped_by && !shallow
          if pre.empty?
            show_rest_method = "#{scoped_by.class.to_s.underscore}_#{singular_ar_type}_path" if ar_col.size > 0
          else
            show_rest_method = "#{pre}_#{scoped_by.class.to_s.underscore}_#{singular_ar_type }_path" if ar_col.size > 0
          end
        elsif pre.empty?
          show_rest_method = "#{singular_ar_type}_path" if ar_col.size > 0
          show_rest_method.gsub!( /#{singular_ar_type}/, "#{singular_polymorphic_type}") if singular_polymorphic_type
        else
          show_rest_method = "#{pre}_#{singular_ar_type}_path" if ar_col.size > 0
          show_rest_method.gsub!( /#{singular_ar_type}/, "#{singular_polymorphic_type}") if singular_polymorphic_type
        end

        unless no_actions
          # Build the name of the REST path helper methods   
          if options.has_key?( :edit_path_helper )
            edit_rest_method = options[:edit_path_helper].to_s
          elsif scoped_by && !shallow
            if pre.empty?
              edit_rest_method = "edit_#{scoped_by.class.to_s.underscore}_#{singular_ar_type}_path" if ar_col.size > 0
            else
              edit_rest_method = "edit_#{pre}_#{scoped_by.class.to_s.underscore}_#{singular_ar_type }_path" if ar_col.size > 0
            end       
          elsif pre.empty?
            edit_rest_method = "edit_#{singular_ar_type}_path" if ar_col.size > 0
          else
            edit_rest_method = "edit_#{pre}_#{singular_ar_type}_path" if ar_col.size > 0
          end

          if options.has_key?( :delete_path_helper )
            delete_rest_method = options[:delete_path_helper].to_s   
          elsif pre.empty?
            delete_rest_method = "#{singular_ar_type}_path" if ar_col.size > 0
          else
            delete_rest_method = "#{pre}_#{singular_ar_type}_path" if ar_col.size > 0
          end
        end
      end
      
      cols, col_titles = Guilded::Rails::Helpers.resolve_field_methods_and_titles( options[:cols], ar_col[0] )

      do_paginate = true
      begin
        if options[:paginate] == false || options[:paginate] == 'false' #ar_col.total_pages <= 1
          do_paginate = false
        end
      rescue => e
        if e.is_a? NoMethodError # This just means no will_paginate methods are present.
          do_paginate = false
        else
          throw e
        end
      end

      do_checkboxes = true
      do_checkboxes = false if options[:checkboxes] == false || options[:checkboxes] == 'false'
      options[:checkboxes] = do_checkboxes unless options[:checkboxes]
      
      total_columns = cols.size
      total_columns = total_columns + 1 if do_checkboxes
      total_columns = total_columns + 1 unless no_actions
      options[:total_columns] = total_columns
      
      vars = { 
        :no_actions => no_actions, :actions => options[:actions], :do_checkboxes => do_checkboxes,
        :total_columns => total_columns, :del_confirmation => 'Are you sure you would like to delete this record?',
        :col_titles => col_titles, :cols => cols, :grid_class => 'already-grid', :checkbox_class => options[:checkbox_class],
        :check_all_class => options[:check_all_class], :grid_id => options[:id], :ar_col => ar_col, :do_paginate => do_paginate,
        :date_format => date_format, :polymorphic_type => polymorphic_type, :polymorphic_as => polymorphic_as,
        :sort_by => sort_by, :index_rest_method => index_rest_method, :shallow => shallow, :scoped_by => scoped_by
      }
      
      if ( !options[:actions].nil? && options[:actions].include?( :show ) ) || options[:actions].nil?
        vars.merge!( :show_rest_method => show_rest_method )
      else
        vars.merge!( :show_rest_method => nil )
      end
      if ( !options[:actions].nil? && options[:actions].include?( :edit ) ) || options[:actions].nil?
        vars.merge!( :edit_rest_method => edit_rest_method )
      else
        vars.merge!( :edit_rest_method => nil )
      end
      if ( !options[:actions].nil? && options[:actions].include?( :delete ) ) || options[:actions].nil?
        vars.merge!( :delete_rest_method => delete_rest_method )
      else
        vars.merge!( :delete_rest_method => nil )
      end

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
    # name:: The text to use for the link
    # method:: The actual name of this column's field.
    # path:: (Symbol) The name of the path method to call from routing.
    # options:: see link_to helper.
    #
    def sortable_header( name, method, path, options={} )

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
      
      if is_sorted_link
        # Handle the currently sorted by link
        path = @controller.send( path, sort_options )
      else
        # Handle the the other currently unsorted by links (we will always sort in 
        # an ASC direction the first time)
        path = @controller.send( path, unsorted_options )
      end
      #end

      # Load the params to an args array to send to the link_to helper
      args = Array.new
      args << name << path << options

      link_to( *args )

    end
    
  end
end