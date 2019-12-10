//
//  DestinationPickerController.swift
//  UbUTT
//
//  Created by if26-grp3 on 10/12/2019.
//  Copyright © 2019 BourdelatPieret. All rights reserved.
//

import UIKit
import GooglePlaces
import GoogleMaps

class DestinationPickerController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    public static let segueIdentifier: String = "segueBetweenDestinationPickerAndCreateCourse"
    
    private var workItem: DispatchWorkItem?
    var selectedRow: Int!
    
    @IBOutlet weak var destinationInput: UITextField!
    @IBAction func onEditingChangedInput(_ sender: UITextField) {
        workItem?.cancel()
        workItem = DispatchWorkItem(block: {
            self.autoCompleteWithPlaces()
        })
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3), execute: workItem!)
    }
    
    @IBOutlet weak var confirmBtn: UIButton!
    @IBAction func onConfirmPressed(_ sender: UIButton) {
        self.delegate.pass(data: self.pickerData[picker.selectedRow(inComponent: 0)])
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBOutlet weak var navbarItem: UINavigationItem!
    @IBOutlet weak var picker: UIPickerView!
    
    var pickerData: [GMSAutocompletePrediction] = [GMSAutocompletePrediction]()
    var location: CLLocation!
    
    private var placesClient: GMSPlacesClient!
    private var token: GMSAutocompleteSessionToken!
    
    var delegate: isAbleToReceiveData!
    var choice: GMSAutocompletePrediction!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        confirmBtn.layer.cornerRadius = 4

        self.picker.delegate = self
        self.picker.dataSource = self
        
        placesClient = GMSPlacesClient.shared()
        if(token == nil){
            token = GMSAutocompleteSessionToken.init()
        }
        
    }
    
    func viewWillDisappear() {
        if(delegate != nil){
            delegate.pass(data: choice)
        }
    }
    
    // Number of columns of data
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    // The data to return fopr the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row].attributedPrimaryText.string
    }
    
    /* -------------------------------------------------------------------------------------- */
    
    /* GESTION API PLACES */
    
    func autoCompleteWithPlaces(){
        // Create a type filter.
        let filter = GMSAutocompleteFilter()
        filter.type = .establishment
        
        let bounds: GMSCoordinateBounds = GMSCoordinateBounds.init(
            coordinate: CLLocationCoordinate2DMake(location.coordinate.latitude - (12000*Constants.meterInDegree), location.coordinate.longitude - (12000*Constants.meterInDegree) / cos(location.coordinate.latitude*(Double.pi/180))),
            coordinate: CLLocationCoordinate2DMake(location.coordinate.latitude + (12000*Constants.meterInDegree), location.coordinate.longitude + (12000*Constants.meterInDegree) / cos(location.coordinate.latitude*(Double.pi/180)))
        )
            
        placesClient?.findAutocompletePredictions(fromQuery: destinationInput.text!, bounds: bounds, boundsMode: GMSAutocompleteBoundsMode.bias, filter: filter, sessionToken: token,
            callback: { (results, error) in
                if let error = error {
                    print("Autocomplete error: \(error)")
                    return
                }
                if let results = results {
                    print("Autocomplete success: \(results.count) results")
                    self.pickerData = [GMSAutocompletePrediction]()
                    for result in results {
                        self.pickerData.append(result)
                    }
                    self.picker.reloadAllComponents()
                }
        })
    }
    
    /* FIN API PLACES */
    
    /* -------------------------------------------------------------------------------------- */

}
