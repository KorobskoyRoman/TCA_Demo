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
   }

   enum Action {
      case tab1(CounterReducer.Action)
      case tab2(CounterReducer.Action)
   }

   var body: some ReducerOf<Self> {

      Scope(state: \.tab1, action: \.tab1) {
         CounterReducer()
      }

      Scope(state: \.tab2, action: \.tab2) {
         CounterReducer()
      }

      Reduce { state, action in
         return .none
      }
   }

}
