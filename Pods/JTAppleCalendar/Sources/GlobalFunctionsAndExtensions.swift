//
//  GlobalFunctionsAndExtensions.swift
//  Pods
//
//  Created by JayT on 2016-06-26.
//
//

func delayRunOnMainThread(_ delay: Double, closure: @escaping () -> ()) {
    DispatchQueue.main.asyncAfter(
        deadline: DispatchTime.now() +
            Double(Int64(delay * Double(NSEC_PER_SEC))) /
            Double(NSEC_PER_SEC), execute: closure)
}

func delayRunOnGlobalThread(_ delay: Double,
                            qos: DispatchQoS.QoSClass,
                            closure: @escaping () -> ()) {
    DispatchQueue.global(qos: qos).asyncAfter(
        deadline: DispatchTime.now() +
            Double(Int64(delay * Double(NSEC_PER_SEC))) /
            Double(NSEC_PER_SEC), execute: closure
    )
}

extension Date {
    static let formatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy MM dd"
        return dateFormatter
    }()
    static func startOfMonth(for date: Date, using calendar: Calendar) -> Date? {
        let dayOneComponents = calendar.dateComponents([.year, .month], from: date)
        
        guard
            let month = dayOneComponents.month,
            let year = dayOneComponents.year else {
                return nil
        }
        
        return Date.formatter.date(from: "\(year) \(month) 01")
    }
    
    static func endOfMonth(for date: Date, using calendar: Calendar) -> Date? {
        var lastDayComponents = calendar.dateComponents([.era, .year, .month, .day, .hour], from: date)
        lastDayComponents.month = lastDayComponents.month! + 1
        lastDayComponents.day = 0
        return calendar.date(from: lastDayComponents)
    }
}

extension Dictionary where Value: Equatable {
    func key(for value: Value) -> Key? {
        guard let index = index(where: { $0.1 == value }) else {
            return nil
        }
        return self[index].0
    }
}
