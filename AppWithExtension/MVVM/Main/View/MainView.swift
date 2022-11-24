//
//  MainView.swift
//  AppWithExtension
//
//  Created by Егор Чирков on 24.11.2022.
//

import SwiftUI

struct MainView: View {
    
    @StateObject private var viewModel: MainViewModel = .init()
    
    var body: some View {
        
        TabView(selection: $viewModel.selection) {
            
            Text("Home View")
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
                .tag(0)
            
            Text("Settings View")
                .tabItem {
                    Image(systemName: "gearshape")
                    Text("Settings")
                }
                .tag(1)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
