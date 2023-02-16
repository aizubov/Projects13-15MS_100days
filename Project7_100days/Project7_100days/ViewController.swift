//
//  ViewController.swift
//  Project7_100days
//
//  Created by user228564 on 1/11/23.
//

import UIKit

class ViewController: UITableViewController {
    
    var picturesHR = [String]()
    var picturesLR = [String]()
    var countries = [Country]()
    var filtered = [Country]()
    var keyword: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        guard let urlString = Bundle.main.path(forResource: "countries_my", ofType: "json") else { return }
        print(urlString)
        //let urlString = URL(fileURLWithPath: path)
        let fm = FileManager.default
        
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasSuffix(".png"){
                if item.split(separator: "_")[1] == "hd" {
                    picturesHR.append(item)
                } else if item.split(separator: "_")[1] == "sd" {
                    picturesLR.append(item)
                }
            }
        }


        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(filterCountries))
        
        loadJson(filename: "countries_my")

    
    }
    
    func loadJson(filename fileName: String) {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(Countries.self, from: data)
                countries = jsonData.results
                filterData()
                tableView.reloadData()
                
            } catch {
                print("error:\(error)")
            }
        }
    }
    
    
    @objc func filterCountries() {
        let ac = UIAlertController(title: "Filter", message: "Enter a keyword or leave empty to reset", preferredStyle: .alert)
        ac.addTextField()

        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        ac.addAction(UIAlertAction(title: "Filter", style: .default) {
            [weak self, weak ac] _ in
            self?.keyword = ac?.textFields?[0].text ?? ""
            self?.filterData()
            self?.tableView.reloadData()
        })
        
        present(ac, animated: true)

    }
    
    func filterData() {
        if keyword.isEmpty {
            filtered = countries
            title = "Countries List"
            return
        }
        
        title = "Filter: \"\(keyword)\""
        filtered = countries.filter({$0.country.lowercased().contains(keyword.lowercased())})
         
    }
    
    func showError() {
        let ac = UIAlertController(title: "Loading error", message: "There was a problem loading the file", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filtered.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let country = filtered[indexPath.row]
        cell.textLabel?.text = country.country
        cell.detailTextLabel?.text = country.city
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.detailItem = filtered[indexPath.row]
            vc.picturesHR = picturesHR
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}


