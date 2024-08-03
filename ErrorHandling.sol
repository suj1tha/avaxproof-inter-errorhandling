// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract ParkingManagement {
    uint8 public constant MAX_PARKING_SLOTS = 10;
    uint8 public availableSlots;
    address public owner;
    mapping(address => bool) public parkedVehicles;
    address[] public parkedVehicleAddresses;

    constructor() {
        owner = msg.sender;
        availableSlots = MAX_PARKING_SLOTS;
    }

    function parkVehicle() public {
        require(availableSlots > 0, "No available parking slots");
        require(!parkedVehicles[msg.sender], "Vehicle already parked");

        parkedVehicles[msg.sender] = true;
        parkedVehicleAddresses.push(msg.sender);
        availableSlots -= 1;
        
        assert(availableSlots >= 0);
    }

    function unparkVehicle() public {
        require(parkedVehicles[msg.sender], "Vehicle not parked");

        parkedVehicles[msg.sender] = false;
        removeParkedVehicleAddress(msg.sender);
        availableSlots += 1;
        
        assert(availableSlots <= MAX_PARKING_SLOTS);
    }

    function emergencyClearance() public {
        if (msg.sender != owner) {
            revert("Only the owner can perform emergency clearance");
        }

        for (uint8 i = 0; i < parkedVehicleAddresses.length; i++) {
            parkedVehicles[parkedVehicleAddresses[i]] = false;
        }
        delete parkedVehicleAddresses;
        availableSlots = MAX_PARKING_SLOTS;
    }

    function removeParkedVehicleAddress(address _address) internal {
        for (uint8 i = 0; i < parkedVehicleAddresses.length; i++) {
            if (parkedVehicleAddresses[i] == _address) {
                parkedVehicleAddresses[i] = parkedVehicleAddresses[parkedVehicleAddresses.length - 1];
                parkedVehicleAddresses.pop();
                break;
            }
        }
    }
}
