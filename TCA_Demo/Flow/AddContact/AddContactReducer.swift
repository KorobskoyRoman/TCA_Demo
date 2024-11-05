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

   struct State: Equatable {
      var contact: Contact
   }

   enum Action {
      case setName(String)
      case cancelButtonTapped
      case saveButtonTapped
   }

   var body: some ReducerOf<Self> {
      Reduce { state, action in
         switch action {
         case .setName(let name):
            state.contact.name = name
            return .none

         case .cancelButtonTapped:
            return .none

         case .saveButtonTapped:
            return .none
         }
      }
   }
}
