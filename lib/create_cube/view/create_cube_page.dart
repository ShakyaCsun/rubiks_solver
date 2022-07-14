import 'package:cuber/cuber.dart' hide Color;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rubiks_solver/create_cube/create_cube.dart';
import 'package:rubiks_solver/create_cube/models/rubiks_cube.dart';
import 'package:rubiks_solver/create_cube/view/widgets/trapezoid_clipper.dart';
import 'package:rubiks_solver/cube_solution/cube_solution.dart';
import 'package:rubiks_solver/extensions.dart';
import 'package:rubiks_solver/settings/settings.dart';
import 'package:rubiks_solver/solve_cube/bloc/solve_cube_bloc.dart';

class CreateCubePage extends StatelessWidget {
  const CreateCubePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CreateCubeBloc(),
        ),
        BlocProvider(
          create: (context) => SolveCubeBloc(),
        ),
      ],
      child: const CreateCubeView(),
    );
  }
}

class CreateCubeView extends StatelessWidget {
  const CreateCubeView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Rubik's Cube Solver"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(SettingsPage.route());
            },
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          CubeFaceInputsPageView(),
          PieceColorInputGrid(),
          ShowSolutionButton(),
        ],
      ),
    );
  }
}

class ShowSolutionButton extends StatelessWidget {
  const ShowSolutionButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isComplete = context.select<CreateCubeBloc, bool>(
      (bloc) => bloc.state.cube.isValid,
    );
    if (!isComplete) {
      return const SizedBox.shrink();
    }
    return BlocConsumer<SolveCubeBloc, SolveCubeState>(
      listener: (context, state) {
        if (state is SolveCubeSolutionNotPossible) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(
                content: Text(
                  'The Cube configuration is not valid. No Solution exists.',
                ),
              ),
            );
        } else if (state is SolveCubeSolutionFound) {
          Navigator.of(context).push(CubeSolutionPage.route(state.moves));
        } else if (state is SolveCubeAlreadySolved) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(
                content: Text(
                  'The Cube configuration is already in solved state.',
                ),
              ),
            );
        }
      },
      builder: (context, state) {
        if (state is SolveCubeInProgress) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return ElevatedButton(
          onPressed: () {
            context.read<SolveCubeBloc>().add(
                  SolveCubeSolutionRequested(
                    Cube.from(
                      context.read<CreateCubeBloc>().state.cube.stringNotation,
                    ),
                    targetCube:
                        context.read<SettingsCubit>().state.solutionCube,
                    deepSolve: context.read<SettingsCubit>().state.deepSolve,
                  ),
                );
          },
          child: const Text('Show Solution'),
        );
      },
    );
  }
}

class CubeFaceInputsPageView extends StatelessWidget {
  const CubeFaceInputsPageView({super.key});

  @override
  Widget build(BuildContext context) {
    final cubeState = context.watch<CreateCubeBloc>().state;
    return AspectRatio(
      aspectRatio: 3 / 4,
      child: PageView(
        children: Face.values
            .map(
              (face) => CubeFaceInput(
                face: face,
                pieces: cubeState.cube.getPieceOfFace(face),
              ),
            )
            .toList(),
      ),
    );
  }
}

class CubeFaceInput extends StatelessWidget {
  const CubeFaceInput({
    super.key,
    required this.face,
    required this.pieces,
  });

  final Face face;
  final List<PieceColor> pieces;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 3 / 4,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 12,
        itemBuilder: (context, index) {
          if (index == 0 || index == 2) {
            return const SizedBox.shrink();
          }
          if (index == 1) {
            return Padding(
              padding: const EdgeInsets.all(4),
              child: ClipPath(
                clipper: TrapezoidClipper(),
                child: ColoredBox(color: face.upperCenterPiece.color),
              ),
            );
          }
          final effectiveIndex = index - 3;
          final piece = pieces[effectiveIndex];
          if (effectiveIndex == 4) {
            return CubePiece(
              color: piece.color,
              child: Center(
                child: FittedBox(
                  child: Text(
                    face.symbol,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: piece.color.contrastingTextColor,
                        ),
                  ),
                ),
              ),
            );
          }
          return GestureDetector(
            onTap: () {
              context.read<CreateCubeBloc>().add(
                    CreateCubePositionTapped(
                      Position(face: face, index: effectiveIndex),
                    ),
                  );
            },
            child: CubePiece(color: piece.color),
          );
        },
      ),
    );
  }
}

class PieceColorInputGrid extends StatelessWidget {
  const PieceColorInputGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Center(
          child: TextButton(
            onPressed: () {
              showModalBottomSheet<void>(
                context: context,
                isScrollControlled: true,
                builder: (_) {
                  return BlocProvider.value(
                    value: context.read<CreateCubeBloc>(),
                    child: const PredefinedCubePatternsSelection(),
                  );
                },
              );
            },
            child: const Text('Predefined Cubes'),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            PieceColorInput(
              color: PieceColor.up,
            ),
            PieceColorInput(
              color: PieceColor.right,
            ),
            PieceColorInput(
              color: PieceColor.front,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            PieceColorInput(
              color: PieceColor.down,
            ),
            PieceColorInput(
              color: PieceColor.left,
            ),
            PieceColorInput(
              color: PieceColor.back,
            ),
          ],
        ),
      ],
    );
  }
}

class PredefinedCubePatternsSelection extends StatelessWidget {
  const PredefinedCubePatternsSelection({super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      maxChildSize: 0.8,
      expand: false,
      builder: (context, scrollController) {
        return Column(
          children: [
            AppBar(
              title: const Text('Predefined Cube Patterns'),
              automaticallyImplyLeading: false,
            ),
            Expanded(
              child: ListView.builder(
                controller: scrollController,
                padding: const EdgeInsets.all(16),
                itemCount: patternedCubes.length + 1,
                itemBuilder: (context, index) {
                  if (index == patternedCubes.length) {
                    return Center(
                      child: TextButton(
                        onPressed: () {
                          context.read<CreateCubeBloc>().add(
                                const CreateCubeResetRequested(),
                              );
                          Navigator.of(context).pop();
                        },
                        child: const Text('Reset Cube'),
                      ),
                    );
                  }
                  final cube = patternedCubes[index];
                  return GestureDetector(
                    onTap: () {
                      context.read<CreateCubeBloc>().add(
                            CreateCubeFromPredefinedPatternRequested(cube.cube),
                          );
                      Navigator.of(context).pop();
                    },
                    child: SizedBox(
                      height: 100,
                      child: Row(
                        children: [
                          SvgPicture.string(
                            cube.cube.svg(height: 80, width: 80),
                            width: 80,
                            height: 80,
                          ),
                          Expanded(
                            child: Text(
                              cube.name,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                        ],
                      ),
                    ),
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

class PieceColorInput extends StatelessWidget {
  const PieceColorInput({
    super.key,
    required this.color,
  });

  final PieceColor color;

  @override
  Widget build(BuildContext context) {
    final isSelected = context.select<CreateCubeBloc, bool>(
      (bloc) => bloc.state.color == color,
    );
    final colorCount = context.select<CreateCubeBloc, int>(
      (bloc) => bloc.state.cube.pieceCount(color),
    );

    final countLabel = colorCount == 9 ? 'OK' : '$colorCount';
    return GestureDetector(
      onTap: () {
        context.read<CreateCubeBloc>().add(CreateCubeColorChanged(color));
      },
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected
                ? Theme.of(context).colorScheme.onBackground
                : Colors.transparent,
            width: 2,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: SizedBox.square(
            dimension: 80,
            child: ColoredBox(
              color: color.color,
              child: Center(
                child: Text(
                  countLabel,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: color.color.contrastingTextColor,
                      ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CubePiece extends StatelessWidget {
  const CubePiece({
    super.key,
    required this.color,
    this.child,
  });

  final Color color;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: ColoredBox(
        color: color,
        child: SizedBox.expand(
          child: child,
        ),
      ),
    );
  }
}

extension PieceExtensions on PieceColor {
  Color get color {
    switch (this) {
      case PieceColor.up:
        return const Color(0xFFFFFF00);
      case PieceColor.right:
        return const Color(0xFFF44336);
      case PieceColor.front:
        return const Color(0xFF3F51B5);
      case PieceColor.down:
        return const Color(0xFFFFFFFF);
      case PieceColor.left:
        return const Color(0xFFFF9800);
      case PieceColor.back:
        return const Color(0xFF4CAF50);
      case PieceColor.unselected:
        return const Color(0xFFA1A4A7);
    }
  }
}

extension FaceExtensions on Face {
  PieceColor get upperCenterPiece {
    switch (this) {
      case Face.up:
        return PieceColor.back;
      case Face.down:
        return PieceColor.front;
      case Face.right:
      case Face.front:
      case Face.left:
      case Face.back:
        return PieceColor.up;
    }
  }
}
