//
//  LineSegment.swift
//  GeometryHelpers
//
//  Created by Andreas Verhoeven on 04/06/2021.
//

import UIKit

/// A line segment is a line, but with a specific start and end point
public struct LineSegment {
	public private(set) var start: CGPoint
	public private(set) var end: CGPoint

	/// the line for this segment
	public var line: Line {
		return Line(from: start, to: end)
	}

	/// the slope of this segment
	public var slope: Slope {
		return Slope(from: start, to: end)
	}

	/// Creates a LineSegment between two points
	///
	/// - Parameters:
	///		- start: the first point of the segment
	///		- end: the end point of the segment
	public init(start: CGPoint, end: CGPoint) {
		// ensure we always have the same order for two given points,
		// so that they compare equally
		if start.y < end.y || (start.y == end.y && start.x <= end.x)  {
			self.start = start
			self.end = end
		} else {
			self.start = end
			self.end = start
		}

		self.start = start
		self.end = end
	}

	/// Checks if this line segment is almost equal to the other, with a given tolerance
	public func isAlmostEqual(to other: Self, tolerance: CGFloat = .ulpOfOne.squareRoot()) -> Bool {
		return start.isAlmostEqual(to: other.start, tolerance: tolerance)
			&& end.isAlmostEqual(to: other.end, tolerance: tolerance)
	}

	/// Checks if a point is inside on the line segment, with a given tolerance
	///
	/// - Parameters:
	///		- point: the point to check if it is on this line segment
	/// - Returns: true iff `point` is on the line segment
	public func contains(other point: CGPoint, tolerance: CGFloat = .ulpOfOne.squareRoot()) -> Bool {
		guard line.contains(point: point, tolerance: tolerance) else { return false }

		let dl = CGPoint(x: end.x - start.x, y: end.y - start.y)
		if abs(dl.x) >= abs(dl.y) {
			if dl.x > 0 {
				return start.x <= point.x && point.x <= end.x
			} else {
				return end.x <= point.x && point.x <= start.x
			}
		} else {
			if dl.y > 0 {
				return start.y <= point.y && point.y <= end.y
			} else {
				return end.y <= point.y && point.y <= start.y
			}
		}
	}
}

extension LineSegment: Hashable {
	public func hash(into hasher: inout Hasher) {
		hasher.combine(start.x)
		hasher.combine(start.y)

		hasher.combine(end.x)
		hasher.combine(end.y)
	}
}

