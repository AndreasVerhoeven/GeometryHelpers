//
//  CircleArc.swift
//  GeometryHelpers
//
//  Created by Andreas Verhoeven on 04/06/2021.
//

import UIKit

public struct CircleArc: Hashable {
	private(set) public var circle: Circle
	private(set) public var start: CirclePoint
	private(set) public var end: CirclePoint
	private(set) public var isClockwise: Bool

	/// Creates a circle arc with a given start and end point. Both points need to lie on the circle, otherwise nil is returned.
	///
	/// - Parameters:
	/// 	- circle: the circle we want an arc of
	/// 	- startPoint: the start point of the arc, must lie on the circle
	/// 	- endPoint: the end point of the arc, must lie on the circle
	/// 	- clockwise: true if the arc is in the clock wise direction
	/// 	- tolerance: the tolerance to use for calculations
	/// - Returns: the created arc, or nil if any of the points are not on the circle
	public init?(circle: Circle, startPoint: CGPoint, endPoint: CGPoint, clockwise: Bool, tolerance: CGFloat = .defaultGeometryTolerance) {
		guard let startAngle = circle.angle(for: startPoint, tolerance: tolerance) else { return nil }
		guard let endAngle = circle.angle(for: endPoint, tolerance: tolerance) else { return nil }

		self.circle = circle
		self.isClockwise = clockwise
		self.start = CirclePoint(point: startPoint, angle: startAngle)
		self.end = CirclePoint(point: endPoint, angle: endAngle)
	}

	/// Creates a circle with a given start and end angle.
	/// - Parameters:
	/// 	- circle: the circle we want an arc of
	/// 	- startAngle: the start angle of the arc
	/// 	- endAngle: the end angle of the arc
	/// 	- clockwise: true if the arc is in the clock wise direction
	/// 	- tolerance: the tolerance to use for calculations
	public init(circle: Circle, startAngle: CGFloat, endAngle: CGFloat, clockwise: Bool) {
		self.circle = circle
		self.isClockwise = clockwise
		self.start = CirclePoint(point: circle.point(for: startAngle), angle: startAngle.normalizedAngle)
		self.end = CirclePoint(point: circle.point(for: endAngle), angle: endAngle.normalizedAngle)
	}

	/// Creates a circle arc with a given center and start and and end point.
	/// the startPoint is assumed to be on the circle, the endPoint must also be on the circle.
	///
	/// - Parameters:
	/// 	- circle: the circle we want an arc of
	/// 	- startPoint: the start point of the arc
	/// 	- endPoint: the end point of the arc, must lie on the circle
	/// 	- clockwise: true if the arc is in the clock wise direction
	/// 	- tolerance: the tolerance to use for calculations
	/// - Returns: the created arc, or nil if the end point is not on the circle.
	public init?(center: CGPoint, startPoint: CGPoint, endPoint: CGPoint, clockwise: Bool, tolerance: CGFloat = .defaultGeometryTolerance) {
		let radius = sqrt(pow(startPoint.x - center.x, 2) + pow(startPoint.y - center.y, 2))
		let circle = Circle(center: center, radius: radius)

		self.init(circle: circle,
				  startPoint: startPoint,
				  endPoint: endPoint,
				  clockwise: clockwise,
				  tolerance: tolerance)
	}

	/// Creates a circle arc with a given center and start and end angle.
	/// the startPoint is assumed to be on the circle.
	///
	/// - Parameters:
	/// 	- circle: the circle we want an arc of
	/// 	- startPoint: the start point of the arc
	/// 	- endAngle: the end angle of the circle
	/// 	- clockwise: true if the arc is in the clock wise direction
	/// 	- tolerance: the tolerance to use for calculations
	public init(center: CGPoint, startPoint: CGPoint, endAngle: CGFloat, clockwise: Bool, tolerance: CGFloat = .defaultGeometryTolerance) {
		let radius = sqrt(pow(startPoint.x - center.x, 2) + pow(startPoint.y - center.y, 2))
		let circle = Circle(center: center, radius: radius)

		self.init(circle: circle,
				  startPoint: startPoint,
				  endPoint: circle.point(for: endAngle, tolerance: tolerance),
				  clockwise: clockwise,
				  tolerance: tolerance)!
	}

	/// checks if the given angle is on the circle arc
	public func contains(angle: CGFloat, tolerance: CGFloat = .defaultGeometryTolerance) -> Bool {
		let normalizedAngle = angle.normalizedAngle
		if isClockwise {
			return normalizedAngle.isLargerOrAlmostEqual(to: start.angle, tolerance: tolerance)
				&& normalizedAngle.isSmallerOrAlmostEqual(to: end.angle, tolerance: tolerance)
		} else {
			let reversedAngle = (.pi * 2 - normalizedAngle).normalizedAngle
			return reversedAngle.isLargerOrAlmostEqual(to: start.angle, tolerance: tolerance)
				&& reversedAngle.isSmallerOrAlmostEqual(to: end.angle, tolerance: tolerance)
		}
	}

	/// checks if the given point is on the circle arc
	public func contains(point: CGPoint, tolerance: CGFloat = .defaultGeometryTolerance) -> Bool {
		guard let angle = circle.angle(for: point, tolerance: tolerance) else { return false }
		return contains(angle: angle, tolerance: tolerance)
	}

	/// Checks if this circle arc is almost equal to the other, with a given tolerance
	public func isAlmostEqual(to other: Self, tolerance: CGFloat = .defaultGeometryTolerance) -> Bool {
		return circle.isAlmostEqual(to: other.circle, tolerance: tolerance)
			&& start.isAlmostEqual(to: other.start, tolerance: tolerance)
			&& end.isAlmostEqual(to: other.end, tolerance: tolerance)
	}

	public var clockwise: Self {
		var item = self
		item.isClockwise = true
		return item
	}

	public var counterClockwise: Self {
		var item = self
		item.isClockwise = false
		return item
	}

}

/// A point on a circle. Holds the point and the angle, so we don't have to recalculate all the time.
public struct CirclePoint {
	public var point: CGPoint
	public var angle: CGFloat

	/// Checks if this circle arc is almost equal to the other, with a given tolerance
	public func isAlmostEqual(to other: Self, tolerance: CGFloat = .defaultGeometryTolerance) -> Bool {
		return point.isAlmostEqual(to: other.point, tolerance: tolerance)
			&& angle.isAlmostEqual(to: other.angle, tolerance: tolerance)
	}
}

extension CirclePoint: Hashable {
	public func hash(into hasher: inout Hasher) {
		hasher.combine(point.x)
		hasher.combine(point.y)
		hasher.combine(angle)
	}
}


fileprivate extension CGFloat {
	var normalizedAngle: Self {
		return truncatingRemainder(dividingBy: .pi * 2)
	}
}
