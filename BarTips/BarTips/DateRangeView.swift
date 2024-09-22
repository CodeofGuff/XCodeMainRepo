//
//  DateRangeView.swift
//  BarTips
//
//  Created by David Guffre on 9/6/24.
//

import SwiftUI

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
	@Previewable @State var startDate = Date()
	@Previewable @State var endDate = Calendar.current.date(byAdding: .day, value: 7, to: Date()) ?? Date()
	
	return DateRangeView(startDate: $startDate, endDate: $endDate)
}
