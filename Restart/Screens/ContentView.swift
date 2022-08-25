//
//  ContentView.swift
//  Restart
//
//  Created by Developer on 24/08/2022.
//

import SwiftUI

struct ContentView: View {
    
    @AppStorage("onBoarding") var isOnBoardingViewActive: Bool =  true
    
    var body: some View {
        
        if (isOnBoardingViewActive) {
            OnBoardingView()
        } else {
           HomeView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
