# RollingToggle

A SwiftUI toggle style that visually **rolls between two views**.

This package provides a custom `ToggleStyle` called `RollingToggle` that animates the transition between two states using a 3D rolling effect.

## Preview

https://github.com/user-attachments/assets/d6fad3d5-cf44-4273-8d1e-7b05e2facfd2

## Features

- Roll between two custom views.
- Customize the number of rotations.
- Specify the axis of rotation (horizontal or vertical).

## Usage

Wrap your toggle content with two views. The toggle will roll between them when toggled.

### Basic Example

```swift
Toggle(isOn: $isOn) {
    Text("😀")
    Text("🙁")
}
.toggleStyle(RollingToggle())
```

### Customizing Axis and Rotation Count

```swift
Toggle(isOn: $isOn) {
    Text("😀")
    Text("🙁")
}
.toggleStyle(RollingToggle(rotationCount: 3, axis: .vertical))
```

## Parameters

- `rotationCount`: `Int` – Number of 360° rotations applied when toggling.
- `axis`: `Axis` – Direction of rotation (`.horizontal` or `.vertical`).



## License

MIT
