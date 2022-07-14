part of 'solve_cube_bloc.dart';

abstract class SolveCubeState extends Equatable {
  const SolveCubeState();

  @override
  List<Object> get props => [];
}

class SolveCubeInitial extends SolveCubeState {}

class SolveCubeInProgress extends SolveCubeState {
  const SolveCubeInProgress();
}

class SolveCubeSolutionFound extends SolveCubeState {
  const SolveCubeSolutionFound({required this.moves});

  final List<Move> moves;

  @override
  List<Object> get props => [moves];
}

class SolveCubeSolutionNotPossible extends SolveCubeState {
  const SolveCubeSolutionNotPossible();
}

class SolveCubeAlreadySolved extends SolveCubeState {
  const SolveCubeAlreadySolved();
}
