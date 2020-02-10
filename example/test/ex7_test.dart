import 'package:copy_with_e_annotation/CopyWithE.dart';
import 'package:test/test.dart';

part 'ex7_test.g.dart';
//
//IF MY ABSTRACT CLASS HAS A COMPLICATED GENERIC TYPE
//  WE ALLOW CREATION PARAMS FOR ONLY THOSE IN THE BASE TYPE

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

    //Kill all the pets!!!
    var result = petOwners
        .map(
          (petOwner) => petOwner.cwPetOwnerBase(
            name: "Bad " + petOwner.name,
            pets: () {
              if (petOwner is DogOwner) //
                return petOwner.pets.map<Dog>((x) => x.cwPet(isAlive: false)).toList();

              if (petOwner is CatOwner) //
                return petOwner.pets.map<Cat>((x) => x.cwPet(isAlive: false)).toList();

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

@CopyWithE()
abstract class PetOwnerBase<TPet extends Pet, T> {
  T get id;
  String get name;
  List<TPet> get pets;
}

class DogOwner implements PetOwnerBase<Dog, int> {
  final int id;
  final List<Dog> pets;
  final String name;
  final String dogStuff;

  DogOwner({this.id, this.pets, this.name, this.dogStuff});
}

class CatOwner implements PetOwnerBase<Cat, String> {
  final String id;
  final List<Cat> pets;
  final String name;
  final String catStuff;

  CatOwner({this.id, this.pets, this.name, this.catStuff});
}

@CopyWithE()
abstract class Pet {
  bool get isAlive;
}

class Dog extends Pet {
  final bool isAlive;
  final String woofType;

  Dog({this.isAlive, this.woofType});
}

class Cat extends Pet {
  final bool isAlive;
  final String whiskers;

  Cat({this.isAlive, this.whiskers});
}
