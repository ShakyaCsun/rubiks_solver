import 'package:bloc/bloc.dart';
import 'package:cuber/cuber.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'solve_cube_event.dart';
part 'solve_cube_state.dart';

class SolveCubeBloc extends Bloc<SolveCubeEvent, SolveCubeState> {
  SolveCubeBloc() : super(SolveCubeInitial()) {
    on<SolveCubeSolutionRequested>(_onSolveCubeSolutionRequested);
  }

  Future<void> _onSolveCubeSolutionRequested(
    SolveCubeSolutionRequested event,
    Emitter<SolveCubeState> emit,
  ) async {
    emit(const SolveCubeInProgress());
    final patternizedCube = event.cube.patternize(event.targetCube);
    final solution = event.deepSolve
        ? await compute(_cubeDeepSolver, patternizedCube)
        : await compute(_cubeSolver, patternizedCube);
    if (solution == null) {
      emit(const SolveCubeSolutionNotPossible());
    } else {
      final moves = solution.algorithm.moves;
      if (moves.isEmpty) {
        emit(const SolveCubeAlreadySolved());
      } else {
        emit(SolveCubeSolutionFound(moves: moves));
      }
    }
  }
}

Solution? _cubeSolver(Cube cube) {
  return cube.solve();
}

Future<Solution> _cubeDeepSolver(Cube cube) async {
  return cube.solveDeeply().last;
}
