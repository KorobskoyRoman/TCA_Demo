//
//  ContactsReducer.swift
//  TCA_Demo
//
//  Created by Roman Korobskoy on 04.11.2024.
//

import Foundation
import ComposableArchitecture

@Reducer
struct ContactsReducer {

   @ObservableState
   struct State: Equatable {
      @Presents var addContact: AddContactReducer.State?
      var contacts: IdentifiedArrayOf<Contact> = []
   }

   enum Action {
      case addButtonTapped
      case addContact(PresentationAction<AddContactReducer.Action>)
   }

   var body: some ReducerOf<Self> {
      Reduce { state, action in
         switch action {
         case .addButtonTapped:
            state.addContact = AddContactReducer.State(contact: .init(id: UUID(), name: ""))
            return .none

         case let .addContact(.presented(.delegate(.saveContact(contact)))):
            state.contacts.append(contact)
            return .none

         case .addContact:
            return .none
         }
      }
      .ifLet(\.$addContact, action: \.addContact) {
         AddContactReducer()
      }
   }
}
