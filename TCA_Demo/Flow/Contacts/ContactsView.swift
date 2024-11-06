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
      NavigationStack(path: $store.scope(state: \.path, action: \.path)) {
         List {
            ForEach(store.contacts) { contact in
               NavigationLink(state: ContactDetailsReducer.State(contact: contact)) {
                  HStack {
                     Text(contact.name)
                     Spacer()
                     Button {
                        store.send(.deleteButtonTapped(id: contact.id))
                     } label: {
                        Image(systemName: "trash")
                           .foregroundColor(.red)
                     }
                  }
               }
               .buttonStyle(.borderless)
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
      } destination: { store in
         ContactDetailsView(store: store)
      }
      .sheet(
         item: $store.scope(state: \.destination?.addContact, action: \.destination.addContact)
      ) { addContactStore in
         NavigationStack {
            AddContactView(store: addContactStore)
         }
      }
      .alert($store.scope(state: \.destination?.alert, action: \.destination.alert))
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
