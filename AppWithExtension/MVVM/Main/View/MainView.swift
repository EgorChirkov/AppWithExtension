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
            
            HomeView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
                .tag(0)
            
            SettingsView()
                .tabItem {
                    Image(systemName: "gearshape")
                    Text("Settings")
                }
                .tag(1)
        }
        .onOpenURL { url in
            guard url.scheme == "widget-deeplink" else {
                return
            }
            viewModel.onOpenFromWidget(with: url)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
