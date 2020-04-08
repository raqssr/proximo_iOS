//
//  BusinessDetailViewController.swift
//  Proxi_mo
//
//  Created by raquel ramos on 08/04/2020.
//  Copyright © 2020 raquel ramos. All rights reserved.
//

import UIKit

class BusinessDetailViewController: UIViewController {
    
    @IBOutlet weak var businessCard: UIView!
    @IBOutlet weak var businessLogo: UIImageView!
    @IBOutlet weak var businessName: UILabel!
    @IBOutlet weak var businessAddress: UILabel!
    @IBOutlet weak var businessPhone: UILabel!
    @IBOutlet weak var businessDelivery: UILabel!
    @IBOutlet weak var businessInfo: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
        let url = URL(string: "https://plasticoresponsavel.continente.pt/wp-content/uploads/2019/04/IMG_8383.jpg")
        DispatchQueue.global().async {
            guard let urlImage = url else {
                print("Error fecthing url of image")
                return
            }
            let data = try? Data(contentsOf: urlImage)
            DispatchQueue.main.async {
                guard let dataImage = data else {
                    print("Error fetching data from url")
                    return
                }
                self.businessLogo.image = UIImage(data: dataImage)
            }
        }
        businessName.text = "O mercado da raquel"
        businessAddress.text = "Rua em casa pq isolamento, 69, São Bernardo, Aveiro"
        businessPhone.text = "961559817"
        businessDelivery.text = "Entregas ao domicílio: querias lol"
        businessInfo.text = "aqui vai ficar info interessante sobre o estabelecimento"
    }
    
    func setupUI() {
        businessCard.layer.cornerRadius = 10
        businessLogo.layer.borderWidth = 1.0
        businessLogo.layer.masksToBounds = false
        businessLogo.layer.borderColor = UIColor.white.cgColor
        businessLogo.layer.cornerRadius = 20
        businessLogo.clipsToBounds = true
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
