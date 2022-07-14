part of 'create_cube_bloc.dart';

class CreateCubeState extends Equatable {
  CreateCubeState({
    RubiksCube? cube,
    this.color = PieceColor.unselected,
  }) : cube = cube ?? RubiksCube();

  final RubiksCube cube;
  final PieceColor color;

  @override
  List<Object> get props => [color, cube];

  CreateCubeState copyWith({
    RubiksCube? cube,
    PieceColor? color,
  }) {
    return CreateCubeState(
      cube: cube ?? this.cube,
      color: color ?? this.color,
    );
  }
}
