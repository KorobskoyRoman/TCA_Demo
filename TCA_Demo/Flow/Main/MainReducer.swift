//
//  MainReducer.swift
//  TCA_Demo
//
//  Created by Roman Korobskoy on 04.11.2024.
//

import Foundation
import ComposableArchitecture

@Reducer
struct MainReducer {

   struct State: Equatable {
      var tab1 = CounterReducer.State()
      var tab2 = CounterReducer.State()
      var tab3 = ContactsReducer.State()
   }

   enum Action {
      case tab1(CounterReducer.Action)
      case tab2(CounterReducer.Action)
      case tab3(ContactsReducer.Action)
   }

   var body: some ReducerOf<Self> {

      Scope(state: \.tab1, action: \.tab1) {
         CounterReducer()
      }

      Scope(state: \.tab2, action: \.tab2) {
         CounterReducer()
      }

      Scope(state: \.tab3, action: \.tab3) {
         ContactsReducer()
      }

      Reduce { state, action in
         return .none
      }
   }

}
