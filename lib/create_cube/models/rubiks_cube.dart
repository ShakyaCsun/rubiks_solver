import 'package:cuber/cuber.dart';
import 'package:equatable/equatable.dart';

class RubiksCube extends Equatable {
  RubiksCube({
    List<PieceColor>? up,
    List<PieceColor>? right,
    List<PieceColor>? front,
    List<PieceColor>? down,
    List<PieceColor>? left,
    List<PieceColor>? back,
  })  : upPieces = List.unmodifiable(
          up ?? _invalidPieces.replaceAt(4, PieceColor.up),
        ),
        rightPieces = List.unmodifiable(
          right ?? _invalidPieces.replaceAt(4, PieceColor.right),
        ),
        frontPieces = List.unmodifiable(
          front ?? _invalidPieces.replaceAt(4, PieceColor.front),
        ),
        downPieces = List.unmodifiable(
          down ?? _invalidPieces.replaceAt(4, PieceColor.down),
        ),
        leftPieces = List.unmodifiable(
          left ?? _invalidPieces.replaceAt(4, PieceColor.left),
        ),
        backPieces = List.unmodifiable(
          back ?? _invalidPieces.replaceAt(4, PieceColor.back),
        );

  factory RubiksCube.fromCube(Cube cube) {
    final colors = cube.colors.map<PieceColor>((color) {
      switch (color) {
        case Color.up:
          return PieceColor.up;
        case Color.right:
          return PieceColor.right;
        case Color.front:
          return PieceColor.front;
        case Color.down:
          return PieceColor.down;
        case Color.left:
          return PieceColor.left;
        case Color.back:
          return PieceColor.back;
      }
    }).toList();
    return RubiksCube(
      up: colors.take(9).toList(),
      right: colors.sublist(9, 18),
      front: colors.sublist(18, 27),
      down: colors.sublist(27, 36),
      left: colors.sublist(36, 45),
      back: colors.sublist(45),
    );
  }

  final List<PieceColor> upPieces;
  final List<PieceColor> rightPieces;
  final List<PieceColor> frontPieces;
  final List<PieceColor> downPieces;
  final List<PieceColor> leftPieces;
  final List<PieceColor> backPieces;

  @override
  List<Object> get props {
    return [
      upPieces,
      rightPieces,
      frontPieces,
      downPieces,
      leftPieces,
      backPieces,
    ];
  }

  static final initial = RubiksCube();

  static final List<PieceColor> _invalidPieces = List.filled(
    9,
    PieceColor.unselected,
  );

  RubiksCube setPieceColor(Position position, PieceColor color) {
    final index = position.index;
    switch (position.face) {
      case Face.up:
        return _copyWith(up: upPieces.replaceAt(index, color));
      case Face.right:
        return _copyWith(right: rightPieces.replaceAt(index, color));
      case Face.front:
        return _copyWith(front: frontPieces.replaceAt(index, color));
      case Face.down:
        return _copyWith(down: downPieces.replaceAt(index, color));
      case Face.left:
        return _copyWith(left: leftPieces.replaceAt(index, color));
      case Face.back:
        return _copyWith(back: backPieces.replaceAt(index, color));
    }
  }

  String get stringNotation {
    return allPieces.map((e) => e.symbol).join();
  }

  bool get isValid {
    return !allPieces.any((element) => element == PieceColor.unselected) &&
        allPieces.where((element) => element == PieceColor.up).length == 9 &&
        allPieces.where((element) => element == PieceColor.front).length == 9 &&
        allPieces.where((element) => element == PieceColor.right).length == 9 &&
        allPieces.where((element) => element == PieceColor.down).length == 9 &&
        allPieces.where((element) => element == PieceColor.back).length == 9 &&
        allPieces.where((element) => element == PieceColor.left).length == 9 &&
        Cube.from(stringNotation).isOk;
  }

  List<PieceColor> get allPieces {
    return [
      ...upPieces,
      ...rightPieces,
      ...frontPieces,
      ...downPieces,
      ...leftPieces,
      ...backPieces,
    ];
  }

  List<PieceColor> getPieceOfFace(Face face) {
    switch (face) {
      case Face.up:
        return upPieces;
      case Face.right:
        return rightPieces;
      case Face.front:
        return frontPieces;
      case Face.down:
        return downPieces;
      case Face.left:
        return leftPieces;
      case Face.back:
        return backPieces;
    }
  }

  int pieceCount(PieceColor piece) {
    return allPieces.where((element) => element == piece).length;
  }

  RubiksCube _copyWith({
    List<PieceColor>? up,
    List<PieceColor>? right,
    List<PieceColor>? front,
    List<PieceColor>? down,
    List<PieceColor>? left,
    List<PieceColor>? back,
  }) {
    return RubiksCube(
      up: up ?? upPieces,
      right: right ?? rightPieces,
      front: front ?? frontPieces,
      down: down ?? downPieces,
      left: left ?? leftPieces,
      back: back ?? backPieces,
    );
  }
}

class Position extends Equatable {
  const Position({
    required this.face,
    required this.index,
  }) : assert(
          index >= 0 && index < 9 && index != 4,
          'Only Indices from 0 to 9 (except the middle piece i.e. 4) are valid',
        );

  final Face face;
  final int index;

  @override
  List<Object> get props => [face, index];
}

enum Face {
  up,
  right,
  front,
  down,
  left,
  back;

  String get symbol {
    switch (this) {
      case Face.up:
        return 'U';
      case Face.right:
        return 'R';
      case Face.front:
        return 'F';
      case Face.down:
        return 'D';
      case Face.left:
        return 'L';
      case Face.back:
        return 'B';
    }
  }
}

enum PieceColor {
  up,
  right,
  front,
  down,
  left,
  back,
  unselected;

  String get symbol {
    switch (this) {
      case PieceColor.up:
        return 'U';
      case PieceColor.right:
        return 'R';
      case PieceColor.front:
        return 'F';
      case PieceColor.down:
        return 'D';
      case PieceColor.left:
        return 'L';
      case PieceColor.back:
        return 'B';
      case PieceColor.unselected:
        return '-';
    }
  }
}

extension ListExtensions<T> on List<T> {
  List<T> replaceAt(int index, T value) {
    final list = [...this]..[index] = value;
    return list;
  }
}
