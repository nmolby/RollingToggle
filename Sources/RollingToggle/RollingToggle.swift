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
public struct RollingToggle: ToggleStyle {
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
                RollingToggleHelper(
                    firstView: subviews[0],
                    secondView: subviews[1],
                    rotationCount: rotationCount,
                    axis: axis,
                    isOn: configuration.$isOn
                )
            }
        }
    }
}

private struct RollingToggleHelper: View {
    let firstView: Subview
    let secondView: Subview
    let rotationCount: Int
    let axis: Axis
    
    @Binding var isOn: Bool
    
    var frameAlignment: Alignment {
        switch axis {
        case .horizontal:
            isOn ? .leading : .trailing
        case .vertical:
            isOn ? .top : .bottom
        }
    }
    
    var maxWidth: CGFloat? {
        axis == .horizontal ? .infinity : nil
    }
    
    var maxHeight: CGFloat? {
        axis == .vertical ? .infinity : nil
    }
    
    var body: some View {
        Button {
            withAnimation(.bouncy) {
                isOn.toggle()
            }
        } label: {
            rollingView
                .rotationEffect(
                    isOn ? .zero : .degrees(Double(360 * rotationCount))
                )
                .frame(
                    maxWidth: maxWidth,
                    maxHeight: maxHeight,
                    alignment: frameAlignment
                )
                .contentShape(.rect)
        }
        .buttonStyle(.plain)
    }
    
    var rollingView: some View {
        ZStack {
            firstView
                .opacity(isOn ? 1 : 0)
            
            secondView
                .opacity(isOn ? 0 : 1)
        }
    }
    
}

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
        .toggleStyle(RollingToggle(rotationCount: 1, axis: .vertical))
    }
    .font(.system(size: 75))
    .frame(width: 300)
    .toggleStyle(RollingToggle(rotationCount: 1))

}
