//
//  Circle.swift
//  GeometryHelpers
//
//  Created by Andreas Verhoeven on 04/06/2021.
//

import UIKit

/// A circle
public struct Circle {
	/// the center point of the circle
	public var center: CGPoint

	/// the radius of the circle
	public var radius: CGFloat

	/// Creates a circle
	public init(center: CGPoint, radius: CGFloat) {
		self.center = center
		self.radius = radius
	}

	/// checks if a given point is on a the circle
	public func isOnCircle(point: CGPoint, tolerance: CGFloat = .ulpOfOne.squareRoot()) -> Bool {
		return (pow(point.x - center.x, 2) + pow(point.y - center.y, 2)).isAlmostEqual(to: pow(radius, 2), tolerance: tolerance)
	}

	/// checks if the given point is inside of the circle
	public func isInsideCircle(point: CGPoint, tolerance: CGFloat = .ulpOfOne.squareRoot()) -> Bool {
		return (pow(point.x - center.x, 2) + pow(point.y - center.y, 2)).isSmallerOrAlmostEqual(to: pow(radius, 2), tolerance: tolerance)
	}

	/// gets the angle (in radians) for a point on the circle
	public func angle(for point: CGPoint, tolerance: CGFloat = .ulpOfOne.squareRoot()) -> CGFloat? {
		guard isOnCircle(point: point, tolerance: tolerance) else { return nil }
		return atan2(point.y - center.y, point.x - center.x)
	}

	/// gets the point on the circle for the given angle (in radians)
	public func point(for angle: CGFloat, tolerance: CGFloat = .ulpOfOne.squareRoot()) -> CGPoint {
		guard radius.isAlmostZero(absoluteTolerance: tolerance) else { return center }

		return CGPoint(x: radius * sin(angle) + center.x,
					   y: radius * cos(angle) + center.y)
	}

	/// gets the tangent line for a point on the circle. If the point is not on the circle,
	/// will return nil
	public func tangent(at point: CGPoint, tolerance: CGFloat = .ulpOfOne.squareRoot()) -> Line? {
		guard isOnCircle(point: point, tolerance: tolerance) else { return nil }
		return Line(tangentFromPointOnCircle: point, center: center)
	}

	/// gets the tangent line for for point on the circle at the given angle (in radians).
	public func tangent(for angle: CGFloat, tolerance: CGFloat = .ulpOfOne.squareRoot()) -> Line {
		let point = point(for: angle, tolerance: tolerance)
		return Line(tangentFromPointOnCircle: point, center: center)
	}

	/// Checks if this circle is almost equal to the other, with a given tolerance
	public func isAlmostEqual(to other: Self, tolerance: CGFloat = .ulpOfOne.squareRoot()) -> Bool {
		return center.isAlmostEqual(to: other.center, tolerance: tolerance)
			&& radius.isAlmostEqual(to: other.radius, tolerance: tolerance)
	}
}

extension Circle: Hashable {
	public func hash(into hasher: inout Hasher) {
		hasher.combine(center.x)
		hasher.combine(center.y)
		hasher.combine(radius)
	}
}

