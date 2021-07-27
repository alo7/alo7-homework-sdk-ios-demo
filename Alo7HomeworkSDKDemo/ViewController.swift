//
//  ViewController.swift
//  Alo7HomeworkSDKExample
//
//  Created by Joseph Lee on 2021/4/22.
//

import UIKit
import Alo7HomeworkSDK

class ViewController: UIViewController {
    @IBOutlet weak var token: UITextField!
    
    @IBOutlet weak var homeworkId: UITextField!
 
    @IBOutlet weak var thirdClazzIds: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func TeacherAssigned(_ sender: Any) {
        guard let token = token.text, !token.isEmpty else {
            showAlert(with: "token不能为空")
            return
        }
        Alo7HomeworkSDK.assignHomework(token: token,
                                       thirdPartyClazzIds: thirdClazzIds.text?.split(separator: ",").compactMap({"\($0)"}),
                                       from: self,
                                       success: {
                                        
                                       },
                                       fail: { [weak self ](error) in
                                        self?.showAlert(with: error.debugDescription)
                                       }) { (state) in
            switch state {
            case .close(let data):
                self.showAlert(with: "\(data)")
            @unknown default:
                fatalError()
            }
        }
    }
    
    @IBAction func teacheCheck(_ sender: Any) {
        guard let token = token.text, !token.isEmpty else {
            showAlert(with: "token不能为空")
            return
        }

        guard let id = homeworkId.text, !id.isEmpty else {
            showAlert(with: "homeworkId不能为空")
            return
        }
        
        Alo7HomeworkSDK.checkHomework(id, token: token, from: self, success: {
            
        },
        fail: { [weak self ](error) in
            self?.showAlert(with: error.debugDescription)
        })
        
    }
    
    @IBAction func studentCheck(_ sender: Any) {
        guard let token = token.text, !token.isEmpty else {
            showAlert(with: "token不能为空")
            return
        }

        guard let id = homeworkId.text, !id.isEmpty else {
            showAlert(with: "homeworkId不能为空")
            return
        }
        Alo7HomeworkSDK.showHomework(
            id, token: token, from: self,
            success: {
                
            },
            fail: { [weak self ](error) in
                self?.showAlert(with: error.debugDescription)
                
            })
        
    }
    
    private func showAlert(with message: String){
        let alertVc = UIAlertController(title: message, message: nil, preferredStyle: .alert)
        alertVc.addAction(UIAlertAction(title: "确定", style: .cancel, handler: nil))
        present(alertVc, animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

