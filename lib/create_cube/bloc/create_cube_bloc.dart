import 'package:bloc/bloc.dart';
import 'package:cuber/cuber.dart';
import 'package:equatable/equatable.dart';
import 'package:rubiks_solver/create_cube/models/rubiks_cube.dart';

part 'create_cube_event.dart';
part 'create_cube_state.dart';

class CreateCubeBloc extends Bloc<CreateCubeEvent, CreateCubeState> {
  CreateCubeBloc() : super(CreateCubeState()) {
    on<CreateCubeColorChanged>(_onCreateCubeColorChanged);
    on<CreateCubePositionTapped>(_onCreateCubePositionTapped);
    on<CreateCubeResetRequested>(_onCreateCubeResetRequested);
    on<CreateCubeFromPredefinedPatternRequested>(
      _onCreateCubeFromPredefinedPatternRequested,
    );
  }

  void _onCreateCubeColorChanged(
    CreateCubeColorChanged event,
    Emitter<CreateCubeState> emit,
  ) {
    emit(state.copyWith(color: event.color));
  }

  void _onCreateCubePositionTapped(
    CreateCubePositionTapped event,
    Emitter<CreateCubeState> emit,
  ) {
    emit(
      state.copyWith(
        cube: state.cube.setPieceColor(event.position, state.color),
      ),
    );
  }

  void _onCreateCubeResetRequested(
    CreateCubeResetRequested event,
    Emitter<CreateCubeState> emit,
  ) {
    emit(state.copyWith(cube: RubiksCube()));
  }

  void _onCreateCubeFromPredefinedPatternRequested(
    CreateCubeFromPredefinedPatternRequested event,
    Emitter<CreateCubeState> emit,
  ) {
    emit(
      state.copyWith(cube: RubiksCube.fromCube(event.cube)),
    );
  }
}
