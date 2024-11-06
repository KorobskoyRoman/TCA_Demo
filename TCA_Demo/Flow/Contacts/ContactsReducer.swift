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
      var contacts: IdentifiedArrayOf<Contact> = []
      @Presents var destination: Destination.State?
      var path = StackState<ContactDetailsReducer.State>()
   }

   enum Action {
      case addButtonTapped
      case deleteButtonTapped(id: Contact.ID)
      case destination(PresentationAction<Destination.Action>)
      case path(StackAction<ContactDetailsReducer.State, ContactDetailsReducer.Action>)

      enum Alert: Equatable {
         case confirmDeletion(id: Contact.ID)
      }
   }

   var body: some ReducerOf<Self> {
      Reduce { state, action in
         switch action {
         case .addButtonTapped:
            state.destination = .addContact(AddContactReducer.State(contact: .init(id: UUID(), name: "")))
            return .none

         case let .destination(.presented(.addContact(.delegate(.saveContact(contact))))):
            state.contacts.append(contact)
            return .none

         case let .deleteButtonTapped(id: id):
            state.destination = .alert(AlertState {
               TextState("Are you sure?")
            } actions: {
               ButtonState(role: .destructive, action: .confirmDeletion(id: id)) {
                  TextState("Delete")
               }
            })

            return .none

         case let .destination(.presented(.alert(.confirmDeletion(id: id)))):
            state.contacts.remove(id: id)
            return .none

         case .destination:
            return .none

         case let .path(.element(id: id, action: .delegate(.confirmDeletion))):
            guard let detailState = state.path[id: id]
            else { return .none }
            state.contacts.remove(id: detailState.contact.id)
            return .none

         case .path:
            return .none
         }
      }
      .ifLet(\.$destination, action: \.destination)
      .forEach(\.path, action: \.path) {
         ContactDetailsReducer()
      }
   }
}

extension ContactsReducer {

   @Reducer
   enum Destination {
      case addContact(AddContactReducer)
      case alert(AlertState<ContactsReducer.Action.Alert>)
   }
}

extension ContactsReducer.Destination.State: Equatable {}
