//
//  HomeView.swift
//  AppWithExtension
//
//  Created by Егор Чирков on 24.11.2022.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject private var viewModel: HomeViewModel = .init()
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading){
                
                Text("Enter text")
                
                TextEditor(text: $viewModel.text)
                    .padding(4)
                    .overlay(
                             RoundedRectangle(cornerRadius: 10)
                               .stroke(Color(#colorLiteral(red: 0.675, green: 0.675, blue: 0.675, alpha: 1)), lineWidth: 1)
                             )
                    .frame(maxHeight: 200)
              
                Spacer()
                   
            }
            .padding()
            .navigationTitle("Home View")
        }

    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
