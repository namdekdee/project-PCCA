<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<style>
hr {
	border: 1px solid #ccc;
}
</style>

<script>
var numminlvl = '${sessionScope.C_UserInfo.numminlvl}';
var guId = '${sessionScope.C_UserInfo.gu_id}';

$(document).ready(
		function() {
			try{
			ShowWaiting();
// 			var guId = '${sessionScope.C_UserInfo.gu_id}';
			var date = new Date();
			var firstDay = new Date(date.getFullYear(), date.getMonth(), 1);
			var lastDay = new Date(date.getFullYear(), date.getMonth() + 1, 0);
	        var day_first = firstDay.getDate();
	        var day_last = lastDay.getDate();
	        var mont = lastDay.getMonth() + 1;
	        var year = lastDay.getFullYear();

	         if (day_first < 10) {
	        	 day_first = '0' + day_first;
	         }
	         if (day_last < 10) {
	        	 day_last = '0' + day_last;
	         }
	         if (mont < 10) {
	             mont = '0' + mont;
	         }
	         if (year < 2500) {
	             year = year + 543;
	         }
	         var start_date=day_first+'/'+mont+'/'+year;
	         var end_date=day_last+'/'+mont+'/'+year;
	        
		         $("#txtStartDate").val(start_date);
		         $("#txtEndDate").val(end_date);
			

			   	if(numminlvl>9){
					SetDropDownCompanyMD();
				}else{
		         	if(guId!="0005"){
			        	SetDropDownCompany();
					}else{
						SetDropDownCompany2();
					}
				}
			}catch(ex)
			{
				HideWaiting();
				ShowErrorMsg('0006',ex);
			}
			
		});
		
var codcomp = '${sessionScope.C_UserInfo.codcomp}'; 		
var codcomp1 = guId=='0021'?codcomp.substring(0, 3)+"000000000000000000":codcomp.substring(0, 3);
var codcomp4 = guId=='0021'?codcomp.substring(0, 12)+"000000000":codcomp.substring(9, 12);
var codcomp5 = guId=='0021'?codcomp.substring(0, 15)+"000000":codcomp.substring(12, 15);
var codcomp6 = guId=='0021'?codcomp.substring(0, 18)+"000":codcomp.substring(15, 18);
var codcomp7 = guId=='0021'?codcomp.substring(0, 21):codcomp.substring(18, 21);

	function SetDropDownCompany(){
		try{
			jQuery.ajax({
				url : 'report-getcompany',
				type : "Post",
				contentType : "application/json",
				dataType : 'json',
				success : function(obj) {
					 $('#ddlCompany') .find('option').remove().end();
			         var select = document.getElementById('ddlCompany');
			         for (var i = 0; i < obj.length; i++) {
			             var opt = document.createElement('option');
			             opt.value = obj[i].ddl_value;
			             opt.innerHTML = obj[i].ddl_text;
			             select.appendChild(opt);
			         }
			         $("#ddlCompany option[value='"+codcomp1+"']").prop('selected',true);
					 SetDropDownParty();
				},
				error : function() {
					HideWaiting();
					ShowErrorConnectMessage();
				}
			});
			
			HideWaiting();
			
		}catch(ex)
		{
			HideWaiting();
			ShowErrorMsg('0006',ex);
		}	    
	}
	
	function SetDropDownCompany2(){ 		
		try{
			jQuery.ajax({
				url : 'report-getcompany',
				type : "Post",
				contentType : "application/json",
				dataType : 'json',
				success : function(obj) {
				     var str = "";
					 $('#ddlCompany') .find('option').remove().end();
			         var select = document.getElementById('ddlCompany');
			         for (var i = 0; i < obj.length; i++) { 
			        	 var opt = document.createElement('option');
			             opt.value = obj[i].ddl_value;
			             opt.innerHTML = obj[i].ddl_text;
			             select.appendChild(opt);
			         }
					
			         $("#dlgSearchBranchUser").show();
				},
				error : function() {
					HideWaiting();
					ShowErrorConnectMessage();
				}
			});
			
			HideWaiting();
			
		}catch(ex)
		{
			HideWaiting();
			ShowErrorMsg('0006',ex);
		}	    
	}
	
	/* Set DropDownParty */
	function SetDropDownParty(){ 
		try{
			ShowWaiting();
			document.getElementById("txtEmp").value='';
			document.getElementById("txtBranch").value='';
			var company_id = document.getElementById('ddlCompany');
			var com_id  ='';
	    	com_id =company_id.value;

	    	var data = {}
// 	    	data["comp1"] = com_id;
	    	if(numminlvl>9){	
	    		data["company"] = com_id;
				$('#ddlSection').find('option').remove().end();
				$('#ddlDepartment').find('option').remove().end();
				$('#ddlBranch').find('option').remove().end();
		    	
			}else{
				data["comp1"] = com_id;
			}
	    	
	    	jQuery.ajax({
				url : 'report-getparty-R02',
				type : "Post",
				contentType : "application/json",
				data: JSON.stringify(data),
				dataType : 'json',
				success : function(obj) {   
					 $('#ddlParty') .find('option').remove().end();
			         var select = document.getElementById('ddlParty');
			         for (var i = 0; i < obj.length; i++) {
			             var opt = document.createElement('option');
			             opt.value = obj[i].ddl_value;
			             opt.innerHTML = obj[i].ddl_text;
			             select.appendChild(opt); 
			         }
// 			         $("#ddlParty option[value='"+codcomp4+"']").prop('selected',true);
// 			         SetDropDownSection();
			         if(numminlvl>9){	
			        	 HideWaiting();	
				         
			         }else{
			        	 $("#ddlParty option[value='"+codcomp4+"']").prop('selected',true);
				         SetDropDownSection();		        	 
			         }

				},
				error : function() {
					HideWaiting();
					ShowErrorConnectMessage();
				}
			});
	    	//SetDropDownEmp();
//      		HideWaiting();
		}catch(ex){
			HideWaiting();
			ShowErrorMsg('0006',ex);
		}	    
	}
	
	/* Set DropDownSection*/
	function SetDropDownSection(){ 
		try{
			ShowWaiting();
			var company4 = document.getElementById('ddlParty');
			var company1 = document.getElementById('ddlCompany');
// 			var com_id  ='';
// 	    	com_id =company_id.value;

	    	var data = {}
// 	    	data["comp4"] = company4.value;
// 	    	data["comp1"] = company1.value;
	    	if(numminlvl>9){	
	    		data["company"] = company4.value;
	    		$('#ddlDepartment').find('option').remove().end();
				$('#ddlBranch').find('option').remove().end();
		    	
	    	}else{
	    		data["comp4"] = company4.value;
		    	data["comp1"] = company1.value;
	    	}
	    	
	    	jQuery.ajax({
				url : 'report-getsection-R02',
				type : "Post",
				contentType : "application/json",
				data: JSON.stringify(data),
				dataType : 'json',
				success : function(obj) {
					 $('#ddlSection') .find('option').remove().end();
			         var select = document.getElementById('ddlSection');
			         for (var i = 0; i < obj.length; i++) {
			             var opt = document.createElement('option');			            
			             opt.value = obj[i].ddl_value; 
			             opt.innerHTML = obj[i].ddl_text;
			             select.appendChild(opt);
			         }
// 					$("#ddlSection option[value='"+codcomp5+"']").prop('selected',true);
// 			         SetDropDownDepartment()

			      	if(numminlvl>9){	
			      		SetDropDownEmp_MD(company4.value.substring(0, 12));
				     	HideWaiting();
						
					}else{
						$("#ddlSection option[value='"+codcomp5+"']").prop('selected',true);
						SetDropDownDepartment();
					}
				},
				error : function() {
					HideWaiting();
					ShowErrorConnectMessage();
				}
			});
	    	//SetDropDownEmp();
//      		HideWaiting();
		}catch(ex){
			HideWaiting();
			ShowErrorMsg('0006',ex);
		}	    
	}
	
	/* Set DropDownDepartment*/
	function SetDropDownDepartment(){ 
		try{
			ShowWaiting();
			var company5 = document.getElementById('ddlSection');
			var company4 = document.getElementById('ddlParty');
			var company1 = document.getElementById('ddlCompany');

	    	var data = {}
// 	    	data["comp1"] = company1.value;
// 	    	data["comp4"] = company4.value;
// 	    	data["comp5"] = company5.value;
	    	if(numminlvl>9){
	    		data["company"] = company5.value;
	    		$('#ddlBranch').find('option').remove().end();
	    	}else{
	    		data["comp1"] = company1.value;
		    	data["comp4"] = company4.value;
		    	data["comp5"] = company5.value;
	    	}
	    	
	    	jQuery.ajax({
				url : 'report-getdepartment-R02',
				type : "Post",
				contentType : "application/json",
				data: JSON.stringify(data),
				dataType : 'json',
				success : function(obj) {
					 $('#ddlDepartment') .find('option').remove().end();
			         var select = document.getElementById('ddlDepartment');
			         for (var i = 0; i < obj.length; i++) {
			             var opt = document.createElement('option');			            
			             opt.value = obj[i].ddl_value; 
			             opt.innerHTML = obj[i].ddl_text;
			             select.appendChild(opt);
			         }
//  					$("#ddlDepartment option[value='"+codcomp6+"']").prop('selected',true);
// 			         SetDropDownBranch()
			         if(numminlvl>9){	
			        	 SetDropDownEmp_MD(company5.value.substring(0, 15))
			        	 HideWaiting();
			         }else{
			        	 $("#ddlDepartment option[value='"+codcomp6+"']").prop('selected',true);
				         SetDropDownBranch();
			        	 
			         }		         
				},
				error : function() {
					HideWaiting();
					ShowErrorConnectMessage();
				}
				
			});
	    	//SetDropDownEmp();
//      		HideWaiting();
		}catch(ex){
			HideWaiting();
			ShowErrorMsg('0006',ex);
		}	    
	}
	
	/* Set DropDownBranch */
	function SetDropDownBranch(){
		try{
			ShowWaiting();
			var company1 = document.getElementById('ddlCompany');
			var company4 = document.getElementById('ddlParty');
			var company5 = document.getElementById('ddlSection');
			var company6 = document.getElementById('ddlDepartment');
			
			var data = {}
// 	    	data["comp1"] = company1.value;
// 			data["comp4"] = company4.value;
// 	    	data["comp5"] = company5.value;
// 	    	data["comp6"] = company6.value;

			if(numminlvl>9){
				data["company"] = company6.value;
			}else{				
				data["comp1"] = company1.value;
				data["comp4"] = company4.value;
		    	data["comp5"] = company5.value;
		    	data["comp6"] = company6.value;
			}
			
	    	
	    	jQuery.ajax({
				url : 'report-getbranch-R02',
				type : "Post",
				contentType : "application/json",
				data: JSON.stringify(data),
				dataType : 'json',
				success : function(obj) {
					 $('#ddlBranch') .find('option').remove().end();
			         var select = document.getElementById('ddlBranch');
			         for (var i = 0; i < obj.length; i++) {
			             var opt = document.createElement('option');
			             opt.value = obj[i].ddl_value;
			             opt.innerHTML = obj[i].ddl_text;
			             select.appendChild(opt);
			         }
// 			         $("#ddlBranch option[value='"+codcomp7+"']").prop('selected',true);
// 			         SetDropDownEmp()

			         if(numminlvl>9){
			        	 SetDropDownEmp_MD(company6.value.substring(0, 18))
			        	 HideWaiting();
			         }else{
			        	 $("#ddlBranch option[value='"+codcomp7+"']").prop('selected',true);
				         SetDropDownEmp();
			        	 
			         }
				},
				error : function() {
					HideWaiting();
					ShowErrorConnectMessage();
				}
				
			});
	    	//SetDropDownEmp();
//      		HideWaiting();
		}catch(ex){
			HideWaiting();
			ShowErrorMsg('0006',ex);
		}	    
	}
	
	/* Set DropDownEmp */
	function SetDropDownEmp(){
		try{
			ShowWaiting();
			var company1 = document.getElementById('ddlCompany');
			var company4 = document.getElementById('ddlParty');
			var company5 = document.getElementById('ddlSection');
			var company6 = document.getElementById('ddlDepartment');
			var company_id = document.getElementById('ddlBranch');
			
			var data = {}
			data["comp1"] = company1.value;
			data["comp4"] = company4.value;
	    	data["comp5"] = company5.value;
	    	data["comp6"] = company6.value;
	    	data["comp7"] = company_id.value;
	    	
			jQuery.ajax({
				url : 'report-getmemberfollower-company-R02',
				type : "Post",
				contentType : "application/json",
				data: JSON.stringify(data),
				dataType : 'json',
				success : function(obj) {
					$('#ddlUser') .find('option').remove().end();
		         	var select = document.getElementById('ddlUser');
		         	for (var i = 0; i < obj.length; i++) {
		             	var opt = document.createElement('option');
		             	opt.value = obj[i].ddl_value;
		            	opt.innerHTML = obj[i].ddl_text;
		            	 select.appendChild(opt);
		         	}
				},
				error : function() {
					HideWaiting();
					ShowErrorConnectMessage();
				}
			});
		
     		HideWaiting();
		}catch(ex){
			HideWaiting();
			ShowErrorMsg('0006',ex);
		}	    
	}
	
	
	
	function GetResultPdf(){
		try{
// 			var guId = '${sessionScope.C_UserInfo.gu_id}';
			var company1 = document.getElementById('ddlCompany');
			var company4 = document.getElementById('ddlParty');
			var company5 = document.getElementById('ddlSection');
			var company6 = document.getElementById('ddlDepartment');
			var company7 = document.getElementById('ddlBranch');
			var emp_id = document.getElementById('ddlUser');
						
			var start_date = $("#txtStartDate").val();
	        var end_date= $("#txtEndDate").val();
	        var check_valid =0;
	        var start_date_db ='';
	        var end_date_db ='';
	        if(start_date !=null && start_date !='' ){
	        	if(end_date !=null && end_date !=''){
	        		var res_start =start_date.split('/');
	                var res_end =end_date.split('/');
	                
	                if (res_start[0].length == 1) {
	                	res_start[0] = '0' + res_start[0];
	                }
	                if (res_start[1].length == 1) {
	                	res_start[1] = '0' + res_start[1];
	                }
	                if (res_start[2] > 2500) {
	                	res_start[2] = res_start[2] - 543;
	                }
	                start_date = res_start[2] + '-' + res_start[1] + '-' + res_start[0];
	                
	                if (res_end[0].length == 1) {
	                	res_end[0] = '0' + res_end[0];
	                }
	                if (res_end[1].length == 1) {
	                	res_end[1] = '0' + res_end[1];
	                }
	                if (res_end[2] > 2500) {
	                	res_end[2] = res_end[2] - 543;
	                }
	                end_date = res_end[2] + '-' + res_end[1] + '-' + res_end[0];
	                
	                 start_date_db=res_start[0] + '/' + res_start[1] + '/' + res_start[2];
	                 end_date_db=res_end[0] + '/' + res_end[1] + '/' + res_end[2];
	                 if(end_date <start_date){
// 	                	Clear();
	                 	HideWaiting();
	                 	ShowErrorMsg('0009',null);
	                 	check_valid++;
	                 	return false;
	                 }else if(res_start[2]!=res_end[2])	{
	                	 HideWaiting();
		                 ShowErrorMsg('0040',null);
		                 return false;
	                 }else{
	                	var oneDay = 24*60*60*1000; // hours*minutes*seconds*milliseconds
	                 	var firstDate = new Date(res_start[2],res_start[1]-1,res_start[0]);
	                 	var secondDate = new Date(res_end[2],res_end[1]-1,res_end[0]);
	                 	var diffDays = Math.round(Math.abs((firstDate.getTime() - secondDate.getTime())/(oneDay)));
						
	                 	if(guId!='0005' && guId!='0020'){
		                 	if(diffDays>31){
			                 	HideWaiting();
			                 	ShowErrorMsg('0010',null);
			                 	return false;
			             	}
	                 	}
	                 	
		            }
	        	}
	        }
	       
	        var testDate = false;
	        var comp = start_date.split('-');
			var m = parseInt(comp[1], 10);
			var d = parseInt(comp[2], 10);
			var y = parseInt(comp[0], 10);
			var date = new Date(y,m-1,d);
			
			if (date.getFullYear() == y && date.getMonth() + 1 == m && date.getDate() == d) {
				comp = end_date.split('-');
				m = parseInt(comp[1], 10);
				d = parseInt(comp[2], 10);
				y = parseInt(comp[0], 10);
				date = new Date(y,m-1,d);
				if (date.getFullYear() == y && date.getMonth() + 1 == m && date.getDate() == d) {
					testDate = true; 
				}else {
					testDate = false; 
				}
			} else {
				testDate = false; 
			}
			
			if(testDate){
				var ctx = "${pageContext.request.contextPath}";
		    	
		    	var link = ctx+"/report-getDataR02-PDF?comp1="+company1.value+"&comp4="+company4.value
		    			+"&comp5="+company5.value+"&comp6="+company6.value+"&comp7="+company7.value+"&emp_id="+emp_id.value
		    			+"&startDate="+start_date_db+"&endDate="+end_date_db;
				
		    	window.location.href = link;
			}else{
// 				Clear();
		     	HideWaiting();
		     	ShowErrorMsg('0039',null);
			}

		}catch(ex){
			HideWaiting();
			ShowErrorMsg('0006',ex);
		}	
		
		
	}
	
		
	function GetResultExcel(){
		try{
// 			var guId = '${sessionScope.C_UserInfo.gu_id}';
			var company1 = document.getElementById('ddlCompany');
			var company4 = document.getElementById('ddlParty');
			var company5 = document.getElementById('ddlSection');
			var company6 = document.getElementById('ddlDepartment');
			var company7 = document.getElementById('ddlBranch');
			var emp_id = document.getElementById('ddlUser');
						
			var start_date = $("#txtStartDate").val();
	        var end_date= $("#txtEndDate").val();
	        var check_valid =0;
	        var start_date_db ='';
	        var end_date_db ='';
	        if(start_date !=null && start_date !='' ){
	        	if(end_date !=null && end_date !=''){
	        		var res_start =start_date.split('/');
	                var res_end =end_date.split('/');
	                
	                if (res_start[0].length == 1) {
	                	res_start[0] = '0' + res_start[0];
	                }
	                if (res_start[1].length == 1) {
	                	res_start[1] = '0' + res_start[1];
	                }
	                if (res_start[2] > 2500) {
	                	res_start[2] = res_start[2] - 543;
	                }
	                start_date = res_start[2] + '-' + res_start[1] + '-' + res_start[0];
	                
	                if (res_end[0].length == 1) {
	                	res_end[0] = '0' + res_end[0];
	                }
	                if (res_end[1].length == 1) {
	                	res_end[1] = '0' + res_end[1];
	                }
	                if (res_end[2] > 2500) {
	                	res_end[2] = res_end[2] - 543;
	                }
	                end_date = res_end[2] + '-' + res_end[1] + '-' + res_end[0];
	                
	                 start_date_db=res_start[0] + '/' + res_start[1] + '/' + res_start[2];
	                 end_date_db=res_end[0] + '/' + res_end[1] + '/' + res_end[2];
	                 if(end_date <start_date){
	                 	HideWaiting();
	                 	ShowErrorMsg('0009',null);
	                 	check_valid++;
	                 	return false;
	                 }else if(res_start[2]!=res_end[2])	{
	                	 HideWaiting();
		                 ShowErrorMsg('0040',null);
		                 return false;
	                 }else{
	                	var oneDay = 24*60*60*1000; // hours*minutes*seconds*milliseconds
	                 	var firstDate = new Date(res_start[2],res_start[1]-1,res_start[0]);
	                 	var secondDate = new Date(res_end[2],res_end[1]-1,res_end[0]);
	                 	var diffDays = Math.round(Math.abs((firstDate.getTime() - secondDate.getTime())/(oneDay)));

	                 	if(guId!='0005' && guId!='0020'){
				        	if(diffDays>31){
			                 	HideWaiting();
			                 	ShowErrorMsg('0010',null);
			                 	return false;
			             	}
	                 	}
		            }
	        	}
	        }

	        
	        var testDate = false;
	        var comp = start_date.split('-');
			var m = parseInt(comp[1], 10);
			var d = parseInt(comp[2], 10);
			var y = parseInt(comp[0], 10);
			var date = new Date(y,m-1,d);
			
			if (date.getFullYear() == y && date.getMonth() + 1 == m && date.getDate() == d) {
				comp = end_date.split('-');
				m = parseInt(comp[1], 10);
				d = parseInt(comp[2], 10);
				y = parseInt(comp[0], 10);
				date = new Date(y,m-1,d);
				if (date.getFullYear() == y && date.getMonth() + 1 == m && date.getDate() == d) {
					testDate = true;
				}else {
					testDate = false;
				}
			} else {
				testDate = false;
			}

			if(testDate){
				var ctx = "${pageContext.request.contextPath}";		    	
		    	var link = ctx+"/report-getDataR02-Excel?comp1="+company1.value+"&comp4="+company4.value
	    			+"&comp5="+company5.value+"&comp6="+company6.value+"&comp7="+company7.value+"&emp_id="+emp_id.value
	    			+"&startDate="+start_date_db+"&endDate="+end_date_db;
			
	    		window.location.href = link;
			}else{
// 				Clear();
		     	HideWaiting();
		     	ShowErrorMsg('0039',null);
			}

		}catch(ex){
			HideWaiting();
			ShowErrorMsg('0006',ex);
		}	
		
	}
	
	
	function searchByEmp(){ 
		ShowWaiting();
		document.getElementById("txtBranch").value='';
		$("#ddlCompany option[value=select]").prop('selected',true);
		$('#ddlParty') .find('option').remove().end();
		$('#ddlSection') .find('option').remove().end();
		$('#ddlDepartment') .find('option').remove().end();
		$('#ddlBranch') .find('option').remove().end();
		
		var emp = document.getElementById("txtEmp");
		if(emp.value.length<6){
			HideWaiting();
	     	ShowErrorMsg('0044',null);
	     	return false;
		}
		$.ajax({
		  url: "report-getEmpBySearch",
		  type : "Post",
		  data : {
			  emp : emp.value,
		  }
		}).done(function(obj) {
			if(obj.length>0){
				$('#ddlUser') .find('option').remove().end();
	         	var select = document.getElementById('ddlUser');
	         	for (var i = 0; i < obj.length; i++) {
	             	var opt = document.createElement('option');
	             	opt.value = obj[i].DDL_VALUE;
	            	opt.innerHTML = obj[i].DDL_TEXT;
	            	 select.appendChild(opt);
	         	}
	         	HideWaiting();
			}else{
				HideWaiting();
		     	ShowErrorMsg('0045',null);
				
			}
		}).fail (function(){
			HideWaiting();
		});	
		
}

function searchByBranch(){ 
		ShowWaiting();
		document.getElementById("txtEmp").value='';
		$("#ddlCompany option[value=select]").prop('selected',true);
		$('#ddlParty') .find('option').remove().end();
		$('#ddlSection') .find('option').remove().end();
		$('#ddlDepartment') .find('option').remove().end();
		$('#ddlUser') .find('option').remove().end();
		var branch = document.getElementById("txtBranch");
	
		$.ajax({
		  url: "report-getBranchBySearch",
		  type : "Post",
		  data : {
			 branch : branch.value,
		  }
		}).done(function(obj) {
			if(obj.length>0){
				$('#ddlBranch') .find('option').remove().end();
	         	var select = document.getElementById('ddlBranch');
	         	for (var i = 0; i < obj.length; i++) {
	             	var opt = document.createElement('option');
	             	opt.value = obj[i].DDL_VALUE;
	            	opt.innerHTML = obj[i].DDL_TEXT;
	            	select.appendChild(opt);
	         	}
	         	
	         	setEmpBySearchBranch();
			}else{
				HideWaiting();
		     	ShowErrorMsg('0045',null);
			}
		}).fail (function(){
			HideWaiting();
		});
			
}

function setEmpBySearchBranch(){
	var branch = document.getElementById("ddlBranch");
	$.ajax({
		  url: "report-getEmpByBranch",
		  type : "Post",
		  data : {
			 branch : branch.value,
		  }
		}).done(function(obj) { 
			if(obj.length>0){
				$('#ddlUser') .find('option').remove().end();
	         	var select = document.getElementById('ddlUser');
	         	var opt = document.createElement('option');
             	opt.value = "ALL";
            	opt.innerHTML = "ทั้งหมด";
            	 select.appendChild(opt);
	         	for (var i = 0; i < obj.length; i++) {
	             	opt = document.createElement('option');
	             	opt.value = obj[i].DDL_VALUE;
	            	opt.innerHTML = obj[i].DDL_TEXT;
	            	 select.appendChild(opt);
	         	}
	         	HideWaiting();
			}else{
				HideWaiting();
		     	ShowErrorMsg('0045',null);
			}
		}).fail (function(){
			HideWaiting();
		});
	
}


function SetDropDownCompanyMD(){
	try{
		jQuery.ajax({
			url : 'report-getcompany',
			type : "Post",
			contentType : "application/json",
			dataType : 'json',
			success : function(obj) {
			     var str = "";
				 $('#ddlCompany') .find('option').remove().end();
		         var select = document.getElementById('ddlCompany');
		         for (var i = 0; i < obj.length; i++) { 
		        	 var opt = document.createElement('option');
		             opt.value = obj[i].ddl_value;
		             opt.innerHTML = obj[i].ddl_text;
		             select.appendChild(opt);
		         }
		         
			},
			error : function() {
				HideWaiting();
				ShowErrorConnectMessage();
			}
		});
		
		HideWaiting();
		
	}catch(ex){
		HideWaiting();
		ShowErrorMsg('0006',ex);
	}	    
}

function  SetDropDownEmp_MD(comp_id){
	
	var data = {}
	
	data["company"] = comp_id;
	
	jQuery.ajax({
		url : 'report-getmemberfollower-company-R02',
		type : "Post",
		contentType : "application/json",
		data: JSON.stringify(data),
		dataType : 'json',
		success : function(obj) {
			$('#ddlUser') .find('option').remove().end();
         	var select = document.getElementById('ddlUser');
         	for (var i = 0; i < obj.length; i++) {
             	var opt = document.createElement('option');
             	opt.value = obj[i].ddl_value;
            	opt.innerHTML = obj[i].ddl_text;
            	 select.appendChild(opt);
         	}
		},
		error : function() {
			HideWaiting();
			ShowErrorConnectMessage();
		}
	});
}

</script>

<div id="dlgSearchBranchUser" style='display: none'>
	<form id="frmSearch" class="form-horizontal"
		style="padding-left: 10px; padding-right: 10px;" method="get">
		<div class="row">
			<div class="col-md-1">
				<label for="" class="control-label">ค้นหา</label>
			</div>
			<div class="col-md-4">
				<div class="input-group">
					<input type="text" class="form-control" placeholder="Search"
						id='txtBranch'>
					<div class="input-group-btn">
						<button class="btn btn-default form-control" type="button"
							onclick="searchByBranch()">
							<i class="glyphicon glyphicon-search"></i>
						</button>
					</div>
				</div>
			</div>
			<div class="col-md-1">
				<label for="" class="control-label">พนักงาน</label>
			</div>
			<div class="col-md-4">
				<div class="input-group">
					<input type="text" class="form-control" placeholder="Search"
						id='txtEmp'>
					<div class="input-group-btn">
						<button class="btn btn-default  form-control" type="button"
							onclick="searchByEmp()">
							<i class="glyphicon glyphicon-search"></i>
						</button>
					</div>
				</div>
			</div>
		</div>
	</form>
	<hr>
</div>

<form:form id="frm" class="form-horizontal"
	style="padding-left:10px;padding-right:10px;" method="get">
	<div class="row">
		<div class="col-md-1">
			<label for="ddlCompany" class="control-label">บริษัท</label>
		</div>
		<div class="col-md-4">
			<select id="ddlCompany" class="form-control select2"
				style="width: 100%;" data-placeholder=""
				onchange="SetDropDownParty();"></select>
		</div>
		<div class="col-md-1">
			<label for="ddlParty" class="control-label">ฝ่าย</label>
		</div>
		<div class="col-md-4">
			<select id="ddlParty" class="form-control select2"
				style="width: 100%;" data-placeholder=""
				onchange="SetDropDownSection();"></select>
		</div>
	</div>
	<div class="row">
		<div class="col-md-1">
			<label for="ddlSection" class="control-label">ส่วน</label>
		</div>
		<div class="col-md-4">
			<select id="ddlSection" class="form-control select2"
				style="width: 100%;" data-placeholder=""
				onchange="SetDropDownDepartment();"></select>
		</div>
		<div class="col-md-1">
			<label for="ddlDepartment" class="control-label">แผนก/เขต</label>
		</div>
		<div class="col-md-4">
			<select id="ddlDepartment" class="form-control select2"
				style="width: 100%;" data-placeholder=""
				onchange="SetDropDownBranch();"></select>
		</div>
	</div>
	<div class="row">
		<div class="col-md-1">
			<label for="ddlBranch" class="control-label">สาขา</label>
		</div>
		<div class="col-md-4">
			<select id="ddlBranch" class="form-control select2"
				style="width: 100%;" data-placeholder=""
				onchange="SetDropDownEmp();"></select>
		</div>
		<div class="col-md-1">
			<label for="ddlUser" class="control-label">พนักงาน</label>
		</div>
		<div class="col-md-4">
			<select id="ddlUser" class="form-control select2"
				style="width: 100%;"></select>
		</div>
	</div>
	<div class="row">
		<div class="col-md-1">
			<label for="ddlDate" class="control-label">วันที่</label>
		</div>
		<div class="col-md-4">
			<input type="text" id="txtStartDate"
				class="custom-text-horizon-rangdate2" maxlength="10"
				data-inputmask="'mask': '99/99/9999'" data-mask
				data-provide="datepicker"> <label class="control-label">ถึง</label>
			<input type="text" id="txtEndDate"
				class="custom-text-horizon-rangdate2" maxlength="10"
				data-inputmask="'mask': '99/99/9999'" data-mask
				data-provide="datepicker">
		</div>
	</div>
	<div class="row">
		<div class="col-md-9"></div>
		<div class="col-md-3">
			<button type="button" class="btn btn-primary"
				onclick="GetResultPdf();">PDF</button>

			<button type="button" class="btn btn-primary"
				onclick="GetResultExcel();">EXCEL</button>
		</div>
	</div>
</form:form>