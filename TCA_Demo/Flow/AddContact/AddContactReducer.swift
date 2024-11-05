//
//  AddContactReducer.swift
//  TCA_Demo
//
//  Created by Roman Korobskoy on 04.11.2024.
//

import Foundation
import ComposableArchitecture

@Reducer
struct AddContactReducer {

   @ObservableState
   struct State: Equatable {
      var contact: Contact
   }

   enum Action {
      case setName(String)
      case cancelButtonTapped
      case saveButtonTapped
      case delegate(Delegate)

      enum Delegate: Equatable {
         case saveContact(Contact)
      }
   }

   @Dependency(\.dismiss)
   var dismiss

   var body: some ReducerOf<Self> {
      Reduce { state, action in
         switch action {
         case .setName(let name):
            state.contact.name = name
            return .none

         case .cancelButtonTapped:
            return .run { _ in await self.dismiss() }

         case .delegate:
            return .none

         case .saveButtonTapped:
            return .run { [contact = state.contact] send in
               await send(.delegate(.saveContact(contact)))
               await self.dismiss()
            }
         }
      }
   }
}
