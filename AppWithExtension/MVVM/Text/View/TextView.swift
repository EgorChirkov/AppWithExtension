//
//  TextView.swift
//  AppWithExtension
//
//  Created by Егор Чирков on 24.11.2022.
//

import SwiftUI

struct TextView: View {
    
    @EnvironmentObject private var globalAppData: GlobalAppData
    
    @StateObject private var viewModel: TextViewModel = .init()
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading){
                
                Text("Enter text")
                
                GeometryReader{ geometry in
                    
                    TextEditor(text: $viewModel.text)
                        .padding(4)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color(#colorLiteral(red: 0.675, green: 0.675, blue: 0.675, alpha: 1)), lineWidth: 1)
                        )
                        .frame(height: geometry.size.height / 2)
                }
            }
            .padding()
            .navigationTitle("Text View")
            .onAppear{
                viewModel.onAppear(for: globalAppData)
            }
            .onDisappear{
                viewModel.onDisappear()
            }
        }

    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        TextView()
    }
}
