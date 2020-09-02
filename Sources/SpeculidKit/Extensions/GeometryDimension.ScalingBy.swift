extension Geometry {
  func scalingBy(_ scale: Float) -> Geometry {
    Geometry(value: value * scale, dimension: dimension)
  }
}
