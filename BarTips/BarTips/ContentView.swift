//
//  ContentView.swift
//  BarTips
//
//  Created by David Guffre on 9/4/24.
//


import SwiftUI

struct ContentView: View {
	@State private var showSettingsSheet = false
	@State private var showDateRangeSheet = false
	@State private var hoursWorked: Double = 0
	@State private var tipsEarned: Double = 0
	@State private var payRate: Double = 16.0 // Default pay rate
	@State private var taxRate: Double = 0.29  // Default tax rate (20%)
	@State private var selectedStartDate = Date()
	@State private var selectedEndDate = Date()
    @State private var dayTotalSaved = [Int]()
	
	// Calculates total earnings based on input
	var dayTotal: Double {
		let grossPay = hoursWorked * payRate + tipsEarned
		let netPay = grossPay * (1 - taxRate) // Apply tax deduction
		return netPay
	}
	
	var body: some View {
		NavigationView {
			VStack {
				Form {
					Section(header: Text("Work Details")) {
						// Input for hours worked
						HStack {
							Text("Hours Worked")
							Spacer()
							TextField("Hours", value: $hoursWorked, format: .number)
								.keyboardType(.decimalPad)
								.frame(width: 100)
						}
						// Input for tips earned
						HStack {
							Text("Tips Earned")
							Spacer()
							TextField("Tips", value: $tipsEarned, format: .number)
								.keyboardType(.decimalPad)
								.frame(width: 100)
                        }
                    }
                    
                    Section(header: Text("")) {
                        HStack {
                            Text("Estimate Day Total: ")
                            Spacer()
                            Text("$\(dayTotal, specifier: "%.2f")")
                            
                        }
                        // Save the current Day Pay - Save it into an Array, and allow it to be picked
                        Button(action: {
                            dayTotalSaved.append(Int(dayTotal))
                        }) {
                            Text("Save")
                        }
                        
                        Text("\(dayTotalSaved)")
                    }
                    
					// Button to show the settings sheet
					Button(action: {
						showSettingsSheet = true
					}) {
						Text("Edit PayRate and Taxes")
					}
					.sheet(isPresented: $showSettingsSheet) {
						SettingsView(payRate: $payRate, taxRate: $taxRate)
					}
					
					// Button to show the date range sheet
					Button(action: {
						showDateRangeSheet = true
					}) {
						Text("Select Date Range")
					}
					.sheet(isPresented: $showDateRangeSheet) {
						DateRangeView(startDate: $selectedStartDate, endDate: $selectedEndDate)
					}
				}
				.navigationTitle("Enter Shift Info: ")
            }
		}
        Spacer()
        VStack {
            Form {
                Text("How do I make this les then half the screen?")
            }
        }
		.preferredColorScheme(.dark)
	}
}


#Preview {
    ContentView()
}
