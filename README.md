# RollingToggle

A SwiftUI toggle style and view that visually **rolls between two states** with a animation.

This package provides two components for animated toggling behavior:

- `RollingToggleStyle`: A `ToggleStyle` available on **iOS 18+ / macOS 15+** that animates between **two subviews** of a `Toggle` using a rolling effect.
- `RollingToggle`: A **standalone view** available on **iOS 13+** that accepts two view closures and toggles between them using the same rolling animation.

## Preview

https://github.com/user-attachments/assets/d6fad3d5-cf44-4273-8d1e-7b05e2facfd2

## Features

- Animated roll between two custom views.
- Customizable rotation count.
- Configurable rotation axis (`horizontal` or `vertical`).
- Backwards-compatible view (`RollingToggle`) for iOS 13+.

## Usage

### Using `RollingToggleStyle` (iOS 18+)

Apply this style to a standard `Toggle` that contains exactly two subviews.

```swift
Toggle(isOn: $isOn) {
    Text("😀")
    Text("🙁")
}
.toggleStyle(RollingToggleStyle())
```

Customize the axis and rotation count:

```swift
Toggle(isOn: $isOn) {
    Text("😀")
    Text("🙁")
}
.toggleStyle(RollingToggleStyle(rotationCount: 3, axis: .vertical))
```

### Using `RollingToggle` (iOS 13+)

Use this view directly when targeting earlier iOS versions.

```swift
RollingToggle(isOn: $isOn) {
    Text("😀")
} secondView: {
    Text("🙁")
}
```

You can also specify axis and rotation count:

```swift
RollingToggle(isOn: $isOn, rotationCount: 2, axis: .vertical) {
    Image(systemName: "sun.max")
} secondView: {
    Image(systemName: "moon")
}
```

## Parameters

- `rotationCount`: `Int` – Number of full 360° rotations applied on toggle.
- `axis`: `Axis` – Direction of rotation (`.horizontal` or `.vertical`).

## License

MIT
