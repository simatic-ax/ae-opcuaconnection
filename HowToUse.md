# UAExpert  User Documentation

## Introduction

This documentation provides guidance on installing, using, and configuring UAExpert to work with this specific water tank example.

UAExpert is an OPC UA client designed to demonstrate the OPC UA technology. It serves as a versatile test client supporting various OPC UA features, making it an essential tool for developers and testers evaluating OPC UA technology. Further details: https://www.unified-automation.com/products/development-tools/uaexpert.html

## Installation

### System Requirements

- **Operating System**: Windows 10.
- **Processor**: x86 or x64 architecture.
- **Memory**: Minimum 4GB RAM.
- **Disk Space**: 1GB available.


For being able to follow this guide. You need to have already **downloaded the PLC configuration to a PLC** (e.g. PLCSim Advanced) and have it on **run** state.

###  Download

1. Visit the official UA Expert website. https://www.unified-automation.com/products/development-tools/uaexpert.html

2. Download the latest version.

### Installation Steps

Run the installer and follow on-screen instructions.

## Usage

### Initial Start-Up of UA Expert

When starting UaExpert for the first time, it is necessary to perform some final configuration steps. 
An application instance certificate is needed to create a secure channel, identifying the installation of UaExpert. A new dialog window will open, collecting the information which is needed to create such a certificate. Fill out the form and confirm with OK. Red crosses indicate that a required field is still empty.

![alt text](./screenshots/NewApplicationInstanceCertificate.png)

The new application instance certificate is saved in UaExpert’s PKI certificate store.

## Step-by-Step Connect Example

In this specific case we are going to add a new connection to the OPC UA Server that is already running on the PLC of this example.

To add a new connection to an OPC UA Server, click on the _+_ button in the toolbar or choose _Server -> Add..._ from the menu. A new dialog window will be displayed. Double-click on _Double click to Add Server_.

Then, add the IP address and the port (default: 4840) of the OPC UA server running on the PLC:

![alt text](./screenshots/AddServerConnection.png)

After finding the connection, you can add the credentials of the client configurated in the project: 

![alt text](./screenshots/UserCredentials.png)

To actually connect to the server, click on the plug connector button in the toolbar or choose Server → Connect from the menu. A new dialog window for validating the Server’s certificate will open (see screenshot). After examining the certificate, choose **Trust Server Certificate** to permanently add the certificate to UaExpert’s trust list. It is also possible to check the box at **Accept the server certificate temporarily for this session** and choose Continue to not save the certificate in the trust list. If you choose **Cancel** to reject the certificate you cannot proceed.

![alt text](./screenshots/TrustCertificate.png)


After successfully add the certificate to the trusted list, the user is able to access to the variables available on the OPC UA server. Then, by drag and drop, its possible to add a visualization of the variables:
![alt text](./screenshots/VariableDisplay.png)

*Depending on how the variables were configurated, it is possible to only read them (if they are ReadOnly) or also write them (if they are ReadWrite). In this case, it is also possible to modify the input/output valve related variables and isEmergencyDraining variable.

The user has as well a log display where he can follow every event that is tracked, like for example:

![alt text](./screenshots/LogEvent.png)