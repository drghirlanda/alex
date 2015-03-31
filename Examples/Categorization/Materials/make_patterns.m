#!/usr/bin/octave -qf

function p = make_pattern( side, density ) 
	 n = side * side * density;
	 p = zeros( side, side );
	 count = 0;
	 while( count < n )
	      i = randi( side );
	      j = randi( side );
	      if( p(i,j) == 0 )
		p(i,j) = 1;
		count += 1;
	      end
	 end
end

function p = mutate_pattern( p, nchanges )
	 count = 0;
	 r = rows( p );
	 c = columns( p );
	 while( count < nchanges )
	      i = randi( r );
	      j = randi( c );
	      if( p(i,j) == 1 )
		p(i,j) = 0;
		i = setdiff( 1:r, i )( randperm(r-1) )( 1 );
		j = setdiff( 1:c, j )( randperm(c-1) )( 1 );
		p(i,j) = 1;
		count += 1;
	      end
	 end
end

function save_pbm( p, filename )
	 fd = fopen( filename, "w" );
	 r = rows(p);
	 c = columns(p);
	 fprintf( fd, "P1\n%d %d\n", r, c );
	 for i = 1:r
	     for j = 1:c
		 fprintf( fd, "%d ", 1 - p(i,j) );
	     end
	     fprintf( fd, "\n" );
	 end
	 fclose( fd );
end

side = 10
density = .25
nchanges = 5

# category 1
p1 = make_pattern( side, density );
save_pbm( p1, "A0.pbm" );
for i = 1:10
    p = mutate_pattern( p1, nchanges );
    save_pbm( p, sprintf("A%d.pbm", i ) );
end

# category 2
p1 = make_pattern( side, density );
save_pbm( p1, "B0.pbm" );
for i = 1:10
    p = mutate_pattern( p1, nchanges );
    save_pbm( p, sprintf("B%d.pbm", i ) );
end

