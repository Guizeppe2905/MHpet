//
//  ListViewController.swift
//  15 cacao
//
//  Created by Мария Хатунцева on 06.05.2022.
//
// swiftlint: disable: redundant_optional_initialization
// swiftlint: disable: colon
// swiftlint: disable: line_length
// swiftlint: disable: redundant_void_return
// swiftlint: disable: identifier_name
import UIKit
import CoreData
import SnapKit
import Combine

class ListTableViewController: UITableViewController {
    private let persistentContainer = NSPersistentContainer(name: "Model")
    private var savedTextName: String? = nil
    private lazy var fetchedResultsController: NSFetchedResultsController<Employee> = {
        let fetchRequest = Employee.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "lastname", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        let reverse = fetchRequest.sortDescriptors?.reversed()
        let fetchedResultsController =
        NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: self.persistentContainer.viewContext,
            sectionNameKeyPath: nil,
            cacheName: nil)
        fetchedResultsController.delegate = self
            return fetchedResultsController
    }()
    lazy var headerView: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 400, height: 50))
        label.text = " "
        return label
         }()
       private let button: UIButton = {
           let button = UIButton(frame: CGRect(x: 0, y: 150, width: 1, height: 1))
           return button
       }()
    var navigationBarAppearace = UINavigationBar.appearance()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .secondarySystemBackground
        tableView.tableHeaderView = headerView
        setNavBar()
        setSegment()
        persistentContainer.loadPersistentStores { (_, error) in
            if let error = error {
                print("Unable to load persistent store")
                print("\(error), \(error.localizedDescription)")
            } else {
                do {
                try self.fetchedResultsController.performFetch()
            } catch {
                print(error)
                       }
                   }
               }
    }
    private func setSegment() {
        let items = ["From A to Z", "From Z to A"]
        let filtersSegment = UISegmentedControl(items: items)
        filtersSegment.frame = CGRect.init(x: 0, y: 0, width: 400, height: 50)
        filtersSegment.tintColor = UIColor.black
        filtersSegment.selectedSegmentIndex = 0
        filtersSegment.backgroundColor = .systemGray6
        filtersSegment.addTarget(self, action: #selector(self.filterApply), for: UIControl.Event.valueChanged)
     view.addSubview(filtersSegment)
    }
    private func setNavBar() {
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.sizeToFit()
        navigationController?.navigationBar.backgroundColor = Constants.Colors.primaryTeal
        navigationController?.navigationBar.topItem!.title = "Список Сотрудников"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .automatic
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white, NSAttributedString.Key.font:UIFont.systemFont(ofSize: 26, weight: UIFont.Weight.bold)]
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Заполнить форму >",
                                                                 style: .done,
                                                                target: self,
                                                                action: #selector(goToApplicationForm))
        navigationItem.backBarButtonItem = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
        self.tabBarController?.navigationItem.hidesBackButton = true
    }
    @objc private func filterApply(_ segment: UISegmentedControl) -> Void {
       let reverseVC = ReverseVC()
        if segment.selectedSegmentIndex == 0 {
            savedTextName = "VC1"
        } else if segment.selectedSegmentIndex == 1 {
      navigationController?.pushViewController(reverseVC, animated: false)
            savedTextName = "VC2"
            segment.selectedSegmentIndex = 0
        } else {
            print("error Main")
        }
        UserDefaults.standard.set(savedTextName, forKey: "NewTextName")
    }
    @objc func goToApplicationForm(_ sender: Any) {
        if let vc = ViewController() as? ViewController {
        vc.employee = Employee.init(
            entity: NSEntityDescription.entity(
                forEntityName: "Employee",
                in: persistentContainer.viewContext)!,
            insertInto: persistentContainer.viewContext)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
override func numberOfSections(in tableView: UITableView) -> Int {
        return fetchedResultsController.sections?.count ?? 0
}
   override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = fetchedResultsController.sections {
            return sections[section].numberOfObjects
        }
        return 0
   }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let employee = fetchedResultsController.object(at: indexPath)
                if employee.lastname == nil || employee.name == nil {
                     cell.textLabel?.text = nil
                     } else {
                         cell.textLabel?.text = "\(employee.lastname!) \(employee.name!)"
                     }
        return cell
            }
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let employee = fetchedResultsController.object(at: indexPath)
            persistentContainer.viewContext.delete(employee)
            try? persistentContainer.viewContext.save()
        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc =  ViewController() as? ViewController {
            vc.employee = fetchedResultsController.object(at: indexPath)
            navigationController?.pushViewController(vc, animated: true)
}
}
}
extension ListTableViewController: NSFetchedResultsControllerDelegate {
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .automatic)
            }
        case .update:
            if let indexPath = indexPath {
                let employee = fetchedResultsController.object(at: indexPath)
                let cell = tableView.cellForRow(at: indexPath)
                cell!.textLabel?.text = employee.lastname
            }
        case .move:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
            if let newIndexPath = newIndexPath {
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
        case .delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
    }
    }
}
