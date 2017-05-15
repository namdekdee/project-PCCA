package org.tempuri;

public class PTWebServiceSoapProxy implements org.tempuri.PTWebServiceSoap {
  private String _endpoint = null;
  private org.tempuri.PTWebServiceSoap pTWebServiceSoap = null;
  
  public PTWebServiceSoapProxy() {
    _initPTWebServiceSoapProxy();
  }
  
  public PTWebServiceSoapProxy(String endpoint) {
    _endpoint = endpoint;
    _initPTWebServiceSoapProxy();
  }
  
  private void _initPTWebServiceSoapProxy() {
    try {
      pTWebServiceSoap = (new org.tempuri.PTWebServiceLocator()).getPTWebServiceSoap();
      if (pTWebServiceSoap != null) {
        if (_endpoint != null)
          ((javax.xml.rpc.Stub)pTWebServiceSoap)._setProperty("javax.xml.rpc.service.endpoint.address", _endpoint);
        else
          _endpoint = (String)((javax.xml.rpc.Stub)pTWebServiceSoap)._getProperty("javax.xml.rpc.service.endpoint.address");
      }
      
    }
    catch (javax.xml.rpc.ServiceException serviceException) {}
  }
  
  public String getEndpoint() {
    return _endpoint;
  }
  
  public void setEndpoint(String endpoint) {
    _endpoint = endpoint;
    if (pTWebServiceSoap != null)
      ((javax.xml.rpc.Stub)pTWebServiceSoap)._setProperty("javax.xml.rpc.service.endpoint.address", _endpoint);
    
  }
  
  public org.tempuri.PTWebServiceSoap getPTWebServiceSoap() {
    if (pTWebServiceSoap == null)
      _initPTWebServiceSoapProxy();
    return pTWebServiceSoap;
  }
  
  public java.lang.String PTHR_WfOutSideInsert(java.lang.String json_outside_data) throws java.rmi.RemoteException{
    if (pTWebServiceSoap == null)
      _initPTWebServiceSoapProxy();
    return pTWebServiceSoap.PTHR_WfOutSideInsert(json_outside_data);
  }
  
  public java.lang.String PTHR_WfOutSideUpdate(java.lang.String json_outside_data) throws java.rmi.RemoteException{
    if (pTWebServiceSoap == null)
      _initPTWebServiceSoapProxy();
    return pTWebServiceSoap.PTHR_WfOutSideUpdate(json_outside_data);
  }
  
  public java.lang.String PTHR_WfOutSideCancel(java.lang.String json_outside_data) throws java.rmi.RemoteException{
    if (pTWebServiceSoap == null)
      _initPTWebServiceSoapProxy();
    return pTWebServiceSoap.PTHR_WfOutSideCancel(json_outside_data);
  }
  
  public java.lang.String PTHR_WfOutSideApprove(java.lang.String json_outside_data) throws java.rmi.RemoteException{
    if (pTWebServiceSoap == null)
      _initPTWebServiceSoapProxy();
    return pTWebServiceSoap.PTHR_WfOutSideApprove(json_outside_data);
  }
  
  public java.lang.String PTHR_WfOutSideSearch(java.lang.String json_outside_data) throws java.rmi.RemoteException{
    if (pTWebServiceSoap == null)
      _initPTWebServiceSoapProxy();
    return pTWebServiceSoap.PTHR_WfOutSideSearch(json_outside_data);
  }
  
  
}