import UIKit
import Alamofire

class ContactusVC: UIViewController
{
    @IBOutlet weak var contactTabV: UITableView!
    var contactArr = [NSDictionary]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.ContactData()
    }
    
    func ContactData()
    {
        let param = ["request":"contact_us","device_type":"ios","country":"india"]
        AF.request("http://kalyanmobile.com/apiv1_staging/contact_us.php", method: .post, parameters: param).responseJSON { (resp) in
            print("Response Here")
            if let dict = resp.value as? NSDictionary
            {
                print("Response Here \(dict)")
                if let respCode = dict.value(forKey: "responseCode") as? String,let respMsg = dict.value(forKey: "responseMessage") as? String
                {
                    if respCode == "success"
                    {
                        self.contactArr = dict.value(forKey: "contact_us") as! [NSDictionary]
                        self.contactTabV.reloadData()
                        print("SUCCESS")
                    }else{
                        print("ERROR \(respMsg)")
                    }
                }
            }
        }
    }
}

extension ContactusVC: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return contactArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactUsTVC") as! ContactUsTVC
        cell.officeLbl.text = contactArr[indexPath.row].value(forKey: "office") as? String
        cell.phoneLbl.text = contactArr[indexPath.row].value(forKey: "phone_no") as? String
        cell.branchLbl.text = contactArr[indexPath.row].value(forKey: "branch") as? String
        cell.addressLbl.text = contactArr[indexPath.row].value(forKey: "address") as? String
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 156
    }
}

class ContactUsTVC: UITableViewCell
{
    @IBOutlet weak var officeLbl: UILabel!
    @IBOutlet weak var phoneLbl: UILabel!
    @IBOutlet weak var branchLbl: UILabel!
    @IBOutlet weak var addressLbl: UILabel!
}
