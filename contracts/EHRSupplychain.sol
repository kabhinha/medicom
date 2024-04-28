// SPDX-License-Identifier: MIT 
pragma solidity >=0.4.22 <0.9.0;
pragma experimental ABIEncoderV2;

import "./HealthRecordSystem.sol";

contract EHRSupplychain is HealthRecordSystem {

    mapping(uint256 => Batch) public batches;
    
    // function getBatchInfo(uint256 _batchID) public view returns (Batch memory) {
    //     return batches[_batchID];
    // }
    
    // Function to link a patient's health record to medication dispensation
    function linkHealthRecordToMedication(address patient, string memory medicationInstanceID, uint256 batchID) public {
        require(patients[patient].exists, "Patient does not exist");
        require(medicationInstances[medicationInstanceID].exists, "Medication instance does not exist");
        require(batches[batchID].exists, "Batch does not exist");

        // Update health record with medication dispensation information
        updateHealthRecord(patient, medicationInstanceID, batchID);
    }
    
    // Function to retrieve medication history of a patient
    function getMedicationHistory(address patient) public view returns (uint[] memory) {
        require(patients[patient].exists, "Patient does not exist");
        
        return patients[patient].medicationHistory;
    }
    
    // Function to update health record with batch information
    function updateHealthRecordWithBatchInfo(address patient, uint256 batchID, string memory batchInfo) public {
        require(patients[patient].exists, "Patient does not exist");
        require(batches[batchID].exists, "Batch does not exist");
        
        // Update health record with batch information
        updateHealthRecordWithBatch(patient, batchID, batchInfo);
    }
    
    // Function to verify medication origin
    function verifyMedicationOrigin(string memory medicationInstanceID) public view returns (Batch memory) {
        require(medicationInstances[medicationInstanceID].exists, "Medication instance does not exist");
        
        string memory batchID = medicationInstances[medicationInstanceID].batchID;
        return getBatchInfo(batchID);
    }
    
    // Function to update health record with medication dispensation information
    function updateHealthRecord(address patient, string memory medicationInstanceID, uint256 batchID) public {
        // Call the internal function from Contract 2 (HealthRecordSystem)
        super.updateHealthRecord(patient, medicationInstanceID, batchID);
    }
    
    // Function to update health record with batch information
    function updateHealthRecordWithBatch(address patient, uint256 batchID, string memory batchInfo) public {
        // Call the internal function from Contract 2 (HealthRecordSystem)
        super.updateHealthRecordWithBatch(patient, batchID, batchInfo);
    }
}
