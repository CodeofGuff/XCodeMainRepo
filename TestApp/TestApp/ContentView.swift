//
//  ContentView.swift
//  TestApp
//
//  Created by David Guffre on 10/3/24.
//
import SwiftUI

struct ContentView: View {
    
    @State var selectedDate = Date()

    var dateClosedRange: ClosedRange<Date> {
        let min = Calendar.current.date(byAdding: .day, value: -15, to: Date())!
        let max = Calendar.current.date(byAdding: .day, value: 15, to: Date())!
        return min...max
    }

    var body: some View {
       

        NavigationView {
            Form {
                Section {
                    DatePicker(
                        selection: $selectedDate,
                        in: dateClosedRange,
                        displayedComponents: .date,
                        label: { Text("Due Date") }
                    )
                }
            }
        }
        
        
        
    }
}



#Preview {
    ContentView()
}
