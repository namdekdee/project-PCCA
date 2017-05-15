/**
 * PTWebServiceSoap.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package org.tempuri;

public interface PTWebServiceSoap extends java.rmi.Remote {
    public java.lang.String PTHR_WfOutSideInsert(java.lang.String json_outside_data) throws java.rmi.RemoteException;
    public java.lang.String PTHR_WfOutSideUpdate(java.lang.String json_outside_data) throws java.rmi.RemoteException;
    public java.lang.String PTHR_WfOutSideCancel(java.lang.String json_outside_data) throws java.rmi.RemoteException;
    public java.lang.String PTHR_WfOutSideApprove(java.lang.String json_outside_data) throws java.rmi.RemoteException;
    public java.lang.String PTHR_WfOutSideSearch(java.lang.String json_outside_data) throws java.rmi.RemoteException;
}
