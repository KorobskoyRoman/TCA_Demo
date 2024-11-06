//
//  ContactDetailsReducer.swift
//  TCA_Demo
//
//  Created by Roman Korobskoy on 05.11.2024.
//

import Foundation
import ComposableArchitecture

@Reducer
struct ContactDetailsReducer {

   @ObservableState
   struct State: Equatable {
      @Presents var alert: AlertState<Action.Alert>?
      let contact: Contact
   }

   enum Action {
      case alert(PresentationAction<Alert>)
      case delegate(Delegate)
      case deleteButtonTapped

      enum Alert {
         case confirmDeletion
      }

      enum Delegate {
         case confirmDeletion
      }
   }

   @Dependency(\.dismiss)
   var dismiss

   var body: some ReducerOf<Self> {
      Reduce { state, action in
         switch action {
         case .alert(.presented(.confirmDeletion)):
            return .run { send in
               await send(.delegate(.confirmDeletion))
               await self.dismiss()
            }

         case .alert:
            return .none

         case .delegate:
            return .none

         case .deleteButtonTapped:
            state.alert = .confirmDeletion
            return .none
         }
      }
      .ifLet(\.$alert, action: \.alert)
   }
}

extension AlertState where Action == ContactDetailsReducer.Action.Alert {
   static let confirmDeletion = Self {
      TextState("Are you sure?")
   } actions: {
      ButtonState(role: .destructive, action: .confirmDeletion) {
         TextState("Delete")
      }
   }
}
