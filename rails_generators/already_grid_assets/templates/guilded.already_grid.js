/* Guilded Already 1.0.0
 * Copyright (c) 2009 C. Jason Harrelson (midas)
 * Guilded Flash Growler is licensed under the terms of the MIT License */

g.alreadyGridInit = function( options )
{
	if( g.beforeAlreadyGridInit )
		g.beforeAlreadyGridInit( options );
		
  var grid = $j( '#' + options.id );
  grid.alreadyGrid( options );

	if( g.afterAlreadyGridInit )
		g.afterAlreadyGridInit( options );
};