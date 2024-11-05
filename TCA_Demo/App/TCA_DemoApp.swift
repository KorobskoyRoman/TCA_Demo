//
//  TCA_DemoApp.swift
//  TCA_Demo
//
//  Created by Roman Korobskoy on 04.11.2024.
//

import SwiftUI
import ComposableArchitecture

@main
struct TCA_DemoApp: App {

   static let store = Store(initialState: MainReducer.State()) {
      MainReducer()
   }

   var body: some Scene {
      WindowGroup {
         MainView(store: TCA_DemoApp.store)
      }
   }
}
