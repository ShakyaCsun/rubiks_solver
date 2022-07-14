part of 'create_cube_bloc.dart';

abstract class CreateCubeEvent extends Equatable {
  const CreateCubeEvent();

  @override
  List<Object> get props => [];
}

class CreateCubeColorChanged extends CreateCubeEvent {
  const CreateCubeColorChanged(this.color);

  final PieceColor color;

  @override
  List<Object> get props => [color];
}

class CreateCubePositionTapped extends CreateCubeEvent {
  const CreateCubePositionTapped(this.position);

  final Position position;

  @override
  List<Object> get props => [position];
}

class CreateCubeFromPredefinedPatternRequested extends CreateCubeEvent {
  const CreateCubeFromPredefinedPatternRequested(this.cube);

  final Cube cube;

  @override
  List<Object> get props => [cube];
}

class CreateCubeResetRequested extends CreateCubeEvent {
  const CreateCubeResetRequested();
}
