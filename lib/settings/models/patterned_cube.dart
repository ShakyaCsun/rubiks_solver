import 'package:cuber/cuber.dart';
import 'package:equatable/equatable.dart';

class _PatternedCube extends Equatable {
  const _PatternedCube({
    required this.cube,
    required this.name,
  });

  final Cube cube;
  final String name;

  @override
  List<Object> get props => [name, cube];
}

final patternedCubes = List<_PatternedCube>.unmodifiable([
  const _PatternedCube(cube: Cube.solved, name: 'Default'),
  _PatternedCube(cube: Cube.anaconda, name: 'Anaconda'),
  _PatternedCube(cube: Cube.checkerboard, name: 'Checkerboard'),
  _PatternedCube(cube: Cube.chickenFeet, name: 'Chicken Feet'),
  _PatternedCube(cube: Cube.crossOne, name: 'Cross One'),
  _PatternedCube(cube: Cube.crossTwo, name: 'Cross Two'),
  _PatternedCube(cube: Cube.cubeInCube, name: 'Cube in Cube'),
  _PatternedCube(cube: Cube.cubeInCubeInCube, name: 'Cube in Cube in Cube'),
  _PatternedCube(cube: Cube.feliksZemdegs422, name: 'Feliks Zemdegs 4.22'),
  _PatternedCube(cube: Cube.fourSpots, name: 'Four Spots'),
  _PatternedCube(cube: Cube.python, name: 'Python'),
  _PatternedCube(cube: Cube.sixSpots, name: 'Six Spots'),
  _PatternedCube(cube: Cube.sixTs, name: 'Six Ts'),
  _PatternedCube(cube: Cube.spiral, name: 'Spiral'),
  _PatternedCube(cube: Cube.stripes, name: 'Stripes'),
  _PatternedCube(cube: Cube.tetris, name: 'Tetris'),
  _PatternedCube(cube: Cube.twister, name: 'Twister'),
  _PatternedCube(cube: Cube.wire, name: 'Wire'),
  _PatternedCube(cube: Cube.yushengDu347, name: 'Yusheng Du 3.47'),
]);
