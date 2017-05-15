<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<h2>Add Employee Data</h2>
<button type="button" class="btn btn-primary" onclick="InitData();">Test</button>
<button type="button" class="btn btn-primary" onclick="InitData2();">Test2</button>
<a href="#">ทดสอบ</a>
<input type="text" id="txtMemberNo" class="form-control" maxlength="13"
	name="memberno" placeholder="รหัสสมาชิก" />

<script type="text/javascript">
	 function InitData() {
		 waitingDialog.show('Please Wait...'); setTimeout(function () { waitingDialog.hide(); }, 50000);
     }
	 
	 function InitData2() {
			
		 waitingDialog.show('Please Wait...'); setTimeout(function () { waitingDialog.hide(); }, 50000);
	     }
	 </script>