src = ' Rcpp::IntegerVector epn(4);
epn[0] = 6;
epn[1] = 14;
epn[2] = 496;
epn[3] = 8182;
return epn;'

fun <- cxxfunction(signature(), src, plugin="Rcpp")
fun()

src <- 'Rcpp::IntegerVector vec(vx);
 int prod = 1;
 for (int i=0; i<vec.size(); i++) {
   prod *= vec[i];
  }
 return Rcpp::wrap(prod);'

 fun <- cxxfunction(signature(vx="integer"), src, plugin="Rcpp")
 fun(1:10) # creates integer vector