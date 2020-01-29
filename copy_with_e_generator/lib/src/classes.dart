class NameType {
  final String type;
  final String name;

  NameType(this.name, this.type);
}

class ClassDef {
  final bool isAbstract;
  final String name;
  final List<NameType> fields;

  ClassDef(this.isAbstract, this.name, this.fields);
}
