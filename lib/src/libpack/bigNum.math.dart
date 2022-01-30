//整除関係
extension Divisibility on int{
  //整除
  int divisibility(int byNum){
    if(this.isDivisible(byNum)){
      return (this / byNum).floor();
    }else{
      return (this - (this % byNum)).divisibility(byNum);
    }
  }
  //整除可能か
  bool isDivisible(int byNum){
    return (this % byNum == 0);
  }
}
extension BasicOnInt on int{
  //符号反転
  int get reverse => -this;
}
extension FracCalc on int{
  Frac operator +(Frac y)=>Frac(this,1) + y;
  Frac operator -(Frac y)=>Frac(this, 1) - y;
  Frac operator *(Frac y)=>Frac(this, 1) * y;
  Frac operator /(Frac y)=>Frac(this, 1) / y;
}
class IlligalBaseError extends Exception {
  IlligalBaseError(String message) : super(message);
}
class IlligalBaseSettledError extends IlligalBaseError {
  IlligalBaseSettledError() : super("基数が不正です");
}
class BasesIsNotSameError extends IlligalBaseError {
  BasesIsNotSameError() : super("基数が異なります");
}
enum BaseKind{
  binary,
  decimal,
}
class ExtNum{}
extension BigIntExt on BigInt{
  BigInt oparator ++(){
    return this + BigInt.one;
  }
  BigInt oparator --(){
    return this - BigInt.one;
  }
  BigDecimal 
}
class BigDecimal implements Comparable<BigDecimal>, ExtNum{
  //仮数部
  late BigInt _significand;
  //指数部
  late BigInt _exponent;
  //基数
  late BigInt _base;
  //コンストラクタ
  BigDecimal(BigInt significand, BigInt exponent, [BaseKind baseKind = BaseKind.decimal]){
    this._significand = significand;
    this._exponent = exponent;
    this._base = BigInt.from(baseKind == BaseKind.binary ? 2 : 10);
  }
  //コンストラクタ
  BigDecimal.from(int significand, int exponent, [BaseKind baseKind = BaseKind.decimal]){
    this._significand = BigInt.from(significand);
    this._exponent = BigInt.from(exponent);
    this._base = BigInt.from(baseKind == BaseKind.binary ? 2 : 10);
  }
  //コンストラクタ
  BigDecimal.fromBI(BigInt number){
    this._significand = number;
    this._exponent = BigInt.zero;
    this._base = BigInt.from(10);
  }
  int compareTo(BigDecimal other){
    if(this.base != other.base){
      throw BasesIsNotSameError();
    }else{
      if(this.exponent == other.exponent){
        return this.significand.compareTo(other.significand);
      }else{
        return this.exponent.compareTo(other.exponent);
      }
    }
  }
  BigInt get significand => this._significand;
  BigInt get exponent => this._exponent;
  BigInt get base => this._base;
  BigDecimal exponentChange(BigInt exponent){
    if(exponent > this.exponent){
      return BigDecimal(this.significand * this.base.pow(exponent - this.exponent), exponent, this.baseKind);
    }else{
      return BigDecimal(this.significand, this.exponent, this.baseKind);
    }
  }
  BigInt operator +(BigDecimal other){
    if(this.base != other.base){
      throw BasesIsNotSameError();
    }else{
      if(this.exponent == other.exponent){
        return BigDecimal(this.significand + other.significand, this.exponent);
      }else if(this.exponent > other.exponent){
        return BigDecimal(this.significand + other.exponentChange(this.exponent).significand, this.exponent, this.baseKind);
      }else{
        return BigDecimal(this.exponentChange(other.exponent).significand + other.significand, other.exponent, this.baseKind);
      }
    }
  }
  BigInt operator -(BigDecimal other){
    if(this.base != other.base){
      throw BasesIsNotSameError();
    }else{
      if(this.exponent == other.exponent){
        return BigDecimal(this.significand - other.significand, this.exponent);
      }else if(this.exponent > other.exponent){
        return BigDecimal(this.significand - other.exponentChange(this.exponent).significand, this.exponent, this.baseKind);
      }else{
        return BigDecimal(this.exponentChange(other.exponent).significand - other.significand, other.exponent, this.baseKind);
      }
    }
  }
  BigDecimal operator *(BigDecimal other){
    if(this.base != other.base){
      throw BasesIsNotSameError();
    }else{
      return BigDecimal(this.significand * other.significand, this.exponent + other.exponent, this.baseKind);
    }
  }
  BigDecimal operator /(BigDecimal other){
    if(this.base != other.base){
      throw BasesIsNotSameError();
    }else{
      return BigDecimal(this.significand * other.significand, this.exponent - other.exponent, this.baseKind);
    }
  }
  BigDecumal operator %(BigDecimal other){
    if(this.base != other.base){
      throw BasesIsNotSameError();
    }else{
      return BigDecimal(this.significand % other.significand, this.exponent - other.exponent, this.baseKind);
    }
  }
  BigDecimal operator ~/(BigDecimal other){
    if(this.base != other.base){
      throw BasesIsNotSameError();
    }else{
      return BigDecimal(this.significand ~/ other.significand, this.exponent - other.exponent, this.baseKind);
    }
  }
  BigDecimal operator -(){
    return BigDecimal(-this.significand, this.exponent, this.baseKind);
  }
  BaseKind get baseKind {
    if(this.base == BigInt.from(2)){
      return BaseKind.binary;
    }else if(this.base == BigInt.from(10)){
      return BaseKind.decimal;
    }else{
      throw IlligalBaseSettledError();
    }
  }
  BigDecimal abs(){
    return BigDecimal(this.significand.abs(), this.exponent, this.baseKind);
  }
  BigDecimal pow(BigDecimal? exponent){
    late BigDecimal exp;
    if(exponent == null){
      exp = BigDecimal.fromBI(BigInt.two);
    }else{
      exp = exponent;
    }
    return BigDecimal(this.significand.pow(exp.significand), this.exponent * exp.significand, this.baseKind);
  }
  BigDecimal sqrt(BigDecimal? precision){
    late BigDecimal prec;
    if(precision == null){
      prec = BigDecimal.fromBI(BigInt.two);
    }else{
      prec = precision;
    }
    return BigDecimal(this.significand.sqrt(prec.significand), this.exponent ~/ prec.significand, this.baseKind);
  }
  BigDecimal log(BigDecimal? precision){
    late BigDecimal prec;
    if(precision == null){
      prec = BigDecimal.fromBI(BigInt.two);
    }else{
      prec = precision;
    }
    return BigDecimal(this.significand.log(prec.significand), this.exponent ~/ prec.significand, this.baseKind);
  }

}
class Frac implements Comparable<Frac>, ExtNum{
  late BigInt _numer;
  late BigInt _denom;
  Frac(BigInt numer, BigInt denom){
    if(denom == 0){
      this._numer = 0;
      this._denom = -999;
      throw Exception("denominator is 0");
    }else if(numer == 0){
      this._numer = 0;
      this._denom = 1;
    }else{
      this._numer = numer;
      this._denom = denom;
    }
  }
int get numer => this._numer;
int get denom => this._denom;
  //約分
  Frac reduce(){
    int gcdNum = this._numer.gcd(this._denom);
    return this;
  }
  //通分
  Frac common(List<Frac> byFrac)=>[this,...byFrac].common()[0];
  //分母が0でないか
  Frac nonZeroCheck(){
    if(this._denom == 0){
      throw Exception("分母が0です");
    } else {
      return this;
    }
  }
  //整理：分母が0でないか確認する。その後分母が負の場合分母分子の符号をそれぞれ反転させる。さらに約分する。
  Frac regulate(){
    Frac nonZeroCheck = this.nonZeroCheck();
    if(nonZeroCheck._denom < 0){
      nonZeroCheck._numer = nonZeroCheck._numer.reverse;
      nonZeroCheck._denom = nonZeroCheck._denom.reverse;
    }
    return nonZeroCheck.reduce();
  }
  Frac operator +(Frac y){
    List<Frac> byFrac = [this, y];
    List<Frac> common = byFrac.common();
    return Frac(common[0]._numer + common[1]._numer, common[0]._denom).regulate();
  }
  Frac operator -(){
    this._numer.reverse;
    return this;
  }
  //逆数
  Frac operator ~(){
    return Frac(this._denom, this._numer).regulate();
  }
  Frac operator -(Frac y){
    return (this + (-y)).regulate();
  }
  Frac operator *(Frac y){
    return Frac(this._numer * y._numer, this._denom * y._denom).regulate();
  }
  Frac operator /(Frac y) => (this * (~y)).regulate();
  @override
  bool operator ==(Object other){
    if(other is Frac){
      return (this._numer == other._numer) && (this._denom == other._denom);
    }else{
      return false;
    }
  }
  bool operator <(Frac y){
    return (this._numer * y._denom) < (y._numer * this._denom);
  }
  bool operator >(Frac y){
    return (this._numer * y._denom) > (y._numer * this._denom);
  }
  bool operator <=(Frac y){
    return (this._numer * y._denom) <= (y._numer * this._denom);
  }
  bool operator >=(Frac y){
    return (this._numer * y._denom) >= (y._numer * this._denom);
  }
  @override
  String toString(){
    if(this._denom==1){
      return this._numer.toString();
    }else{
      return "${this._numer}/${this._denom}";
    }
  }
}
extension ListOfFrac on List<Frac>{
  //通分
  List<Frac> common(){
    List<int> commonDenom = this.map((Frac e)=>e.denom).toList();
    int commonDenomNum = commonDenom.reduce((a,b)=>a.lcm(b));
    List<Frac> commonFrac = this.map((Frac e)=>Frac((e.numer * commonDenomNum / e.denom).floor(), commonDenomNum)).toList();
    return commonFrac;
  }
}