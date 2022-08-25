//
//  OnBoardingView.swift
//  Restart
//
//  Created by Developer on 24/08/2022.
//

import SwiftUI

struct OnBoardingView: View {
    @AppStorage("onBoarding") var isOnBoardingViewActive: Bool =  true
    @State private var buttonWidth = UIScreen.main.bounds.width-80
    @State private var buttonOfset:CGFloat = 0
    @State private var isAnimating: Bool =  false
    @State private var imageOffset:CGSize = .zero
    @State private var indicatorOpacity: Double = 1.0
    @State private var titleText : String = "Share."
    
    /// <#Description#>
    var body: some View {
        ZStack {
            Color("ColorBlue")
                .ignoresSafeArea(.all, edges: .all)
            VStack( spacing: 20) {
                
                // MARK: - HEADER
                Spacer()
                
                VStack (spacing:0){
                    Text(titleText)
                        .font(.system(size: 60))
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                        .transition(.opacity)
                        .id(titleText)
                    
                    Text("""
                         It's not how much we give but
                         how much love we put into giving.
                         """)
                        .font(.title)
                        .fontWeight(.light)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 10)
                } // : HEADER
                .opacity(isAnimating ? 1:0)
                .offset(y: isAnimating ? 0:-40)
                .animation(.easeOut(duration: 1), value: isAnimating)
                
                // MARK: - CENTER
                
                ZStack {
                    CircleGroupView(ShapeColor: .white, ShapeOpacity: 0.2)
                        .offset(x: imageOffset.width * -1)
                        .blur(radius: abs(imageOffset.width/5))
                        .animation(.easeOut(duration:1), value: imageOffset)
                    Image("character-1")
                        .resizable()
                        .scaledToFit()
                        .opacity(isAnimating ? 1:0)
                        .animation(.easeOut(duration: 0.5), value: isAnimating)
                        .offset(x: imageOffset.width*1.2)
                        .rotationEffect(.degrees(Double(imageOffset.width/20)))
                    
                        .gesture (
                            DragGesture()
                                .onChanged({ gesture in
                                    if (abs(imageOffset.width) <= 150) {
                                        imageOffset = gesture.translation
                                        withAnimation(.linear(duration: 0.25)) {
                                            indicatorOpacity = 0
                                            titleText = "Give."
                                        }
                                    }
                                })
                                .onEnded() { _ in
                                    imageOffset = .zero
                                    withAnimation(.linear(duration: 0.25)) {
                                        indicatorOpacity = 1
                                        titleText = "Share."
                                    }
                                }
                        ) // : Gesture
                        .animation(.easeOut(duration: 1), value: imageOffset)
                } // : CENTER
                .overlay(
                    Image(systemName: "arrow.left.and.right.circle")
                        .font(.system(size: 44, weight: .ultraLight))
                        .foregroundColor(.white)
                        .opacity(isAnimating ? indicatorOpacity : 0)
                        .animation(.easeOut(duration: 1).delay(2), value: isAnimating),alignment: .bottom
                )
                Spacer()
                
                // MARK: - FOTER
                ZStack {
                    // PARTS OF CUSTOM BUTTONS
                    
                    // 1. BACKGROUNDS (STATICS)
                    Capsule()
                        .fill(Color.white.opacity(0.2))
                    
                    Capsule()
                        .fill(Color.white.opacity(0.2))
                        .padding(8)
                    
                    // 2. CALL-TO-ACTION(STATIC)
                    Text("Get Started")
                        .font(.system(.title3, design: .rounded))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .offset(x: 20)
                    
                    // 3. CAPSULE (DYNAMIC WIDTH)
                    HStack {
                        Capsule()
                            .fill(Color("ColorRed"))
                            .frame(width: buttonOfset+80)
                        Spacer()
                    }
                    
                    // 4. CIRCLE (DRAGGABLE)
                    
                    HStack {
                        ZStack {
                            Circle()
                                .fill(Color("ColorRed"))
                            
                            Circle()
                                .fill(.black.opacity(0.15))
                                .padding(8)
                            
                            Image(systemName: "chevron.right.2")
                                .font(.system(size: 24,weight: .bold))
                        }
                        .foregroundColor(.white)
                        .frame(width: 80, height: 80, alignment: .center)
                        .offset(x: buttonOfset)
                        .gesture(
                            DragGesture()
                                .onChanged({ gesture in
                                    if (gesture.translation.width>0 && buttonOfset <= buttonWidth-80) {
                                        buttonOfset = gesture.translation.width
                                    }
                                    
                                })
                                .onEnded({_ in
                                    withAnimation(Animation.easeOut(duration: 0.4)) {
                                        if (buttonOfset > buttonWidth/2) {
                                            playSound(sound: "chimeup", type: "mp3")
                                            buttonOfset = buttonWidth-80
                                            isOnBoardingViewActive = false
                                        } else {
                                            buttonOfset = 0
                                        }
                                        
                                    }
                                    
                                })
                        )//: Gesture
                        Spacer()
                    } //: HSTACK
                    
                } //: FOOTER
                .frame(width:buttonWidth, height: 80, alignment: .center)
                .padding()
                .opacity(isAnimating ? 1:0)
                .offset(y: isAnimating ? 0:40)
                .animation(.easeOut(duration: 1.0), value: isAnimating)
                
            } // : VSTACK
        } //: ZSTACK
        .onAppear(perform: {
            isAnimating = true
        })
        .preferredColorScheme(.dark)
    }
}

struct OnBoardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingView()
    }
}
