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
                    ForEach(viewModel.searchQueries, id: \.id){ item in
                        Text(item.query)
                    }
                }
                .listStyle(.plain)
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
