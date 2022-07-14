part of 'solve_cube_bloc.dart';

abstract class SolveCubeEvent extends Equatable {
  const SolveCubeEvent();

  @override
  List<Object> get props => [];
}

class SolveCubeSolutionRequested extends SolveCubeEvent {
  const SolveCubeSolutionRequested(
    this.cube, {
    required this.targetCube,
    required this.deepSolve,
  });

  final Cube cube;
  final Cube targetCube;
  final bool deepSolve;

  @override
  List<Object> get props => [deepSolve, cube, targetCube];
}
