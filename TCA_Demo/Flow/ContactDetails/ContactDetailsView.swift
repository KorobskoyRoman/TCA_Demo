//
//  ContactDetailsView.swift
//  TCA_Demo
//
//  Created by Roman Korobskoy on 05.11.2024.
//

import SwiftUI
import ComposableArchitecture

struct ContactDetailsView: View {

   @Bindable var store: StoreOf<ContactDetailsReducer>

   var body: some View {
      Form {
         Button("Delete") {
            store.send(.deleteButtonTapped)
         }
      }
      .navigationTitle(Text(store.contact.name))
      .alert($store.scope(state: \.alert, action: \.alert))
   }
}

#Preview {
   NavigationStack {
      ContactDetailsView(
         store: Store(
            initialState: ContactDetailsReducer.State(
               contact: Contact(id: UUID(), name: "Blob")
            )
         ) {
            ContactDetailsReducer()
         }
      )
   }
}
