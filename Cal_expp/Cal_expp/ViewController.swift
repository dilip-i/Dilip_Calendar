//
//  ViewController.swift
//  Cal_expp
//
//  Created by Dilip Indpro on 07/12/17.
//  Copyright © 2017 Dilip Indpro. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var calendar: FSCalendar!
    @IBOutlet weak var calendarHeightConstraint : NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scopeGesture = UIPanGestureRecognizer(target: self.calendar, action: #selector(self.calendar.handleScopeGesture(_:)))
        self.calendar.addGestureRecognizer(scopeGesture)
        
        let itemTapGesture = UILongPressGestureRecognizer(target: self.calendar, action: #selector(self.calendar.handlelongPressItem(_:)))
        self.calendar.addGestureRecognizer(itemTapGesture)
        
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    fileprivate let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        return formatter
    }()
    
    @IBAction func btnclk(sender:AnyObject){
//        self.calendar.select(Calendar.current.date(byAdding: .day, value: 100, to: Date()))
        self.calendar.selectWeekno(17, inYr: 2018, scrollToWeekno: true);
    }

}

extension ViewController : FSCalendarDelegate {
  
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        print("change page to \(self.formatter.string(from: calendar.currentPage))")
        calendar.wCollectionView.reloadData()
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print("calendar did select date \(self.formatter.string(from: date))")
        if monthPosition == .previous || monthPosition == .next {
            calendar.setCurrentPage(date, animated: true)
        }
    }
    
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        self.calendarHeightConstraint.constant = bounds.height
        self.view.layoutIfNeeded()
    }
    
    func calendar(_ calendar: FSCalendar, didSelectWeekno weekno: NSInteger, _ startDate: Date, _ enddate: Date, at monthPosition: FSCalendarMonthPosition) {
        print("calendar did select week no \(weekno)")
        print("Start Date : \(self.formatter.string(from: startDate)), End Date \(self.formatter.string(from: enddate))")
    }
    
    func didLongPressedCell(_ cell: FSCalendarCell, date: Date) {
        print("calendar did Pressed date \(self.formatter.string(from: date))")
        cell.barSelectedView.backgroundColor = UIColor.black;
    }
    
    func didLongPressedCell(_ cell: FSCalendarWCell, weekno: Int, start stDate: Date) {
        cell.barWSelectedView.backgroundColor = UIColor.blue;
        print("calendar did Pressed week no \(weekno) start Date \(self.formatter.string(from: stDate))")
    }
    
}

extension ViewController : FSCalendarDataSource {
    func calendar(_ calendar: FSCalendar, cellFor cell: FSCalendarCell, date: Date) {
        cell.barSelectedView.backgroundColor = UIColor.blue
        cell.barUnselectedView.backgroundColor = UIColor.lightGray
        //cell.titleLabel.font; set fonts
        cell.progressBar = 0.1
    }
    
    func calendar(_ calendar: FSCalendar, cellFor wCell: FSCalendarWCell, week weekno: Int, inyr yr: Int) {
        wCell.barWSelectedView.backgroundColor = UIColor.black
        wCell.barWUnselectedView.backgroundColor = UIColor.clear
        wCell.progressBar = 0.8
       // wCell.titleLabel.font; set fonts
    }
    
    func maximumDate(for calendar: FSCalendar) -> Date {
        return Calendar.current.date(byAdding: .year, value: 2, to: Date())!
    }
    
    func minimumDate(for calendar: FSCalendar) -> Date {
        return Calendar.current.date(byAdding: .year, value: -2, to: Date())!
    }
}
