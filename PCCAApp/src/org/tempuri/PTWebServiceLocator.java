/**
 * PTWebServiceLocator.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package org.tempuri;

import th.co.pt.pcca.pccaapp.helper.WebUtil;

public class PTWebServiceLocator extends org.apache.axis.client.Service implements org.tempuri.PTWebService {

    public PTWebServiceLocator() {
    }


    public PTWebServiceLocator(org.apache.axis.EngineConfiguration config) {
        super(config);
    }

    public PTWebServiceLocator(java.lang.String wsdlLoc, javax.xml.namespace.QName sName) throws javax.xml.rpc.ServiceException {
        super(wsdlLoc, sName);
    }

    // Use to get a proxy class for PTWebServiceSoap
    private java.lang.String PTWebServiceSoap_address = WebUtil.WebServiceIntranet();//"http://172.16.200.75/HrisWebserviceintranet/PTWebService.asmx";

    public java.lang.String getPTWebServiceSoapAddress() {
        return PTWebServiceSoap_address;
    }

    // The WSDD service name defaults to the port name.
    private java.lang.String PTWebServiceSoapWSDDServiceName = "PTWebServiceSoap";

    public java.lang.String getPTWebServiceSoapWSDDServiceName() {
        return PTWebServiceSoapWSDDServiceName;
    }

    public void setPTWebServiceSoapWSDDServiceName(java.lang.String name) {
        PTWebServiceSoapWSDDServiceName = name;
    }

    public org.tempuri.PTWebServiceSoap getPTWebServiceSoap() throws javax.xml.rpc.ServiceException {
       java.net.URL endpoint;
        try {
            endpoint = new java.net.URL(PTWebServiceSoap_address);
        }
        catch (java.net.MalformedURLException e) {
            throw new javax.xml.rpc.ServiceException(e);
        }
        return getPTWebServiceSoap(endpoint);
    }

    public org.tempuri.PTWebServiceSoap getPTWebServiceSoap(java.net.URL portAddress) throws javax.xml.rpc.ServiceException {
        try {
            org.tempuri.PTWebServiceSoapStub _stub = new org.tempuri.PTWebServiceSoapStub(portAddress, this);
            _stub.setPortName(getPTWebServiceSoapWSDDServiceName());
            return _stub;
        }
        catch (org.apache.axis.AxisFault e) {
            return null;
        }
    }

    public void setPTWebServiceSoapEndpointAddress(java.lang.String address) {
        PTWebServiceSoap_address = address;
    }

    /**
     * For the given interface, get the stub implementation.
     * If this service has no port for the given interface,
     * then ServiceException is thrown.
     */
    public java.rmi.Remote getPort(Class serviceEndpointInterface) throws javax.xml.rpc.ServiceException {
        try {
            if (org.tempuri.PTWebServiceSoap.class.isAssignableFrom(serviceEndpointInterface)) {
                org.tempuri.PTWebServiceSoapStub _stub = new org.tempuri.PTWebServiceSoapStub(new java.net.URL(PTWebServiceSoap_address), this);
                _stub.setPortName(getPTWebServiceSoapWSDDServiceName());
                return _stub;
            }
        }
        catch (java.lang.Throwable t) {
            throw new javax.xml.rpc.ServiceException(t);
        }
        throw new javax.xml.rpc.ServiceException("There is no stub implementation for the interface:  " + (serviceEndpointInterface == null ? "null" : serviceEndpointInterface.getName()));
    }

    /**
     * For the given interface, get the stub implementation.
     * If this service has no port for the given interface,
     * then ServiceException is thrown.
     */
    public java.rmi.Remote getPort(javax.xml.namespace.QName portName, Class serviceEndpointInterface) throws javax.xml.rpc.ServiceException {
        if (portName == null) {
            return getPort(serviceEndpointInterface);
        }
        java.lang.String inputPortName = portName.getLocalPart();
        if ("PTWebServiceSoap".equals(inputPortName)) {
            return getPTWebServiceSoap();
        }
        else  {
            java.rmi.Remote _stub = getPort(serviceEndpointInterface);
            ((org.apache.axis.client.Stub) _stub).setPortName(portName);
            return _stub;
        }
    }

    public javax.xml.namespace.QName getServiceName() {
        return new javax.xml.namespace.QName("http://tempuri.org/", "PTWebService");
    }

    private java.util.HashSet ports = null;

    public java.util.Iterator getPorts() {
        if (ports == null) {
            ports = new java.util.HashSet();
            ports.add(new javax.xml.namespace.QName("http://tempuri.org/", "PTWebServiceSoap"));
        }
        return ports.iterator();
    }

    /**
    * Set the endpoint address for the specified port name.
    */
    public void setEndpointAddress(java.lang.String portName, java.lang.String address) throws javax.xml.rpc.ServiceException {
        
if ("PTWebServiceSoap".equals(portName)) {
            setPTWebServiceSoapEndpointAddress(address);
        }
        else 
{ // Unknown Port Name
            throw new javax.xml.rpc.ServiceException(" Cannot set Endpoint Address for Unknown Port" + portName);
        }
    }

    /**
    * Set the endpoint address for the specified port name.
    */
    public void setEndpointAddress(javax.xml.namespace.QName portName, java.lang.String address) throws javax.xml.rpc.ServiceException {
        setEndpointAddress(portName.getLocalPart(), address);
    }

}
