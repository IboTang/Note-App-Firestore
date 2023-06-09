//
//  NoteViewController.swift
//  Journal App
//
//  Created by Christopher Ching on 2020-02-24.
//  Copyright © 2020 Christopher Ching. All rights reserved.
//

import UIKit

class NoteViewController: UIViewController {
    
    
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var bodyTextView: UITextView!
    
    @IBOutlet weak var starButton: UIButton!
    
    
    var note:Note?
    var notesModel:NotesModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if note != nil {
            
            // User is viewing an existing note, so populate the fields
            titleTextField.text = note?.title
            bodyTextView.text = note?.body
            
            // Set the status of the star button
            setStarButton()
        }
        else {
            // Note property is nil, so create a new note
            
            // Create the note
            let n = Note(docId: UUID().uuidString, title: titleTextField.text ?? "", body: bodyTextView.text ?? "", isStarred: false, createdAt: Date(), lastUpdatedAt: Date())
            
            self.note = n
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        // Clear the fields
        note = nil
        titleTextField.text = ""
        bodyTextView.text = ""
    }
    
    func setStarButton() {
        
        let imageName = note!.isStarred ? "star.fill" : "star"
        
        starButton.setImage(UIImage(systemName: imageName), for: .normal)
        
    }
    
    @IBAction func deleteTapped(_ sender: Any) {
        if self.note != nil {
            notesModel?.deleteNote(self.note!)
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveTapped(_ sender: Any) {
        
        // This is an update to the existing note
        self.note?.title = titleTextField.text ?? ""
        self.note?.body = bodyTextView.text ?? ""
        self.note?.lastUpdatedAt = Date()
        
        // Send it to the notes model
        self.notesModel?.saveNote(self.note!)
        
        dismiss(animated: true, completion: nil)
    }
    
   
    @IBAction func starTapped(_ sender: Any) {
        
        // Change the property in the note
        note?.isStarred.toggle()
        
        // Update the database
        notesModel?.updateFaveStatus(note!.docId, note!.isStarred)
        
        // Update the button
        setStarButton()
        
        
    }
    
   
    
}
