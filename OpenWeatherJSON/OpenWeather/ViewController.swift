//
//  ViewController.swift
//  OpenWeather
//
//  Created by Sara Gil González on 8/2/21.
//  Copyright © 2021 Sara Gil González. All rights reserved.
//

import UIKit

class ViewController: UIViewController, XMLParserDelegate, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var currentIcon: UIImageView!
    @IBOutlet weak var currentTemp: UILabel!
    @IBOutlet weak var currentPrecip: UILabel!
    @IBOutlet weak var currentPronost: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var result:Result?
    var dia = Dia()
    var dias = [Dia]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        jsonDecoding()

    }
    
    func jsonDecoding() {
        let urlTxt = "http://api.worldweatheronline.com/premium/v1/weather.ashx?key=8a7b34041ff14af9939114715210502&q=Toledo,Spain&num_of_days=10&fx24=yes&lang=es&mca=no&tp=24&format=json"
        
        guard let url = URL(string: urlTxt) else {return}
        URLSession.shared.dataTask(with: url) { (data, response, err) in
                guard let data = data else {return}
                    do {
                        self.result =  try JSONDecoder().decode(Result.self, from: data)
                        self.weatherToDias()
                        self.UI()
                    } catch let jsonErr {
                        print("Error serializing json", jsonErr)
                    }
        }.resume()
    }

    func weatherToDias() {
            let weathers = result!.datos!.weather!
            for i in 0..<weathers.count {
                dia = Dia()
                dia.fecha = weathers[i].fecha!
                dia.icon = weathers[i].hourly![0].icon![0].value!
                dia.prono = weathers[i].hourly![0].prono![0].value!
                dia.preci = weathers[i].hourly![0].preci!
                dia.max = weathers[i].max!
                dia.min = weathers[i].min!
                dias.append(dia)
            }
    }

    func UI() {
        DispatchQueue.main.async {
            self.currentPronost.text = self.result!.datos!.current![0].prono![0].value!
            self.currentTemp.text = self.result!.datos!.current![0].temp!
            self.currentPrecip.text = self.result!.datos!.current![0].preci!

            let url = URL(string: self.result!.datos!.current![0].icon![0].value!)
            let data = try? Data(contentsOf: url!)
            if let data = data {
                self.currentIcon.image = UIImage(data : data)
            }

            self.tableView.reloadData()
        }

    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dias.count
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tableView.dequeueReusableCell(withIdentifier: "RowTiempo", for: indexPath) as! MiCelda
            
        let dia = dias[indexPath.row]
        
        celda.fecha.text = dia.fecha
        celda.pronostico.text = dia.prono
        celda.minTemp.text = dia.min
        celda.maxTemp.text = dia.max
        celda.precip.text = dia.preci
        
        let url = URL(string: dia.icon)
        let data = try? Data(contentsOf: url!)
        if let data = data {
            celda.imageIcon.image = UIImage(data : data)
        }

        return celda
    }
}

