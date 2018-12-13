//
//  ViewController.swift
//  QuickNotes
//
//  Created by Wilmer sinchi on 11/2/18.
//  Copyright © 2018 Wilmer sinchi. All rights reserved.
//

import UIKit
import CoreData

struct classcell {
    let className : String!
//    let schedule : String!
//    let professorEmail : String!
//
    //
}

class ViewController : UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    
    let courseMaterial = CourseMaterials()
    @IBOutlet weak var editingButton: UIBarButtonItem!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var addButton: UIBarButtonItem!
    
    var courses = [Course]()
    var keys = [String]()
//    var classArray = [String]()
//    var managedObjectContext: NSManagedObjectContext? {
//        return (UIApplication.shared.delegate as! PersistenceService).persistentContainer.viewContext
//    }
//
    /////////////////////////////////////
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        let deleteButtonAcrion = ClassCellView()
        deleteButtonAcrion.deleteButton?.isHidden = true

        //implemnet something here in the retrieve note section
//        retreiveData()
        //rename a function that add the new class
        return
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
     
        retrievData()
        navBarSetting()
        reszingButton()
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        return courses.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ClassCollectionViewCell", for: indexPath) as! ClassCellView
        //set the label
        //change the cell background color by cell.bakcground.color = UIcolor to whatever you want
       //this code below here is a pratice one to see your view or how the layout looksout
        cell.className.text = courses[indexPath.row].name
//        cell.schedule.text = "MonTues 8:30pm - 9:30pm"
        //set the color of the class cell background
        cell.deleteButton?.layer.setValue(indexPath.row, forKey: "index")
        cell.deleteButton?.addTarget(self, action:#selector(deleteUser(sender:)), for: UIControl.Event.touchUpInside)
        
        
//        cell.deleteButton?.isHidden = true
        
        if (editingButton.title == "Done"){
            cell.deleteButton?.isHidden = false}else if(editingButton.title == "Edit"){
            cell.deleteButton?.isHidden = true}
        
    
    return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //        println is depreacitated
        print("user tapped on image # \(indexPath.row)")
        //create a new variable to pass to the next viewcontroller or the detailviewcontroller
        
//        courses[indexPath.row].name = courseMaterial.title
                /*
         let mydetailViewController: DetailViewController = self.storyboard?.instantiateViewController(withIdentifier: "MyDetailViewController") as! DetailViewController
         mydetailViewController.selectedImage = array[indexPath.row]
         mydetailViewController.selectedKey = keys[indexPath.row]
         
         
         self.navigationController?.pushViewController(mydetailViewController, animated: true
         */
        let cvc = self.storyboard?.instantiateViewController(withIdentifier: "assignments") as! CourseMaterials
        cvc.navigationItem.title = courses[indexPath.row].name

        self.navigationController?.pushViewController(cvc, animated: true)
//        performSegue(withIdentifier: "currentCourse", sender: indexPath)
        //fix this error of showing the current course title when its push to the new viewcontroller

//        self.collectionView.reloadData()
        
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
////let i : Int = (sender.layer.value(forKey: "index")) as! Int
//        let i : Int = (value(forKey: "index")) as! Int
////        let indexPath = sender as! IndexPath
//        if let mydetailViewController: CourseMaterials  = segue.destination as? CourseMaterials {
//
//            mydetailViewController.seletedKey = keys[i]
//        }
//
//
//    }
    
//        cell.deleteButton?.addTarget(self, action: "deleteUser:", for: UIControl.Event.touchUpInside)
//        let courseArray : Course = courses[indexPath.row]
    // putting in the name of the function which exist in the bottom
        //courseArray: courseArray is the parameter
//        cell.configureCell(courseArray:courseArray)
//        if (indexPath.row == 0){
//            let close : UIButton = (cell.viewWithTag(11) as? UIButton)!
//            close.isHidden = true
//        }
        //maybe set up the image logo for differnet class
//        if let imageData = imageData {
//            cell.myImageView.image = UIImage(data: imageData) }
    
    
    
     @objc func deleteUser(sender:UIButton) {
//        var fetchRequest: NSFetchRequest<Course> = Course.fetchRequest()
        let i : Int = (sender.layer.value(forKey: "index")) as! Int
        
            //this is how we get the data that we want back to the uicollectionview label
//        var items = PersistenceService.persistentContainer.viewContext.deletedObjects
////            .context.deletedObjects
////                fetch(fetchRequest)
////                self.courses = [items.remove(at: i)]
        let course  =  courses[i]
        
        
        PersistenceService.persistentContainer.viewContext.delete(course)
        PersistenceService.saveContext()
        
        
        courses.remove(at: i)
        self.collectionView.reloadData()
        
        
//            } catch{}
        }
        
        
//        let i : Int = (sender.layer.value(forKey: "index")) as! Int
////        courses.removeAtIndex(i)
//        courses.remove(at: i)
//        collectionView.reloadData()
    
    func navBarSetting(){
        
        self.navigationItem.title = "Courses"
        
        // write something her to change the color of the nav bar color
        
    }
        func reszingButton(){
        
        let addButton =  UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 50, height: 50))
        addButton.setImage(UIImage.init(named:"plus2"), for: .normal)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: addButton)
        
        addButton.addTarget(self, action: #selector(addButtonPressed(sender:)), for: .touchUpInside)
        
        
    }
    
  @objc func addButtonPressed(sender: UIBarButtonItem)
  {
//        let manageViewController = self.storyboard?.instantiateViewController(withIdentifier: "manageViewController") as! manageViewController
//        self.navigationController?.pushViewController(manageViewController, animated: true)
    
    let alert = UIAlertController(title: "Add Course", message: nil, preferredStyle: .alert)
    alert.addTextField{ (UITextField) in UITextField.placeholder = "Course Name"
        
    }
//    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ClassCollectionViewCell", for: indexPath) as! ClassCellView
    let action = UIAlertAction(title: "Save", style: .default) { (_) in
        let course = alert.textFields!.first!.text!
        print (course)
        let classNames = Course(context: PersistenceService.context)
        classNames.name = course
        //to save the data, back it wont read it
        //save context after being deleted so when the app reluanc it would stay deleted.
        PersistenceService.saveContext()
        
        self.courses.append(classNames)
        self.collectionView.reloadData()
        
        
    }
    alert.addAction(action)
    present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func editButton(_ sender: Any) {
        if (editingButton.title == "Edit"){
            editingButton.title = "Done"}else{
            editingButton.title = "Edit"
            
        }
        self.collectionView.reloadData()
       // editingButton.target = self;
        
        //editingButton.action = #selector(showDeleteButton(_:))
//        editingButton?.addTarget(self, action: #selector(showDeleteButton(_ :)), for: UIControl.Event.touchUpInside)
       
//    return editingButton
    }
    
    
    func retrievData(){
        let fetchRequest: NSFetchRequest<Course> = Course.fetchRequest()
        do{
            //this is how we get the data that we want back to the uicollectionview label
            do {
                let classes = try PersistenceService.context.fetch(fetchRequest)
                self.courses = classes
                self.collectionView.reloadData()
            } catch{}
        }
        
        
    }
    

    
    }


    

class ClassCellView : UICollectionViewCell
{
    
    @IBOutlet weak var deleteButton: UIButton!
    
    @IBOutlet weak var className: UILabel!
    
//    @IBOutlet weak var schedule: UILabel!
    
}

