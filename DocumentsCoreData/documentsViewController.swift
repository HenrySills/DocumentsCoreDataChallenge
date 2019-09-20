//
//  documentsViewController.swift
//  DocumentsCoreData
//
//  Created by Henry Sills on 9/19/19.
//  Copyright © 2019 Henry Sills. All rights reserved.
//

import UIKit
import CoreData

class documentsViewController: UIViewController {

    
    @IBOutlet weak var documentsTableView: UITableView!
    
    var documents = [Document]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    
    override func viewWillAppear(_ animated: Bool) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Document> = Document.fetchRequest()
        
        do{
            documents = try managedContext.fetch(fetchRequest)
            documentsTableView.reloadData()
            
        } catch {
            print("Fetch could not be performed")
        }
    }
    
    @IBAction func addDocument(_ sender: Any) {
        performSegue(withIdentifier: "showDocuments", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? DocumentsCoreDataViewController,
            let selectedRow = self.documentsTableView.indexPathForSelectedRow?.row
            else{
                return
        }
        
        destination.existingDocument = documents[selectedRow]
    }
    
    func deleteDocument(at indexPath: IndexPath) {
        let document = documents[indexPath.row]
        
        if let managedContext = document.managedObjectContext {
            managedContext.delete(document)
            
            do {
                try managedContext.save()
                
                self.documents.remove(at: indexPath.row)
                
                documentsTableView.deleteRows(at: [indexPath], with: .automatic)
            } catch {
                print("Delete Failed")
                
                documentsTableView.reloadRows(at: [indexPath], with: .automatic)
            }
        }
    }
}

extension documentsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return documents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = documentsTableView.dequeueReusableCell(withIdentifier: "docTitle", for: indexPath)
        let document = documents[indexPath.row]
        
        cell.textLabel?.text = document.name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deleteDocument(at: indexPath)
        }
    }
}

extension documentsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDocuments", sender: self)
    }
}


