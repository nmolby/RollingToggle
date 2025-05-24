import SwiftUI

/// A toggle style that rolls between two views
///
/// Provide exactly two views inside of your toggle.
/// The toggle will roll between them `rotationCount` times
///
/// ```swift
/// Toggle(isOn: $isOn) {
///     Text("😀")
///     Text("🙁")
/// }
/// .toggleStyle(RollingToggle())
/// ```
///
/// You can also specify the axis and the rotation count
///
/// ```swift
/// Toggle(isOn: $isOn) {
///     Text("😀")
///     Text("🙁")
/// }
/// .toggleStyle(RollingToggle(rotationCount: 3, axis: .vertical))
/// ```
/// - Parameters:
///   - rotationCount: Number of times the first view rotates to become the second view
///   - axis: The axis to move across
@available(iOS 18.0, macOS 15, *)
public struct RollingToggleStyle: ToggleStyle {
    let rotationCount: Int
    let axis: Axis
    
    init(rotationCount: Int = 1, axis: Axis = .horizontal) {
        self.rotationCount = rotationCount
        self.axis = axis
    }
    
    public func makeBody(configuration: Configuration) -> some View {
        Group(subviews: configuration.label) { subviews in
            if subviews.count != 2 {
                EmptyView()
            } else {
                RollingToggle(
                    isOn: configuration.$isOn,
                    rotationCount: rotationCount,
                    axis: axis,
                    firstView: {
                        subviews[0]
                    },
                    secondView: {
                        subviews[1]
                    }
                )
            }
        }
    }
}

@available(iOS 18.0, macOS 15, *)
#Preview {
    @Previewable @State var isOn = true
    VStack(spacing: 20) {
        Toggle(isOn: $isOn) {
            Text("😀")
            Text("🙁")
        }
        .background {
            Group {
                if isOn {
                    Color.blue.opacity(0.2)
                } else {
                    Color.red.opacity(0.2)
                }
            }
            .mask {
                RoundedRectangle(cornerRadius: 8)
            }
        }
        
        Toggle(isOn: $isOn) {
            Image(systemName: "eyebrow")
            Image(systemName: "nose")
        }
        .foregroundStyle(isOn ? .orange : .purple)
        .background {
            Group {
                if isOn {
                    Color.green.opacity(0.2)
                } else {
                    Color.mint.opacity(0.2)
                }
            }
            .mask {
                RoundedRectangle(cornerRadius: 8)
            }
        }
        .frame(width: 200)
        
        Toggle(isOn: $isOn) {
            Image(systemName: "hand.thumbsup")
            Image(systemName: "hand.thumbsdown.fill")
        }
        .foregroundStyle(isOn ? .pink : .cyan)
        .background {
            Group {
                if isOn {
                    Color.indigo.opacity(0.2)
                } else {
                    Color.teal.opacity(0.2)
                }
            }
            .mask {
                RoundedRectangle(cornerRadius: 8)
            }
        }
        .frame(height: 200)
        .toggleStyle(RollingToggleStyle(rotationCount: 1, axis: .vertical))
    }
    .font(.system(size: 75))
    .frame(width: 300)
    .toggleStyle(RollingToggleStyle(rotationCount: 1))
}
