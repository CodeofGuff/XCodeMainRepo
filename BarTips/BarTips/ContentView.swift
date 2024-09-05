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
					
					Section(header: Text("Estimate Day Total")) {
						HStack {
							Text("Estimated Paycheck")
							Spacer()
							Text("$\(dayTotal, specifier: "%.2f")")
						}
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
				.navigationTitle("Paycheck Calculator")
			}
		}
	}
}

// Sheet View for editing PayRate and TaxRate
struct SettingsView: View {
	@Binding var payRate: Double
	@Binding var taxRate: Double
	
	var body: some View {
		NavigationView {
			Form {
				Section(header: Text("PayRate Settings")) {
					HStack {
						Text("Pay Rate")
						Spacer()
						TextField("Pay Rate", value: $payRate, format: .currency(code: "USD"))
							.keyboardType(.decimalPad)
							.frame(width: 100)
					}
				}
				
				Section(header: Text("Tax Settings")) {
					HStack {
						Text("Tax Rate (%)")
						Spacer()
						TextField("Tax Rate", value: $taxRate, format: .percent)
							.keyboardType(.decimalPad)
							.frame(width: 100)
					}
				}
			}
			.navigationTitle("Settings")
			.toolbar {
				ToolbarItem(placement: .cancellationAction) {
					Button("Done") {
						// Code to dismiss the view
					}
				}
			}
		}
	}
}

// Sheet View for selecting a date range
struct DateRangeView: View {
	@Binding var startDate: Date
	@Binding var endDate: Date
	
	var body: some View {
		NavigationView {
			Form {
				DatePicker("Start Date", selection: $startDate, displayedComponents: .date)
				DatePicker("End Date", selection: $endDate, displayedComponents: .date)
			}
			.navigationTitle("Select Date Range")
			.toolbar {
				ToolbarItem(placement: .cancellationAction) {
					Button("Done") {
						// Code to dismiss the view
					}
				}
			}
		}
	}
}

#Preview {
    ContentView()
}
