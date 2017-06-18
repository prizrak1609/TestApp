//
//  ChartsVC.swift
//  DisplayPlanStats
//
//  Created by Dima Gubatenko on 25.05.17.
//  Copyright © 2017 A2Lab. All rights reserved.
//

import UIKit
import Charts

final class ChartsVC: UIViewController {

    @IBOutlet fileprivate weak var scrollView: UIScrollView!

    var campainID = ""
    var campainType = ServerCampainType.liftNLearn

    fileprivate let server = ServerChart()
    fileprivate let viewModel = ChartsVCViewModel()
    fileprivate var lineChart: LineChartCell?
    fileprivate var circularDiagram: CircularDiagramCell?
    fileprivate var barChart: BarChartCell?
    fileprivate var tableInsigts: TableInsightsCell?

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        addLineChart()
        addCircularDiagram()
        addBarChart()
        addTableInsights()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layoutSubviews()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getData(id: campainID, type: campainType)
    }
}

// MARK: add subviews
private extension ChartsVC {

    func addLineChart() {
        lineChart = LineChartCell.loadFromXib(owner: self)
        add(view: lineChart)
    }

    func addCircularDiagram() {
        circularDiagram = CircularDiagramCell.loadFromXib(owner: self)
        add(view: circularDiagram)
    }

    func addBarChart() {
        barChart = BarChartCell.loadFromXib(owner: self)
        add(view: barChart)
    }

    func addTableInsights() {
        tableInsigts = TableInsightsCell.loadFromXib(owner: self)
        add(view: tableInsigts)
    }

    private func add(view: UIView?) {
        if let view = view {
            scrollView.addSubview(view)
        }
    }
}

// MARK: layout subviews
private extension ChartsVC {

    func layoutSubviews() {
        // disable because don't need variable y outside of this func
        // swiftlint:disable:next nesting
        struct Helper {
            static var y: CGFloat = 0
        }
        Helper.y = 0
        var contentSize = scrollView.contentSize
        contentSize.width = UIScreen.main.bounds.width
        let width = contentSize.width
        let layoutView = { (view: UIView?) -> Void in
            guard let view = view, view is ChartCellProtocol else { return }
            var frame = view.frame
            frame.origin.x = 0
            frame.origin.y = Helper.y
            frame.size.width = width
            // disable because earlier checked that view is implement ChartCellProtocol
            // swiftlint:disable:next force_cast
            frame.size.height = (view as! ChartCellProtocol).height
            view.frame = frame
            Helper.y += frame.size.height
        }
        layoutView(lineChart)
        layoutView(circularDiagram)
        layoutView(barChart)
        layoutView(tableInsigts)
        contentSize.height = Helper.y
        scrollView.contentSize = contentSize
    }
}

extension ChartsVC : ChartsVCViewModelProtocol {

    func lineChartData(_ data: LineChartData?) {
        lineChart?.model = data
    }

    func pieChartData(_ data: PieChartData?) {
        circularDiagram?.model = data
        let text: String
        switch campainType {
            case .liftNLearn: text = "LIFT N LEARN"
            default: text = ""
        }
        circularDiagram?.title = text
    }

    func barChartData(_ data: BarChartData?) {
        barChart?.model = data
    }

    func tableInsigts(_ data: TableInsightsCellModel?) {
        tableInsigts?.model = data
        view.setNeedsLayout()
        view.layoutIfNeeded()
    }

    func error(_ error: Error) {
        showText(error.localizedDescription)
    }
}
