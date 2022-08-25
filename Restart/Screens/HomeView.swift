//
//  HomeView.swift
//  Restart
//
//  Created by Developer on 24/08/2022.
//

import SwiftUI

struct HomeView: View {
    @AppStorage("onBoarding") var isOnBoardingViewActive: Bool =  false
    @State var isAnimating: Bool = false
    var body: some View {
       
            VStack(spacing:20) {
                Spacer()
                // MARK: - HEADER
                ZStack {
                    CircleGroupView(ShapeColor: .gray, ShapeOpacity: 0.1)
                    Image("character-2")
                        .resizable()
                        .scaledToFit()
                        .offset(y: isAnimating ? 35: -35)
                        .animation(Animation
                                .easeInOut(duration: 4).repeatForever(),value: isAnimating)
                }
                // : HEADER
                
                // MARK: - CENTER
                
                HStack {
                    Text("""
                         The time that leads to mastery is
                         dependent on the intensity of our
                         focus
                         """)
                        .font(.title)
                        .fontWeight(.light)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 10)
                } // : CENTER
                
                // MARK: - FOOTER
                Spacer()
                    Button(action:
                            {
                        withAnimation() {
                            playSound(sound: "success", type: "m4a")
                            isOnBoardingViewActive = true
                        }
                      
                    }, label: {
                        Image(systemName: "arrow.triangle.2.circlepath.circle.fill")
                            .imageScale(.large)
                            .foregroundColor(.white)
                        Text("Restart")
                            .font(.system(.title3, design: .rounded))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    })
                    .buttonStyle(.borderedProminent)
                    .buttonBorderShape(.capsule)
                    .controlSize(.large)
                    
            }.onAppear(perform: {
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                    isAnimating = true
                })
                
                
            })
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
        
    }
}
