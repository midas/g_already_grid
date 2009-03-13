(function($){
		  
jQuery.fn.alreadyGrid = function( /* Object literal */ options )
{
  opts = $j.extend( $j.fn.alreadyGrid.defaults, options );
  
  // Set up check box events
  checkAllBox = $j( '.' + opts.check_all_class );
  checkboxes = $j( '.' + opts.checkbox_class );
  $j( 'document' ).ready( updateSelecteds );
  checkAllBox.click( checkAllClicked );
  checkboxes.click( checkboxClicked );
  
  return jQuery;
}
  
/* *************** public *************** */

jQuery.fn.alreadyGrid.defaults = 
{ 
  paginate: true,
  checkboxes: false,
  checkbox_class: 'chk',
  check_all_class: 'checkAll'
}; 

/* *************** private *************** */

checkAllClicked = function( /* jquery Event */ e )
{
  if( $j( this ).is(':checked') )
  {
    //$j( '.' + opts.checkbox_class ).click();
    checkboxes.attr( 'checked', true );
    checkboxes.parent().parent().addClass( 'selected' );
  }
  else
  {
    checkboxes.attr( 'checked', false );
    checkboxes.parent().parent().removeClass( 'selected' );
  }
};

checkboxClicked = function( /* jquery Event */ e )
{
  if( $j( this ).is(':checked') )
    $j( this ).parent().parent().addClass( 'selected' );
  else
  {
    $j( this ).parent().parent().removeClass( 'selected' );
    if( checkAllBox.is(':checked') )
    {
      checkAllBox.attr( 'checked', false );  
    }      
  }
};

/* Used after load to update selected based on check boxes when the 
 * grid loads. */
updateSelecteds = function( /* jquery Event */ e )
{
  var checkboxes = $j( "." + opts.checkbox_class + "[checked]");
  checkboxes.parent().parent().addClass( 'selected' );
};

})(jQuery);