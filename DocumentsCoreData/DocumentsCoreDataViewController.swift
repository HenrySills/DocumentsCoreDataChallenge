//
//  DocumentsCoreDataViewController.swift
//  DocumentsCoreData
//
//  Created by Henry Sills on 9/19/19.
//  Copyright © 2019 Henry Sills. All rights reserved.
//

import UIKit

class DocumentsCoreDataViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var textTextField: UITextField!
    
    var existingDocument: Document?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTextField.delegate = self
        textTextField.delegate = self
        
        nameTextField.text = existingDocument?.name
        textTextField.text = existingDocument?.text
        

        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        nameTextField.resignFirstResponder()
        textTextField.resignFirstResponder()
    }

  
    @IBAction func saveDocument(_ sender: Any) {
        let name = nameTextField.text
        let text = textTextField.text
        
        var document: Document?
        
        if let existingDocument = existingDocument {
            existingDocument.name = name
            existingDocument.text = text
            
            document = existingDocument
        } else {
            document = Document(name: name, text: text)
        }
        
        if let document = document {
            do  {
                let managedContext = document.managedObjectContext
                
                try managedContext?.save()
                
                self.navigationController?.popViewController(animated: true)

            } catch {
                print("Document could not be saved")
            }
        }
        
    }
    
}

extension DocumentsCoreDataViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
