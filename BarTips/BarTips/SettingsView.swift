//
//  SettingsView.swift
//  BarTips
//
//  Created by David Guffre on 9/6/24.
//

import SwiftUI

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
		.preferredColorScheme(.dark)
	}

}

#Preview {
	@State var payRate: Double = 16.0
	@State var taxRate: Double = 0.3
	
	return SettingsView(payRate: $payRate, taxRate: $taxRate)
}
