//
//  ViewController.swift
//  MMSimpleCalendar
//
//  Created by Masato Minami on 2017/09/30.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var calendarView: CalendarView!

    override func viewDidLoad() {
        super.viewDidLoad()

        calendarView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ViewController: CalendarViewDelegate {
    func calendarView(_ calendarView: CalendarView, didSeletDate: Date) {
        print(didSeletDate)
    }
}

