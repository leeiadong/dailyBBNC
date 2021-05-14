//
//  ContentView.swift
//  dailyBBNC
//
//  Created by sean on 2021/4/25.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        HomeView().environmentObject(ModelData())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
