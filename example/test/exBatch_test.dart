import 'package:copy_with_e_annotation/CopyWithE.dart';
import 'package:meta/meta.dart';

part 'exBatch_test.g.dart';

//if I want to change this, get the copyWith to work with my supertypes, then I must
//  rerun this code gen and patch things up manually

//********************Lectures*****************
@CopyWithE([BatchItemLecture, BatchItem_PairsWords0])
abstract class BatchItem {
  List<int> get lectureIds;
  bool get isComplete;
  int get orderId;
  const BatchItem();
}

//5 points: abstract all classes | implements not extends | empty constant constructor | functions not included in copywith | fields should be getters
abstract class BatchItem_Test implements BatchItem {
  int get attempts;
  int get incorrectCount;
  List<int> get lectureIds;
  int get orderId;
  const BatchItem_Test();
}

//5 points: abstract all classes | implements not extends | empty constant constructor | functions not included in copywith | fields should be getters
abstract class HasOptions {
  const HasOptions();
}

//5 points: abstract all classes | implements not extends | empty constant constructor | functions not included in copywith | fields should be getters
abstract class HasPrincipal {
  int get principalId;
  const HasPrincipal();
}

//5 points: abstract all classes | implements not extends | empty constant constructor | functions not included in copywith | fields should be getters
abstract class IsRandom {
  const IsRandom();
}

//5 points: abstract all classes | implements not extends | empty constant constructor | functions not included in copywith | fields should be getters
abstract class BatchItem_Multi implements BatchItem_Test, HasOptions, HasPrincipal, IsRandom {
  int get attempts;
  int get incorrectCount;
  List<int> get lectureIds;
  int get orderId;
  int get principalId;
  const BatchItem_Multi();
}

//5 points: abstract all classes | implements not extends | empty constant constructor | functions not included in copywith | fields should be getters
abstract class BatchItem_Pairs implements BatchItem_Test, HasOptions, IsRandom {
  int get attempts;
  int get incorrectCount;
  List<int> get lectureIds;
  int get orderId;
  const BatchItem_Pairs();
}

//5 points: abstract all classes | implements not extends | empty constant constructor | functions not included in copywith | fields should be getters
abstract class BatchItem_Single implements BatchItem_Test {
  int get attempts;
  int get incorrectCount;
  List<int> get lectureIds;
  int get orderId;
  int get score;
  const BatchItem_Single();
}

//5 points: abstract all classes | implements not extends | empty constant constructor | functions not included in copywith | fields should be getters
abstract class Lecture {
  const Lecture();
}

//5 points: abstract all classes | implements not extends | empty constant constructor | functions not included in copywith | fields should be getters
class BatchItemLecture implements BatchItem, Lecture {
  final bool isComplete;
  final List<int> lectureIds;
  final int orderId;
  const BatchItemLecture({
    @required this.isComplete,
    @required this.lectureIds,
    @required this.orderId,
  });
}

class BatchItemLectureWithType implements BatchItemLecture {
  final bool isComplete;
  final List<int> lectureIds;
  final int lectureType;
  final int orderId;

  const BatchItemLectureWithType({
    @required this.isComplete,
    @required this.lectureIds,
    @required this.lectureType,
    @required this.orderId,
  });
}

//5 points: abstract all classes | implements not extends | empty constant constructor | functions not included in copywith | fields should be getters
class BatchItem_PairsWords0 implements BatchItem_Pairs {
  final int attempts;
  final bool isComplete;
  final int incorrectCount;
  final List<int> lectureIds;
  final int orderId;
  const BatchItem_PairsWords0({
    @required this.attempts,
    @required this.isComplete,
    @required this.incorrectCount,
    @required this.lectureIds,
    @required this.orderId,
  });
}

//5 points: abstract all classes | implements not extends | empty constant constructor | functions not included in copywith | fields should be getters
class BatchItem_PairsFlash1 implements BatchItem_Pairs {
  final int attempts;
  final bool isComplete;
  final int incorrectCount;
  final List<int> lectureIds;
  final int orderId;
  const BatchItem_PairsFlash1({
    @required this.attempts,
    @required this.isComplete,
    @required this.incorrectCount,
    @required this.lectureIds,
    @required this.orderId,
  });
}

//5 points: abstract all classes | implements not extends | empty constant constructor | functions not included in copywith | fields should be getters
class BatchItem_MultiQFgnaudioAEng2 implements BatchItem_Multi {
  final int attempts;
  final bool isComplete;
  final int incorrectCount;
  final List<int> lectureIds;
  final int orderId;
  final int principalId;
  const BatchItem_MultiQFgnaudioAEng2({
    @required this.attempts,
    @required this.isComplete,
    @required this.incorrectCount,
    @required this.lectureIds,
    @required this.orderId,
    @required this.principalId,
  });
}

//5 points: abstract all classes | implements not extends | empty constant constructor | functions not included in copywith | fields should be getters
class BatchItem_MultiQFgnaudioAFgn3 implements BatchItem_Multi {
  final int attempts;
  final bool isComplete;
  final int incorrectCount;
  final List<int> lectureIds;
  final int orderId;
  final int principalId;
  const BatchItem_MultiQFgnaudioAFgn3({
    @required this.attempts,
    @required this.isComplete,
    @required this.incorrectCount,
    @required this.lectureIds,
    @required this.orderId,
    @required this.principalId,
  });
}

//5 points: abstract all classes | implements not extends | empty constant constructor | functions not included in copywith | fields should be getters
class BatchItem_MultiQEngAFgn4 implements BatchItem_Multi {
  final int attempts;
  final bool isComplete;
  final int incorrectCount;
  final List<int> lectureIds;
  final int orderId;
  final int principalId;
  const BatchItem_MultiQEngAFgn4({
    @required this.attempts,
    @required this.isComplete,
    @required this.incorrectCount,
    @required this.lectureIds,
    @required this.orderId,
    @required this.principalId,
  });
}

//5 points: abstract all classes | implements not extends | empty constant constructor | functions not included in copywith | fields should be getters
class BatchItem_MultiQFgnAEng5 implements BatchItem_Multi {
  final int attempts;
  final bool isComplete;
  final int incorrectCount;
  final List<int> lectureIds;
  final int orderId;
  final int principalId;
  const BatchItem_MultiQFgnAEng5({
    @required this.attempts,
    @required this.isComplete,
    @required this.incorrectCount,
    @required this.lectureIds,
    @required this.orderId,
    @required this.principalId,
  });
}

//5 points: abstract all classes | implements not extends | empty constant constructor | functions not included in copywith | fields should be getters
class BatchItem_MultiQFgnAFgn6 implements BatchItem_Multi {
  final int attempts;
  final bool isComplete;
  final int incorrectCount;
  final List<int> lectureIds;
  final int orderId;
  final int principalId;
  const BatchItem_MultiQFgnAFgn6({
    @required this.attempts,
    @required this.isComplete,
    @required this.incorrectCount,
    @required this.lectureIds,
    @required this.orderId,
    @required this.principalId,
  });
}

//5 points: abstract all classes | implements not extends | empty constant constructor | functions not included in copywith | fields should be getters
class BatchItem_Typed7 implements BatchItem_Single {
  final int attempts;
  final bool isComplete;
  final int incorrectCount;
  final List<int> lectureIds;
  final int orderId;
  final int score;
  const BatchItem_Typed7({
    @required this.attempts,
    @required this.isComplete,
    @required this.incorrectCount,
    @required this.lectureIds,
    @required this.orderId,
    @required this.score,
  });
}

//5 points: abstract all classes | implements not extends | empty constant constructor | functions not included in copywith | fields should be getters
class BatchItem_PiecesLong8 implements BatchItem_Single {
  final int attempts;
  final bool isComplete;
  final int incorrectCount;
  final List<int> lectureIds;
  final int orderId;
  final int score;
  const BatchItem_PiecesLong8({
    @required this.attempts,
    @required this.isComplete,
    @required this.incorrectCount,
    @required this.lectureIds,
    @required this.orderId,
    @required this.score,
  });
}

//5 points: abstract all classes | implements not extends | empty constant constructor | functions not included in copywith | fields should be getters
class BatchItem_PiecesSingle9 implements BatchItem_Single {
  final int attempts;
  final bool isComplete;
  final int incorrectCount;
  final List<int> lectureIds;
  final int orderId;
  final int score;
  const BatchItem_PiecesSingle9({
    @required this.attempts,
    @required this.isComplete,
    @required this.incorrectCount,
    @required this.lectureIds,
    @required this.orderId,
    @required this.score,
  });
}