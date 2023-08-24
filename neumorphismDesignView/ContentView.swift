//
//  ContentView.swift
//  CurvedScreenView
//
//  Created by Mekala Vamsi Krishna on 8/24/23.
//

import SwiftUI

extension Color {
    static let offWhite = Color(red: 225 / 255, green: 225 / 255, blue: 235 / 255)
    
    static let darkStart = Color(red: 50 / 255, green: 60 / 255, blue: 65 / 255)
    static let darkEnd = Color(red: 25 / 255, green: 25 / 255, blue: 30 / 255)
    
    static let lightStart = Color(red: 60 / 255, green: 160 / 255, blue: 240 / 255)
    static let lightEnd = Color(red: 30 / 255, green: 60 / 255, blue: 80 / 255)
}

extension LinearGradient {
    init(_ colors: Color...) {
        self.init(gradient: Gradient(colors: colors), startPoint: .topLeading, endPoint: .bottomTrailing)
    }
}

struct SimpleButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(30)
            .background {
                Group {
                    if configuration.isPressed {
                        Circle()
                            .fill(Color.offWhite)
                            .overlay {
                                Circle()
                                    .stroke(Color.gray, lineWidth: 4)
                                    .blur(radius: 4)
                                    .offset(x: 2, y: 2)
                                    .mask {
                                        Circle()
                                            .fill(LinearGradient(Color.black, Color.clear))
                                    }
                            }
                            .overlay {
                                Circle()
                                    .stroke(Color.white, lineWidth: 8)
                                    .blur(radius: 4)
                                    .offset(x: -2, y: -2)
                                    .mask {
                                        Circle()
                                            .fill(LinearGradient(Color.clear, Color.black))
                                    }
                            }
                    } else {
                        Circle()
                            .fill(Color.offWhite)
                            .shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10)
                            .shadow(color: Color.white.opacity(0.7), radius: 10, x: -5, y: -5)
                    }
                }
            }
    }
}

struct DarkBackground<S: Shape>: View {
    var isHighlighted: Bool
    var shape: S
    
    var body: some View {
        if isHighlighted {
            shape
                .fill(LinearGradient(Color.darkEnd, Color.darkStart))
                .overlay(content: {
                    shape.stroke(LinearGradient(Color.darkStart, Color.darkEnd), lineWidth: 4)
                })
                .shadow(color: Color.darkStart, radius: 10, x: 5, y: 5)
                .shadow(color: Color.darkEnd, radius: 10, x: -5, y: -5)
        } else {
            shape
                .fill(LinearGradient(Color.darkStart, Color.darkEnd))
                .overlay(content: {
                    shape.stroke(Color.darkEnd, lineWidth: 4)
                })
                .shadow(color: Color.darkStart, radius: 10, x: -10, y: -10)
                .shadow(color: Color.darkStart, radius: 10, x: 10, y: 10)
        }
    }
}

struct ColorfulBackground<S: Shape>: View {
    var isHighlighted: Bool
    var shape: S
    
    var body: some View {
        if isHighlighted {
            shape
                .fill(LinearGradient(Color.lightEnd, Color.lightStart))
                .overlay(content: {
                    shape.stroke(LinearGradient(Color.lightStart, Color.lightEnd), lineWidth: 4)
                })
                .shadow(color: Color.lightStart, radius: 10, x: 5, y: 5)
                .shadow(color: Color.lightEnd, radius: 10, x: -5, y: -5)
        } else {
            shape
                .fill(LinearGradient(Color.darkStart, Color.darkEnd))
                .overlay(content: {
                    shape.stroke(LinearGradient(Color.lightStart, Color.lightEnd), lineWidth: 4)
                })
                .shadow(color: Color.darkStart, radius: 10, x: -10, y: -10)
                .shadow(color: Color.darkStart, radius: 10, x: 10, y: 10)
        }
    }
}

struct DarkButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(30)
            .containerShape(Circle())
            .background {
                DarkBackground(isHighlighted: configuration.isPressed, shape: Circle())
            }
            .animation(nil)
    }
}

struct DarkToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button {
            configuration.isOn.toggle()
        } label: {
            configuration.label
                .padding(30)
                .containerShape(Circle())
        }
        .background {
            DarkBackground(isHighlighted: configuration.isOn, shape: Circle())
        }

    }
}

struct ColorfulButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(30)
            .containerShape(Circle())
            .background {
                ColorfulBackground(isHighlighted: configuration.isPressed, shape: Circle())
            }
            .animation(nil)
    }
}

struct ColorfulToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button {
            configuration.isOn.toggle()
        } label: {
            configuration.label
                .padding(30)
                .containerShape(Circle())
        }
        .background {
            ColorfulBackground(isHighlighted: configuration.isOn, shape: Circle())
        }

    }
}

struct ContentView: View {
    @State private var isToggled = false
    
    var body: some View {
        ZStack {
            LinearGradient(Color.darkStart, Color.darkEnd)
        
            VStack(spacing: 80) {
                Button {
                    print("Button Tapped")
                } label: {
                    Image(systemName: "heart.fill")
                        .foregroundColor(.pink)
                }
                .buttonStyle(ColorfulButtonStyle())
                
                Toggle(isOn: $isToggled) {
                    Image(systemName: "heart.fill")
                        .foregroundColor(.white)
                }
                .toggleStyle(ColorfulToggleStyle())
            }
        }
        .ignoresSafeArea()
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
