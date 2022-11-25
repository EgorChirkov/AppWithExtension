//
//  NumbersView.swift
//  AppWithExtension
//
//  Created by Егор Чирков on 24.11.2022.
//

import SwiftUI

struct NumbersView: View {
    
    @EnvironmentObject private var globalAppData: GlobalAppData
    
    @StateObject private var viewModel: NumbersViewModel = .init()
    
    var body: some View {
        NavigationView {
            
            VStack(spacing: 20){
                
                Picker("", selection: $viewModel.selection) {
                    ForEach(0..<viewModel.segments.count) { index in
                        Text(viewModel.segments[index])
                            .foregroundColor(.blue)
                            .tag(index)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)
                
                TextField("Search", text: $viewModel.searchText)
                    .padding(4)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5).stroke(Color(#colorLiteral(red: 0.675, green: 0.675, blue: 0.675, alpha: 1)), lineWidth: 1)
                        
                    )
                    .padding(.horizontal)
                
                if viewModel.selection == 0{
                    List{
                        ForEach(viewModel.items, id: \.id) { item in
                            ListItemRow(item: item)
                        }
                    }
                    .listStyle(.plain)
                }
                
                if viewModel.selection == 1{
                    List{
                        ForEach(viewModel.itemsTop.prefix(10), id: \.id) { item in
                            ListItemRow(item: item)
                        }
                    }
                    .listStyle(.plain)
                }
            }
            
            .onAppear{
                viewModel.onAppear(for: globalAppData)
            }
            
            .navigationTitle("Numbers View")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NumbersView()
    }
}

private struct ListItemRow: View {
    
    let item: ListItem
    
    var body: some View {
        HStack{
            Text(item.word)
            
            Spacer()
            
            Text("\(item.count)")
        }
    }
}
