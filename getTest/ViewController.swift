
import UIKit
class ViewController: UIViewController  {
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("running app..")
        // Create destination URL
        let documentsUrl:URL =  (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first as URL?)!
        let destinationFileUrl = documentsUrl.appendingPathComponent("downloadedFile.jpg")
        
        //Create URL to the source file you want to download
        let fileURL = URL(string: "http://hhres1.dev.smartlayer.ca/Attachments/Download/1239")
        
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig)
        
        var request = URLRequest(url: fileURL!)
        request.setValue("Bearer QD4xXd3DM4Q0nOREIRFbH2dAzrSPBd5pP4N62WFI1rhqojkrd97NZqfH57KevodpnhLYgz6pTz2ZhJ6TzVeLgIMBaNM5tUDXNwy_RIQTdPK5R_qXDfMTgqtMiLIrvssGQfUEjkPO1dsOsw7LLStLK36dqpVg-Rkobh8uCWLzUFGLHlKvtUK1ljeNleWI9JcRDPIrbHs4Ieq8DsEOd8tv8QMgL-HR7NGFaYCWyNaSl0SZ71bIEfWVhwQWm6VONBj-T9QKVWz-gGyZFi3_OILV5B15riwPfboYT8r5b3v5MubeiWVyILAw4oKQRAkrX0vQdJfSNnU_uStMvMVDul3udLLI_A8xiKuycL_1gowlSpY8u9hjEsINz-LLYvZ11znu8eocXbzf6s87cK0AiR44LYcXzjcdNOg8JZqPub0roffLQbnkl8xZXzJA3cFhg3Ny0Qa9tvsYRyPTc2zGdwcA8SvCTOCwe_8gYizS8NaIQj_Fvsx6Qsv53bI39VMbNHe1", forHTTPHeaderField: "Authorization")
        
        let task = session.downloadTask(with: request) { (tempLocalUrl, response, error) in
            if let tempLocalUrl = tempLocalUrl, error == nil {
                // Success
                if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                    print("Successfully downloaded. Status code: \(statusCode)")
                }
                
                do {
                    try
                    print(destinationFileUrl)
                    DispatchQueue.global().async {
                        let data = try? Data(contentsOf: destinationFileUrl) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                        print(data)
                        DispatchQueue.main.async {
                           self.imageView.image = UIImage(data: data!)
                        }
                    }
                    
                } catch (let writeError) {
                    print("Error creating a file \(destinationFileUrl) : \(writeError)")
                }
                
            } else {
                print("Error took place while downloading a file. Error description: %@", error?.localizedDescription);
            }
        }
        task.resume()
        
    }
}
