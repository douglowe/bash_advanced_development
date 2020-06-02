NR == 1 { m = $1 } 
NR > 1 { m += $1 } 
END { printf( "%f\n", m ) }
