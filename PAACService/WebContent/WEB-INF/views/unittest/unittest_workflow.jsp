<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<script>
function TestUnit()
{
 var data = {}
	data["transactionId"] = $('#txtTranID').val();
	data["serviceId"] =$('#txtServiceID').val();
	data["workflowId"] = $('#txtWorkflowID').val();
	data["empidRequest"] = $('#txtEmpID').val();

	jQuery.ajax({
			url : 'workflow-getapproverstep',
			type : "Post",
			contentType : "application/json",
			data : JSON.stringify(data),
			dataType : 'json',
			success : function(data) {

				var det =JSON.stringify(data);
				 $('#divData').html(det);
			},
			error : function() {

				alert("false");

			}
		});
	}
</script>
<h1>Test Webservice Workflow</h1>
<table>
<tr>
<td align="right" width="200px;"><label>TRANSACTION_ID : </label></td>
<td align="left"><input type="text" id="txtTranID"></td>
</tr>
<tr>
<td align="right" width="200px;"><label>SERVICE_ID : </label></td>
<td align="left"><input type="text" id="txtServiceID"></td>
</tr>
<tr>
<td align="right" width="200px;"><label>WORKFLOW_ID : </label></td>
<td align="left"><input type="text" id="txtWorkflowID"></td>
</tr>
<tr>
<td align="right" width="200px;"><label>EMPID_REQUEST : </label></td>
<td align="left"><input type="text" id="txtEmpID"></td>
</tr>
<tr>
<td align="right" width="200px;"></td>
<td align="left"><input type="button" onclick="TestUnit();" value="OK"></td>
</tr>
</table>
<br/>
<label>Data Response </label>
<br/>
<br/>
<div id="divData" style="border: inset;height:200px;"></div>
