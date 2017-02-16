//
//  DetailViewController.swift
//  TimeEditLNU
//
//  Created by Alper Gündogdu on 12/26/16.
//  Copyright © 2016 Alper Gündogdu. All rights reserved.
//

import UIKit
import JTAppleCalendar
import SwiftyJSON
import ObjectMapper
import PopupDialog

class MainViewController: UIViewController, JTAppleCalendarViewDelegate, JTAppleCalendarViewDataSource, UITableViewDelegate, UITableViewDataSource, AddCoursesPopupVCDelegate {
    
    // ========================================
    // MARK: - IBOutlets
    // ========================================
    
    @IBOutlet weak var calendarView: JTAppleCalendarView!
    @IBOutlet fileprivate weak var monthLabel: UILabel!
    @IBOutlet weak var calendarHeightConstraint: NSLayoutConstraint! {
        didSet{
            calendarHeightConstraint.constant = dateCellSize * CGFloat(numberOfRows)
        }
    }
    @IBOutlet weak var todayButtonItem: UIBarButtonItem!
    @IBOutlet weak var settingsButtonItem: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var NumberContainerView: UIView! {
        didSet{
            NumberContainerView.layer.cornerRadius = NumberContainerView.bounds.size.height/2
        }
    }
    @IBOutlet weak var courseNumberLabel: UILabel! {
        didSet{
            courseNumberLabel.text = "\(numberOfMyCourses())"
        }
    }
    
    
    // ========================================
    // MARK: - Private properties
    // ========================================
    
    fileprivate var numberOfRows = 5
    fileprivate let formatter = DateFormatter()
    fileprivate var testCalendar = Calendar.current
    fileprivate var generateInDates: InDateCellGeneration = .forAllMonths
    fileprivate var generateOutDates: OutDateCellGeneration = .tillEndOfGrid
    fileprivate let firstDayOfWeek: DaysOfWeek = .monday
    fileprivate let disabledColor = UIColor.lightGray
    fileprivate let enabledColor = UIColor.blue
    fileprivate let dateCellSize: CGFloat = 40
    fileprivate let kDateFormat = "yyyy MM dd"
    
    fileprivate let finalDateFormat = "yyyy-MM-dd"
    
    fileprivate var eventsDictionary: [Date: [EventModel]] = [Date: [EventModel]]()

    fileprivate let kCellView = "CellView"
    fileprivate var currentEvents: [EventModel] = [EventModel]()
    
    fileprivate let animContainer = LoadingAnimView()
    
    // ========================================
    // MARK: - IBActions
    // ========================================
    
    @IBAction func todayButtonClicked(_ sender: UIButton) {
        setToTodaysDate()
    }
    
    @IBAction func settingsButtonClicked(_ sender: UIButton) {

    }
    
    
    @IBAction func leftButtonClicked(_ sender: UIButton) {
        self.calendarView.scrollToSegment(.previous) {
            self.calendarView.visibleDates({ (visibleDates: DateSegmentInfo) in
                self.setupViewsOfCalendar(from: visibleDates)
            })
        }
    }
    
    @IBAction func rightButtonClicked(_ sender: UIButton) {
        self.calendarView.scrollToSegment(.next) {
            self.calendarView.visibleDates({ (visibleDates: DateSegmentInfo) in
                self.setupViewsOfCalendar(from: visibleDates)
            })
        }
    }
    
    @IBAction func addCourseClicked(_ sender: UIButton) {
        let popupView = AddCoursesPopupVC(nibName: UINib.getNibNameFromClass(AddCoursesPopupVC.self), bundle: Bundle.main)
        popupView.delegate = self
        
        let popupVC = PopupDialog(viewController: popupView, buttonAlignment: .horizontal, transitionStyle: .bounceDown, gestureDismissal: true)
        popupVC.keyboardShiftsView = false
        //popupVC.dismiss()
        
        
        self.present(popupVC, animated: true, completion: nil)
    }
    

    // ========================================
    // MARK: - VC lifecycle
    // ========================================
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavbar()
        setupTableView()
        formatter.dateFormat = kDateFormat
        
        // Setting up your dataSource and delegate is manditory
        // ___________________________________________________________________
        calendarView.delegate = self
        calendarView.dataSource = self
        
        // ___________________________________________________________________
        // Registering your cells is manditory
        // ___________________________________________________________________
        calendarView.registerCellViewXib(file: kCellView)
        
        // ___________________________________________________________________
        //calendarView.registerHeaderView(xibFileNames: [kHeaderName])
        
        
        calendarView.cellInset = CGPoint(x: 0, y: 0)
        
        calendarView.visibleDates { (visibleDates: DateSegmentInfo) in
//            /// Visible pre-dates
//            public let indates: [Date]
//            /// Visible month-dates
//            public let monthDates: [Date]
//            /// Visible post-dates
//            public let outdates: [Date]
            
            self.setupViewsOfCalendar(from: visibleDates)
        }

        setToTodaysDate()
        
        requestMyCourses()
        
        
    }
    
    func setupViewsOfCalendar(from visibleDates: DateSegmentInfo) {
        //let todayDate = Date()
        guard let todayDate = visibleDates.monthDates.first else {
            return
        }
        
        let month = testCalendar.dateComponents([.month], from: todayDate).month!
        let monthName = DateFormatter().monthSymbols[(month-1) % 12]
        // 0 indexed array
        let year = testCalendar.component(.year, from: todayDate)
        monthLabel.text = monthName + " " + String(year)
    }

}


// ========================================
// MARK: - AddCoursesPopupVCDelegate
// ========================================

extension MainViewController {
    
    func popupDismissed() {
        courseNumberLabel.text = "\(numberOfMyCourses())"
        requestMyCourses()
    }
    
}

// ========================================
// MARK: - JTAppleCalendarDelegate
// ========================================

extension MainViewController {
    
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        
        //TODO: date that the first event is visible and the last event date
        let startDate = formatter.date(from: "2016 03 01")!
        let endDate = formatter.date(from: "2020 12 01")!
        
        let parameters = ConfigurationParameters(startDate: startDate,
                                                 endDate: endDate,
                                                 numberOfRows: numberOfRows,
                                                 calendar: testCalendar,
                                                 generateInDates: generateInDates,
                                                 generateOutDates: generateOutDates,
                                                 firstDayOfWeek: firstDayOfWeek)
        
        return parameters
    }
    
    func calendar(_ calendar: JTAppleCalendarView, willDisplayCell cell: JTAppleDayCellView, date: Date, cellState: CellState) {
        (cell as? CellView)?.setupCellBeforeDisplay(cellState, date: date)
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleDayCellView?, cellState: CellState) {
        (cell as? CellView)?.cellSelectionChanged(cellState)
    }
    
    func calendar(_ calendar: JTAppleCalendarView, canSelectDate date: Date, cell: JTAppleDayCellView, cellState: CellState) -> Bool {
        if cellState.dateBelongsTo == .thisMonth {
            return true
        }
        return false
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleDayCellView?, cellState: CellState) {
        (cell as? CellView)?.cellSelectionChanged(cellState)
        print(date, cellState.text)
        
        currentEvents = eventsDictionary[date] ?? [EventModel]()
        tableView.reloadData()
        
    }
    
    
    func calendar(_ calendar: JTAppleCalendarView, didScrollToDateSegmentWith visibleDates: DateSegmentInfo) {
        self.setupViewsOfCalendar(from: visibleDates)
    }
    
//    func calendar(_ calendar: JTAppleCalendarView,
//                  sectionHeaderIdentifierFor range: (start: Date, end: Date),
//                  belongingTo month: Int) -> String {
//        return kHeaderName
//    }
    
    func calendar(_ calendar: JTAppleCalendarView, sectionHeaderSizeFor range: (start: Date, end: Date), belongingTo month: Int) -> CGSize {
            return CGSize(width: 200, height: 50)
    }
    
    func calendar(_ calendar: JTAppleCalendarView, willDisplaySectionHeader header: JTAppleHeaderView, range: (start: Date, end: Date), identifier: String) {
//        switch identifier {
//        case "WhiteSectionHeaderView":
//            let headerCell = header as? WhiteSectionHeaderView
//            headerCell?.title.text = "Design multiple headers"
//        default:
//            let headerCell = header as? PinkSectionHeaderView
//            headerCell?.title.text = "In any color or size you want"
//        }
    }
    
}

// ========================================
// MARK: - Private functions
// ========================================

fileprivate extension MainViewController {
    
    func setupTableView() {
        tableView.separatorColor = UIColor.clear
        tableView.rowHeight = 80
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(EventCell.nib, forCellReuseIdentifier: EventCell.reuseIdentifier)
        
    }
    
    func setupNavbar() {
        //        self.navigationBar.backgroundColor = UIColor.yellow
        //        self.navigationBar.setBackgroundImage(UIImage(named: "lnulogo"), for: UIBarMetrics.default)
        
        let negativeSpace: UIBarButtonItem = {
            let item = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.fixedSpace, target: nil, action: nil)
            item.width = -16
            return item
        }()
        
        self.navigationItem.rightBarButtonItems = [settingsButtonItem, negativeSpace]
        self.navigationItem.leftBarButtonItems = [negativeSpace ,todayButtonItem]
    }
    
    func getDateOfEvent(dateString: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = finalDateFormat
        let date = dateFormatter.date(from: dateString)
        return date!
    }
    
    func setToTodaysDate(){
        calendarView.scrollToDate(Date())
        calendarView.selectDates([Date()])
    }
    
    func requestMyCourses() {
        
        if numberOfMyCourses() > 0 {
            //self.navigationController?.view.addSubview(animContainer)
            animContainer.startAnimating()
            
            getCoursesEvents(courses: getMyCourses())
        }
        //        getCoursesEvents(courseCode: "1DV517")
        //        getCoursesEvents(courseCode: "1DV021")
        //        getCoursesEvents(courseCode: "1DV022")
        //        getCoursesEvents(courseCode: "1DV023")
        //        getCoursesEvents(courseCode: "1DV024")
        //        getCoursesEvents(courseCode: "1DV433")
        //        getCoursesEvents(courseCode: "1DV507")
        //        getCoursesEvents(courseCode: "1DV508")
//        getCoursesEvents(courses: ["1DV517","1DV021","1DV507","1DV508"])
    }
    
}

// ========================================
// MARK: - UITableViewDataSource
// ========================================

extension MainViewController {
    //TODO: number of rows and stuff will be set whenever the date is selected
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentEvents.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EventCell.reuseIdentifier) as! EventCell
        
        let event = currentEvents[indexPath.row]
        cell.fromTimeString = event.startTime
        cell.endTimeString = event.endTime
        cell.eventNameString = event.info
        cell.eventNoteString = event.room
        
        return cell
    }
    
}

// ========================================
// MARK: - UITableViewDelegate
// ========================================

extension MainViewController {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}

// ========================================
// MARK: - Network Ops
// ========================================

extension MainViewController {
    
    func getCoursesEvents(courses: [String]){
        
        
        networkProvider.request(NetworkProvider.getCoursesEvents(courses: courses ), completion: { (result) -> () in
            
            switch result{
                
            case let .success(result):
                
                do
                {
                    let resultString = try result.mapString()
                    let resultJSON = JSON(data: resultString.data(using: String.Encoding.utf8)!)
                    
                    let resultArray = resultJSON[0]
                    let events = resultArray["events"]
                    
                    var i = 0
                    for _ in events
                    {
                        let event = events[i]
                        
                        if let eventMapped = Mapper<EventModel>().map(JSONString: event.rawString()!)
                        {
                            print(eventMapped.info ?? "NULL")
                            let date = self.getDateOfEvent(dateString: eventMapped.startDate!)
                            if self.eventsDictionary[date] != nil {
                                self.eventsDictionary[date]!.append(eventMapped)
                            } else {
                                self.eventsDictionary.updateValue([eventMapped], forKey: date)
                            }
                            
                        }
                        
                        i += 1
                    }
                    
                    self.animContainer.stopAnimating()
                }
                catch
                {
                    
                }
                
                
            case let .failure(error):
                print(error)
                self.animContainer.stopAnimating()
            }
            
        })
        
    }

    
}



