import 'package:cuber/cuber.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rubiks_solver/settings/settings.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final settingsState = context.watch<SettingsCubit>().state;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          ...ListTile.divideTiles(
            context: context,
            tiles: [
              ListTile(
                onTap: () {
                  showModalBottomSheet<void>(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) {
                      return const TargetCubeSelectionSheet();
                    },
                  );
                },
                title: const Text('Cube to Solve for:'),
                trailing: SvgPicture.string(
                  settingsState.solutionCube.svg(height: 36, width: 36),
                  width: 48,
                  height: 48,
                ),
              ),
              SwitchListTile(
                value: settingsState.deepSolve,
                onChanged: (_) {
                  context.read<SettingsCubit>().toggleDeepSolve();
                },
                title: const Text('Deep Solve?'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class TargetCubeSelectionSheet extends StatelessWidget {
  const TargetCubeSelectionSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      maxChildSize: 0.8,
      expand: false,
      builder: (context, scrollController) {
        return Column(
          children: [
            AppBar(
              title: const Text('Cube to Solve for'),
              automaticallyImplyLeading: false,
            ),
            Expanded(
              child: ListView.builder(
                controller: scrollController,
                padding: const EdgeInsets.all(16),
                itemCount: patternedCubes.length,
                itemBuilder: (context, index) {
                  final cube = patternedCubes[index];
                  return TargetCubeTile(
                    cube: cube.cube,
                    label: cube.name,
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

class TargetCubeTile extends StatelessWidget {
  const TargetCubeTile({
    super.key,
    required this.cube,
    required this.label,
    this.onTap,
  });

  final Cube cube;
  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final isSolutionCube = context.select<SettingsCubit, bool>(
      (cubit) => cubit.state.solutionCube == cube,
    );
    return GestureDetector(
      onTap: () {
        context.read<SettingsCubit>().changeCubeToSolveFor(cube);
        onTap?.call();
      },
      child: SizedBox(
        height: 100,
        child: Row(
          children: [
            SvgPicture.string(
              cube.svg(height: 80, width: 80),
              width: 80,
              height: 80,
            ),
            Expanded(
              child: Text(
                label,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            if (isSolutionCube)
              const Icon(
                Icons.check,
                size: 40,
              ),
          ],
        ),
      ),
    );
  }
}
