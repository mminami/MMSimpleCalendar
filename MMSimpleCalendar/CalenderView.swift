//
//  CalenderView.swift
//  MMSimpleCalendar
//
//  Created by mminami on 2017/09/30.
//

import Foundation
import UIKit

protocol CalendarViewDelegate: class {
    func calendarView(_ calendarView: CalendarView, didSeletDate: Date)
}

class CalendarView: UIView {
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!

    @IBOutlet weak var currentLabel: UILabel!
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!

    @IBAction func didTapPrevButton(_ sender: UIButton) {
        updateCurrentDate(currentDate.lastMonth)
        collectionView.reloadData()
    }

    @IBAction func didTapNextButton(_ sender: UIButton) {
        updateCurrentDate(currentDate.nextMonth)
        collectionView.reloadData()
    }

    weak var delegate: CalendarViewDelegate?

    private let numberOfDaysInWeek = 7

    private var fullDatesInMonth = [Date]()

    var currentDate = Date()
    var weekDaySymbols = Calendar.current.weekdaySymbols
    var dayCellSize = CGSize(width: 50, height: 50)

    override init(frame: CGRect) {
        super.init(frame: frame)

        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        commonInit()
    }

    private func commonInit() {
        UINib.init(nibName: "\(CalendarView.self)", bundle: nil)
            .instantiate(withOwner: self, options: nil)
        addSubview(contentView)
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]

        collectionView.backgroundColor = UIColor.orange
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CalendarDayCell.nib,
                                forCellWithReuseIdentifier: CalendarDayCell.cellIdentifier)

        updateCurrentDate(Date())
    }

    func updateCurrentDate(_ date: Date) {
        currentDate = date
        fullDatesInMonth = currentDate.fullDatesInMonth()
        currentLabel.text = currentDate.dateString(with: "yyyy年MM月dd日")
    }
}

extension CalendarView: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0: return numberOfDaysInWeek
        case 1: return currentDate.weekRangeInMonth().count * numberOfDaysInWeek
        default: fatalError("Invalid section")
        }
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CalendarDayCell.cellIdentifier,
                                                            for: indexPath) as? CalendarDayCell else {
            fatalError("Invalid cell at \(indexPath)")
        }

        cell.dayLabel.adjustsFontSizeToFitWidth = true
        cell.dayLabel.minimumScaleFactor = 0.5
        cell.dayLabel.textAlignment = .center

        switch indexPath.section {
        case 0:
            cell.backgroundColor = UIColor.purple
            cell.dayLabel.text = weekDaySymbols[indexPath.row]
        case 1: cell.backgroundColor = UIColor.red
            cell.dayLabel.text = "\(fullDatesInMonth[indexPath.row].day)"
        default: cell.backgroundColor = UIColor.green
        }

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.calendarView(self, didSeletDate: fullDatesInMonth[indexPath.row])
    }
}

extension CalendarView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return dayCellSize
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        let sideMergin =
            ((collectionView.bounds.width - dayCellSize.width * CGFloat(numberOfDaysInWeek)))
                / CGFloat(numberOfDaysInWeek + 1)
        return UIEdgeInsets(top: 5, left: sideMergin, bottom: 5, right: sideMergin)
    }
}
