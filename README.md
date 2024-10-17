# GeometryHelpers
iOS CGSize, CGPoint, CGRect, CGFloat helpers

### CGFloat

Helpers such as `roundedToNearestPixel` to round a float to the nearest pixel, instead of point. Useful when aligning on pixel boundaries.

- `hairLineHeight` the height of 1 pixel on the screen
- `roundedToNearestPixel` 
- `ceiledToNearestPixel`
- `flooredToNearestPixel`

## CGPoint

Helpers such as `with(x:)`, `with(y:)` to quickly change a component.

### Creating
- `all(_:)` creates a point with x and y set to the given value
- `x(_:)` creates a point with x set to the given value, y to 0
- `y(_:)` creates a point withyx set to the given value, x to 0

### Changing
- `with(x:)` new point with a given x
- `with(y:)` new point with a given y


### Offset

- `offsetted(by:)` offsetted by another point
- `offsetted(x:y:)` offsetted by some x and y
- `offsetted(by:)` offsetted by insets
- `reverseOffsetted(by:)` undoes the offsetting by another point/insets

### Flipping & Mirroring

- `mirrored` returns a point mirrored alongside the y-axis
- `flipped` returns a point flipped alongside the x-axis

### To Pixel/Point

### To Points/Pixels

- `roundedToNearestPixel` rounds to the nearest pixel
- `ceiledToNearestPixel` ceils to the nearest pixel
- `flooredToNearestPixel` floors to the nearest pixel
- `roundedToFullPoints` rounds to full (integer) points
- `ceiledToFullPoints` ceils to full (integer) points
- `flooredToFullPoints` floors to full (integer) points


### Other:

- `slope(to:)` returns the slope of the line from this point to another point

## CGSize

- `min(_:)` returns the minimum dimensions of self and another size
- `max(_:)` returns the maximum dimensions self and another size

### Creating
- `all(_:)` creates a size with width and height set to the given value

### Converting to Rects 

- `rectAtZeroOrigin` returns `CGRect(origin: .zero, size: self)`
- `center` returns the center point for `rectAtZeroOrigin`


### Changing:

- `with(width:)` returns a new size with a new width
- `with(height:)` returns a new size with a new height
-  `adding(width:height)` returns a new size by adding to the width or height
- `adding(_:)` returns a new size by adding another size
- `adding(_:)` returns a new size by adding the insets


### Subtracting

- `subtracting(width:height:)` subtracts from this size
- `subtracting(_:)` subtracts another size from this size
- `insetted(by:)` insets the size by given insets

### Stacking

- `verticallyStacked(with: spacing)` returns the size that is needed to stack this with other
- `horizontallyStacked(with: spacing)` returns the size that is needed to stack this with other


### To Points/Pixels

- `roundedToNearestPixel()` rounds to the nearest pixel
- `ceiledToNearestPixel()` ceils to the nearest pixel
- `flooredToNearestPixel()` floors to the nearest pixel
- `roundedToFullPoints()` rounds to full (integer) points
- `ceiledToFullPoints()` ceils to full (integer) points
- `flooredToFullPoints()` floors to full (integer) points


### Aspect Fitting


- `sizeThatFitsSize(_:)` returns a size thats in the other size, while maintaining aspect ratio 
- `aspectFill(for:)` returns the size that aspect fills in the given other size
- `aspectFit(for:)` returns the size that aspect fits in the given other size
- `aspectScale(for:)` returns the size that aspect scales in the given size

### Other

 - `isEmpty` true if width or height are <= 0
 - `greatestFiniteMagnitude` both width and height are set to `greatestFiniteMagnitude`, useful for `UIView.sizeThatFits()`

## CGRect

### Derived Points

- `center`
- `topLeft`
- `topRight`
- `bottomLeft`
- `bottomRight`
- `midX`
- `midY`
- `topMiddle`
- `bottomMiddle`
- `midLeft`
- `midRight`

### Changing

- `with(origin:)` returns a new rect with a new origin
- `with(size:)` returns a new rect with a new size
- `with(x:)` returns a new rect with a new x origin
- `with(y:)` returns a new rect with a new y origin
- `with(height:)` returns a new rect with a new height
- `with(width:)` returns a new rect with a new width


### Offsetted

- `offsetted(by:)` returns a new rect offsetted by a point/insets
- `offsetted(x:y:)` returns a new rect offsetted by x and y


### Insettted

- `insetted(top:left:bottom:right)` returns a new rect insetted by the given values

### To Points

- `roundedToNearestPixel` returns a new rect with the corners rounded to the nearest pixels 
- `ceiledToNearestPixel` returns a new rect with the min coordinates floored, the max coordinates ceiled to the nearest pixel

### Fitting

- `rectThatFitsInRect(_:)` returns the rect that fits in this rect, retaining aspect ratio

## UIView

When setting the `center` and `bounds` of a `UIView`, one must take special care that the view is actually aligned on pixel boundaries. If not, the view
will be slightly blurry, because the pixels of the grid do not align with the pixel grid of the device. 

`safeCenter` and `safeSize` automatically do this for you: they make sure that the **untransformed** frame of the view will be pixel aligned. 

Using `UIView.frame` compensates for the current `transform` of the view: it literally returns the actual position. More often than not, one wants 
to set the frame irregardless of the `transform`, for example, when doing a scale animation. A way to do this is to set the `center` and `bounds`.

`safeFrame` wraps this by calculating the `safeCenter` and `safeSize` for you and setting it correctly, ignoring any transforms. 


## Euclidian Geometry Helpers

There are also a bunch of helpers for dealing with simple euclidian geometry:
 
 - `Slope`
 - `Line`
 - `LineSegment`
 - `Circle`
 - `CircleArc`
 
 ### Slope
 
 A slope models the slope of a line. Three cases:
 
- zero: the slope of a strict horizontal line
- infinity: the slope of a strict vertical line
- any other value: the slope of any other line

#### Creating:

- `init(rawValue:)` creates a slope with a given raw value as slope
- `.horizontal` the horizontal slope
- `.vertical` the vertical slope
- `init(from:to:)` creates a slope from the slope of the line between two points

#### Methods:

- `isHorizontal`
- `isVertical`
- `perpendicular` the slope perpendicular to this
- `isAmostEqual(to: tolerance:)`
 
 ### Line

A line goes thru a point with a specific slope and has no start and end point: it goes on forever.

#### Creation

- `init(point:slope:)` creates a line that goes thru a point with a specific slope
- `init(verticalLineAtX:)` creates a vertical line that goes thru the x coordinate
- `init(horizontalLineAtY:)` creates a horizontal line that goes thru the y coordinate
- `init(yIsXTimes:plus:)` creates a line from the formula `y = x * slope + b`
- `init(from:to:)` creates a line that goes thru the two given points
- `init(tangentFromPointOnCircle:center:)` create the line that is tangent for the point on the circle with the given center

#### Methods

- `isHorizontal`
- `isVertical`
- `perpendicular(at:tolerance:)` creates the line that is perpendicular to this line in the given point, if the given point is on this line, otherwise nil.

#### Getting positions/values

- `yValue(forX:)` gets the value of y for the given x, if it exists
- `point(forX:)` get the point for the given x, if it exists
- `xValue(forY:)` gets the value of x for the given y, if it exists
- `point(forY:)` gets the point  foe the given y, if it exists

#### Other

- `contains(other:tolerance:)` checks if this line contains the given point
- `isAlmostEqual(to:tolerance:)` check if this line is equal to another line
- `intersection(with:tolerance:)` gets the intersection result from this line to another line, which could be: `sameLine`, `parallel` or `intersect(at:)`
- `intersectionPoint(with:tolerance:)` returns the intersection point of this line with another line, if there's only one unique intersection point, otherwise nil.


### LineSegment

A line segment is a segment of a line between two points.

#### Creation

- `init(start:end:)` creates a line segment between start and end.

#### Methods

- `line` gets the line for this segment
- `slope` gets the slope of this segment
- `isAlmostEqual(to:tolerance:)` checks if this line segment is equal to another one
- `contains(point:tolerance:)` checks if the given point is contained by the line segment


### Circle

It's a circle :) 

#### Creation

- `init(center:radius:)` creates a circle with a given center and radius

#### Methods

- `isOnCircle(point:tolerance:)` check if the given point is __on__ the circle
- `isInsideCircle(point:tolerance:)` checks if the given point is __inside__ the circle
- `angle(for:tolerance:)` returns the angle (in radians) for a point on the circle
- `point(for:tolerance:)` returns the point for a given angle (in radians)
- `tangent(at:tolerance:`) returns the tangent line for a point on the circle
- `tangent(for:tolerance:)` returns the tangent line for a point at the given angle (in radians) 
- `isAlmostEqual(to:tolerance:)` checks if this circle is the same as another circle


### CircleArc

An arc of a circle. An arc start at a point on a circle and ends at a point on a circle and can go clockwise or counter clockwise.

### Creation

- `init(circle:startPoint:endPoint:clockwise:tolerance:)` creates an arc on the circle from start to end point
- `init(circle:startAngle:endAngle:clockwise:)` creates an arc on the circle from start to end angle
- `init(center:startPoint:endPoint:clockwise:tolerance:)` creates an arc on the circle with the given center going thru startPoint and endPoint.
- `init(center:startPoint:endAngle:clockwise:tolerance:)` creates an arc on the circle with the given start point and end angle

#### Methods

- `contains(angle:tolerance:)` checks if the given angle is contained by the arc
- `contains(point:tolerance:)` checks if the given point on the circle is contained by the arc
- `isAlmostEqual(to: tolerance:)` checks if this arc is equal to another arc
- `clockwise` returns this arc, but in clock wise direction
- `counterClockwise` returns this arc, but in counter clock wise direction
