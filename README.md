# GeometryHelpers
iOS CGSize, CGPoint, CGRect, CGFloat helpers

### CGFloat

Helpers such as `roundedToNearestPixel` to round a float to the nearest pixel, instead of point. Useful when aligning on pixel boundaries.

## CGPoint

Helpers such as `with(x:)`, `with(y:)` to quickly change a component.

## CGSize

## CGRect

## UIView

When setting the `center` and `bounds` of a `UIView`, one must take special care that the view is actually aligned on pixel boundaries. If not, the view
will be slightly blurry, because the pixels of the grid do not align with the pixel grid of the device. 

`safeCenter` and `safeSize` automatically do this for you: they make sure that the **untransformed** frame of the view will be pixel aligned. 

Using `UIView.frame` compensates for the current `transform` of the view: it literally returns the actual position. More often than not, one wants 
to set the frame irregardless of the `transform`, for example, when doing a scale animation. A way to do this is to set the `center` and `bounds`.

`safeFrame` wraps this by calculating the `safeCenter` and `safeSize` for you and setting it correctly, ignoring any transforms. 
