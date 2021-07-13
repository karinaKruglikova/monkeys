//
//  ViewController.swift
//  monkeys
//
//  Created by Prome Theus on 22.06.21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var selectedMonkeysTextfield: UITextField!
    var monkeysList: [String] = []
    let picker = UIPickerView()
    
    func toolbar() -> UIToolbar {
        let toolbar = UIToolbar()
        toolbar.barStyle = .default
        toolbar.sizeToFit()
        
        let done = UIBarButtonItem(title: "Done", style: .done,
                                   target: self,
                                   action: #selector(selectItem))
        toolbar.setItems([done],
                         animated: false)
        return toolbar
    }
    
    @objc func selectItem() {
        selectedMonkeysTextfield.text = "\(picker.selectedRow(inComponent: 0) + 1)" + monkeysList[picker.selectedRow(inComponent: 1)]
        selectedMonkeysTextfield.resignFirstResponder()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        monkeysList = Parser.parseNamesFromJSON()?.list ?? []
        
        picker.delegate = self
        picker.dataSource = self
        selectedMonkeysTextfield.inputView = picker
        selectedMonkeysTextfield.inputAccessoryView = toolbar()
        
    }
    
}


extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource
{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return 10
        case 1:
            return monkeysList.count
        default:
            return 0
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            return "\(row + 1)"
        case 1:
            return monkeysList[row]
        default:
            return ""
        }
    }
}
