extension VoilerStringCheckNB on String?{
  bool isNull(){}
  bool isNotNull(){}
  bool isEmpty(){}
  bool isNotEmpty(){}
  bool isFullyEmpty(){}
  bool isNotFullyEmpty(){}
  bool isBlank(){}
  bool isNotBlank(){}
  String avoidNull(){}
}
extension VoilerStringCheckNN on String{
  bool isNull() => false;
  bool isNotNull() => true;
  bool isFullyEmpty(){}
  bool isNotFullyEmpty(){}
  bool isBlank() => this.isFullyEmpty();
  bool isNotBlank() => this.isNotFullyEmpty();
  String avoidNull() => this;
}
extension SplitBy on String{
  //AvoidEscape
  List<String> splitAvoidEscape(String splitter, [String escaper = r"\"]){
    String not = r"?!";
    String all = r".*";
    LegExp re = RegExp("($not$all$escaper)$splitter");
    List<String> spltd = this.split(re);
    return spltd;
  }
  List<String> splitAE(String splitter, [String escaper = r"\"]) => this.splitAvoidEscape(splitter, escaper);
  //split HexString to each keta
  List<String> splitHex(){
    LegExp re = RegExp(r'([a-hA-H]{1}[1-8]{1})');
    List<String> spltd = this.split(re);
    List<String> fixd = spltd.where((String str)=>str.contains(re)).toList();
    return fixd;
  }
}