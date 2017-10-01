//
//  CalendarDayCell.swift
//  MMSimpleCalendar
//
//  Created by mminami on 2017/09/30.
//

import Foundation
import UIKit

class CalendarDayCell: UICollectionViewCell {
    static var nib: UINib {
        return UINib.init(nibName: "\(CalendarDayCell.self)", bundle: nil)
    }
    static var cellIdentifier = "\(CalendarDayCell.self)"

    @IBOutlet weak var dayLabel: UILabel!
}
