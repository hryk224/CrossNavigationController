# CrossNavigationcontroller

Move to cross using `UINavigationController`

<table>
<tr>
<td> -2, 2 </td>
<td> -1, 2 </td>
<td> 0, 2 </td>
<td> 1, 2 </td>
<td> 2, 2 </td>
</tr>
<tr>
<td> -2, 1 </td>
<td> -1, 1 </td>
<td> 0, 1 </td>
<td> 1, 1 </td>
<td> 2, 1 </td>
</tr>
<tr>
<td> -2, 0 </td>
<td> -1, 0 </td>
<td> 0, 0 </td>
<td> 1, 0 </td>
<td> 2, 0 </td>
</tr>
<tr>
<td> -2, -1 </td>
<td> -1, -1 </td>
<td> 0, -1 </td>
<td> 1, -1 </td>
<td> 2, -1 </td>
</tr>
<tr>
<td> -2, -2 </td>
<td> -1, -2 </td>
<td> 0, -2 </td>
<td> 1, -2 </td>
<td> 2, 2  </td>
</tr>
</table>

[![CocoaPods Compatible](http://img.shields.io/cocoapods/v/CrossNavigationcontroller.svg?style=flat)](http://cocoadocs.org/docsets/CrossNavigationcontroller)
[![Swift 3.0](https://img.shields.io/badge/Swift-3.0-orange.svg?style=flat)](https://developer.apple.com/swift/)

<img src="https://github.com/hryk224/CrossNavigationcontroller/wiki/images/sample.gif" width="320" >

<img src="https://github.com/hryk224/CrossNavigationcontroller/wiki/images/sample2.gif" width="320" >

## Requirements
- iOS 9.0+
- Swift 3.0+
- ARC

## install

#### CocoaPods

Adding the following to your `Podfile` and running `pod install`:

```Ruby
use_frameworks!
pod "CrossNavigationcontroller"
```

### import

```Swift
import CrossNavigationcontroller
```

## Usage

#### initialize

```Swift
override func viewDidLoad() {
  super.viewDidLoad()
  // Required setup
  configure(manager: Cross(rootCoordinate: (0, 0))) // initial position
}
```

##### move (push, pop)

```Swift
func moveViewController(_ viewController: CrossViewController, direction : Cross.Direction, animated: Bool)
```

`Cross.Direction` => `.up` or `.down` or `.left` or `right`

##### move to root
```Swift
// UINavigationController method
func popToRootViewController(animated: Bool) -> [UIViewController]?
```

## License

This project is made available under the MIT license. See LICENSE file for details.
