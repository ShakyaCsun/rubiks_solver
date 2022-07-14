part of 'cube_solution_cubit.dart';

class CubeSolutionState extends Equatable {
  const CubeSolutionState._({
    required this.index,
    required this.movesCount,
  }) : assert(
          index >= 0 && index < movesCount,
          'Index must be greater than 0 and less than movesCount.',
        );

  const CubeSolutionState.initial({
    required int movesCount,
  }) : this._(
          index: 0,
          movesCount: movesCount,
        );

  final int movesCount;
  final int index;

  bool get isFirstStep => index == 0;
  bool get isLastStep => index + 1 == movesCount;

  CubeSolutionState changeIndex(int newIndex) {
    return CubeSolutionState._(index: newIndex, movesCount: movesCount);
  }

  @override
  List<Object> get props => [movesCount, index];
}
