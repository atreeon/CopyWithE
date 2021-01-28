import 'package:test/test.dart';

//IF MY ABSTRACT CLASS HAS A COMPLICATED GENERIC TYPE
//  WE ALLOW CREATION PARAMS FOR ONLY THOSE IN THE BASE TYPE
//UNFORTUNATELY WHEN YOU SET THE LIST OF PETS THEN YOU NEED
//TO CHECK THE TYPE AND CAST SPECIFICALLY FOR EACH TYPE
//if (petOwner is DogOwner)
//  return petOwner.pets.map<Dog>((x) => x.cwPet(isAlive: false)).toList();

main() {
  test("1", () {
    var dogOwner = DogOwner(
      id: 5,
      pets: <Dog>[Dog(isAlive: true, woofType: "hoowwwl")],
      name: "Doggy Dave",
    );

    var catOwner = CatOwner(
      id: "X5O7",
      pets: <Cat>[Cat(isAlive: true, whiskers: "mwrrow")],
      name: "Catty Carol",
    );

    var petOwners = <PetOwnerBase>[dogOwner, catOwner];

    var result = petOwners
        .map(
          (petOwner) => petOwner.cwPetOwnerBase(
            name: "Bad " + petOwner.name,
            pets: () {
              if (petOwner is DogOwner) //
                return petOwner.pets
                    .map<Dog>((x) => x.cwPet(isAlive: false) as Dog)
                    .toList();

              if (petOwner is CatOwner) //
                return petOwner.pets
                    .map<Cat>((x) => x.cwPet(isAlive: false) as Cat)
                    .toList();

              throw Exception("unexpected owner");
            }(),
          ),
        )
        .toList();

    expect(result[0].name, "Bad Doggy Dave");
    expect(result[0].pets[0].isAlive, false);
    expect(result[1].name, "Bad Catty Carol");
    expect(result[1].pets[0].isAlive, false);
  });
}

abstract class PetOwnerBase<TPet extends Pet, T> {
  T get id;
  String get name;
  List<TPet> get pets;
}

class DogOwner implements PetOwnerBase<Dog, int> {
  final int id;
  final List<Dog> pets;
  final String name;
  final String? dogStuff;

  DogOwner(
      {required this.id,
      required this.pets,
      required this.name,
      this.dogStuff});
}

class CatOwner implements PetOwnerBase<Cat, String> {
  final String id;
  final List<Cat> pets;
  final String name;
  final String? catStuff;

  CatOwner(
      {required this.id,
      required this.pets,
      required this.name,
      this.catStuff});
}

abstract class Pet {
  bool get isAlive;
}

class Dog extends Pet {
  final bool isAlive;
  final String woofType;

  Dog({required this.isAlive, required this.woofType});
}

class Cat extends Pet {
  final bool isAlive;
  final String whiskers;

  Cat({required this.isAlive, required this.whiskers});
}

//cwPetOwnerBase takes in a list of pets
//and then I am trying to set it to a list of Dogs
//I can set dogs to pets but not pets to dogs

extension PetOwnerBaseExt_CopyWithE on PetOwnerBase {
  PetOwnerBase cwPetOwnerBase({String? name, List<Pet>? pets}) {
    switch (this.runtimeType) {
      case DogOwner:
        //why are we not breaking in the correct place?
        return DogOwner(
          id: id == null ? this.id : id,
          pets: pets == null //
              ? this.pets as List<Dog>
              : pets as List<Dog>,
          name: name == null //
              ? this.name
              : name,
          dogStuff: (this as DogOwner).dogStuff,
        );
      case CatOwner:
        return CatOwner(
          id: id == null ? this.id : id,
          pets: pets == null //
              ? this.pets as List<Cat>
              : pets as List<Cat>,
          name: name == null //
              ? this.name
              : name,
          catStuff: (this as CatOwner).catStuff,
        );
      default:
        throw Exception();
    }
  }
}

//RULES: 1 all subtypes must be in same file or be passed in. 2 the types passed in must all be classes
//no generics
extension PetExt_CopyWithE on Pet {
  Pet cwPet({bool? isAlive}) {
    switch (this.runtimeType) {
      case Dog:
        return Dog(
          isAlive: isAlive == null //
              ? this.isAlive
              : isAlive,
          woofType: (this as Dog).woofType,
        );
      case Cat:
        return Cat(
          isAlive: isAlive == null //
              ? this.isAlive
              : isAlive,
          whiskers: (this as Cat).whiskers,
        );
      default:
        throw Exception();
    }
  }
}
