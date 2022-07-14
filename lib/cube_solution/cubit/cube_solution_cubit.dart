import 'package:bloc/bloc.dart';
import 'package:cuber/cuber.dart';
import 'package:equatable/equatable.dart';

part 'cube_solution_state.dart';

class CubeSolutionCubit extends Cubit<CubeSolutionState> {
  CubeSolutionCubit({
    required this.moves,
  })  : assert(moves.isNotEmpty, 'Must have at least one move.'),
        super(
          CubeSolutionState.initial(
            movesCount: moves.length,
          ),
        );

  final List<Move> moves;
  late final movesCount = moves.length;

  void pageChanged(int index) {
    emit(
      state.changeIndex(index),
    );
  }
}
