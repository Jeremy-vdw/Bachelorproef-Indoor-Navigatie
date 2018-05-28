//
//  DetailController.swift
//  FeestwinkelApplicatie
//
//  Created by Jeremie Van de Walle on 13/05/18.
//  Copyright © 2018 Jeremie Van de Walle. All rights reserved.
//

import UIKit

class DetailController : UIViewController {

    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productStockSize: UITextView!
    @IBOutlet weak var productDescription: UITextView!
    @IBOutlet weak var associatedProductImage1: UIImageView!
    @IBOutlet weak var associatedProductName1: UILabel!
    @IBOutlet weak var associatedProductPrice1: UILabel!
    @IBOutlet weak var associatedProductImage2: UIImageView!
    @IBOutlet weak var associatedProductName2: UILabel!
    @IBOutlet weak var associatedProductPrice2: UILabel!
    
    // associated products
    var leg85574 = Product(name: "MARIE ANTOINETTE DELUXE", code: "LEG85574", price: 99.95)
    var kou4780f = Product(name: "HOGE KOUSEN WIT + STRIKJE", code: "KOU4780F", price: 4.95)
    var leg85637 = Product(name: "CARNIVAL CLOWN DAME DELUXE", code: "LEG85637", price: 84.95)
    var leg6923 = Product(name: "GESTREEPTE HOGE KOUSEN", code: "LEG6923", price: 9.95)
    var leg83773 = Product(name: "CHARMING ALICE", code: "LEG83773", price: 64.95)
    var leg85510 = Product(name: "DELIGHTFUL ALICE", code: "LEG85510", price: 79.95)
    var leg85370 = Product(name: "DEAD EYE DOLLIE", code: "LEG85370", price: 64.95)
    var kou6005 = Product(name: "HOGE KOUSEN GESTREEPT NYLON", code: "KOU6005", price: 7.95)
    var leg86710 = Product(name: "ZEEMEERMIN ROK BLAUW", code: "LEG86710", price: 49.95)
    var leg86638 = Product(name: "QUEEN'S CARD GUARD", code: "LEG86638", price: 69.95)
    var leg86646 = Product(name: "HARLEY QUINN", code: "LEG86646", price: 79.95)
    var acc1857c = Product(name: "BASEBALL BAT OPBLAAS", code: "ACC1857C", price: 2.95)
    var smi24362 = Product(name: "PIRAAT GHOST SHIP TREASURE", code: "SMI24362", price: 45.95)
    var wid0565 = Product(name: "ZOMBIE BRUID KORT", code: "WID0565", price: 29.95)
    var leg86707 = Product(name: "DELUXE BELLE OF THE BALL", code: "LEG86707", price: 89.95)
    var leg86659 = Product(name: "ENCHANTING PRINSES BELLE", code: "LEG86659", price: 69.95)
    //main products
    var prua2776 = Product(name: "PRUIK MARIE ANTOINETTE DELUXE ROZE", code: "PRUA2776", price: 24.95, description: "Deze pastel roze gekleurde getoupeerde 'Marie Antoinette' pruik is van goede kwaliteit en heeft lange synthetische haren met krullen.", stock: 2, size: "één maat")
    var pru2816 = Product(name: "PRUIK AFRO CARNIVAL CLOWN AQUA", code: "PRU2816", price: 24.95, description: "Volle afro pruik", stock: 3, size: "één maat")
    var prua2771 = Product(name: "PRUIK ALICE TWO-TONED MET STRIK", code: "PRUA2771", price: 29.95, description: "Alice pruik in twee kleuren met vastzittende strik en verstelbare bandjes.", stock: 3, size: "één maat")
    var prua2732076 = Product(name: "PRUIK DOLLY BOB MET CLIPS LAVENDEL", code: "PRUA2732076", price: 54.95, description: "Poppen pruik in een bobline met optionele staarten. Staarten zitten vast aan haarklemmen.", stock: 3, size: "één maat")
    var prua2722003 = Product(name: "PRUIK WAVY LANG ROOD", code: "PRUA2722003", price: 32.95, description: "Lange pruik in het rood met verstelbare band.", stock: 2, size: "één maat")
    var prua2784 = Product(name: "PRUIK HARLEY QUINN", code: "PRUA2784", price: 49.95, description: "Suicide Squad Harley Quinn pruik", stock: 3, size: "één maat")
    var prua2722 = Product(name: "PRUIK WAVY LANG GRIJS", code: "PRUA2722", price: 32.95, description: "Lange pruik in het grijs met verstelbare band.", stock: 1, size: "één maat")
    var prua1528 = Product(name: "PRUIK STORYBOOK BEAUTY BELLE BRUIN HQ", code: "PRUA1528", price: 29.95, description: "Pruik van Belle uit het sprookje Belle en het beest", stock: 2, size: "één maat")
    
    var productArray: [Product] = [];
    var code: String?
    
    var scannedProductCode: String? {
        didSet {
            var scannedProduct: Product?
            if let i = productArray.index(where: { $0.code == scannedProductCode! }) {
                scannedProduct = productArray[i]
            }
            productName.text = scannedProduct!.name
            productImage.image = UIImage(named: scannedProduct!.code)
            productPrice.text = "€ \(scannedProduct!.price)"
            productStockSize.text = "Stock : \(scannedProduct!.stock) - Beschikbaar in \(scannedProduct!.size)."
            productDescription.text = scannedProduct!.description
            //associatedProducts
            associatedProductImage1.image = UIImage(named: scannedProduct!.associatedProducts[0].code)
            associatedProductName1.text = scannedProduct!.associatedProducts[0].name
            associatedProductPrice1.text = "€ \(scannedProduct!.associatedProducts[0].price)"
            associatedProductImage2.image = UIImage(named: scannedProduct!.associatedProducts[1].code)
            associatedProductName2.text = scannedProduct!.associatedProducts[1].name
            associatedProductPrice2.text = "€ \(scannedProduct!.associatedProducts[1].price)"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.statusBarStyle = .lightContent
        prua2776.associatedProducts = [leg85574, kou4780f];
        pru2816.associatedProducts = [leg85637, leg6923];
        prua2771.associatedProducts = [leg83773, leg85510];
        prua2732076.associatedProducts = [leg85370, kou6005];
        prua2722003.associatedProducts = [leg86710, leg86638];
        prua2784.associatedProducts = [leg86646, acc1857c]
        prua2722.associatedProducts = [smi24362, wid0565]
        prua1528.associatedProducts = [leg86707, leg86707]
        productArray = [prua2776, pru2816, prua2771, prua2732076, prua2722003, prua2784, prua2722, prua1528]
        scannedProductCode = code!
    }
    
}
