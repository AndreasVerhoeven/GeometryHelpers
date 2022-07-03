//
//  Slope.swift
//  GeometryHelpers
//
//  Created by Andreas Verhoeven on 04/06/2021.
//

import UIKit

/// The slope of a line
public struct Slope: RawRepresentable, Hashable {
	public private(set) var rawValue: CGFloat

	/// Initializes a slope with a given value
	/// and normalizes the value
	public init(rawValue: CGFloat) {
		if rawValue.isZero {
			self.rawValue = .zero
		} else if rawValue.isInfinite {
			self.rawValue = .infinity
		} else {
			self.rawValue = rawValue
		}
	}

	/// A slope that indicates a strict horizontal line
	public static let horizontal = Slope(rawValue: 0)

	/// A slope that indicates a strict vertical line
	public static let vertical = Slope(rawValue: .infinity)

	/// True iff this line is strictly horizontal
	public var isHorizontal: Bool {
		return rawValue.isZero
	}

	/// True if this line is strictly vertical
	public var isVertical: Bool {
		return rawValue.isInfinite
	}

	/// returns the slope's value if available, or nil if not
	/// (A vertical line has an infinite slope, which is not available)
	var valueIfAvailable: CGFloat? {
		return isVertical ? nil : rawValue
	}

	/// Returns the slope perpendicular to this slope
	public var perpendicular: Slope {
		if isHorizontal {
			return .vertical
		} else if isVertical {
			return .horizontal
		} else {
			return Slope(rawValue: -1.0 / rawValue)
		}
	}

	/// Checks if this slope is almost equal to the other, with a given tolerance
	func isAlmostEqual(to other: Self, tolerance: CGFloat = .defaultGeometryTolerance) -> Bool {
		return rawValue.isAlmostEqual(to: other.rawValue, tolerance: tolerance)
	}
}

public extension Slope {
	/// Gets the slope between two points
	///
	/// - Parameters:
	///		- point: the first point
	///		- otherPoint: the second point
	init(from point: CGPoint, to otherPoint: CGPoint) {
		let horizontalDisplacement = otherPoint.x - point.x
		let verticalDisplacement = otherPoint.y - point.y

		if horizontalDisplacement.isZero {
			self = .vertical
		} else if verticalDisplacement.isZero {
			self = .horizontal
		} else {
			self = Self(rawValue: verticalDisplacement / horizontalDisplacement)
		}
	}
}

