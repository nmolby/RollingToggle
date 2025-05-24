import SwiftUI

/// A toggle view that rolls between two content views.
///
/// `RollingToggle` renders two views and switches between them with a rotation
/// effect when toggled. It supports both horizontal and vertical axes of motion,
/// and customizable rotation repetition via `rotationCount`.
///
/// Initialize with two content views using trailing closures, and bind to a
/// `Bool` state to drive the toggle. Rotation will occur upon state change.
///
/// Example:
///
/// ```swift
/// RollingToggle(isOn: $isOn) {
///     Text("On")
/// } secondView: {
///     Text("Off")
/// }
/// ```
///
/// You can also specify the number of rotation cycles and axis:
///
/// ```swift
/// RollingToggle(isOn: $isOn, rotationCount: 2, axis: .vertical) {
///     Image(systemName: "sun.max")
/// } secondView: {
///     Image(systemName: "moon")
/// }
/// ```
///
/// - Parameters:
///   - isOn: A binding to the toggle's state.
///   - rotationCount: The number of full 360° rotations applied on toggle. Default is 1.
///   - axis: The axis to rotate around (.horizontal or .vertical). Default is `.horizontal`.
///   - firstView: The view shown when `isOn` is `true`.
///   - secondView: The view shown when `isOn` is `false`.

public struct RollingToggle<FirstView: View, SecondView: View>: View {
    
    @Binding var isOn: Bool

    @ViewBuilder let firstView: () -> FirstView
    @ViewBuilder let secondView: () -> SecondView
    let rotationCount: Int
    let axis: Axis
    
    
    init(
        isOn: Binding<Bool>,
        rotationCount: Int = 1,
        axis: Axis = .horizontal,
        @ViewBuilder firstView: @escaping () -> FirstView,
        @ViewBuilder  secondView: @escaping () -> SecondView,
    ) {
        self.firstView = firstView
        self.secondView = secondView
        self.rotationCount = rotationCount
        self.axis = axis
        self._isOn = isOn
    }
    
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
    
    public var body: some View {
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
            firstView()
                .opacity(isOn ? 1 : 0)
            
            secondView()
                .opacity(isOn ? 0 : 1)
        }
    }
    
}

@available(iOS 18.0, macOS 15, *)
#Preview {
    @Previewable @State var isOn = true
    VStack(spacing: 20) {
        RollingToggle(isOn: $isOn) {
            Text("On")
        } secondView: {
            Text("Off")
        }
        
        RollingToggle(isOn: $isOn, rotationCount: 2, axis: .vertical) {
            Image(systemName: "sun.max")
        } secondView: {
            Image(systemName: "moon")
        }
        
        RollingToggle(isOn: $isOn, axis: .horizontal) {
            Image(systemName: "hand.thumbsup")
        } secondView: {
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
