# Application Example Hardware Engineering

## Description
This repository contains a project that was made as an example on how to use the OPC UA configuration in SIMATIC AX to visualize and control your tank application

## How to run this project

We provide you the solution already prepared for being able to run the **OPC UA Server** with just compilling and downloading the hardware and software. The hardware certificates and user configuration were already created from our side. The hardware certificate has been generated using a third-party tool, in this case **OpenSSL**. This certificate must be an X.509 certificate containing the private keys saved as PKCS#12 certificate. These files are located under the _certificate_ folder. This process is out of the scope of this project.

If you want to do it fully by your own, please follow this steps. If you want to run it direclty continue in step number 5: 

- **1st:** Delete the hwc.gen folder.

- **2nd** Run _apax install_ to install ol the project dependencies.

- **3rd:** Run the script _setup-hw-certificates_  that will setup the secure communication and then will import the certificate to the hardware.

- **4th:** Run the script _set-password_ to enable the password for the user configurated "MyUser".

- **5th:** Run the script _create-opcua-interface_ to create the opcua

- **6th:** Run the script _hcl_. Here the hardware configuration is compiled and downloaded to the plc instance.

- **7th:** Run the script _scl_. The application is built and transferred to the instance.

### Client setup

Please follow the documentation provided for enabling a client connection using the UA Expert software tool: [UA Expert Documentation](../../docs/UA-Expert/HowToUse.md)



## Changes Made for running on Ax with UE

 - Update IP addresses to the ones that works for your setup.

 - Include commands to control the tank from AX side: 
   -  fill: openInputValve
   -  stopFill: closeInputValve
   -  empty: openOutputValve
   -  stopEmpty: closeOutputValve