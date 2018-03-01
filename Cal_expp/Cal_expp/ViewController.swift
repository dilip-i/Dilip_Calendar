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
    @IBOutlet weak var tableview : UITableView!
    var scopeGesture : UIPanGestureRecognizer!
    var lastContentOffset: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scopeGesture = UIPanGestureRecognizer(target: self, action: #selector(self.handleScopeGesture(sender:)))
//        self.calendar.addGestureRecognizer(scopeGesture)
        self.view.addGestureRecognizer(scopeGesture)
        scopeGesture.delegate = self
        let itemTapGesture = UILongPressGestureRecognizer(target: self.calendar, action: #selector(self.calendar.handlelongPressItem(_:)))
        self.calendar.addGestureRecognizer(itemTapGesture)
        self.calendar.appearance.wBackgroundColor = UIColor.gray;
        self.calendar.wFont = UIFont.systemFont(ofSize: 40);
        self.calendar.weekDayTextFont = UIFont.systemFont(ofSize: 10);
        self.calendar.appearance.selectionColor = UIColor.orange;
        self.calendar.appearance.wSelectionColor = UIColor.orange;
//        self.calendar.wGradientColors = [UIColor.init(red: 0.0/255.0, green: 116.0/255.0, blue: 193.0/255.0, alpha: 1.0).cgColor, UIColor.init(red: 0.0/255.0, green: 108.0/255.0, blue: 179.0/255.0, alpha: 1.0).cgColor]
        
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
        self.calendar.select(Calendar.current.date(byAdding: .day, value: 100, to: Date()))
//        self.calendar.selectWeekno(17, inYr: 2018, scrollToWeekno: true);
    }
    
    @objc func handleScopeGesture(sender:UIPanGestureRecognizer){
        let view = sender.view
        let loc = sender.location(in: view)
        if(self.calendar.frame.contains(loc) || self.calendar.transitionCoordinator.state != .idle){
            self.calendar.handleScopeGesture(sender)
        }else{
            if(self.calendar.scope == .week && self.tableview.contentOffset.y <= 0) || (self.calendar.scope == .month){
                self.calendar.handleScopeGesture(sender)
            }
        }
    }

}

extension ViewController : FSCalendarDelegate {
  
    func calendarCurrentPageDidChange(_ calendar: FSCalendar, byScroll: Bool) {
        print("change page to \(self.formatter.string(from: calendar.currentPage))")
        calendar.wCollectionView.reloadData()
        if(byScroll){
            if(calendar.scope == .month){
                calendar.select(calendar.currentPage)
            }else{
                let weekObj = calendar.getweek(fromStart: calendar.currentPage);
                print("Week no = \(weekObj.week)")
                calendar.selectWeekno(weekObj.week, inYr: weekObj.yr, scrollToWeekno: false)
            }
        }
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print("calendar did select date \(self.formatter.string(from: date))")
        if monthPosition == .previous || monthPosition == .next {
            calendar.select(date)
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
        cell.colorForSelectedBar = UIColor.orange;
    }
    
    func didLongPressedCell(_ cell: FSCalendarWCell, weekno: Int, start stDate: Date) {
        cell.barWSelectedView.backgroundColor = UIColor.blue;
        print("calendar did Pressed week no \(weekno) start Date \(self.formatter.string(from: stDate))")
    }
    
}

extension ViewController : FSCalendarDataSource {
    func calendar(_ calendar: FSCalendar, cellFor cell: FSCalendarCell, date: Date) {
        cell.colorForSelectedBar = UIColor.black
        cell.colorForUnselectedBar = UIColor.blue
        cell.colorForTitleLabel = UIColor.orange
        if(cell.dateIsToday){
            cell.colorForTitleLabel = UIColor.blue
        }
        //date selection is static and can be set through IB inspectable only
        //cell.titleLabel.font; set fonts
        if UIScreen.main.traitCollection.userInterfaceIdiom == .pad {
            cell.titleLabel.font = UIFont(name: "HelveticaNeue-Light",
                                          size: 22)
        } else {
            cell.titleLabel.font = UIFont(name: "HelveticaNeue-Light",
                                          size: 10)
        }
        cell.progressBar = 0.1
        
        if cell.monthPosition == .previous || cell.monthPosition == .next {
            cell.colorForTitleLabel = UIColor.lightGray
        }
    }
    
    func calendar(_ calendar: FSCalendar, cellFor wCell: FSCalendarWCell, week weekno: Int, inyr yr: Int) {
        wCell.barWSelectedView.backgroundColor = UIColor.black
        wCell.barWUnselectedView.backgroundColor = UIColor.blue
        wCell.colorForTitleLabel = UIColor.blue
        wCell.progressBar = 0.6
        //Weekno selection is static and can be set through IB inspectable only
       // wCell.titleLabel.font; set fonts
        if UIScreen.main.traitCollection.userInterfaceIdiom == .pad {
            wCell.titleLabel.font = UIFont(name: "HelveticaNeue-Light",
                                          size: 22)
        } else {
            wCell.titleLabel.font = UIFont(name: "HelveticaNeue-Light",
                                          size: 10)
        }
    }
    
    func maximumDate(for calendar: FSCalendar) -> Date {
        return Calendar.current.date(byAdding: .year, value: 2, to: Date())!
    }
    
    func minimumDate(for calendar: FSCalendar) -> Date {
        return Calendar.current.date(byAdding: .year, value: -2, to: Date())!
    }
}

extension ViewController : UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        cell.textLabel?.text = "\(indexPath.row)"
        return cell
    }
}

extension ViewController : UIScrollViewDelegate{
    
    // this delegate is called when the scrollView (i.e your UITableView) will start scrolling
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.lastContentOffset = scrollView.contentOffset.y
        print("Begin \(scrollView.contentOffset.y)")
//        self.calendar.handleScopeGesture(scrollView.panGestureRecognizer)
        print("Begin Drag \(scrollView.panGestureRecognizer.state)")
    }
    
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
//        self.calendar.handleScopeGesture(scrollView.panGestureRecognizer)
        print("Begin Decelerrate \(scrollView.panGestureRecognizer.state)")
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        self.calendar.handleScopeGesture(scrollView.panGestureRecognizer)
        print("End decellerate \(scrollView.panGestureRecognizer.state)")
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
//        self.calendar.handleScopeGesture(scrollView.panGestureRecognizer)
        print("End Drag \(scrollView.panGestureRecognizer.state)")
    }
    // while scrolling this delegate is being called so you may now check which direction your scrollView is being scrolled to
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        self.calendar.handleScopeGesture(scrollView.panGestureRecognizer)
        if( self.calendar.transitionCoordinator.state == .changing){
            scrollView.contentOffset.y = self.lastContentOffset
        }
        print("Dis Scroll \(scrollView.panGestureRecognizer.state)")
        if (self.lastContentOffset < scrollView.contentOffset.y) {
            // moved to top
//            if(scrollView.contentOffset.y > (scrollView.contentSize.height - scrollView.frame.size.height)){
//            scrollView.contentOffset.y = self.lastContentOffset;
//            if(self.calendar.scope != .week){
//                self.calendar.setScope(.week, animated: true)
//            }
//            }
        } else if (self.lastContentOffset > scrollView.contentOffset.y) {
            // moved to bottom
//            if(scrollView.contentOffset.y < 0){
//                if(self.calendar.scope != .month){
//                    self.calendar.setScope(.month, animated: true)
//                }
//            }
        } else {
            // didn't move

        }
        
//        print("Scroll \(scrollView.contentOffset.y)")
    }
}

extension ViewController : UIGestureRecognizerDelegate{
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        let bool = otherGestureRecognizer == self.tableview.panGestureRecognizer
        return bool
            //&& self.tableview.isDecelerating
    }
    
    
}

