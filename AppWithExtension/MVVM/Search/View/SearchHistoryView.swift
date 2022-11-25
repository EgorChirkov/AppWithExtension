//
//  SearchHistoryView.swift
//  AppWithExtension
//
//  Created by Егор Чирков on 25.11.2022.
//

import SwiftUI

struct SearchHistoryView: View {
    
    @EnvironmentObject private var globalAppData: GlobalAppData
    
    @StateObject private var viewModel: SearchHistoryViewModel = .init()
    
    var body: some View {
        NavigationView {
            VStack{
                List{
                    ForEach(viewModel.searchQueries, id: \.self){ item in
                        Text(item)
                    }
                }
            }
            .navigationTitle("Search History")
            
            .onAppear{
                viewModel.onAppear(for: globalAppData)
            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchHistoryView()
    }
}
