//
//  Line.swift
//  GeometryHelpers
//
//  Created by Andreas Verhoeven on 04/06/2021.
//

import UIKit

/// Line models a mathematical line in the form of
/// `(y - point.y) = (x - point.x) * slope`
///
/// A line has no start and end point, but goes
/// on infinitely in the plane.
public struct Line {
	/// A point on this line
	public private(set) var point: CGPoint

	/// the slope of this line, take
	/// special care when its `.isHorizontal`
	/// and `.isVertical`.
	///
	/// This is not a CGFloat, but a custom struct
	/// so users are forced to deal with the special
	/// cases.
	public private(set) var slope: Slope

	/// Creates a line thru a point with a given slope
	///
	/// Note, the values will be normalized:
	/// 	- a horizontal line will have `x = 0`
	/// 	- a vertical line will have `y = 0`
	/// 	- any other line will have `y = 0` and the `x` for that `y`
	///
	/// - Parameters:
	/// 	- point: the point the lines goes thru
	/// 	- slope: the slope of the line
	public init(point: CGPoint, slope: Slope) {
		self.slope = slope

		if slope.isHorizontal {
			self.point = CGPoint(x: 0, y: point.y)
		} else if slope.isVertical {
			self.point = CGPoint(x: point.x, y: 0)
		} else {
			let y = slope.rawValue * (0  - point.x) + point.y
			self.point = CGPoint(x: 0, y: y)
			//self.point = point
		}
	}


	/// Creates a vertical line at a given x position
	///
	/// - Parameters:
	///		- x: the x position of the vertical line
	public init(verticalLineAtX x: CGFloat) {
		self.init(point: CGPoint(x: x, y: 0), slope: .vertical)
	}

	/// Creates a horizontal line at a given y position
	///
	/// - Parameters:
	///		- y: the x position of the horizontal line
	public init(horizontalLineAtY y: CGFloat) {
		self.init(point: CGPoint(x: 0, y: y), slope: .horizontal)
	}


	/// Creates a line in the form of `y = slope * x + b`
	///
	/// - Parameters:
	///		- slope: the slope of the line
	///		- b: the b value in the equation
	public init(yIsXTimes slope: Slope, plus b: CGFloat) {
		self.init(point: CGPoint(x: 0, y: b), slope: slope)
	}

	/// Initializes a line that goes between point a and b
	///
	/// - Parameters:
	///		- from: the first point the line goes thru
	///		- to: the second point the line goes thru
	public init(from: CGPoint, to: CGPoint) {
		self.init(point: from, slope: Slope(from: from, to: to))
	}

	/// Initializes a line that is the tangent to the given point on the circle with
	/// the given center.
	///
	/// - Parameters:
	///		- pointOnCircle: the point **on** the circle that we want the tangent for
	///		- center: the center point of the circle
	public init(tangentFromPointOnCircle pointOnCircle: CGPoint, center: CGPoint) {
		self = Line(from: pointOnCircle, to: center).perpendicular(at: pointOnCircle)!
	}
}

extension Line: CustomDebugStringConvertible {
	public var debugDescription: String {
		if isHorizontal {
			return "y = \(point.y)"
		} else if isVertical {
			return "x = \(point.x)"
		} else {
			return "y = \(slope.rawValue) * x + \(point.y)"
		}
	}
}

extension Line: Hashable {
	public func hash(into hasher: inout Hasher) {
		hasher.combine(point.x)
		hasher.combine(point.y)
		hasher.combine(slope)
	}
}

public extension Line {
	/// True iff this line is strictly horizontal
	var isHorizontal: Bool {
		return slope.isHorizontal
	}

	/// True if this line is strictly vertical
	var isVertical: Bool {
		return slope.isVertical
	}

	/// Returns the line perpendicular to this line in the given point
	/// if the given point is on this line, otherwise nil.
	///
	/// - Parameters:
	///		- point: the point we want the perpendicular line to go thru
	///
	/// - Returns: the perpendicular line if point is on this line, otherwise nil
	func perpendicular(at point: CGPoint, tolerance: CGFloat = .ulpOfOne.squareRoot()) -> Line? {
		guard contains(point: point, tolerance: tolerance) else { return nil }
		return Self(point: point, slope: slope.perpendicular)
	}

	/// Calculates the y value for a given x, if it uniquely exists.
	/// Vertical lines have an infinite number of y values
	/// for any given x, so that will return nil.
	///
	/// - Parameters:
	/// 	- x: the x value we want the y value for
	///
	/// - Returns: the y value on the line at position x, if it
	/// 			uniquely exists otherwise nil.
	func yValue(forX x: CGFloat) -> CGFloat? {
		guard isVertical == false else { return nil }
		guard isHorizontal == false else { return point.y }
		return slope.rawValue * (x  - point.x) + point.y
	}

	/// Calculates the point for the given x value on the line, if available.
	/// Vertical lines have an infinite number of points for a given x,
	/// so that will return nil.
	///
	/// - Parameters:
	/// 	- x: the x value we want the point for
	///
	/// - Returns: the point value on the line at position x, if it
	/// 			uniquely exists otherwise nil.
	func point(forX x: CGFloat) -> CGPoint? {
		guard let y  = yValue(forX: x) else { return nil }
		return CGPoint(x: x, y: y)
	}

	/// Calculates the x value for a given y, if it uniquely exists.
	/// Horizontal lines have an infinite number of x values
	/// for any given y, so that will return nil.
	///
	/// - Parameters:
	/// 	- y: the y value we want the x value for
	///
	/// - Returns: the x value on the line at position y, if it
	/// 			uniquely exists otherwise nil.
	func xValue(forY y: CGFloat) -> CGFloat? {
		guard isHorizontal == false else { return nil }
		guard isVertical == false else { return point.x }
		return (y - point.y) / slope.rawValue + point.x
	}

	/// Calculates the point for the given y value on the line, if available.
	/// Horizontal lines have an infinite number of points for a given y,
	/// so that will return nil.
	///
	/// - Parameters:
	/// 	- y: the y value we want the point for
	///
	/// - Returns: the point value on the line at position y, if it
	/// 			uniquely exists otherwise nil.
	func point(forY y: CGFloat) -> CGPoint? {
		guard let x  = xValue(forY: y) else { return nil }
		return CGPoint(x: x, y: y)
	}

	/// Returns true if point is on this line
	///
	/// - Parameters:
	///		- other: the point we want to check for being on this line
	///
	/// - Returns: true iff `other` is on this line
	func contains(point other: CGPoint, tolerance: CGFloat = .ulpOfOne.squareRoot()) -> Bool {
		if isHorizontal {
			return point.y.isAlmostEqual(to: other.y, tolerance: tolerance)
		} else if isVertical {
			return point.x.isAlmostEqual(to: other.x, tolerance: tolerance)
		} else {
			return yValue(forX: other.x)?.isAlmostEqual(to: other.y, tolerance: tolerance) ?? false
		}
	}

	/// Checks if this line is almost equal to the other, with a given tolerance
	func isAlmostEqual(to other: Self, tolerance: CGFloat = .ulpOfOne.squareRoot()) -> Bool {
		return point.isAlmostEqual(to: other.point, tolerance: tolerance)
			&& slope.isAlmostEqual(to: other.slope, tolerance: tolerance)
	}
}


public extension Line {
	enum IntersectionResult {
		/// Both lines are the same, so there are an infinitive
		/// number of intersection points
		case sameLine

		/// Both lines are parallel and thus never intersect.
		case parallel

		/// The lines uniquely intersect at the point
		case intersect(at: CGPoint)
	}

	/// Calculates the intersection of two lines: results can be either that the lines are
	///  - equal (`.sameLine`) and thus have an infinite number of intersection points,
	///  - parallel (`.parallel`) and thus have no intersection points
	///  - or a single intersection point (`.intersect(at:)`
	///
	/// - Parameters:
	///		- other: the other line to intersect with
	/// - Returns: an IntersectionResult holding the intersection information
	func intersection(with other: Line, tolerance: CGFloat = .ulpOfOne.squareRoot()) -> IntersectionResult {
		guard slope != other.slope else {
			/// the same slope, so we must be parallel or the same line
			return self.isAlmostEqual(to: other, tolerance: tolerance) ? .sameLine : .parallel
		}

		if isVertical {
			// We know the other line is not vertical, because their slopes
			// are different, so this y does exist and the x coordinate is fixed
			let y = other.yValue(forX: point.x)!
			return .intersect(at: CGPoint(x: point.x, y: y))
		} else if other.isVertical {
			// Other is vertical, so we are not. The x coordinate
			// is fixed to other
			let y = yValue(forX: point.x)!
			return .intersect(at: CGPoint(x: other.point.x, y: y))
		} else if isHorizontal {
			// We know the other line is not horizontal, because
			// their slopes are different, so this x does exist and they y coordinate
			// is fixed
			let x = other.xValue(forY: point.y)!
			return .intersect(at: CGPoint(x: x, y: point.y))
		} else if other.isHorizontal {
			// Other is horizontal, so we are not. The y coordinate
			// is fixed to other
			let x = xValue(forY: other.point.y)!
			return .intersect(at: CGPoint(x: x, y: other.point.y))
		} else {
			// Both lines are neither vertical nor horizontal, so
			// they intersect somewhere
			let x = ((other.slope.rawValue * other.point.x - slope.rawValue * point.x) - ( other.point.y - point.y)) / (other.slope.rawValue - slope.rawValue)
			let y = yValue(forX: x)! // we know this exist, because we are not vertical
			return .intersect(at: CGPoint(x: x, y: y))
		}
	}

	/// Returns the unique intersection point of this line with another line, if available.
	///
	/// If the lines have an infinite number of intersection points (equal lines), or no intersection points (parallel line)
	/// This returns nil.
	///
	/// - Parameters:
	///		- other: the other line to intersect with
	/// - Returns: the intersection point if uniquely available, otherwise nil
	func intersectionPoint(with other: Line, tolerance: CGFloat = .ulpOfOne.squareRoot()) -> CGPoint? {
		switch intersection(with: other, tolerance: tolerance) {
			case .sameLine, .parallel: return nil
			case .intersect(let point): return point
		}
	}
}
