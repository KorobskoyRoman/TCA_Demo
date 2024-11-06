//
//  MainView.swift
//  TCA_Demo
//
//  Created by Roman Korobskoy on 04.11.2024.
//

import SwiftUI
import ComposableArchitecture

struct MainView: View {

   let store: StoreOf<MainReducer>

   var body: some View {
      TabView {
         CounterView(store: store.scope(state: \.tab1, action: \.tab1))
            .tabItem {
               Text("Counter 1")
            }
         CounterView(store: store.scope(state: \.tab2, action: \.tab2))
            .tabItem {
               Text("Counter 2")
            }

         ContactsView(store: store.scope(state: \.tab3, action: \.tab3))
            .tabItem {
               Text("Contacts")
            }
      }
   }
}

#Preview {
   MainView(
      store: Store(initialState: MainReducer.State()) {
         MainReducer()
      }
   )
}
