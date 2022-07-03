//
//  CGFloat+Helpers.swift
//  GeometryHelpers
//
//  Created by Andreas Verhoeven on 13/05/2021.
//

import UIKit

public extension CGFloat {
	/// the height of a `hairline`, corresponding to 1 __pixel__, not points.
	static var hairLineHeight: CGFloat {
		let scale = UIScreen.main.scale
		return 1.0 / Swift.max(1, scale)
	}

	/// Rounds this value to the nearest __pixel__
	/// On devices where scale != 1, pixels on the screen
	/// have fractional values. This function ensures that we round
	/// to one of those fractional values, so views won't be blurry.
	var roundedToNearestPixel: CGFloat {
		let scale = UIScreen.main.scale
		return (self * scale).rounded() / scale
	}

	/// Ceils this value to the nearest __pixel__
	/// On devices where scale != 1, pixels on the screen
	/// have fractional values. This function ensures that we ceil
	/// to one of those fractional values, so views won't be blurry.
	var ceiledToNearestPixel: CGFloat {
		let scale = UIScreen.main.scale
		return ceil(self * scale) / scale
	}

	/// Floors this value to the nearest __pixel__
	/// On devices where scale != 1, pixels on the screen
	/// have fractional values. This function ensures that we floor
	/// to one of those fractional values, so views won't be blurry.
	var flooredToNearestPixel: CGFloat {
		let scale = UIScreen.main.scale
		return floor(self * scale) / scale
	}
	
	
	/// the tolerance used by default for geometry calculations
	static var defaultGeometryTolerance = Self.ulpOfOne.squareRoot()
}
