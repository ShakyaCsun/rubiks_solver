part of 'settings_cubit.dart';

class SettingsState extends Equatable {
  const SettingsState({
    this.solutionCube = Cube.solved,
    this.deepSolve = false,
  });

  final Cube solutionCube;
  final bool deepSolve;

  @override
  List<Object> get props => [solutionCube, deepSolve];

  SettingsState copyWith({
    Cube? solutionCube,
    bool? deepSolve,
  }) {
    return SettingsState(
      solutionCube: solutionCube ?? this.solutionCube,
      deepSolve: deepSolve ?? this.deepSolve,
    );
  }
}
