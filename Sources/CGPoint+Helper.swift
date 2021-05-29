//
//  CGPoint+Helper.swift
//  GeometryHelpers
//
//  Created by Andreas Verhoeven on 13/05/2021.
//

import UIKit

public extension CGPoint {
	/// Returns this point with a different `x` coordinate
	func with(x: CGFloat) -> CGPoint {
		return CGPoint(x: x, y: y)
	}

	/// Returns this point with a different `y` coordinate
	func with(y: CGFloat) -> CGPoint {
		return CGPoint(x: x, y: y)
	}

	/// Returns this point offsetted by another `point`
	func offsetted(by point: CGPoint) -> CGPoint {
		return CGPoint(x: x + point.x, y: y + point.y)
	}

	/// Returns this point offsetted by the given `x` and `y` values
	func offsetted(x: CGFloat = 0, y: CGFloat = 0) -> CGPoint {
		return CGPoint(x: self.x + x, y: self.y + y)
	}

	/// Returns this point "reverse" offsetted by the given `point`
	/// (We calculate back where this point would have been after it got offsetted by the given `point`)
	func reverseOffsetted(by point: CGPoint) -> CGPoint {
		return CGPoint(x: x - point.x, y: y - point.y)
	}

	/// Returns this point offsetted by the given insets
	func offsetted(by insets: UIEdgeInsets) -> CGPoint {
		return CGPoint(x: x + insets.left, y: y + insets.top)
	}

	/// Returns this point "reverse" offsetted by the given `insets`
	/// (We calculate back where this point would have been after it got offsetted by the given `insets`)
	func reverseOffsetted(by insets: UIEdgeInsets) -> CGPoint {
		return CGPoint(x: x - insets.left, y: y - insets.top)
	}

	/// Returns this point offsetted by the given insets
	func offsetted(by insets: NSDirectionalEdgeInsets) -> CGPoint {
		return CGPoint(x: x + insets.leading, y: y + insets.top)
	}

	/// Returns this point "reverse" offsetted by the given `insets`
	/// (We calculate back where this point would have been after it got offsetted by the given `insets`)
	func reverseOffsetted(by insets: NSDirectionalEdgeInsets) -> CGPoint {
		return CGPoint(x: x - insets.leading, y: y - insets.top)
	}

	/// Returns this point mirrored along side the y-axis
	var mirrored: CGPoint {
		return CGPoint(x: -x, y: y)
	}

	/// Returns this point flipped along side the x-axis
	var flipped: CGPoint {
		return CGPoint(x: x, y: -y)
	}

	/// calculates the slope of the line from this point to another point
	func slope(to other: CGPoint) -> CGFloat {
		let widthDiff = (other.x - x)
		guard widthDiff != 0 else { return 0 }
		return  (other.y - y) / widthDiff
	}

	/// Returns this point rounded to the nearest pixel
	var roundedToNearestPixel: CGPoint {
		return CGPoint(x: x.roundedToNearestPixel, y: y.roundedToNearestPixel)
	}

	/// Returns this point rounded to the ceiled pixel
	var ceiledToNearestPixel: CGPoint {
		return CGPoint(x: x.ceiledToNearestPixel, y: y.ceiledToNearestPixel)
	}

	/// Returns this point floored to the ceiled pixel
	var flooredNearestPixel: CGPoint {
		return CGPoint(x: x.flooredToNearestPixel, y: y.flooredToNearestPixel)
	}
}
