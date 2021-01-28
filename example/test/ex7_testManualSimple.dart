//main() {
//  var dogOwner = DogOwner(
//    id: 5,
//    pets: <Dog>[Dog(isAlive: true, woofType: "hoowwwl")],
//    name: "Doggy Dave",
//  );
//
//  var petOwners = <PetOwnerBase>[dogOwner];
//
//  petOwners.map(
//    (petOwner) {
//      if (petOwner is DogOwner) //
//        return petOwner.pets.map<Dog>((x) => formatPet(x) as Dog).toList();
//
//      throw Exception("unexpected owner");
//    },
//  ).toString();
//}
//
//Pet formatPet(Pet pet) {
//  switch (pet.runtimeType) {
//    case Dog:
//      return (pet as Dog);
//    default:
//      throw Exception();
//  }
//}
//
//abstract class PetOwnerBase<TPet extends Pet, T> {
//  T get id;
//  String get name;
//  List<TPet> get pets;
//}
//
//class DogOwner implements PetOwnerBase<Dog, int> {
//  final int id;
//  final List<Dog> pets;
//  final String name;
//  final String? dogStuff;
//
//  DogOwner(
//      {required this.id,
//      required this.pets,
//      required this.name,
//      this.dogStuff});
//}
//
//abstract class Pet {
//  bool get isAlive;
//}
//
//class Dog extends Pet {
//  final bool isAlive;
//  final String woofType;
//
//  Dog({required this.isAlive, required this.woofType});
//}
