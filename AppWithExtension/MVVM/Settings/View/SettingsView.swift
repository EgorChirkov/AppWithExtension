//
//  SettingsView.swift
//  AppWithExtension
//
//  Created by Егор Чирков on 24.11.2022.
//

import SwiftUI

struct SettingsView: View {
    
    @StateObject private var viewModel: SettingsViewModel = .init()
    
    var body: some View {
        Text("Settings View")
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
