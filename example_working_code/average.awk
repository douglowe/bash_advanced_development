NR == 1 { m = $1 ; n = 1 } 
NR > 1 { m += $1 ; n++ } 
END { print n ; print m/n }
