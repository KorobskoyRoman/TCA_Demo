//
//  CounterView.swift
//  TCA_Demo
//
//  Created by Roman Korobskoy on 04.11.2024.
//

import SwiftUI
import ComposableArchitecture

struct CounterView: View {

   let store: StoreOf<CounterReducer>

   var body: some View {
      VStack {
         Text("\(store.count)")
            .font(.largeTitle)
            .padding()
            .background(Color.black.opacity(0.1))
            .cornerRadius(10)
         HStack {
            Button("-") {
               store.send(.decrementButtonTapped)
            }
            .font(.largeTitle)
            .padding()
            .background(Color.black.opacity(0.1))
            .cornerRadius(10)

            Button("+") {
               store.send(.incrementButtonTapped)
            }
            .font(.largeTitle)
            .padding()
            .background(Color.black.opacity(0.1))
            .cornerRadius(10)
         }

         Button(store.isTimerRunning ? "Stop timer" : "Start timer") {
            store.send(.toggleTimerButtonTapped)
         }
         .font(.largeTitle)
         .padding()
         .background(Color.black.opacity(0.1))
         .cornerRadius(10)

         Button("Fact") {
            store.send(.factButtonTapped)
         }
         .font(.largeTitle)
         .padding()
         .background(Color.black.opacity(0.1))
         .cornerRadius(10)

         if store.isLoading {
            ProgressView()
         } else if let fact = store.fact {
            Text(fact)
               .font(.largeTitle)
               .multilineTextAlignment(.center)
               .padding()
         }
      }
   }
}

#Preview {
   CounterView(
      store: Store(initialState: CounterReducer.State()) {
         CounterReducer()
      }
   )
}
