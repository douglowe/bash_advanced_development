$1 < m || NR == 1 { m = $1 } 
END { print m }