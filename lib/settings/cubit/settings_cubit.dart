import 'package:bloc/bloc.dart';
import 'package:cuber/cuber.dart';
import 'package:equatable/equatable.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(const SettingsState());

  void changeCubeToSolveFor(Cube cube) {
    emit(state.copyWith(solutionCube: cube));
  }

  void toggleDeepSolve() {
    emit(state.copyWith(deepSolve: !state.deepSolve));
  }
}
