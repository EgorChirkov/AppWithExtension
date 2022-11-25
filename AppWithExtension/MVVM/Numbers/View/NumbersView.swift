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
            
            VStack{
                
                Picker("", selection: $viewModel.selection) {
                    ForEach(0..<viewModel.segments.count) { index in
                        Text(viewModel.segments[index])
                            .foregroundColor(.blue)
                            .tag(index)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)
                
                if viewModel.selection == 0{
                    List{
                        ForEach(viewModel.items, id: \.id) { item in
                            HStack{
                                Text(item.word)
                                
                                Spacer()
                                
                                Text("\(item.count)")
                            }
                        }
                    }
                }
                
                if viewModel.selection == 1{
                    List{
                        ForEach(viewModel.itemsTop.prefix(10), id: \.id) { item in
                            HStack{
                                Text(item.word)
                                
                                Spacer()
                                
                                Text("\(item.count)")
                            }
                        }
                    }
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
