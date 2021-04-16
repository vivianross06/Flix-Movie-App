//
//  MovieTrailerViewController.swift
//  flix
//
//  Created by Vivian Ross on 4/15/21.
//

import UIKit
import WebKit

class MovieTrailerViewController: UIViewController, WKUIDelegate {
    
    var movie: [String:Any]!
    var trailerResults = [[String:Any]]()
    var trailer: [String:Any]!
    
    @IBOutlet weak var trailerView: WKWebView!
    
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let movieID = movie["id"]
        let url = URL(string:"https://api.themoviedb.org/3/movie/"+String(format: "%@", movieID as! CVarArg)+"/videos?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed&language=en-US")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
             // This will run when the network request returns
             if let error = error {
                    print(error.localizedDescription)
             } else if let data = data {
                    let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                
                self.trailerResults=dataDictionary["results"] as! [[String:Any]]
                self.trailer=self.trailerResults[0]
                let key = self.trailer["key"]
                let trailerURL = URL(string: "https://www.youtube.com/watch?v="+String(format: "%@", key as! CVarArg))
                let myRequest = URLRequest(url: trailerURL!)
                self.trailerView.load(myRequest)

             }
        }
        task.resume()
        

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
