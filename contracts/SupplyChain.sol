// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract SupplyChain {
    struct Product {
        bool exists;
        string productSpecID;
        string productName;
        string dosageForm;
        uint strength;
    }

    struct Batch {
        bool exists;
        string batchID;
        string productSpecID;
        uint manufactureDate;
        string lotNumber;
        bytes32 ipfsHash; // IPFS hash of health record
        address manufacturer; // Address of the manufacturer
    }
    
    struct MedicationInstance {
        bool exists;
        string medicationInstanceID;
        string batchID;
        address patient;
        uint expiryDate;
        bool dispensed;
        address[] originHistory; // List of addresses representing the origin history
    }

    mapping(string => Product) public products;
    mapping(string => Batch) public batches;
    mapping(string => MedicationInstance) public medicationInstances;
    
    function addProduct(string memory productSpecID, string memory productName, string memory dosageForm, uint strength) public {
        products[productSpecID] = Product(true, productSpecID, productName, dosageForm, strength);
    }

    function addBatch(string memory batchID, string memory productSpecID, uint manufactureDate, string memory lotNumber, bytes32 ipfsHash, address manufacturer) public {
        batches[batchID] = Batch(true, batchID, productSpecID, manufactureDate, lotNumber, ipfsHash, manufacturer);
    }
    
    function dispenseMedication(string memory medicationInstanceID, string memory batchID, address patient, uint expiryDate) public {
        require(batches[batchID].exists, "Batch does not exist");
        
        address[] memory originHistory = new address[](1);
        originHistory[0] = batches[batchID].manufacturer;
        
        medicationInstances[medicationInstanceID] = MedicationInstance(true, medicationInstanceID, batchID, patient, expiryDate, true, originHistory);
    }
    
}
