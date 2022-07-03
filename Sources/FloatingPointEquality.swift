//
//  FloatingPointEquality.swift
//  GeometryHelpers
//
//  Created by Andreas Verhoeven on 04/06/2021.
//

import Foundation

// taken from https://github.com/apple/swift-evolution/blob/main/proposals/0259-approximately-equal.md

extension FloatingPoint {
	@inlinable
	func isSmallerOrAlmostEqual(
		to other: Self,
		tolerance: Self = Self.ulpOfOne.squareRoot()
	) -> Bool {
		return self < other || isAlmostEqual(to: other, tolerance: tolerance)
	}

	@inlinable
	func isLargerOrAlmostEqual(
		to other: Self,
		tolerance: Self = Self.ulpOfOne.squareRoot()
	) -> Bool {
		return self > other || isAlmostEqual(to: other, tolerance: tolerance)
	}

	@inlinable
	func isAlmostEqual(
		to other: Self,
		tolerance: Self = Self.ulpOfOne.squareRoot()
	) -> Bool {
		assert(tolerance >= .ulpOfOne && tolerance < 1, "tolerance should be in [.ulpOfOne, 1).")

		guard self.isFinite && other.isFinite else {
			return rescaledAlmostEqual(to: other, tolerance: tolerance)
		}

		let scale = max(abs(self), abs(other), .leastNormalMagnitude)
		return abs(self - other) < scale*tolerance
	}

	@inlinable
	func isAlmostZero(
		absoluteTolerance tolerance: Self = Self.ulpOfOne.squareRoot()
	) -> Bool {
		assert(tolerance > 0)
		return abs(self) < tolerance
	}

	@usableFromInline
	func rescaledAlmostEqual(to other: Self, tolerance: Self) -> Bool {
		if self.isNaN || other.isNaN { return false }
		if self.isInfinite {
			if other.isInfinite { return self == other }
			let scaledSelf = Self(sign: self.sign,
								  exponent: Self.greatestFiniteMagnitude.exponent,
								  significand: 1)
			let scaledOther = Self(sign: .plus,
								   exponent: -1,
								   significand: other)
			return scaledSelf.isAlmostEqual(to: scaledOther, tolerance: tolerance)
		}

		return other.rescaledAlmostEqual(to: self, tolerance: tolerance)
	}
}
