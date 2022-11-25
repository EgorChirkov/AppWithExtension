//
//  MainView.swift
//  AppWithExtension
//
//  Created by Егор Чирков on 24.11.2022.
//

import SwiftUI

class GlobalAppData: ObservableObject{
    @Published var repeatedWordsDict: [String: Int] = [:]
}

struct MainView: View {
    
    @StateObject private var viewModel: MainViewModel = .init()
    
    @StateObject private var globalAppData: GlobalAppData = .init()
    
    var body: some View {
        
        TabView(selection: $viewModel.selection) {
            
            TextView()
                .tabItem {
                    Image(systemName: "textformat")
                }
                .tag(0)
            
            NumbersView()
                .tabItem {
                    Image(systemName: "list.number")
                }
                .tag(1)
        }
        .environmentObject(globalAppData)
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
