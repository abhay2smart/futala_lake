//
//  CustomCalendarView.swift
//  FutalaLake
//
//  Created by Abhayjeet Singh on 30/12/22.
//

import SwiftUI
import UIKit
import FSCalendar





struct CustomCalendarView: UIViewRepresentable {
   
    typealias UIViewType = FSCalendar
    
    @Binding var dateSelected: Date
    @Binding var mnthNm: Date
    @Binding var pageCurrent: Date
    
    var calendar = FSCalendar()
    
    var today: Date{
        return Date()
    }
    
    
    
    
    func makeUIView(context: Context) -> FSCalendar {
        
        calendar.dataSource = context.coordinator
        calendar.delegate = context.coordinator
        calendar.appearance.headerMinimumDissolvedAlpha = 0
        
       
        return calendar
    }
    
    func updateUIView(_ uiView: FSCalendar, context: Context) {
        
        uiView.setCurrentPage(pageCurrent, animated: true) // --->> update calendar view when click on left or right button
    }
    
    func makeCoordinator() -> CustomCalendarView.Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, FSCalendarDelegate, FSCalendarDataSource {
        
        var parent: CustomCalendarView
        
        init(_ parent: CustomCalendarView) {
            self.parent = parent
        }

        func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
            
            parent.dateSelected = date
        }
        
        func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
            if date .compare(Date()) == .orderedAscending {
                return false
            }
            else {
                return true
            }
        }
        
        func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
            DispatchQueue.main.async {
                self.parent.pageCurrent = calendar.currentPage
                self.parent.mnthNm = calendar.currentPage
            }
            
        }
    }
}


struct CustomCalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CustomCalendarView(dateSelected: .constant(Date()), mnthNm: .constant(Date()), pageCurrent: .constant(Date()))
    }
}
