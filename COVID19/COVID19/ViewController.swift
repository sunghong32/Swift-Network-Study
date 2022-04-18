//
//  ViewController.swift
//  COVID19
//
//  Created by 민성홍 on 2022/04/13.
//

import UIKit
import Charts
import Alamofire

class ViewController: UIViewController {
    @IBOutlet weak var totalCaseLabel: UILabel!
    @IBOutlet weak var newCaseLabel: UILabel!
    
    @IBOutlet weak var pieChartView: PieChartView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetchCovidOverview(completionHandler: { [weak self] result in
            guard let self = self else { return }

            switch result {
                case .success(let result):
                    debugPrint("success \(result)")
                case .failure(let error):
                    debugPrint("failure \(error)")
            }
        })
    }

    func fetchCovidOverview(completionHandler: @escaping (Result<CityCovidOverView, Error>) -> Void) {
        let url = "https://api.corona-19.kr/korea/country/new/"
        let param = [
            "serviceKey": "EWBU8QwaevngKNPmCuG34ZkrozyAYMHqf"
        ]

        AF.request(url, method: .get, parameters: param)
            .responseData(completionHandler: { response in
                switch response.result {
                    case .success(let data):
                        do {
                            let decoder = JSONDecoder()
                            let result = try decoder.decode(CityCovidOverView.self, from: data)
                            completionHandler(.success(result))
                        } catch {
                            completionHandler(.failure(error))
                        }

                    case .failure(let error):
                        completionHandler(.failure(error))
                }
            })
    }
}

