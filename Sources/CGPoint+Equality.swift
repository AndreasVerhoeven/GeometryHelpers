//
//  CGPoint+Equality.swift
//  GeometryHelpers
//
//  Created by Andreas Verhoeven on 04/06/2021.
//

import UIKit

extension CGPoint {
	/// Checks if this line is almost equal to the other, with a given tolerance
	func isAlmostEqual(to other: Self, tolerance: CGFloat = .defaultGeometryTolerance) -> Bool {
		return x.isAlmostEqual(to: other.x, tolerance: tolerance) && y.isAlmostEqual(to: other.y, tolerance: tolerance)
	}
}
