xx = function(){
    #病人编号,subject
    tt = patient_chartevents[[2]][i]
    #找到event中的位置
    location = which(events[[1]] == tt)[1]
    #itemid编号,和value的数值
    zz = patient_chartevents[[3]][i]
    zz_value = patient_chartevents[[4]][i]
    #赋值给最终的表
    switch(
      zz,
      #温度
      "676"=,"677"=,
      "223762" = ifelse(zz_value>38 && zz_value<36 , setevents(2),NA),
      
      #心率
      "3494"=,
      "211"=,
      "220045"= ifelse(zz_value>90 ,setevents(3),NA),
      
      #呼吸频率
      "220210" =,
      "6749" =,
      "618" =,
      "7884"= ifelse(zz_value>20 ,setevents(4),NA),
      #二氧化碳分压,毫米汞柱
      "4201" =,
      "778" =,
      "3784" =,"3835"=,"3836"=,
      "227036"=,"220235" = ifelse(zz_value<32,setevents(4),NA),
      
      #白细胞数目
      "227063"=,"227062"=,"220546"=,"226780"=,
      "4200"=, "1542"=, "861"=, "1127" = ifelse(zz_value>14 && zz_value<4,setevents(5),NA)
    )
}


  
src='Rcpp::NumericVector vec(vx);
   double p = Rcpp::as<double>(dd);
   double sum = 0.0;
   for (int i=0; i<vec.size(); i++) {
   sum += pow(vec[i], p);
   }
   return Rcpp::wrap(sum);'
fun <- cxxfunction(signature(vx="numeric", dd="numeric"), src, plugin="Rcpp")

fun(1:4,2)

src='Rcpp::NumericVector vec(vx);
   double p = Rcpp::as<double>(dd);
   double sum = 0.0;
   for (int i=0; i<vec.size(); i++) {
   sum += pow(vec[i], p);
   }
   return Rcpp::wrap(p);'

src <- '
  Rcpp::NumericVector invec(vx);
  Rcpp::NumericVector outvec = Rcpp::clone(vx);
  for (int i=0; i<invec.size(); i++) {
  outvec[i] = log(invec[i]);
  }
  return outvec;
  '
fun <- cxxfunction(signature(vx="numeric"), src, plugin="Rcpp")  
x <- seq(1.0, 3.0, by=1)

cbind(x, fun(x))

src = 'Rcpp::NumericVector invec(vx);
	    Rcpp::NumericVector outvec = log(invec);
		return outvec;
		'
 fun <- cxxfunction(signature(vx="numeric"),src, plugin="Rcpp")
 
 x = seq(1,3)
 fun(x)
 
src <- '
 Rcpp::NumericMatrix mat = Rcpp::clone<Rcpp::NumericMatrix>(mx);
 std::transform(mat.begin(), mat.end(), mat.begin(), ::sqrt);
 return mat;
 '
 fun <- cxxfunction(signature(mx="numeric"), src, plugin="Rcpp")
 orig <- matrix(1:9, 3, 3)
 fun(orig)
 
fun <- cxxfunction(signature(), plugin="Rcpp",
 body='
 Rcpp::LogicalVector v(6);
 v[0] = v[1] = false;
 v[1] = true;
 v[3] = R_NaN;
 v[4] = R_PosInf;
 v[5] = NA_REAL;
 return v;
 ')
 
 
 fun <- cxxfunction(signature(), plugin="Rcpp",
 body='
 Rcpp::CharacterVector v(3);
 v[0] = "The quick brown";
 v[1] = "fox";
 v[2] = R_NaString;
 return v;
 ')
 
src <- '
 Rcpp::IntegerVector v =Rcpp::IntegerVector::create(7,8,9);
 std::vector<std::string> s(3);
 
 s[0] = "x";
 s[1] = "y";
 s[2] = "z";
 
 return Rcpp::DataFrame::create(Rcpp::Named("a")=v,Rcpp::Named("b")=s);
 '
 src <- '
 Function sort(x) ;
 return sort( y, Named("decreasing", true));
 '
 fun <- cxxfunction(signature(x="function", y="ANY"), src, plugin="Rcpp")

 ##4.5
 src <- '
 RNGScope scp;
 Rcpp::Function rt("rt");
 return rt(5, 3);
 '
 fun <- cxxfunction(signature(), src, plugin="Rcpp")
 set.seed(42)
fun()

f1 <- cxxfunction(signature(x="any"), plugin="Rcpp", body='
 RObject y(x) ;
 List res(3) ;
 res[0] = y.isS4();
 res[1] = y.hasSlot("z");
 res[2] = y.slot("z");
 return res;
')

f2 <- cxxfunction(signature(x="any"), plugin="Rcpp", body='
 S4 foo(x);
 foo.slot(".Data") = "foooo";
 return foo;
 '
)


src = '
 Rcpp::IntegerVector v =Rcpp::IntegerVector::create(7,8,9);
 std::vector<std::string> s(3);
  
 s[0] = "x";
 s[1] = "y";
 s[2] = "z";
 
 return Rcpp::DataFrame::create(Rcpp::Named("a")=v,Rcpp::Named("b")=s);
 '
fun <- cxxfunction(signature(vx="numeric"), src, plugin="Rcpp")  
x <- seq(1.0, 3.0, by=1)

src <- '
 Rcpp::IntegerVector vec(vx);
 Rcpp::DataFrame     DF =Rcpp::clone<Rcpp::DataFrame>(vc);
 DF[1][2] = 9;
 
 return DF ;
'
a = data.frame(matrix(1:9,3))

 fun <- cxxfunction(signature(vx="integer",vc="dataframe"), src, plugin="Rcpp")
 fun(1:10) # creates integer vector

for(i in 1:trials){
  #病人编号,subject
  tt = patient_chartevents[[2]][i]
  #找到event中的位置
  location = which(events[[1]] == tt)[1]
  #itemid编号,和value的数值
  zz = patient_chartevents[[3]][i]
  zz_value = patient_chartevents[[4]][i]
  #赋值给最终的表
  switch(
    zz,
    #温度
    "676"=,"677"=,
    "223762" = ifelse(zz_value>38 && zz_value<36 , setevents(2),NA),
    
    #心率
    "3494"=,
    "211"=,
    "220045"= ifelse(zz_value>90 ,setevents(3),NA),
    
    #呼吸频率
    "220210" =,
    "6749" =,
    "618" =,
    "7884"= ifelse(zz_value>20 ,setevents(4),NA),
    #二氧化碳分压,毫米汞柱
    "4201" =,
    "778" =,
    "3784" =,"3835"=,"3836"=,
    "227036"=,"220235" = ifelse(zz_value<32,setevents(4),NA),
    
    #白细胞数目
    "227063"=,"227062"=,"220546"=,"226780"=,
    "4200"=, "1542"=, "861"=, "1127" = ifelse(zz_value>14 && zz_value<4,setevents(5),NA)
  )
}
 

 




