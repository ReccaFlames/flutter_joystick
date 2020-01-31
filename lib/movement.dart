class Movement {
  final double move;
  final double strafe;
  final double rotate;

  Movement(this.move, this.strafe, this.rotate);

  Map<String, dynamic> toJson() => {
    'move': move,
    'strafe': strafe,
    'rotate': rotate,
  };
}