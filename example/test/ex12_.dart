import 'package:copy_with_e_annotation/copy_with_e_annotation.dart';

part 'ex12_.g.dart';

@CopyWithE()
class Batch_Lesson {}

class Lesson_Lectures implements Batch_Lesson {}

class Batch_Staged_Lesson implements Batch_Lesson {}

class Batch_Staged_Lesson_Lectures //
    implements
        Batch_Staged_Lesson,
        Lesson_Lectures {}
