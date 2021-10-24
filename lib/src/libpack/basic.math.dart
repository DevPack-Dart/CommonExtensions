//Log for All Radixes
double flog(num x, [num? ladix]) {
  if (ladix == null) {
    return log(x);
  } else {
    return log(x) / log(ladix);
  }
}

//Common Log
double clog(num x) {
  return flog(x, 10);
}