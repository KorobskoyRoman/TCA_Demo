//
//  MainReducerTests.swift
//  TCA_DemoTests
//
//  Created by Roman Korobskoy on 04.11.2024.
//

import Testing
import ComposableArchitecture

@testable import TCA_Demo

struct MainReducerTests {

   @Test
   func incrementFirstTab() async {
      let store = TestStore(initialState: MainReducer.State()) {
         MainReducer()
      }

      await store.send(\.tab1.incrementButtonTapped) {
         $0.tab1.count = 1
      }
   }

   @Test
   func incrementSecondTab() async {

   }

}
