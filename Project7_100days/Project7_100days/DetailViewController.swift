//
//  DetailViewController.swift
//  Project7_100days
//
//  Created by user228564 on 1/12/23.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var flagImage: UIImageView!
    @IBOutlet weak var countryName: UILabel!
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var currencyName: UILabel!
    @IBOutlet weak var governmentName: UILabel!
    @IBOutlet weak var populationNumber: UILabel!
    

    var detailItem: Country?
    var picturesHR: [String]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let detailItem = detailItem else { return }
        
        self.countryName.text = detailItem.country
        self.cityName.text = detailItem.city ?? "No capital"
        self.currencyName.text = detailItem.currency_name ?? "No currency"
        self.governmentName.text = detailItem.government ?? "Anarchy, I presume"
        self.populationNumber.text = String(detailItem.population ?? 0)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(share))
    }

    
    @objc func share() {

        let vc = UIActivityViewController(activityItems: [detailItem?.country ?? "No Data", detailItem?.city ?? "No Data"], applicationActivities: nil)
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
}
