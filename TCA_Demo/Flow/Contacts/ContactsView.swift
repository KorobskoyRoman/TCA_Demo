//
//  ContactsView.swift
//  TCA_Demo
//
//  Created by Roman Korobskoy on 04.11.2024.
//

import SwiftUI
import ComposableArchitecture

struct ContactsView: View {

   @Bindable var store: StoreOf<ContactsReducer>

   var body: some View {
      NavigationStack {
         List {
            ForEach(store.contacts) { contact in
               Text(contact.name)
            }
         }
         .navigationTitle("Contacts")
         .toolbar {
            ToolbarItem {
               Button {
                  store.send(.addButtonTapped)
               } label: {
                  Image(systemName: "plus")
               }
            }
         }
      }
      .sheet(item: $store.scope(state: \.addContact, action: \.addContact)) { addContactsStore in
         NavigationStack {
            AddContactView(store: addContactsStore)
         }
      }
   }
}

#Preview {
  ContactsView(
    store: Store(
      initialState: ContactsReducer.State(
        contacts: [
          Contact(id: UUID(), name: "Blob"),
          Contact(id: UUID(), name: "Blob Jr"),
          Contact(id: UUID(), name: "Blob Sr"),
        ]
      )
    ) {
       ContactsReducer()
    }
  )
}
