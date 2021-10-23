
class Pair<T, U> {
  late T _first;
  late U _second;
  Pair(T first, U second) {
    this._first = first;
    this._second = second;
  }
  T get first => _first;
  U get second => _second;
}
class BijectiveFiniteSets<D, C>{
  Set<D> _domain = <D>{};
  Set<C> _codomain = <C>{};
  Map<D, C> _surjection = <D, C>{};
  Map<C, D> _injection = <C, D>{};
  BijectiveFiniteSets();
  BijectiveFiniteSets(Iterable<Pair<D, C>> pairs) {
    BijectiveFiniteSets temp = BijectiveFiniteSets();
    temp.addAll(pairs);
    this._domain = temp.domain;
    this._codomain = temp.codomain;
    this._surjection = temp.surjection;
    this._injection = temp.injection;
  }
  void add(D d, C c){
    if(this._domain.contains(d)){
      throw Exception("$d already in domain");
    }
    if(this._codomain.contains(c)){
      throw Exception("$c already in codomain");
    }
    if(this._surjection.containsKey(d)){
      throw Exception("$d already in surjection");
    }
    if(this._injection.containsKey(c)){
      throw Exception("$c already in injection");
    }
    this._domain.add(d);
    this._codomain.add(c);
    this._surjection[d] = c;
    this._injection[c] = d;
  }
  void addAll(Iterable<Pair<D, C>> pairs){
    List<int> intSeq = List<int>.generate(pairs.length, (int i) => i);
    intSeq.forEach((int i){
      this.add(pairs.elementAt(i).first, pairs.elementAt(i).second);
    });
  }
  Set<D> get domain => this._domain;
  Set<C> get codomain => this._codomain;
  Map<D, C> get surjection => this._surjection;
  Map<C, D> get injection => this._injection;
}