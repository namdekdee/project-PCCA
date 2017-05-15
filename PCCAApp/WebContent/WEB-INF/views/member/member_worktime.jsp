<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<style>
.btn-file {
	position: relative;
	overflow: hidden;
}

.btn-file input[type=file] {
	position: absolute;
	top: 0;
	right: 0;
	min-width: 100%;
	min-height: 100%;
	font-size: 100px;
	text-align: right;
	filter: alpha(opacity = 0);
	opacity: 0;
	outline: none;
	background: white;
	cursor: inherit;
	display: block;
}

.status-req1 {
	background-color: #ff8c00;
	color: white;
}

.status-req2 {
	background-color: yellow;
}

.status-req3 {
	background-color: #48d1cc;
	color: white;
}

.status-approve {
	background-color: #32cd32;
	color: white;
}

.status-unapprove {
	background-color: red;
	color: white;
}

.status-default {
	background-color: white;
	color: black;
}

.status-cancel {
	background-color: black;
	color: white;
}
}
</style>
<script>
	$(document).ready(
			function() {
				
				try
				{
				ShowWaiting();
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
		         //$('#txtStartDate').datepicker('setDate', '03/10/2559');
// 		         $('#txtEndDate').datepicker('setDate', end_date);
				
				$('#iconInformation').popover({
					html: true,
					content: function(){
						return $('#ShowStatusInformation').html();
					}
				});
				
				//$('input[id="chkUser"]').on('ifChecked', function(event){
				//	  document.getElementById("ddlUser").disabled=false;
				//	});
				//$('input[id="chkUser"]').on('ifUnchecked', function(event){
				//	  document.getElementById("ddlUser").disabled=true;
				//	});
				$('input[id="chkDlgLeaveRangDate"]').on('ifChecked', function(event){
					  document.getElementById("trDlgLeaveTo").style.display = "table-row";
					  
					});
				$('input[id="chkDlgLeaveRangDate"]').on('ifUnchecked', function(event){
					  document.getElementById("trDlgLeaveTo").style.display = "none";
					});
				
				$('input[id="chkDlgStartLeaveMo"]').on('ifChecked', function(event){
					  var chk = document.getElementById('chkDlgEndLeaveAf').checked;
					  if(chk){
							$('#chkDlgStartLeaveAf').iCheck('check');
							$('#chkDlgEndLeaveMo').iCheck('check');
					  }
					  
					});

				$('input[id="chkDlgEndLeaveAf"]').on('ifChecked', function(event){
					  var chk = document.getElementById('chkDlgStartLeaveMo').checked;
					  if(chk){
							$('#chkDlgStartLeaveAf').iCheck('check');
							$('#chkDlgEndLeaveMo').iCheck('check');
					  }
					  
					});
			
				SetDropDownCompany();
				}catch(ex)
				{
					HideWaiting();
					ShowErrorMsg('0006',ex);
				}
				
			});
	
	function parseDate(str) {
	    var mdy = str.split('/');
	    return new Date(mdy[2], mdy[1], mdy[0]);
	}

	function daydiff(first, second) {
	    return Math.round((second-first)/(1000*60*60*24));
	}
	function SetDropDownCompany()
	{
		try
		{
		
	     jQuery.ajax({
				url : 'util-getcompany',
				type : "Post",
				contentType : "application/json",
				dataType : 'json',
				success : function(obj) {
					console.log(obj);
					 $('#ddlCompany') .find('option').remove().end();
			         var select = document.getElementById('ddlCompany');
			         for (var i = 0; i < obj.length; i++) {
			             var opt = document.createElement('option');
			             opt.value = obj[i].ddl_value;
			             opt.innerHTML = obj[i].ddl_text;
			             select.appendChild(opt);
			         }

			        
			         SetDropDownDefault();
				},
				error : function() {
					HideWaiting();
					ShowErrorConnectMessage();
				}
			});
			
		}catch(ex)
		{
			HideWaiting();
			ShowErrorMsg('0006',ex);
		}	    
	}
	function SetDropDownDefault()
	{
		try
		{
			var company_id = document.getElementById('ddlCompany');
			var com_id  ='';
			 if(company_id.selectedIndex >0){
	    		 com_id =company_id.value;
	    	 }
	    	var data = {}
	    	data["company"] = com_id;
	    	
			 jQuery.ajax({
				 	url : 'util-getmemberfollower-default',
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
				             if(i==1){
				             	opt.selected =true;
				             }
				             select.appendChild(opt);
				         }
				         
				         InitDropDownTimeCause();
					},
					error : function() {
						HideWaiting();
						ShowErrorConnectMessage();
					}
				});
		 
		}catch(ex)
		{
			HideWaiting();
			ShowErrorMsg('0006',ex);
		}
		
		 
         
	}
	function InitDropDown(){
		var company_id = document.getElementById('ddlCompany');
		var com_id  ='';
		ShowWaiting();
		 if(company_id.selectedIndex >0){
			 SetDropDown();
    	 }else{
    		 SetDropDownDefault();
    	 }
	}
	function SetDropDown()
	{
		try
		{
			var company_id = document.getElementById('ddlCompany');
			var com_id  ='';
			 if(company_id.selectedIndex >0){
	    		 com_id =company_id.value;
	    	 }
	    	var data = {}
	    	data["company"] = com_id;
	    	
			 jQuery.ajax({
				 	url : 'util-getmemberfollower-company',
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
// 				             if(i==1){
				             if(i==0){
				             	opt.selected =true;
				             }
				             select.appendChild(opt);
				         }
				         
// 				         InitDropDownTimeCause();
				         InitDropDownTimeCause2();
					},
					error : function() {
						HideWaiting();
						ShowErrorConnectMessage();
					}
				});
		 
		}catch(ex)
		{
			HideWaiting();
			ShowErrorMsg('0006',ex);
		}
		
		 
         
	}
	function InitDropDownTimeCause()
	{
		try
		{
		jQuery.ajax({
			url : 'util-getworktimetimecause',
			type : "Post",
			contentType : "application/json",
			dataType : 'json',
			success : function(obj) {
				 $('#ddlDlgEditTimeCause') .find('option').remove().end();
				 var select = document.getElementById('ddlDlgEditTimeCause');
				for (var i = 0; i < obj.length; i++) {
		             var opt = document.createElement('option');
		             opt.value = obj[i].ddl_value;
		             opt.innerHTML = obj[i].ddl_text;
		             select.appendChild(opt);
		         }
				
				 InitDropDownWorktimeDoctype();
			},
			error : function() {
				HideWaiting();
				ShowErrorConnectMessage();
			}
		});
		}catch(ex)
		{
			HideWaiting();
			ShowErrorMsg('0006',ex);
		}
		
	}
	function InitDropDownTimeCause2()
	{
		try
		{
		jQuery.ajax({
			url : 'util-getworktimetimecause',
			type : "Post",
			contentType : "application/json",
			dataType : 'json',
			success : function(obj) {
				 $('#ddlDlgEditTimeCause') .find('option').remove().end();
				 var select = document.getElementById('ddlDlgEditTimeCause');
				for (var i = 0; i < obj.length; i++) {
		             var opt = document.createElement('option');
		             opt.value = obj[i].ddl_value;
		             opt.innerHTML = obj[i].ddl_text;
		             select.appendChild(opt);
		         }
				
				 InitDropDownWorktimeDoctype2();
			},
			error : function() {
				HideWaiting();
				ShowErrorConnectMessage();
			}
		});
		}catch(ex)
		{
			HideWaiting();
			ShowErrorMsg('0006',ex);
		}
		
	}
	function InitDropDownWorktimeDoctype()
	{
		try
		{
			var emp_id = document.getElementById('ddlUser');
			 var em_id ='';
        	 //if(emp_id.selectedIndex >0){
        		 em_id =emp_id.value;
        	 //}
        	  var data1 = {}
      		 data1["emp_id"] = '';
		jQuery.ajax({
			url : 'util-getworktimedoctype-all',
			type : "Post",
			contentType : "application/json",
			 data: JSON.stringify(data1),
			dataType : 'json',
			success : function(obj) {
				 $('#ddlOption') .find('option').remove().end();
				 var select = document.getElementById('ddlOption');
				for (var i = 0; i < obj.length; i++) {
		             var opt = document.createElement('option');
		             opt.value = obj[i].ddl_value;
		             opt.innerHTML = obj[i].ddl_text;
		             select.appendChild(opt);
		         }
				PreWorkTime(obj);  
				/* var data = {}
	      		 data["emp_id"] = em_id;
				jQuery.ajax({
					url : 'util-getworktimedoctype-all',
					type : "Post",
					contentType : "application/json",
					data: JSON.stringify(data),
					dataType : 'json',
					success : function(obj) {
				 		 PreWorkTime(obj);
					},
					error : function() {
						HideWaiting();
						ShowErrorConnectMessage();
					}
				});*/
			},
			error : function() {
				HideWaiting();
				ShowErrorConnectMessage();
			}
		});
		}catch(ex)
		{
			HideWaiting();
			ShowErrorMsg('0006',ex);
		}
		 
	}
	
	function InitDropDownWorktimeDoctype2()
	{
		try
		{
			var emp_id = document.getElementById('ddlUser');
			 var em_id ='';
        	 //if(emp_id.selectedIndex >0){
        		 em_id =emp_id.value;
        	 //}
        	  var data1 = {}
      		 data1["emp_id"] = '';
			jQuery.ajax({
				url : 'util-getworktimedoctype-all',
				type : "Post",
				contentType : "application/json",
				 data: JSON.stringify(data1),
				dataType : 'json',
				success : function(obj) {
				 $('#ddlOption') .find('option').remove().end();
				 var select = document.getElementById('ddlOption');
				for (var i = 0; i < obj.length; i++) {
		             var opt = document.createElement('option');
		             opt.value = obj[i].ddl_value;
		             opt.innerHTML = obj[i].ddl_text;
		             select.appendChild(opt);
		         }
// 				PreWorkTime(obj);  
				Clear();
				HideWaiting();
			},
			error : function() {
				HideWaiting();
				ShowErrorConnectMessage();
			}
		});
		}catch(ex)
		{
			HideWaiting();
			ShowErrorMsg('0006',ex);
		}
		 
	}
	
	function PreWorkTime(obj)
	{
		try
		{
		
		InitWorkTime(obj);
		}
		catch(ex)
		{
			alert(ex);
			HideWaiting();
			ShowErrorMsg('0006',ex);
		}
	}
	function PreWorkTime2()
	{
		ShowWaiting();
		var emp_id = document.getElementById('ddlUser');
		 var em_id ='';
   	 //if(emp_id.selectedIndex >0){
   		 em_id =emp_id.value;
   	 //}
		 var data = {}
  		 data["emp_id"] = '';
		
		jQuery.ajax({
			url : 'util-getworktimedoctype-all',
			type : "Post",
			contentType : "application/json",
			data: JSON.stringify(data),
			dataType : 'json',
			success : function(obj) {
		 		 PreWorkTime(obj);
			},
			error : function() {
				HideWaiting();
				ShowErrorConnectMessage();
			}
		});
		//InitDropDownWorktimeDoctype();
	}
	function PreWorkTime3()
	{
		InitDropDownWorktimeDoctype();
	}
	
	
	
	function InitWorkTime(obj_ddl)
	{
		try
		{
		var emp_id = document.getElementById('ddlUser');
		var start_date = $("#txtStartDate").val();
        var end_date= $("#txtEndDate").val();
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
                
                var start_date_db=res_start[0] + '/' + res_start[1] + '/' + res_start[2];
                var end_date_db=res_end[0] + '/' + res_end[1] + '/' + res_end[2];
                if(end_date <start_date){
                	Clear();
                	HideWaiting();
                	ShowErrorMsg('0009',null);
                }else{
                	var oneDay = 24*60*60*1000; // hours*minutes*seconds*milliseconds
                	var firstDate = new Date(res_start[2],res_start[1],res_start[0]);
                	var secondDate = new Date(res_end[2],res_end[1],res_end[0]);
                	var diffDays = Math.round(Math.abs((firstDate.getTime() - secondDate.getTime())/(oneDay)));
                	if(diffDays>30){
                		Clear();
                    	HideWaiting();
                    	ShowErrorMsg('0010',null);
                	}else
                		{
                		 var em_id ='';
                    	 if(emp_id.selectedIndex >0){
                    		 em_id =emp_id.value;
                    	 }
                    	 var w_type='';
                    		 var ddlwork_type = document.getElementById('ddlOption');
                    		 if(ddlwork_type.selectedIndex >0){
                    			 w_type =ddlwork_type.value;
                    		 }
                   var company_id = document.getElementById('ddlCompany');
                 var com_id  ='';
                 if(company_id.selectedIndex >0){
                 	   com_id =company_id.value;
                  }
        		  var data = {}
        		data["codempid"] = em_id;
        		data["start_date"] = start_date_db;
        		data["end_date"] = end_date_db;
        		data["work_type"] = w_type;
        		data["company_id"] = com_id;

        		jQuery.ajax({
        			url : 'member-getmemberworktime',
        			type : "Post",
        			contentType : "application/json",
        			 data: JSON.stringify(data),
        			dataType : 'json',
        			success : function(obj) {   		
        				if(obj.length>0){
        				var nowDate = new Date();	
        				document.getElementById('statusInformation').style.display = "block";	
        				var mask_time="'mask': '99.99'";
        				var mask_date="'mask': '99/99/9999'";
        				var str='<ul class="products-list product-list-in-box" >';
        				var check_approve=0;
        				var check_approve_case =0;
        				var classtime_disable ='';
        				var classddl_disable ='';
        				var classlabel_time ='';
        				$("#txtMaxRow").val(obj.length);
        				$('#txtEmpType').val(obj[0].emp_type);
        				 for (var i = 0; i < obj.length; i++) {
        					  check_approve=0;
             				 check_approve_case =0;
             				 classtime_disable ='';
             				 classddl_disable ='';
             				 classlabel_time ='';
             				
        					 var data_list = {}
        					 data_list["row"] = i;
        					 data_list["codempid"] = obj[i].codempid;
        					 data_list["namempt"] = obj[i].namempt;
        					 var isHoliday = false;
        					 var isSpecialHoliday = false;
        					 if(obj[i].typwork=="H" || obj[i].typwork=="T") {
        						 isHoliday = true;
        						 if(obj[i].typwork=="T" && (obj[i].holiday_desc != null && obj[i].holiday_desc !='' && obj[i].holiday_desc !='null' ) > 0) isSpecialHoliday = true;
        					 }
        					 
        					 str=str+'<li class="item custom-worktime-list" style="border-radius: 5px;">'; 
        					
        					 str=str+'<div class="row" style="padding-left: 20px;line-height: 3px;">';
        					 str=str+' <input type="text" style="display:none;" id="txtWorkTypeHide'+i+'"  value="'+obj[i].typwork+'" > ';
        					
        					 str=str+' <input type="text" style="display:none;" id="txtWorkDateHide'+i+'"  value="'+obj[i].dtework+'" > ';
        					 str=str+' <input type="text" style="display:none;" id="txtShiftStartTime'+i+'"  value="'+obj[i].shift_start_time+'" > ';
        					 str=str+' <input type="text" style="display:none;" id="txtShiftEndTime'+i+'"  value="'+obj[i].shift_end_time+'" > ';
        					 str=str+' <input type="text" style="display:none;" id="txtShiftStartBreakTime'+i+'"  value="'+obj[i].shift_start_breaktime+'" > ';
        					 str=str+' <input type="text" style="display:none;" id="txtShiftEndBreakTime'+i+'"  value="'+obj[i].shift_end_breaktime+'" > ';
        					 str=str+' <input type="text" style="display:none;" id="txtShiftStartDate'+i+'"  value="'+obj[i].dtestrtw+'" > ';
        					 str=str+' <input type="text" style="display:none;" id="txtShiftEndDate'+i+'"  value="'+obj[i].dteendw+'" > ';
//         					 str=str+' <input type="text" style="display:none;" id="txtflag'+i+'"  value="''" > ';
        					 str=str+'</div>';
        					 str=str+'<table class="custable-edittime">';
        					 str=str+'<tr><td colspan="4">'
        					 if(isHoliday) {
        						 str=str+'<div style="color:red; padding-left: 5px; padding-bottom:5px;width:25px; float:left;"><i class="glyphicon glyphicon-star pull-left"></i>&nbsp;</div>';
        						 str=str+'<div>';
        					 } else {
        						 str=str+'<div style="padding-left:5px;">';
        					 }
        					 str=str+'<label class="custom-font-label-thin-small pull-left">วัน'+obj[i].short_date+'</label>';
        					 if(isSpecialHoliday) {
        						 str=str+'<label class="custom-font-label-thin-small pull-left">&nbsp;&nbsp;('+obj[i].holiday_desc+')</label>';
        					 }
        					 str=str+'</div></td></tr><tr>';
        					 
        					 str=str+'<td class="custom-col-table1" colspan="3" style="padding-left: 4px; text-align:left;" ><label  class="custom-font-label-thin-small">'+obj[i].codempid+' '+obj[i].namempt+'</label></td>';
        					 str=str+'<td class="custom-col-table4" style="padding-left: 2px;">';
        				
        					 if(obj[i].list_leave !=null && obj[i].list_leave != '' && obj[i].list_leave != 'null'){
        						 if(obj[i].list_leave.length >0){
        							 if(obj[i].list_leave.length ==1){ //in case have only 1 leave request
        								 var status = obj[i].list_leave[0].leave_request_status;
        								 if(status=='08'){
    										 check_approve++;
    										 if(obj[i].list_leave[0].start_time != '' && obj[i].list_leave[0].start_time != null && obj[i].list_leave[0].start_time !=' '){
    											 if(obj[i].list_leave[0].end_time != '' && obj[i].list_leave[0].end_time != null && obj[i].list_leave[0].end_time !=' '){
        											 check_approve_case =0;
        										 }else{
        											 check_approve_case =1;
        										 }
    										 }else{
    											 check_approve_case =1;
    										 }
    									 }
        							 	 if(obj[i].list_leave[0].cancel_status=='1'){
        							 		 status = obj[i].list_leave[0].cancel_leave_status;
        							 	 }
        							 	if(status=="10") str=str+'<select style="width:100%;height:25px;background-color:#eee;color:#5e5e5e;" disabled><option>ไม่มีรายการลา</option></select>';
        							 	else {
        							 		str=str+'<select class="'+CheckStatusStyle(status)+'" id="ddlLeave'+i+'" style="width:100%;height:25px;"   onclick="ShowLeaveRequest(&quot;'+obj[i].codempid+'|'+obj[i].namempt+'|'+obj[i].dtework+'|'+obj[i].list_leave[0].start_leave_flag+'|'+obj[i].list_leave[0].end_leave_flag+'|'+obj[i].list_leave[0].start_leave_date+'|'+obj[i].list_leave[0].end_leave_date+'|'+obj[i].list_leave[0].leave_remark+'|'+obj[i].list_leave[0].leave_file_name+'|'+obj[i].list_leave[0].leave_request_date+'|'+obj[i].list_leave[0].leave_id+'|'+obj[i].list_leave[0].leave_desc+'|'+obj[i].codcomp+'|'+obj[i].codshift+'|'+obj[i].list_leave[0].leave_docno+'|'+obj[i].list_leave[0].leave_request_status+'|'+obj[i].list_leave[0].cancel_status+'|'+obj[i].list_leave[0].cancel_docno+'|'+obj[i].list_leave[0].cancel_doc_status+'|'+obj[i].list_leave[0].cancel_approver+'|'+obj[i].list_leave[0].request_doc_status+'|'+obj[i].list_leave[0].request_approver+'|'+obj[i].list_leave[0].cancel_leave_status+'|'+i+'|'+obj[i].emp_type+'&quot;);">';
        									str=str+'<option hidden value="'+obj[i].list_leave[0].leave_docno+'">'+obj[i].list_leave[0].leave_desc+'</option>';
        	        					 	str=str+'</select>';
        							 	}
        							 }else{
//         								$('#txtflag').val('A');
//         				alert(obj[i].start_leave_flag+"  "+obj[i].end_leave_flag);
        								 str=str+'<select id="ddlLeaveList'+i+'" style="width:100%;height:25px;" onchange="PreShowLeaveRequest(&quot;'+i+'|'+obj[i].codempid+'|'+obj[i].namempt+'|'+obj[i].dtework+'|'+obj[i].codcomp+'|'+obj[i].codshift+'|'+obj[i].emp_type+'&quot;);">';
        								 str=str+'<option style="background-color:white; color:black;" value="">รายการลา</option>';
        								 
        								 for(var index_leave =0;index_leave <obj[i].list_leave.length;index_leave++){
        									 var class_leave ='';
        									 var sta =obj[i].list_leave[index_leave].leave_request_status;
        									 
        									 if(obj[i].list_leave[index_leave].cancel_status=='1'){
        										 sta =obj[i].list_leave[index_leave].cancel_leave_status;
        									 }
        									 class_leave =CheckStatusStyle(sta);
        									 if(sta=='10') continue;				//in case canceled document
        									 if(sta=='08'){
        										 check_approve++;
        										 if(obj[i].list_leave[index_leave].start_time != '' && obj[i].list_leave[index_leave].start_time != null && obj[i].list_leave[index_leave].start_time !=' '){
        											 if(obj[i].list_leave[index_leave].end_time != '' && obj[i].list_leave[index_leave].end_time != null && obj[i].list_leave[index_leave].end_time !=' '){
            											 check_approve_case =0;
            										 }else{
            											 check_approve_case =1;
            										 }
        										 }else{
        											 check_approve_case =1;
        										 }
        									 }
        									 str=str+'<option class="'+class_leave+'" value="'+obj[i].list_leave[index_leave].leave_docno+'">'+obj[i].list_leave[index_leave].leave_desc+'</option>';
        								 }
        								 str=str+'</select>';
        								 for(var index_leave =0;index_leave <obj[i].list_leave.length;index_leave++){
        								    str=str+' <input type="text" style="display:none;" id="txtStartLeaveFlag'+i+''+index_leave+'"  value="'+obj[i].list_leave[index_leave].start_leave_flag+'" > ';
        								    str=str+' <input type="text" style="display:none;" id="txtEndLeaveFlag'+i+''+index_leave+'"  value="'+obj[i].list_leave[index_leave].end_leave_flag+'" > ';
        								    str=str+' <input type="text" style="display:none;" id="txtStartLeaveDate'+i+''+index_leave+'"  value="'+obj[i].list_leave[index_leave].start_leave_date+'" > ';
        								    str=str+' <input type="text" style="display:none;" id="txtEndLeaveDate'+i+''+index_leave+'"  value="'+obj[i].list_leave[index_leave].end_leave_date+'" > ';
        								    str=str+' <input type="text" style="display:none;" id="txtLeaveRemark'+i+''+index_leave+'"  value="'+obj[i].list_leave[index_leave].leave_remark+'" > ';
        								    str=str+' <input type="text" style="display:none;" id="txtLeaveFileName'+i+''+index_leave+'"  value="'+obj[i].list_leave[index_leave].leave_file_name+'" > ';
        								    str=str+' <input type="text" style="display:none;" id="txtLeaveRequestDate'+i+''+index_leave+'"  value="'+obj[i].list_leave[index_leave].leave_request_date+'" > ';
        								    str=str+' <input type="text" style="display:none;" id="txtLeaveId'+i+''+index_leave+'"  value="'+obj[i].list_leave[index_leave].leave_id+'" > ';
        								    str=str+' <input type="text" style="display:none;" id="txtLeaveDesc'+i+''+index_leave+'"  value="'+obj[i].list_leave[index_leave].leave_desc+'" > ';
        								    str=str+' <input type="text" style="display:none;" id="txtStartLeaveDocNo'+i+''+index_leave+'"  value="'+obj[i].list_leave[index_leave].leave_docno+'" > ';
        								    str=str+' <input type="text" style="display:none;" id="txtLeaveRequestStatus'+i+''+index_leave+'"  value="'+obj[i].list_leave[index_leave].leave_request_status+'" > ';
        								    str=str+' <input type="text" style="display:none;" id="txtLeaveCancelStatus'+i+''+index_leave+'"  value="'+obj[i].list_leave[index_leave].cancel_status+'" > ';
        								    str=str+' <input type="text" style="display:none;" id="txtLeaveCancelDocNo'+i+''+index_leave+'"  value="'+obj[i].list_leave[index_leave].cancel_docno+'" > ';
        								    str=str+' <input type="text" style="display:none;" id="txtLeaveCancelDocStatus'+i+''+index_leave+'"  value="'+obj[i].list_leave[index_leave].cancel_doc_status+'" > ';
        								    str=str+' <input type="text" style="display:none;" id="txtLeaveCancelApprover'+i+''+index_leave+'"  value="'+obj[i].list_leave[index_leave].cancel_approver+'" > ';
        								    str=str+' <input type="text" style="display:none;" id="txtLeaveDocStatus'+i+''+index_leave+'"  value="'+obj[i].list_leave[index_leave].request_doc_status+'" > ';
        								    str=str+' <input type="text" style="display:none;" id="txtLeaveApprover'+i+''+index_leave+'"  value="'+obj[i].list_leave[index_leave].request_approver+'" > ';
        								    str=str+' <input type="text" style="display:none;" id="txtCancelLeaveStatus'+i+''+index_leave+'"  value="'+obj[i].list_leave[index_leave].cancel_leave_status+'" > ';
        								 }
        							 }
        						 }
        					 } else {
        						 str=str+'<select style="width:100%;height:25px;background-color:#eee;color:#5e5e5e;" disabled><option>ไม่มีรายการลา</option></select>';
        					 }
        					 
        					  
        					 str=str+'</td>';
        					 str=str+'</tr>';
        					 str=str+'<tr>';
        					 classlabel_time ='';
        					 var class_casedoc ='';
        					 var event_casedoc ='';
        					 
        					 
        					 if(obj[i].case_doc ==0){
        						 if(obj[i].case_time == 1){
        							 if(obj[i].typwork =="W"){
        								 if (check_approve<= 0){
        									 if(obj[i].timin ==null ||obj[i].timin ==''||obj[i].timin =='null'|| obj[i].timout ==null ||obj[i].timout ==''||obj[i].timout =='null'){
        									 if(obj[i].flag_time =='Y'){
        										 class_casedoc ='text-attend-time-error'; 
        									 }else{
        									 class_casedoc ='text-attend-time-normal'; 
        									 }
        									 }else{
        	        							 class_casedoc ='text-attend-time-normal';  
        	        						 }
        								 }else{
        									 class_casedoc ='text-attend-time-normal'; 
        									  
        								 }
        							 }else{
        								 if(obj[i].timin !=null ||obj[i].timout !=null){
        									 if(obj[i].flag_time =='Y'){
        										 class_casedoc ='text-attend-time-error'; 
        									 }else{
        									 class_casedoc ='text-attend-time-normal'; 
        									 }
        								 }else{
        									 class_casedoc ='text-attend-time-normal';  
        								 }
        							 }
        						 }else{
        							 class_casedoc ='text-attend-time-normal';  
        						 }
        						
        					 }else{
        						
        						 if(obj[i].case_doc =='2'){
        							 class_casedoc ='text-attend-doc-status-req1';  
        							
        						 }
        						 else{
        							 if(obj[i].case_doc =='3'){
        								 class_casedoc ='text-attend-doc-status-approved'; 
            							 
            						 }
        							 else{
        								 if(obj[i].case_doc =='-3'){
        									 class_casedoc ='text-attend-doc-status-approved';  
        								 }else{
                							 if(obj[i].case_doc =='4'){
                								 class_casedoc ='text-attend-doc-status-unapproved';  
                    							
                    						 }
                    						 else{
                    							 if(obj[i].case_doc =='5'){
                    								 class_casedoc ='text-attend-doc-status-req2';  
                        							 
                        						 }
                        						 else{
                        							 if(obj[i].case_doc =='6'){
                        								 class_casedoc ='text-attend-doc-status-req3';  
                            							 
                            						 }
                            						 else{
                            							 class_casedoc ='text-attend-time-normal';  
                            							 
                            						 }
                        						 }
                    						 }
                						 }
        							 }
            						 
        							 
        							 
        							 
        						 }
        						 
        					 }
        					
        					 if(obj[i].request_docno !=null && obj[i].request_docno != '' && obj[i].request_docno != ' '){
        					 event_casedoc ='onclick="ShowRequestEditTime(&quot;'+i+'|'+obj[i].codempid+'|'+obj[i].namempt+'|'+obj[i].dtework+'|'+obj[i].request_datein+'|'+obj[i].request_timein+'|'+obj[i].request_dateout+'|'+obj[i].request_timeout+'|'+obj[i].request_cause+'|'+obj[i].request_remark+'|'+obj[i].request_doc_status+'|'+obj[i].case_doc+'|'+obj[i].dtein+'|'+obj[i].timin+'|'+obj[i].dteout+'|'+obj[i].timout+'|'+obj[i].dteendw+'|'+obj[i].request_approver+'|'+obj[i].codcomp+'|'+obj[i].codshift+'|'+obj[i].request_docno+'|'+obj[i].dtestrtw+'|'+obj[i].timstrtw+'|'+obj[i].typwork+'|'+obj[i].short_date+'|'+obj[i].holiday_desc+'|'+obj[i].timendw+'&quot;);"';
        					 }
        					 str=str+'<td class="custom-col-table1" style="padding-top:4px; padding-left: 3px;"><label  class="custom-font-label-thin '+class_casedoc+'" id="txtStartDate'+i+'" style="cursor:pointer" '+event_casedoc+' >'+obj[i].dtein+'</label></td>';
        					 
        					 str=str+'<td class="custom-col-table2" style="text-align: center;">-</td>';
        					 var date_out='';
        					 if(obj[i].dteout != null){
        						 date_out =obj[i].dteout;
        					 }
							
        					 var check_count_req_ot=0;
        					 if(obj[i].list_ot !=null && obj[i].list_ot != '' && obj[i].list_ot != 'null'){
        						 if(obj[i].list_ot.length >0){
		        					 for(var index_ot =0;index_ot <obj[i].list_ot.length;index_ot++){
		        						 check_count_req_ot++;
        					 }}}
        					 if(obj[i].case_date==1){
            					 if(obj[i].typwork =="W"){
	            					 if(obj[i].case_doc ==0|| obj[i].case_doc==2|| obj[i].case_doc==4|| obj[i].case_doc==3|| obj[i].case_doc==-9){
	            						 if(check_approve <=1){
	            							 if(check_approve==0){
            									 classtime_disable =''; 
            								 }
            								 if(check_approve==1){
            									 if(check_approve_case ==0){

    	            								 classtime_disable ='';
    	            							}else{
    	            									 classtime_disable ='disabled'; 
    	            								 } 
            								 }
	            						 }else{
	            							 classtime_disable ='disabled'; 
	            						 }
	            						 
	            						
	            						 if(check_count_req_ot >0){
        									 classtime_disable ='disabled'; 
        								 }
	            					 }else{
	            						 classtime_disable ='disabled'; 
	            					 }
            					 }else{
            						 //if(obj[i].timin !=null || obj[i].timout !=null){
            							 if(check_approve <=1){
            								 if(check_approve==0){
            									 classtime_disable =''; 
            								 }
            								 if(check_approve==1){
            									 if(check_approve_case ==0){
    	            								 classtime_disable ='';
    	            								 
    	            							}else{
    	            									 classtime_disable ='disabled'; 
    	            								 } 
            								 }
	            							   
	            						 }else{
	            							 classtime_disable ='disabled'; 
	            						 }
            							 if(check_count_req_ot >0){
        									 classtime_disable ='disabled'; 
        								 }
            						// }else{
            							// classtime_disable ='disabled'; 
            						// }
            						 
            					 }
            				}else{
            					classtime_disable ='disabled'; 
            				}
        					
        					
        					 if(obj[i].flag_time =="N"){
        						 classtime_disable ='disabled';
        					 }
							
        					 str=str+'<td class="custom-col-table3"><input type="text" class="text-cutom-border" '+classtime_disable+' maxlength="10" style="width:85px;height:25px;" id="txtEndDate'+i+'" data-inputmask="'+mask_date+'" data-mask  data-provide="datepicker" value="'+date_out+'" onkeyup="ChangeTime(&quot;'+i+'|'+obj[i].codempid+'|'+obj[i].namempt+'|'+obj[i].dtework+'|'+obj[i].codcomp+'|'+obj[i].codshift+'|'+obj[i].dtein+'|'+obj[i].timin+'|'+obj[i].dteout+'|'+obj[i].timout+'|'+obj[i].dteendw+'|1'+'|'+obj[i].dtestrtw+'|'+obj[i].timstrtw+'|'+obj[i].timendw+'|'+obj[i].typwork+'|'+obj[i].short_date+'|'+obj[i].holiday_desc+'&quot;,event);"   ></td>';
        					
        					
        					 str=str+'<td class="custom-col-table4" style="padding-left: 2px;"> ';
        					 /* OT */
        					 if(obj[i].list_ot !=null && obj[i].list_ot != '' && obj[i].list_ot != 'null'){
        						 if(obj[i].list_ot.length >0){
        							 if(obj[i].list_ot.length ==1){
        								if(obj[i].list_ot[0].ot_request_status=='10')
        									str=str+'<select style="width:100%;height:25px;background-color:#eee;color:#5e5e5e;" disabled><option>ไม่มีรายการ&nbsp;OT</option></select>';
        								else {
        									var class_ot = CheckStatusStyle(obj[i].list_ot[0].ot_request_status);
        									str=str+'<select class="'+class_ot+'" id="ddlOT'+i+'" style="width:100%;height:25px;" onclick="ShowOTRequest(&quot;'+i+'|'+obj[i].codempid+'|'+obj[i].namempt+'|'+obj[i].dtework+'|'+obj[i].codcomp+'|'+obj[i].codshift+'|'+obj[i].dtein+'|'+obj[i].timin+'|'+obj[i].dteout+'|'+obj[i].timout+'|'+obj[i].dteendw+'|'+obj[i].list_ot[0].start_date+'|'+obj[i].list_ot[0].end_date+'|'+obj[i].list_ot[0].start_time+'|'+obj[i].list_ot[0].end_time+'|'+obj[i].list_ot[0].ot1_h+'|'+obj[i].list_ot[0].ot15_h+'|'+obj[i].list_ot[0].ot2_h+'|'+obj[i].list_ot[0].ot3_h+'|'+obj[i].list_ot[0].remark+'|'+obj[i].list_ot[0].request_doc_status+'|'+obj[i].list_ot[0].request_approver+'|'+obj[i].list_ot[0].req_docno+'|'+obj[i].list_ot[0].ot_request_status+'|'+obj[i].typwork+'|'+obj[i].short_date+'|'+obj[i].holiday_desc+'&quot;);">';
        	        					 	str=str+'<option hidden value="'+obj[i].list_ot[0].req_docno+'">'+obj[i].list_ot[0].ot_desc+'</option>';
        	        					 	str=str+'</select>';
        							 	}
        							 }else{
        								 str=str+'<select id="ddlOTList'+i+'" style="width:100%;height:25px;" onchange="PreShowOTRequest(&quot;'+i+'|'+obj[i].codempid+'|'+obj[i].namempt+'|'+obj[i].dtework+'|'+obj[i].codcomp+'|'+obj[i].codshift+'|'+obj[i].dtein+'|'+obj[i].timin+'|'+obj[i].dteout+'|'+obj[i].timout+'|'+obj[i].dteendw+'|'+obj[i].typwork+'|'+obj[i].short_date+'|'+obj[i].holiday_desc+'&quot;);">';
        								 str=str+'<option style="background-color:white; color:black;" value="">รายการ OT</option>';
        								 for(var index_ot =0;index_ot <obj[i].list_ot.length;index_ot++){
        									 var class_ot ='';
        									 var sta =obj[i].list_ot[index_ot].ot_request_status;
        									 if(sta=='10') continue;
        									 class_ot= CheckStatusStyle(sta);
        									 str=str+'<option class="'+class_ot+'" value="'+obj[i].list_ot[index_ot].req_docno+'">'+obj[i].list_ot[index_ot].ot_desc+'</option>';
        								 }
        								 str=str+'</select>';
        								 for(var index_ot =0;index_ot <obj[i].list_ot.length;index_ot++){
        								    str=str+' <input type="text" style="display:none;" id="txtOTStartDate'+i+''+index_ot+'"  value="'+obj[i].list_ot[index_ot].start_date+'" > ';
        								    str=str+' <input type="text" style="display:none;" id="txtOTEndDate'+i+''+index_ot+'"  value="'+obj[i].list_ot[index_ot].end_date+'" > ';
        								    str=str+' <input type="text" style="display:none;" id="txtOTStartTime'+i+''+index_ot+'"  value="'+obj[i].list_ot[index_ot].start_time+'" > ';
        								    str=str+' <input type="text" style="display:none;" id="txtOTEndTime'+i+''+index_ot+'"  value="'+obj[i].list_ot[index_ot].end_time+'" > ';
        								    str=str+' <input type="text" style="display:none;" id="txtOTOt1H'+i+''+index_ot+'"  value="'+obj[i].list_ot[index_ot].ot1_h+'" > ';
        								    str=str+' <input type="text" style="display:none;" id="txtOTOt15H'+i+''+index_ot+'"  value="'+obj[i].list_ot[index_ot].ot15_h+'" > ';
        								    str=str+' <input type="text" style="display:none;" id="txtOTOt2H'+i+''+index_ot+'"  value="'+obj[i].list_ot[index_ot].ot2_h+'" > ';
        								    str=str+' <input type="text" style="display:none;" id="txtOTOt3H'+i+''+index_ot+'"  value="'+obj[i].list_ot[index_ot].ot3_h+'" > ';
        								    str=str+' <input type="text" style="display:none;" id="txtOTRemark'+i+''+index_ot+'"  value="'+obj[i].list_ot[index_ot].remark+'" > ';
        								    str=str+' <input type="text" style="display:none;" id="txtOTDocNo'+i+''+index_ot+'"  value="'+obj[i].list_ot[index_ot].req_docno+'" > ';
        								    str=str+' <input type="text" style="display:none;" id="txtOTRequestStatus'+i+''+index_ot+'"  value="'+obj[i].list_ot[index_ot].request_doc_status+'" > ';
        								    str=str+' <input type="text" style="display:none;" id="txtOTRequestApprover'+i+''+index_ot+'"  value="'+obj[i].list_ot[index_ot].request_approver+'" > ';
        								    str=str+' <input type="text" style="display:none;" id="txtOTRequestStatusCode'+i+''+index_ot+'"  value="'+obj[i].list_ot[index_ot].ot_request_status+'" > ';
        								   
        								   
        								 }
        							 }
        						 }
        					 } else {
        						 str=str+'<select style="width:100%;height:25px;background-color:#eee;color:#5e5e5e;" disabled><option>ไม่มีรายการ&nbsp;OT</option></select>';
        					 }
        					 str =str+'</td>';
        					 str=str+'</tr><tr>';
        					 var st_time='';
         					var et_time ='';
         					
	         					if(obj[i].timin !=null){
	         						st_time =obj[i].timin;
	         						}
	         					if(obj[i].timout !=null){
	         						et_time =obj[i].timout;
	         					}
         					
         					if(obj[i].case_date==0){
         						st_time='';
         						et_time ='';
         					}
         					str=str+'<td class="custom-col-table1" style="padding-left: 4px;"><input type="text" style="width:85px;height:25px;" '+classtime_disable+' class="custom-font-label-thin text-cutom-border" data-inputmask="'+mask_time+'" data-mask maxlength="5"  id="txtStartTime'+i+'"  value="'+st_time+'"  onkeyup="ChangeTime(&quot;'+i+'|'+obj[i].codempid+'|'+obj[i].namempt+'|'+obj[i].dtework+'|'+obj[i].codcomp+'|'+obj[i].codshift+'|'+obj[i].dtein+'|'+obj[i].timin+'|'+obj[i].dteout+'|'+obj[i].timout+'|'+obj[i].dteendw+'|1'+'|'+obj[i].dtestrtw+'|'+obj[i].timstrtw+'|'+obj[i].timendw+'|'+obj[i].typwork+'|'+obj[i].short_date+'|'+obj[i].holiday_desc+'&quot;,event);" ></td>';
         					
   
        					 str=str+'<td class="custom-col-table2" style="text-align: center;">-</td>';
        					 str=str+'<td class="custom-col-table3"><input type="text" style="width:85px;height:25px;" '+classtime_disable+' class="custom-font-label-thin text-cutom-border" id="txtEndTime'+i+'" value="'+et_time+'" data-inputmask="'+mask_time+'" data-mask maxlength="5"  onkeyup="ChangeTime(&quot;'+i+'|'+obj[i].codempid+'|'+obj[i].namempt+'|'+obj[i].dtework+'|'+obj[i].codcomp+'|'+obj[i].codshift+'|'+obj[i].dtein+'|'+obj[i].timin+'|'+obj[i].dteout+'|'+obj[i].timout+'|'+obj[i].dteendw+'|1'+'|'+obj[i].dtestrtw+'|'+obj[i].timstrtw+'|'+obj[i].timendw+'|'+obj[i].typwork+'|'+obj[i].short_date+'|'+obj[i].holiday_desc+'&quot;,event);"   ></td>';
        					
        					 str=str+'<td class="custom-col-table4" style="padding-left: 2px;">';
        					 
        					 var startCount = 1;
        					 if(obj[i].dtein != null && obj[i].dtein != '' && obj[i].dtein != 'null'){
	        					 if(nowDate < parseToDate(obj[i].dtein)) {
	         						startCount = 3;
	         					}
        					 }
        					 str=str+'<select   style="width:100%;height:25px;" id="ddlWorkTypeEdit'+i+'"  data-placeholder="เลือกแสดงรายการ" onchange="ChangeTimeNotenter(&quot;'+i+'|'+obj[i].codempid+'|'+obj[i].namempt+'|'+obj[i].dtework+'|'+obj[i].codcomp+'|'+obj[i].codshift+'|'+obj[i].dtein+'|'+obj[i].timin+'|'+obj[i].dteout+'|'+obj[i].timout+'|'+obj[i].dteendw+'|2'+'|'+obj[i].dtestrtw+'|'+obj[i].timstrtw+'|'+obj[i].timendw+'|'+obj[i].emp_type+'|'+obj[i].typwork+'|'+obj[i].short_date+'|'+obj[i].holiday_desc+'|'+obj[i].start_leave_flag+'|'+obj[i].end_leave_flag+'&quot;);"   >';
        					 str=str+'<option value="">เพิ่มคำร้อง</option>';
        					 for (var j = startCount; j < obj_ddl.length; j++) {
        							 str=str+'<option value="'+obj_ddl[j].ddl_value+'">'+obj_ddl[j].ddl_text+'</option>';
        					
        					 }
        					 str=str+'</select></td>';
        					 str=str+'</tr>';
        					 if(isHoliday) {
								if(st_time.length==5 && et_time.length==5){
									str=str+'<tr><td colspan="4" style="padding-top:15px; ">พนักงานมาทำงานในวันหยุด ตามกฎหมายให้จ่ายโอที</td></tr>';
								}
        						 
        					 }
        					 str=str+'</table>';
        					 str=str+'</li>';
        				 }
        				  str=str+'</ul>';
        				 $('#divWorkTime').html(str);
        				 InitPluginMain();
                       HideWaiting();
        				}else{
        					Clear();
        	        		HideWaiting();
        	        		str ='<div style="width:100%;text-align: center;"><label  class="control-label">ไม่พบข้อมูล</label></div>';
        	        		 $('#divWorkTime').html(str);
        	        		
        				}
        			},
        			error : function() {
        				HideWaiting();
        				ShowErrorConnectMessage();
        			}
        		 });
                		}
                 }
        	}else{
        		Clear();
        		HideWaiting();
        		ShowErrorMsg('0011',null);
        	}
        } else{
        	Clear();
        	HideWaiting();
        	ShowErrorMsg('0011',null);
        }
        
		}
		catch(ex)
		{
			HideWaiting();
			ShowErrorMsg('0006',ex);
		}
		 
	}
	
	function parseToDate(dateStr) {
		var parts = dateStr.split("/");
		return new Date(parts[2]-543,parts[1]-1,parts[0]);
	}
	
	function ChangeTime(obj,e)
	{
		
		var res = obj.split('|');   
		var row=res[0];
		var strat_time=$('#txtStartTime'+row).val();
		var end_time=$('#txtEndTime'+row).val();
		var work_type = document.getElementById('ddlWorkTypeEdit'+row);
		var work_type_value= work_type.value;
		 var re = /^([0-9]|0[0-9]|1[0-9]|2[0-3]).[0-5][0-9]$/;
		 var count =0;
			 var ss_time =strat_time.split('.');
			 var ee_time =end_time.split('.');

				 if(ss_time[0]>23){
				 	$('#txtStartTime'+row).val(''); 
				 }

				 if(ss_time[1]>59){
				  $('#txtStartTime'+row).val(''); 
				}


				 if(ee_time[0]>23){
						
					 $('#txtEndTime'+row).val('');
				 }

				 if(ee_time[1]>59){
						
					 $('#txtEndTime'+row).val('');
				 }

			 
	        if (re.test(strat_time)) {
	        	count++;
	        }
		 

	        if (re.test(end_time)) {
	        	count++;
	        }
	  if(e.keyCode==13){
		  $('#txtEndDate'+row).blur();
		if(count==2 && $('#txtEndDate'+row).val().length==10){
			
			var check_start_date =$('#txtStartDate'+row).html();
			var check_end_date = $('#txtEndDate'+row).val();
			 var res_check_start_date =check_start_date.split('/');
		     var res_check_end_date =check_end_date.split('/');
		       
		     if (res_check_start_date[0].length == 1) {
		    	 res_check_start_date[0] = '0' + res_check_start_date[0];
		        }
		        if (res_check_start_date[1].length == 1) {
		        	res_check_start_date[1] = '0' + res_check_start_date[1];
		        }
		        if (res_check_start_date[2] > 2500) {
		        	res_check_start_date[2] = res_check_start_date[2] - 543;
		        }
		        check_start_date = res_check_start_date[2] + '' + res_check_start_date[1] + '' + res_check_start_date[0];
		        
		        if (res_check_end_date[0].length == 1) {
		        	res_check_end_date[0] = '0' + res_check_end_date[0];
		        }
		        if (res_check_end_date[1].length == 1) {
		        	res_check_end_date[1] = '0' + res_check_end_date[1];
		        }
		        if (res_check_end_date[2] > 2500) {
		        	res_check_end_date[2] = res_check_end_date[2] - 543;
		        }
		        check_end_date = res_check_end_date[2] + '' + res_check_end_date[1] + '' + res_check_end_date[0];
		        
		        var i_check_start_date =parseInt(check_start_date);
		        var i_check_end_date =parseInt(check_end_date);
		        var i_diff = i_check_end_date -i_check_start_date;
		        var oneDay = 24*60*60*1000; // hours*minutes*seconds*milliseconds
		    	var firstDate = new Date(res_check_start_date[2],parseInt(res_check_start_date[1])-1,res_check_start_date[0]);
            	var secondDate = new Date(res_check_end_date[2],parseInt(res_check_end_date[1])-1,res_check_end_date[0]);
            	var diffDays = Math.round(Math.abs((firstDate.getTime() - secondDate.getTime())/(oneDay)));
		        i_diff =diffDays;
		        if(i_diff >= 0 && i_diff <=1){
					if(work_type_value=="001" || work_type_value==''  ){
						var date_in_real ='&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;';
						var time_in_real ='&nbsp;____&nbsp;';
						var date_out_real ='&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;';
						var time_out_real ='&nbsp;____&nbsp;';
						
						
						if(res[6] != null && res[6] !='' && res[6] != ' '&& res[6] != 'null'){
							date_in_real=res[6];
						}
						if(res[7] != null && res[7] !=''&& res[7] != ' '&& res[7] != 'null'){
							time_in_real=res[7];
						}
						if(res[8] != null && res[8] !=''&& res[8] != ' '&& res[8] != 'null'){
							date_out_real=res[8];
						}else{
							date_out_real=res[10];
						}
						if(res[9] != null && res[9] !=''&& res[9] != ' '&& res[9] != 'null'){
							time_out_real=res[9];
						}
						
					
						var shift_edttime =res[12]+' '+res[13] +' - '+res[10]+' '+res[14];
						$('#txtDlgEditTimeRemark').val('');
						document.getElementById("ddlDlgEditTimeCause").selectedIndex  =0;
						//$('#ddlDlgEditTimeCause').select2();
						$("#lblDlgEditTimeHead").html('<spring:message code="member.worktime.dialog.dlgedittime"/>');
						$("#lblDlgEditTimeEmpId").html(res[1]);
						$("#lblDlgEditTimeName").html(res[2]);
						$("#lblDlgEditTimeDate").html(res[3]);
						$("#txtDlgEditTimeCompanyID").val(res[4]);
						$("#txtDlgEditTimeShiftID").val(res[5]);
						$("#txtDlgEditTimeShiftDate").val(res[10]);
						$("#txtDlgEditTimeStartTime").val($('#txtStartTime'+row).val());
						$("#txtDlgEditTimeEndTime").val($('#txtEndTime'+row).val());
						$("#txtDlgEditTimeStartDate").val($('#txtStartDate'+row).html());
						$("#txtDlgEditTimeEndDate").val($('#txtEndDate'+row).val());
						$("#lblDlgEditTimeDateShift").html(shift_edttime);
						$("#lblDlgEditTimeDateReal").html(date_in_real+' '+time_in_real+'&nbsp;-&nbsp;'+date_out_real+' '+time_out_real);
						$("#lblDlgEditTimeDateRequest").html($('#txtStartDate'+row).html()+' '+$('#txtStartTime'+row).val()+'&nbsp;-&nbsp;'+$('#txtEndDate'+row).val()+' '+$('#txtEndTime'+row).val());
					 	
						if(res[15]=="T" || res[15]=="H") {
					 		document.getElementById("divDlgEditTimeStar").style.display = "block";
					 	} else {
					 		document.getElementById("divDlgEditTimeStar").style.display = "none";
					 		//$("#divDlgEditTimeStar").prop("disabled",true);
					 	}
					 	$("#lblDlgEditTimeDay").html("วัน"+res[16]);
					 	if(res[15]=="T" && res[17].length>0) {
					 		$("#lblDlgEditTimeHoliday").html("("+res[17]+")");
					 	} else {
					 		$("#lblDlgEditTimeHoliday").html("");
					 	}
						//$("#dlgEditTime").modal();
					 	
					 	/*var co =0;
					 	if(check_start_date != check_end_date){
					 		var s_end_time = $('#txtEndTime'+row).val();
					 		var row_next = parseInt(row)+1;
					 		var s_shift_start = $('#txtShiftStartTime'+row_next).val();
					 		var res_s_end_time = s_end_time.split('.');
					 		var res_s_shift_start =s_shift_start.split('.');
					 		var i_endtime =parseInt(res_s_end_time[0]+''+res_s_end_time[1]);
					 		var i_shift_start =parseInt(res_s_shift_start[0]+''+res_s_shift_start[1]);
					 		if(i_endtime>i_shift_start){
					 			co++;
					 		}
					 	}*/
					 	//if(co==0){
					 		$('#dlgEditTime').modal({backdrop: 'static', keyboard: false}) 
					 	//}else{
					 		//ShowErrorMsg('0028',null);
					 	//}
					 	
						
					}
		   }else{
		        	ShowErrorMsg('0019',null);
		        }
			
		}
	   }
		//Another Edit Process
		if(res[11]=="2"){
			var selectedText = work_type.options[work_type.selectedIndex].text;
		if(work_type_value != "001"){
			if(work_type_value == "002"){
				
				var date_in_real ='';
				var time_in_real ='&nbsp;____&nbsp;';
				var date_out_real ='';
				var time_out_real ='&nbsp;____&nbsp;';
		        var count_ot =0;
				if(res[6] != null && res[6] !='' && res[6] != ' '&& res[6] != 'null'){
					date_in_real=res[6];
				}
				if(res[7] != null && res[7] !=''&& res[7] != ' '&& res[7] != 'null'){
					time_in_real=res[7];
					count_ot++;
				}
				if(res[8] != null && res[8] !=''&& res[8] != ' '&& res[8] != 'null'){
					date_out_real=res[8];
				}else{
					date_out_real=res[10];
				}
				if(res[9] != null && res[9] !=''&& res[9] != ' '&& res[9] != 'null'){
					time_out_real=res[9];
					count_ot++;
				}
				
				if(count_ot==2){
				
					$("#lblDlgOTHead").html(selectedText);
					$("#lblDlgOTEmpId").html(res[1]);
					$("#lblDlgOTName").html(res[2]);
					$("#txtDlgOTCompanyID").val(res[4]);
					$("#txtDlgOTShiftID").val(res[5]);
					$("#txtDlgOTWorkDate").val(res[3]);
					
	 				$("#lblDlgOTShiftStartDate").html(res[12]+' '+res[13]);
					$("#lblDlgOTShiftEndDate").html(res[10]+' '+res[14]);
	 				$("#lblDlgOTRealStartDate").html(date_in_real+' '+time_in_real);
	 				$("#lblDlgOTRealEndDate").html(date_out_real+' '+time_out_real);
// 					$("#txtDlgOTStartDate").val(date_in_real);
					$("#txtDlgOTStartDate").val(date_out_real);
					$("#txtDlgOTStartTime").val(time_in_real);
					
					var tempStartTimeShift = res[14].split('.');
					tempStartTimeShift[1] = eval(tempStartTimeShift[1])+30;
					if(tempStartTimeShift[1]==60){
						tempStartTimeShift[0] = eval(tempStartTimeShift[0])+1;
						tempStartTimeShift[1] = 00;
					}
					$("#txtDlgOTStartTimeShift").val(tempStartTimeShift[0]+"."+tempStartTimeShift[1]);
					
					$("#txtDlgOTEndDate").val(date_out_real);
					$("#txtDlgOTEndTime").val(time_out_real);
					$('#txtDlgOTRemark').val('');
					 var type_work = $('#txtWorkTypeHide'+row).val();
					 if(type_work == 'W'){
						 $("#txtDlgOTStartTime").val($('#txtShiftEndTime'+row).val());
					 }
					 $('#txtDlgOTRow').val(row);
					 $("#txtDlgOTStartDate").prop( "disabled", true );
					 $("#txtDlgOTStartTime").prop( "disabled", true );
					 $("#txtDlgOTEndDate").prop( "disabled", false );
					 $("#txtDlgOTEndTime").prop( "disabled", false );
					 $("#btnCancelOT" ).prop( "disabled", true );
					 $("#btnSaveOT" ).prop( "disabled", false );
					 $("#lblDlgOTDocNo").html('');
					 document.getElementById("pDlgOTDocNo").style.display = "none";
				     document.getElementById("pDlgOTDocStatus").style.display = "none";
				     document.getElementById("pDlgOTDocApprover").style.display = "none";
					$('#dlgOT').modal({backdrop: 'static', keyboard: false})  ;
				var z='0';
			 	CalculateOT(z);
				}
			}else{
				
				//Get Leave Permiss
				try
					{
					if(work_type_value != null && work_type_value !='' && work_type_value != ' ' ){
					  var data = {}
		        		data["codempid"] = res[1];
		        		data["leave_id"] = work_type_value;
		        	
					jQuery.ajax({
						url : 'member-getleavepermiss',
						type : "Post",
						contentType : "application/json",
						data: JSON.stringify(data),
						dataType : 'json',
						success : function(obj) {
							$("#lblDlgLeaveHead").html(selectedText);
							$("#lblDlgLeavePermiss").html(obj.leaved_amt+'/'+obj.leave_qty);
							$("#lblDlgLeaveEmpId").html(res[1]);
							$("#lblDlgLeaveName").html(res[2]);
							$("#txtDlgLeaveCompanyID").val(res[4]);
							$("#txtDlgLeaveShiftID").val(res[5]);
							$("#txtDlgLeaveWorkDate").val(res[3]);
							$("#txtDlgLeaveStartDate").val(res[3]);
							$("#txtDlgLeaveLeaveID").val(work_type_value);
							$("#txtDlgLeaveTransID").val('');
							 
							 document.getElementById("pDlgLeaveDocNo").style.display = "none";
						     document.getElementById("pDlgLeaveDocStatus").style.display = "none";
						     document.getElementById("pDlgLeaveDocApprover").style.display = "none";
						 	$('#txtDlgLeaveTimeRemark').val('');
							$('#txtFileUploadLeave').val('');
							$('#chkDlgStartLeaveAf').iCheck('uncheck');
							$('#chkDlgStartLeaveMo').iCheck('uncheck');
							$('#chkDlgEndLeaveAf').iCheck('uncheck');
							$('#chkDlgEndLeaveMo').iCheck('uncheck');
							$('#chkDlgLeaveRangDate').iCheck('uncheck');
					       	$("#txtDlgLeaveEndDate").val(res[3]);
					       	$('#lblDlgReqFileName').html('')
					        $("#lblDlgLeaveChkRangDate" ).prop( "disabled", false );
				        	 $("#chkDlgLeaveRangDate" ).prop( "disabled", false );
				        	 $("#chkDlgStartLeaveMo" ).prop( "disabled", false );
				        	 $("#chkDlgStartLeaveAf" ).prop( "disabled", false );
				        	 $("#txtDlgLeaveEndDate" ).prop( "disabled", false );
				        	 $("#chkDlgEndLeaveMo" ).prop( "disabled", false );
				        	 $("#chkDlgEndLeaveAf" ).prop( "disabled", false );
				        	 $("#txtDlgLeaveTimeRemark" ).prop( "disabled", false );
				        	 $("#fileUploadLeave" ).prop( "disabled", false );
				        	 
				        	
				        	 
							$('#dlgLeave').modal({backdrop: 'static', keyboard: false})  ;
						},
						error : function() {
							HideWaiting();
							ShowErrorConnectMessage();
						}
					});
					}
					}catch(ex)
					{
						HideWaiting();
						ShowErrorMsg('0006',ex);
					}
		
					
			}
		}
		}
		
		work_type.selectedIndex =0;
	}
	
	function CheckStatusStyle(status) {
		var status_style = "";
		if(status=="01"){
			status_style = "status-req1";
		}
   	 	if(status=="08"){
   		 	 status_style = "status-approve";
		}
		if(status=="09"){
			 status_style = "status-unapprove";
		}
		if(status=="02"){
			status_style = "status-req2";
		}
		if(status=="03"){
			status_style = "status-req3";
		}
		//if(status=="10"){
		//	status_style = "status-cancel";
		//} 
		
		return status_style;
	}
	
	function ChangeTimeNotenter(obj)
	{
	
		var res = obj.split('|'); 
		var row=res[0];
		var strat_time=$('#txtStartTime'+row).val();
		var end_time=$('#txtEndTime'+row).val();

		var work_type = document.getElementById('ddlWorkTypeEdit'+row);
		var work_type_value= work_type.value;
		 var re = /^([0-9]|0[0-9]|1[0-9]|2[0-3]).[0-5][0-9]$/;
		 var count =0;
			 var ss_time =strat_time.split('.');
			 var ee_time =end_time.split('.');

				 if(ss_time[0]>23){
				 	$('#txtStartTime'+row).val(''); 
				 }

				 if(ss_time[1]>59){
				  $('#txtStartTime'+row).val(''); 
				}


				 if(ee_time[0]>23){
						
					 $('#txtEndTime'+row).val('');
				 }

				 if(ee_time[1]>59){
						
					 $('#txtEndTime'+row).val('');
				 }

			 
	        if (re.test(strat_time)) {
	        	count++;
	        }
		 

	        if (re.test(end_time)) {
	        	count++;
	        }
	       
		if(count==2 && $('#txtEndDate'+row).val().length==10){
			
		
			var check_start_date =$('#txtStartDate'+row).html();
			var check_end_date = $('#txtEndDate'+row).val();
			 var res_check_start_date =check_start_date.split('/');
		     var res_check_end_date =check_end_date.split('/');
	 
		     if (res_check_start_date[0].length == 1) {
		    	 res_check_start_date[0] = '0' + res_check_start_date[0];
		        }
		        if (res_check_start_date[1].length == 1) {
		        	res_check_start_date[1] = '0' + res_check_start_date[1];
		        }
		        if (res_check_start_date[2] > 2500) {
		        	res_check_start_date[2] = res_check_start_date[2] - 543;
		        }
		        check_start_date = res_check_start_date[2] + '' + res_check_start_date[1] + '' + res_check_start_date[0];
		        
		        if (res_check_end_date[0].length == 1) {
		        	res_check_end_date[0] = '0' + res_check_end_date[0];
		        }
		        if (res_check_end_date[1].length == 1) {
		        	res_check_end_date[1] = '0' + res_check_end_date[1];
		        }
		        if (res_check_end_date[2] > 2500) {
		        	res_check_end_date[2] = res_check_end_date[2] - 543;
		        }
		        check_end_date = res_check_end_date[2] + '' + res_check_end_date[1] + '' + res_check_end_date[0];
		        
		        var i_check_start_date =parseInt(check_start_date);
		        var i_check_end_date =parseInt(check_end_date);
		        var i_diff = i_check_end_date -i_check_start_date;
		        var oneDay = 24*60*60*1000; // hours*minutes*seconds*milliseconds
		    	var firstDate = new Date(res_check_start_date[2],parseInt(res_check_start_date[1])-1,res_check_start_date[0]);
            	var secondDate = new Date(res_check_end_date[2],parseInt(res_check_end_date[1])-1,res_check_end_date[0]);
            	var diffDays = Math.round(Math.abs((firstDate.getTime() - secondDate.getTime())/(oneDay)));
		        i_diff =diffDays;
		        if(i_diff >= 0 && i_diff <=1){
					if(work_type_value=="001"){
						var date_in_real ='&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;';
						var time_in_real ='&nbsp;____&nbsp;';
						var date_out_real ='&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;';
						var time_out_real ='&nbsp;____&nbsp;';
						
						if(res[6] != null && res[6] !='' && res[6] != ' '&& res[6] != 'null'){
							date_in_real=res[6];
						}
						if(res[7] != null && res[7] !=''&& res[7] != ' '&& res[7] != 'null'){
							time_in_real=res[7];
						}
						if(res[8] != null && res[8] !=''&& res[8] != ' '&& res[8] != 'null'){
							date_out_real=res[8];
						}else{
							date_out_real=res[10];
						}
						if(res[9] != null && res[9] !=''&& res[9] != ' '&& res[9] != 'null'){
							time_out_real=res[9];
						}
						var shift_out =$('#txtShiftEndTime'+row).val();
						
						var shift_edttime =res[12]+' '+res[13] +' - '+res[10]+' '+res[14];
						
						
						$('#txtDlgEditTimeRemark').val('');
						document.getElementById("ddlDlgEditTimeCause").selectedIndex  =0;
						//$('#ddlDlgEditTimeCause').select2();
						$("#lblDlgEditTimeHead").html('<spring:message code="member.worktime.dialog.dlgedittime"/>');
						$("#lblDlgEditTimeEmpId").html(res[1]);
						$("#lblDlgEditTimeName").html(res[2]);
						$("#lblDlgEditTimeDate").html(res[3]);
						$("#txtDlgEditTimeCompanyID").val(res[4]);
						$("#txtDlgEditTimeShiftID").val(res[5]);
						$("#txtDlgEditTimeShiftDate").val(res[10]);
						$("#txtDlgEditTimeStartTime").val($('#txtStartTime'+row).val());
						$("#txtDlgEditTimeEndTime").val($('#txtEndTime'+row).val());
						$("#txtDlgEditTimeStartDate").val($('#txtStartDate'+row).html());
						$("#txtDlgEditTimeEndDate").val($('#txtEndDate'+row).val());
						$("#lblDlgEditTimeDateShift").html(shift_edttime);
						$("#lblDlgEditTimeDateReal").html(date_in_real+' '+time_in_real+'&nbsp;-&nbsp;'+date_out_real+' '+time_out_real);
						$("#lblDlgEditTimeDateRequest").html($('#txtStartDate'+row).html()+' '+$('#txtStartTime'+row).val()+'&nbsp;-&nbsp;'+$('#txtEndDate'+row).val()+' '+$('#txtEndTime'+row).val());
						
						if(res[16]=="T" || res[16]=="H") {
							document.getElementById("divDlgEditTimeStar").style.display = "block";
						} else {
							document.getElementById("divDlgEditTimeStar").style.display = "none";
						}
						$("#lblDlgEditTimeDay").html("วัน"+res[17]);
						if(res[16]=="T" && res[18].length>0) {
							$("#lblDlgEditTimeHoliday").html("("+res[18]+")");
						} else {
							$("#lblDlgEditTimeHoliday").html("");
						}
					 
						
					 		$('#dlgEditTime').modal({backdrop: 'static', keyboard: false}) 
					
						/*var co =0;
					 	if(check_start_date != check_end_date){
					 		var s_end_time = $('#txtEndTime'+row).val();
					 		var row_next = parseInt(row)+1;
					 		var s_shift_start = $('#txtShiftStartTime'+row_next).val();
					 		var res_s_end_time = s_end_time.split('.');
					 		var res_s_shift_start =s_shift_start.split('.');
					 		var i_endtime =parseInt(res_s_end_time[0]+''+res_s_end_time[1]);
					 		var i_shift_start =parseInt(res_s_shift_start[0]+''+res_s_shift_start[1]);
					 		if(i_endtime>i_shift_start){
					 			co++;
					 		}
					 	}*/
					 	//if(co==0){
// 					 		$('#dlgEditTime').modal({backdrop: 'static', keyboard: false}) 
					 	//}else{
					 		//ShowErrorMsg('0028',null);
					 	//}
					 	
					 	InitDropDownTimeCause();
					}
		        }else{
		        	ShowErrorMsg('0019',null);
		        }
		} else {
			if(work_type_value == "001")ShowErrorMsg('0032',null);
		}
	   
		//Another Edit Process
		if(res[11]=="2"){
			var selectedText = work_type.options[work_type.selectedIndex].text;
		if(work_type_value != "001"){
			if(work_type_value == "002"){
				
				var date_in_real ='';
				var time_in_real ='&nbsp;____&nbsp;';
				var date_out_real ='';
				var time_out_real ='&nbsp;____&nbsp;';
		        var count_ot =0;
				if(res[6] != null && res[6] !='' && res[6] != ' '&& res[6] != 'null'){
					date_in_real=res[6];
				}
				if(res[7] != null && res[7] !=''&& res[7] != ' '&& res[7] != 'null'){
					time_in_real=res[7];
					count_ot++;
				}
				if(res[8] != null && res[8] !=''&& res[8] != ' '&& res[8] != 'null'){
					date_out_real=res[8];
				}else{
					date_out_real=res[10];
				}
				if(res[9] != null && res[9] !=''&& res[9] != ' '&& res[9] != 'null'){
					time_out_real=res[9];
					count_ot++;
				}
				if(count_ot==2){ 
				$("#lblDlgOTHead").html(selectedText);
				$("#lblDlgOTEmpId").html(res[1]);
				$("#lblDlgOTName").html(res[2]);
				$("#txtDlgOTCompanyID").val(res[4]);
				$("#txtDlgOTShiftID").val(res[5]);
				$("#txtDlgOTWorkDate").val(res[3]);
				
 				$("#lblDlgOTShiftStartDate").html(res[12]+' '+res[13]);
				$("#lblDlgOTShiftEndDate").html(res[10]+' '+res[14]);
 				$("#lblDlgOTRealStartDate").html(date_in_real+' '+time_in_real);
 				$("#lblDlgOTRealEndDate").html(date_out_real+' '+time_out_real);
// 				$("#txtDlgOTStartDate").val(date_in_real);
				$("#txtDlgOTStartDate").val(date_out_real);
				$("#txtDlgOTStartTime").val(time_in_real);
				
				var tempStartTimeShift = res[14].split('.');
				tempStartTimeShift[1] = eval(tempStartTimeShift[1])+30;
				
				if(tempStartTimeShift[1]==60){
					tempStartTimeShift[0] = eval(tempStartTimeShift[0])+1;
					tempStartTimeShift[1] = 00;
				}
				$("#txtDlgOTStartTimeShift").val(tempStartTimeShift[0]+"."+tempStartTimeShift[1]);


				$("#txtDlgOTEndDate").val(date_out_real);
				$("#txtDlgOTEndTime").val(time_out_real);
				$('#txtDlgOTRemark').val('');
				
				if(res[16]=="T" || res[16]=="H") {
					document.getElementById("divDlgOTStar").style.display = "block";
				} else {
					document.getElementById("divDlgOTStar").style.display = "none";
				}
				$("#lblDlgOTDay").html("วัน"+res[17]);
				if(res[16]=="T" && res[18].length>0) {
					$("#lblDlgOTHoliday").html("("+res[18]+")");
				} else {
					$("#lblDlgOTHoliday").html("");
				}
				
				 var type_work = $('#txtWorkTypeHide'+row).val();
				 /*if(type_work == 'W'){
					 $("#txtDlgOTStartTime").val($('#txtShiftEndTime'+row).val());
				 }*/
				 $('#txtDlgOTRow').val(row);
				 $("#txtDlgOTStartDate").prop( "disabled", true );
				 $("#txtDlgOTStartTime").prop( "disabled", res[12]!=res[10] );
				 $("#txtDlgOTEndDate").prop( "disabled", false );
				 $("#txtDlgOTEndTime").prop( "disabled", false );
				 $("#btnCancelOT" ).prop( "disabled", true );
	        	 $("#btnSaveOT" ).prop( "disabled", false );
				 $("#lblDlgOTDocNo").html('');
				 document.getElementById("pDlgOTDocNo").style.display = "none";
			     document.getElementById("pDlgOTDocStatus").style.display = "none";
			     document.getElementById("pDlgOTDocApprover").style.display = "none";
				$('#dlgOT').modal({backdrop: 'static', keyboard: false})  ;
				var z='0';
			 	CalculateOT(z);
				}else{
					HideWaiting();
					ShowErrorMsg('0027',null);
				}
			}else{
				//Get Leave Permiss
				try
					{
					$('#txtDlgLeaveEmpType').val(res[15]);
					if(res[15]=="0002" && work_type_value=="S1"){
						document.getElementById('chkEmpType').style.display = "block"; 
					} else document.getElementById('chkEmpType').style.display = "none"; 
					
					if(work_type_value != null && work_type_value !='' && work_type_value != ' ' ){
						var start_date =res[3];
						 var start_date_db ='';
					       if(start_date != null && start_date != ''){
						       var res_start =start_date.split('/');
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
						        start_date_db=res_start[0] + '/' + res_start[1] + '/' + res_start[2];
					       }
					       
					  var data = {}
		        		data["codempid"] = res[1];
		        		data["leave_id"] = work_type_value;
		        		data["start_date"] =start_date_db;		        		
					jQuery.ajax({
						url : 'member-getleavepermiss',
						type : "Post",
						contentType : "application/json",
						data: JSON.stringify(data),
						dataType : 'json',
						success : function(obj) {
							$('#txtRepay').val(obj.leave_repay);
							$("#lblDlgLeaveHead").html(selectedText);
							if('P5'== work_type_value ){
								$("#lblDlgLeavePermiss").html(obj.leaved_amt+'/'+(0===obj.leaved_amt?obj.leave_repay:obj.leaved_amt));
							}
							else
							$("#lblDlgLeavePermiss").html(obj.leaved_amt+'/'+obj.leave_qty);
							$("#lblDlgLeaveEmpId").html(res[1]);
							$("#lblDlgLeaveName").html(res[2]);
							$("#txtDlgLeaveCompanyID").val(res[4]);
							$("#txtDlgLeaveShiftID").val(res[5]);
							$("#txtDlgLeaveWorkDate").val(res[3]);
							$("#txtDlgLeaveStartDate").val(res[3]);
							$("#txtDlgLeaveTransID").val('');
							$("#txtDlgLeaveLeaveID").val(work_type_value);
							
							$("#btnCancelLeave" ).prop( "disabled", true );
							 $("#btnSaveLeave" ).prop( "disabled", false );
							 
							 document.getElementById("pDlgLeaveDocNo").style.display = "none";
						     document.getElementById("pDlgLeaveDocStatus").style.display = "none";
						     document.getElementById("pDlgLeaveDocApprover").style.display = "none";
						 	$('#txtDlgLeaveTimeRemark').val('');
							$('#txtFileUploadLeave').val('');
							
							$('#chkDlgStartLeaveAf').iCheck('uncheck');
							$('#chkDlgStartLeaveMo').iCheck('uncheck');
							$('#chkDlgEndLeaveAf').iCheck('uncheck');
							$('#chkDlgEndLeaveMo').iCheck('uncheck');
							$('#chkDlgLeaveRangDate').iCheck('uncheck');
							$('#lblDlgReqFileName').html('')
// 					       	$("#txtDlgLeaveEndDate").val(res[3]);
							$("#txtDlgLeaveEndDate").val(res[10]);
					        $("#lblDlgLeaveChkRangDate" ).prop( "disabled", false );
				        	 $("#chkDlgLeaveRangDate" ).prop( "disabled", false );
// 				        	 $("#chkDlgStartLeaveMo" ).prop( "disabled", false );
// 				        	 $("#chkDlgStartLeaveAf" ).prop( "disabled", false );
				        	 $("#txtDlgLeaveEndDate" ).prop( "disabled", false );
// 				        	 $("#chkDlgEndLeaveMo" ).prop( "disabled", false );
// 				        	 $("#chkDlgEndLeaveAf" ).prop( "disabled", false );
				        	 $("#txtDlgLeaveTimeRemark" ).prop( "disabled", false );
				        	 $("#fileUploadLeave" ).prop( "disabled", false );
				        	
// 				        	 alert($('#txtflag').val());
// 				        	if(res[19]=='A'){
// 									$("#chkDlgStartLeaveMo" ).prop( "disabled", true );
// 									$("#chkDlgStartLeaveAf" ).prop( "disabled", true );
// 							}else if(res[19]=='M'){
// 									$("#chkDlgStartLeaveMo" ).prop( "disabled", true );
// 									$("#chkDlgStartLeaveAf" ).prop( "disabled", false);
// 							}else if(res[19]=='E'){
// 									$("#chkDlgStartLeaveMo" ).prop( "disabled", false );
// 									$("#chkDlgStartLeaveAf" ).prop( "disabled", true );
// 							}else{
// 					        	$("#chkDlgStartLeaveMo" ).prop( "disabled", false );
// 					        	$("#chkDlgStartLeaveAf" ).prop( "disabled", false );					        	
// 							}
				        	
// 				        	if(res[20]=='A'){
// 								$("#chkDlgEndLeaveMo" ).prop( "disabled", true );
// 					        	$("#chkDlgEndLeaveAf" ).prop( "disabled", true );
// 				        	}else if(res[20]=='M'){
// 								$("#chkDlgEndLeaveMo" ).prop( "disabled", true );
// 					        	$("#chkDlgEndLeaveAf" ).prop( "disabled", false );
// 				        	}else if(res[20]=='E'){
// 								$("#chkDlgEndLeaveMo" ).prop( "disabled", false );
// 					        	$("#chkDlgEndLeaveAf" ).prop( "disabled", true );
// 				        	}else{
// 								$("#chkDlgEndLeaveMo" ).prop( "disabled", false );
// 					        	$("#chkDlgEndLeaveAf" ).prop( "disabled", false );
// 				        	}
				        	 
							$('#dlgLeave').modal({backdrop: 'static', keyboard: false})  ;
						},
						error : function() {
							HideWaiting();
							ShowErrorConnectMessage();
						}
					});
					}
					}catch(ex)
					{
						HideWaiting();
						ShowErrorMsg('0006',ex);
					}
		
				
			}
		}
		}
		work_type.selectedIndex =0;
	}
	
	function ShowRequestEditTime(obj)
	{
		try{
			//alert(obj);
		$('#divEditTimeList').html('');
		var res = obj.split('|');
		var row=res[0];
		var date_in_real ='&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;';
		var time_in_real ='&nbsp;____&nbsp;';
		var date_out_real ='&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;';
		var time_out_real ='&nbsp;____&nbsp;';
		var shift_edttime =res[21]+' '+res[22] +' - '+res[16]+' '+res[26];
		if(res[11] != null && res[12] !='' && res[12] != ' '&& res[12] != 'null'){
			date_in_real=res[12];
		}
		if(res[13] != null && res[13] !=''&& res[13] != ' '&& res[13] != 'null'){
			time_in_real=res[13];
		}
		if(res[14] != null && res[14] !=''&& res[14] != ' '&& res[14] != 'null'){
			date_out_real=res[14];
		}else{
			date_out_real=res[16];
		}
		if(res[15] != null && res[15] !=''&& res[15] != ' '&& res[15] != 'null'){
			time_out_real=res[15];
		}
		document.getElementById("lblDlgReqEditTimeStatus").className = "";
// 		console.log(res);
				$("#lblDlgReqEditTimeHead").html('<spring:message code="member.worktime.dialog.dlgedittime"/>');
				$("#lblDlgReqEditTimeEmpId").html(res[1]);
				$("#lblDlgReqEditTimeName").html(res[2]);
				$("#lblDlgReqEditTimeStatus").html(res[10]);
				$("#lblDlgReqEditTimeDateShit").html(shift_edttime);
				$("#lblDlgReqEditTimeDateReal").html(date_in_real+' '+time_in_real+'&nbsp;-&nbsp;'+date_out_real+' '+time_out_real);
				//$("#lblDlgReqEditTimeDateRequest").html(res[4]+' '+res[5] +'&nbsp;-&nbsp;'+res[6]+' '+res[7]);
				$("#lblDlgReqEditTimeStartDate").html(res[4]);
				$("#txtDlgReqEditTimeEndDate").val(res[6]);
				$("#txtDlgReqEditTimeStartTime").val(res[5]);
				$("#txtDlgReqEditTimeEndTime").val(res[7]);
				$("#txtDlgReqEditTimeRemark").val(res[9]);
				
				$("#txtDlgReqEditTimeCompanyID").val(res[18]);
				$("#txtDlgReqEditTimeShiftID").val(res[19]);
				$("#txtDlgReqEditTimeShiftDate").val(res[16]);
				$("#lblDlgReqEditTimeDate").html(res[3]);
				$('#lblDlgReqEditTimeTransId').html(res[20]);
				$('#lblEdittimeDocNo').html(res[20]);
				if(res[23]=="T" || res[23]=="H") {
					document.getElementById("divDlgReqEditTimeStar").style.display = "block";
				} else {
					document.getElementById("divDlgReqEditTimeStar").style.display = "none";
				}
				$('#lblDlgReqEditTimeDay').html("วัน"+res[24]);
				if(res[23]=="T" && res[25].length>0) {
					$('#lblDlgReqEditTimeHoliday').html("("+res[25]+")");
				} else {
					$('#lblDlgReqEditTimeHoliday').html("");
				}
				
				if(res[11]=="2"){
				document.getElementById("lblDlgReqEditTimeStatus").className = "text-attend-doc-status-reqp1";
				$( "#txtDlgReqEditTimeEndDate" ).prop( "disabled", false );
				$( "#txtDlgReqEditTimeStartTime" ).prop( "disabled", false );
				$( "#txtDlgReqEditTimeEndTime" ).prop( "disabled", false );
				$( "#txtDlgReqEditTimeRemark" ).prop( "disabled", false );
				$( "#ddlDlgReqEditTimeCause" ).prop( "disabled", false );
				$( "#btnDlgReqEditTimeCancel" ).prop( "disabled", false );
				$( "#btnDlgReqEditTimeSave" ).prop( "disabled", false );
				}else{
					$( "#txtDlgReqEditTimeEndDate" ).prop( "disabled", true );
					$( "#txtDlgReqEditTimeStartTime" ).prop( "disabled", true );
					$( "#txtDlgReqEditTimeEndTime" ).prop( "disabled", true );
					$( "#txtDlgReqEditTimeRemark" ).prop( "disabled", true );
					$( "#ddlDlgReqEditTimeCause" ).prop( "disabled", true );
					$( "#btnDlgReqEditTimeCancel" ).prop( "disabled", true );
					$( "#btnDlgReqEditTimeSave" ).prop( "disabled", true );
				}
				if(res[11]=="3"){
					document.getElementById("lblDlgReqEditTimeStatus").className = "text-attend-doc-status-papproved";
					}
				if(res[11]=="-3"){
					document.getElementById("lblDlgReqEditTimeStatus").className = "text-attend-doc-status-papproved";
					}
				if(res[11]=="4"){
					document.getElementById("lblDlgReqEditTimeStatus").className = "text-attend-doc-status-punapproved";
					}
				if(res[11]=="5"){
					document.getElementById("lblDlgReqEditTimeStatus").className = "text-attend-doc-status-reqp2";
					}
				if(res[11]=="6"){
					document.getElementById("lblDlgReqEditTimeStatus").className = "text-attend-doc-status-reqp3";
					}
				$("#lblDlgReqEditTimeApprover").html(res[17]);
				
				jQuery.ajax({
					url : 'util-getworktimetimecause',
					type : "Post",
					contentType : "application/json",
					dataType : 'json',
					success : function(obj) {
						 $('#ddlDlgReqEditTimeCause').find('option').remove().end();
						
						 var select = document.getElementById('ddlDlgReqEditTimeCause');
						for (var i = 0; i < obj.length; i++) {
				             var opt = document.createElement('option');
				             if(obj[i].ddl_text==res[8]){
				            	 opt.selected =true;
				             }
				             opt.value = obj[i].ddl_value;
				             opt.innerHTML = obj[i].ddl_text;
				             select.appendChild(opt);
				         }
						
						var res_workdate =res[3].split('/');
						if (res_workdate[0].length == 1) {
							res_workdate[0] = '0' + res_workdate[0];
						    }
						if (res_workdate[1].length == 1) {
						     res_workdate[1] = '0' + res_workdate[1];
						     }
						if (res_workdate[2] > 2500) {
						     res_workdate[2] = res_workdate[2] - 543;
						   }

						 var work_date_db=res_workdate[0] + '/' + res_workdate[1] + '/' + res_workdate[2];
						 
						 var data = {}
			        		data["codempid"] = res[1];
			        		data["trans_id"] = res[20];
			        		data["work_date"] = work_date_db;

			        		
						jQuery.ajax({
							url : 'member-getedittimelist',
							type : "Post",
							contentType : "application/json",
							data: JSON.stringify(data),
							dataType : 'json',
							success : function(obj) {
								try{
									if(obj != null){
										if(obj.length >0){
											var str ='';
											for (var i = 0; i < obj.length; i++) {
												 str +=' <div style="border-top: 1px solid #c6beb7">'; 
												 //str +=' <div style="padding-left: 15px;padding-right: 15px;">'; 
												 str += '<div style="padding: 15px;">';
									             str +=' <table width="100%">';
									             str +=' <tr>';
									             str +=' <td>';
									             var class_doc ='';
									             if(obj[i].case_doc=="2"){
									            	 class_doc = "text-attend-doc-status-reqp1";
									 				}
									 			if(obj[i].case_doc=="3"){
									 					class_doc = "text-attend-doc-status-papproved";
									 					}
									 			if(obj[i].case_doc=="4"){
									 					class_doc = "text-attend-doc-status-punapproved";
									 					}
									 			if(obj[i].case_doc=="5"){
									 					class_doc = "text-attend-doc-status-reqp2";
									 					}
									 			if(obj[i].case_doc=="6"){
									 					class_doc = "text-attend-doc-status-reqp3";
									 					}
									 			 str +='<div class="col-sm-3 col-xs-6">';
									             str +=' <label ><spring:message code="member.worktime.dialog.docstatus"/></label>&nbsp;&nbsp;';
									             str +='</div><div class="col-sm-9 col-xs-6">';
									             str +='<label class="'+class_doc+'">'+obj[i].request_doc_status+'</label>';
									             str +=' </div></td>';
									             str +=' </tr>';
									             str +=' <tr><td><div class="col-sm-3 col-xs-6">';
									             str +='<label><spring:message code="member.worktime.dialog.approver"/></label>&nbsp;&nbsp;';
									             str +=' </div><div class="col-sm-9 col-xs-12">';
									             str +=' <label class="custom-font-label-thin">'+obj[i].request_approver+'</label></div></td></tr>';
									             str +=' <tr>';
									             str +=' <td>';
									             str +='<div class="col-sm-3 col-xs-6">';
									             str +=' <label ><spring:message code="member.worktime.dialog.shifttime"/></label></div>';
									             str +='<div class="col-sm-9 col-xs-12"> <label class="custom-font-label-thin">'+shift_edttime+'</label>';
									             str +=' </div></td>';
									             str +=' </tr>';
									             str +=' <tr>';
									             str +=' <td>';
									             str +='<div class="col-sm-3 col-xs-6">';
									             str +=' <label ><spring:message code="member.worktime.dialog.realtime"/></label></div>';
									             str +='<div class="col-sm-9 col-xs-12"><label  class="custom-font-label-thin">'+date_in_real+' '+time_in_real+'&nbsp;-&nbsp;'+date_out_real+' '+time_out_real+'</label>';
									             str +='</div> </td>';
									             str +=' </tr>';
									             str +=' <tr>';
									             str +=' <td><div class="col-sm-3 col-xs-6">';
									             str +=' <label ><spring:message code="member.worktime.dialog.edittime"/></label></div>';
									             str +='<div class="col-sm-9 col-xs-12"><label  class="custom-font-label-thin">'+obj[i].request_datein+' '+obj[i].request_timein+'&nbsp;-&nbsp;'+obj[i].request_dateout+' '+obj[i].request_timeout+'</label>';			             
									             str +='</div></td>';
									             str +=' </tr>';
									             str +=' <tr>';
									             str +=' <td><div class="col-sm-3 col-xs-6">';
									             str +=' <label><spring:message code="member.worktime.dialog.cause"/></label></div>';
									             str +='<div class="col-sm-9 col-xs-12"><label class="custom-font-label-thin">'+obj[i].request_cause+'</label>';
									             str +='</div></td>';
									             str +=' </tr>';
									             str +=' <tr>';
									             str +=' <td>';
									             str +=' <div style="height: 10px;"></div>';
									             str +=' </td>';
									             str +=' </tr>';
									             str +=' <tr>';
									             str +=' <td><div class="col-sm-3 col-xs-6">';
									             str +=' <label><spring:message code="member.worktime.dialog.detail"/></label></div>';
									             str +='<div class="col-sm-9 col-xs-12"><label class="custom-font-label-thin">'+obj[i].request_remark+'</label>';
									             str +='</div></td>';
									             str +=' </tr>';
									             str +=' </table>';
									             str +=' </div>';
									             str +=' </div>';   
									         }
											
											$('#divEditTimeList').html(str);
											$("#divEditTimeList").slideToggle();
										}
									}
									$('#dlgRequestEditTime').modal({backdrop: 'static', keyboard: false})  ;
								}catch(ex)
								{
									HideWaiting();
									ShowErrorMsg('0006',ex);
								}
								
								
								
								
							},
							error : function() {
								HideWaiting();
								ShowErrorConnectMessage();
							}
						});
						
					},
					error : function() {
						HideWaiting();
						ShowErrorConnectMessage();
					}
				});
				
			 	//$("#dlgRequestEditTime").modal();
			 
			
		
		}catch(ex)
		{
			HideWaiting();
			ShowErrorMsg('0006',ex);
		}
	}
	function ShowHideRequestEditTime(){
		//spnDlgReqEditTimeShow
		 $("#divEditTimeList").slideToggle();
	}
	function RequestDocInit(obj)
	{
		var res = obj.split('|');
		var row=res[0];
			var work_type = document.getElementById('ddlWorkTypeEdit'+row);
			var selectedText = work_type.options[work_type.selectedIndex].text;
			if(work_type.value != "001"){
				if(work_type.value == "002"){
			 	 
				}else{
					$("#lblDlgLeaveHead").html(selectedText);
					$("#lblDlgLeaveEmpId").html(res[1]);
					$("#lblDlgLeaveName").html(res[2]);
					$("#dlgLeave").modal();
				}
			}
		
	}
	
	function SaveEditWorkTime()
	{
		try
		{
		ShowWaiting();
       var start_time =$("#txtDlgEditTimeStartTime").val();
       var res_start_time =start_time.split('.');
       var end_time =$("#txtDlgEditTimeEndTime").val();
       var res_end_time =end_time.split('.');
       var work_date =$("#lblDlgEditTimeDate").html();
       
       var start_date =$("#txtDlgEditTimeStartDate").val();
       var end_date =$("#txtDlgEditTimeEndDate").val();
       var shift_date =$("#txtDlgEditTimeShiftDate").val();
       var work_datearr =work_date.split('/');
       if (work_datearr[0].length == 1) {
    	   work_datearr[0] = '0' + work_datearr[0];
       }
       if (work_datearr[1].length == 1) {
    	   work_datearr[1] = '0' + work_datearr[1];
       }
       if (work_datearr[2] > 2500) {
    	   work_datearr[2] = work_datearr[2] - 543;
       }
       work_date = work_datearr[0] + '/' + work_datearr[1] + '/' + work_datearr[2];
       
       var s_date =res_start_time[0]+res_start_time[1];
       var e_date =res_end_time[0]+res_end_time[1];
       
       
       var res_start =start_date.split('/');
       var res_end =end_date.split('/');
       var res_shift_date =shift_date.split('/');
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
      var end_date_select = end_date;
       if (res_shift_date[0].length == 1) {
    	   res_shift_date[0] = '0' + res_shift_date[0];
       }
       if (res_shift_date[1].length == 1) {
    	   res_shift_date[1] = '0' + res_shift_date[1];
       }
       if (res_shift_date[2] > 2500) {
    	   res_shift_date[2] = res_shift_date[2] - 543;
        }
       shift_date = res_shift_date[2] + '-' + res_shift_date[1] + '-' + res_shift_date[0];
          
       var start_date_db=res_start[0] + '/' + res_start[1] + '/' + res_start[2];
       var end_date_db=res_end[0] + '/' + res_end[1] + '/' + res_end[2];
      
    
       if(end_date < start_date){
    	   HideWaiting();
    	   ShowErrorMsg('0009',null);
       }else{
    	   var check=0;
    	   if(end_date == start_date){
    		   if(e_date <=s_date){
    			   check++;
    			   HideWaiting();
    			   ShowErrorMsg('0009',null);
    	       }
    		  
    	   }
    	  /* if(end_date_select > shift_date){
    		   check++;
			   HideWaiting();
			   ShowErrorMsg('0015',null);
    	   }*/
    	   if(check==0){
    		   if($("#txtDlgEditTimeRemark").val() != null && $("#txtDlgEditTimeRemark").val() != ''){
       			var cause = document.getElementById('ddlDlgEditTimeCause');
       			if(cause.value != 'ALL'){
       			  var data = {}
       			data["codempid"] = $("#lblDlgEditTimeEmpId").html();
       			data["company_id"] = $("#txtDlgEditTimeCompanyID").val();
       			data["cod_shift"] = $("#txtDlgEditTimeShiftID").val();
       			data["work_date"] = work_date;
       			data["start_date"] = start_date_db;
       			data["end_date"] = end_date_db;
       			data["time_in"] = res_start_time[0]+res_start_time[1];
       			data["time_out"] = res_end_time[0]+res_end_time[1];
       			data["time_cause"] = cause.value;
       			data["remark"] = $("#txtDlgEditTimeRemark").val();
       			

       			count=0;
//        			if(cause.value =='0009'){
// 	       				var er_start =(parseInt(res_start_time[0])*60)+parseInt(res_start_time[1]) ;
// 	       				var er_end = (parseInt(res_end_time[0])*60)+parseInt(res_end_time[1]) ;
// 	       				var err_diff = er_end-er_start;
// 	       				if(err_diff<=60){
// 			           			jQuery.ajax({
// 			       				url : 'member-insertworktimeedittime',
// 			       				type : "Post",
// 			       				contentType : "application/json",
// 			       				data: JSON.stringify(data),
// 			       				dataType : 'json',
// 			       				success : function(obj) {
			       					
// 			       					HideWaiting();
// 			       					if(obj.success==1){
// 			       						$("#btnCloseEditTime").click();
// 			       					ShowSuccessMsg('0003',obj.message);
// 			       					PreWorkTime3();
// 			       					}else{
// 			       						ShowErrorMsg('00022',obj.message);
// 			       						}
// 			       				},
// 			       				error : function() {
// 			       					HideWaiting();
// 			       					ShowErrorConnectMessage();
// 			       				}
// 	       			});
// 	       				}else{
// 	       					HideWaiting();
// 	              			 ShowErrorMsg('0020',null);
// 	       				}
//        			}
//        			else{
						  var i_check_spe =0;
	    	       			if(ValidateSpecialChar($("#txtDlgEditTimeRemark").val())){
	    	       				i_check_spe++;
		       		  		}
	    	       	if(i_check_spe == 0){
		       			jQuery.ajax({
		       				url : 'member-insertworktimeedittime',
		       				type : "Post",
		       				contentType : "application/json",
		       				data: JSON.stringify(data),
		       				dataType : 'json',
		       				success : function(obj) {
		       					
		       					HideWaiting();
		       					if(obj.success==1){
		       						$("#btnCloseEditTime").click();
		       					ShowSuccessMsg('0003',obj.message);
		       					PreWorkTime3();
		       					}else{
		       						ShowErrorMsg('00022',obj.message);
		       						}
		       				},
		       				error : function() {
		       					HideWaiting();
		       					ShowErrorConnectMessage();
		       				}
		       			});
		       		}else{
	       				
	       				HideWaiting();
	       				ShowErrorMsg('0033',null);
	       			}
       				//}
       			}
       			else{
       			 HideWaiting();
       			 ShowErrorMsg('0012',null);
       			}
       			
       	   }else{
       		   HideWaiting();
       		 ShowErrorMsg('0013',null);
       	   }
    	   }
    	  
	
       	}
		}
		catch(ex)
		{
			HideWaiting();
			ShowErrorMsg('0006',ex);
		}
	}
	function SaveEditWorkTimeRequest(x)
	{
		try
		{
		ShowWaiting();
       var start_time =$("#txtDlgReqEditTimeStartTime").val();
       var res_start_time =start_time.split('.');
       var end_time =$("#txtDlgReqEditTimeEndTime").val();
       var res_end_time =end_time.split('.');
       var work_date =$("#lblDlgReqEditTimeDate").html();
     
       var start_date =$("#lblDlgReqEditTimeStartDate").html();
       var end_date =$("#txtDlgReqEditTimeEndDate").val();
       var shift_date =$("#txtDlgReqEditTimeShiftDate").val();
       var work_datearr =work_date.split('/');
       if (work_datearr[0].length == 1) {
    	   work_datearr[0] = '0' + work_datearr[0];
       }
       if (work_datearr[1].length == 1) {
    	   work_datearr[1] = '0' + work_datearr[1];
       }
       if (work_datearr[2] > 2500) {
    	   work_datearr[2] = work_datearr[2] - 543;
       }
       work_date = work_datearr[0] + '/' + work_datearr[1] + '/' + work_datearr[2];
       
       var s_date =res_start_time[0]+res_start_time[1];
       var e_date =res_end_time[0]+res_end_time[1];
       
       
       var res_start =start_date.split('/');
       var res_end =end_date.split('/');
       var res_shift_date =shift_date.split('/');
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
      var end_date_select = end_date;
     
       if (res_shift_date[0].length == 1) {
    	   res_shift_date[0] = '0' + res_shift_date[0];
       }
       if (res_shift_date[1].length == 1) {
    	   res_shift_date[1] = '0' + res_shift_date[1];
       }
       if (res_shift_date[2] > 2500) {
    	   res_shift_date[2] = res_shift_date[2] - 543;
        }
       shift_date = res_shift_date[2] + '-' + res_shift_date[1] + '-' + res_shift_date[0];
          
       var start_date_db=res_start[0] + '/' + res_start[1] + '/' + res_start[2];
       var end_date_db=res_end[0] + '/' + res_end[1] + '/' + res_end[2];
      
       
       if(end_date < start_date){
    	   HideWaiting();
    	   ShowErrorMsg('0009',null);
       }else{
    	   var check=0;
    	   if(end_date == start_date){
    		   if(e_date <=s_date){
    			   check++;
    			   HideWaiting();
    			   ShowErrorMsg('0009',null);
    	       }
    		  
    	   }
    	  /* if(end_date_select > shift_date){
    		   check++;
			   HideWaiting();
			   ShowErrorMsg('0015',null);
    	   }*/
    	   if(check==0){
    		   if($("#txtDlgReqEditTimeRemark").val() != null && $("#txtDlgReqEditTimeRemark").val() != ''){
       			var cause = document.getElementById('ddlDlgReqEditTimeCause');
       			if(cause.value != 'ALL'){
       			  var data = {}
       			data["trans_id"] = $("#lblDlgReqEditTimeTransId").html();
       			data["save_case"] = x;
       			data["codempid"] = $("#lblDlgReqEditTimeEmpId").html();
       			data["company_id"] = $("#txtDlgReqEditTimeCompanyID").val();
       			data["cod_shift"] = $("#txtDlgReqEditTimeShiftID").val();
       			data["work_date"] = work_date;
       			data["start_date"] = start_date_db;
       			data["end_date"] = end_date_db;
       			data["time_in"] = res_start_time[0]+res_start_time[1];
       			data["time_out"] = res_end_time[0]+res_end_time[1];
       			data["time_cause"] = cause.value;
       			data["remark"] = $("#txtDlgReqEditTimeRemark").val();
       			

       			count=0;
//        			if(cause.value =='0009'){
// 	       				var er_start =(parseInt(res_start_time[0])*60)+parseInt(res_start_time[1]) ;
// 	       				var er_end = (parseInt(res_end_time[0])*60)+parseInt(res_end_time[1]) ;
// 	       				var err_diff = er_end-er_start;
// 	       				if(err_diff<=60){
// 			           			jQuery.ajax({
// 			       				url : 'member-insertworktimeedittime',
// 			       				type : "Post",
// 			       				contentType : "application/json",
// 			       				data: JSON.stringify(data),
// 			       				dataType : 'json',
// 			       				success : function(obj) {
			       					
// 			       					HideWaiting();
// 			       					if(obj.success==1){
// 			       					$("#btnReqCloseEditTime").click();
// 			       					ShowSuccessMsg('0003',obj.message);
// 			       					PreWorkTime3();
// 			       					}else{
// 			       						ShowErrorMsg('00022',obj.message);
// 			       						}
// 			       				},
// 			       				error : function() {
// 			       					HideWaiting();
// 			       					ShowErrorConnectMessage();
// 			       				}
// 	       			});
// 	       				}else{
// 	       					HideWaiting();
// 	              			 ShowErrorMsg('0020',null);
// 	       				}
//        			}
//        			else{
					 var i_check_spe =0;
	    	       			if(ValidateSpecialChar($("#txtDlgReqEditTimeRemark").val())){
	    	       				i_check_spe++;
		       		  		}
	    	       	if(i_check_spe == 0){
		       			jQuery.ajax({
		       				url : 'member-insertworktimeedittime',
		       				type : "Post",
		       				contentType : "application/json",
		       				data: JSON.stringify(data),
		       				dataType : 'json',
		       				success : function(obj) {
		       					
		       					HideWaiting();
		       					if(obj.success==1){
		       						$("#btnReqCloseEditTime").click();
		       					ShowSuccessMsg('0003',obj.message);
		       					PreWorkTime3();
		       					}else{
		       						ShowErrorMsg('00022',obj.message);
		       						}
		       				},
		       				error : function() {
		       					HideWaiting();
		       					ShowErrorConnectMessage();
		       				}
		       			});
					}else{
	       				
	       				HideWaiting();
	       				ShowErrorMsg('0033',null);
	       			}
       				//}
       			}
       			else{
       			 HideWaiting();
       			 ShowErrorMsg('0012',null);
       			}
       			
       	   }else{
       		   HideWaiting();
       		 ShowErrorMsg('0013',null);
       	   }
    	   }
    	  
	
       	}
		}
		catch(ex)
		{
			HideWaiting();
			ShowErrorMsg('0006',ex);
		}
	}
	function validatetime(ele) {
// 		alert(ele);
        var time = ele.value;
        //alert(time);
        var re = /^([0-9]|0[0-9]|1[0-9]|2[0-3]):[0-5][0-9]$/;


        if (re.test(time)) {
            //alert(re.test(time));
           alert('true');
        } else {
        	alert('false');
        }

    }
	function PreShowLeaveRequest(obj){
		try
		{
		var res = obj.split('|');
		var index = document.getElementById('ddlLeaveList'+res[0]).selectedIndex;
		if(index >0){
		var index_t = index-1;
		var start_leave_flag = $('#txtStartLeaveFlag'+res[0]+index_t).val();
		var end_leave_flag = $('#txtEndLeaveFlag'+res[0]+index_t).val();
		var start_leave_date = $('#txtStartLeaveDate'+res[0]+index_t).val();
		var end_leave_date = $('#txtEndLeaveDate'+res[0]+index_t).val();
		var leave_remark = $('#txtLeaveRemark'+res[0]+index_t).val();
		var leave_file_name = $('#txtLeaveFileName'+res[0]+index_t).val();
		var leave_request_date = $('#txtLeaveRequestDate'+res[0]+index_t).val();
		var leave_id = $('#txtLeaveId'+res[0]+index_t).val();
		var leave_desc = $('#txtLeaveDesc'+res[0]+index_t).val();
		var leave_docno = $('#txtStartLeaveDocNo'+res[0]+index_t).val();
		var request_status = $('#txtLeaveRequestStatus'+res[0]+index_t).val();
		var cancel_status = $('#txtLeaveCancelStatus'+res[0]+index_t).val();
		var cancel_docno = $('#txtLeaveCancelDocNo'+res[0]+index_t).val();
		var cancel_docstatus = $('#txtLeaveCancelDocStatus'+res[0]+index_t).val();
		var cancel_approver = $('#txtLeaveCancelApprover'+res[0]+index_t).val();
		var docstatus = $('#txtLeaveDocStatus'+res[0]+index_t).val();
		var approver = $('#txtLeaveApprover'+res[0]+index_t).val();
		var cancel_leave_status = $('#txtCancelLeaveStatus'+res[0]+index_t).val();
        var data =res[1]+'|'+res[2]+'|'+res[3]+'|'+start_leave_flag+'|'+end_leave_flag;
		data +='|'+start_leave_date+'|'+end_leave_date+'|'+leave_remark+'|'+leave_file_name;
		data +='|'+leave_request_date+'|'+leave_id+'|'+leave_desc+'|'+res[4]+'|'+res[5];
		data +='|'+leave_docno+'|'+request_status+'|'+cancel_status;
		data +='|'+cancel_docno+'|'+cancel_docstatus+'|'+cancel_approver;
		data +='|'+docstatus+'|'+approver+'|'+cancel_leave_status+'|'+res[0];
		data +='|'+res[6];
		data +='|'+res[7]+'|'+res[8]+'|'+res[9];
	
		var id_name = "ddlLeaveList"+res[0];
		document.getElementById(id_name).className=CheckStatusStyle(request_status);
		
		ShowLeaveRequest(data);
		} else {
			var id_name = "ddlLeaveList"+res[0];
			document.getElementById(id_name).className="status-default";
		}
		}catch(ex)
		{
			HideWaiting();
			ShowErrorMsg('0006',ex);
		}
	}
	function ShowLeaveRequest(obj)
	{
		var res = obj.split('|');
		try
		{
			$('#txtDlgLeaveEmpType').val(res[24]);
			if(res[24]=="0002" && res[10]=="S1") {
				document.getElementById('chkEmpType').style.display="block";
			} else document.getElementById('chkEmpType').style.display = "none"; 
			
			$('#ddlLeave'+res[23]).hide();
			 $("#ddlLeave"+res[23]).fadeTo(500, 500).slideUp(500, function () {
	             $("#ddlLeave"+res[23]).show();
	         }); 
			 var start_date =res[5];
			 var start_date_db ='';
		       if(start_date != null && start_date != ''){
			       var res_start =start_date.split('/');
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
			        start_date_db=res_start[0] + '/' + res_start[1] + '/' + res_start[2];
		       }
		  var data = {}
    		data["codempid"] = res[0];
    		data["leave_id"] = res[10];
    		data["start_date"] =start_date_db;
			jQuery.ajax({
				url : 'member-getleavepermiss',
				type : "Post",
				contentType : "application/json",
				data: JSON.stringify(data),
				dataType : 'json',
				success : function(obj) {					
					$("#lblDlgLeaveHead").html(res[11]);
					if('P5'== res[10] ){
						$("#lblDlgLeavePermiss").html(obj.leaved_amt+'/'+(0===obj.leaved_amt?obj.leave_repay:obj.leaved_amt));
					}
					else
					$("#lblDlgLeavePermiss").html(obj.leaved_amt+'/'+obj.leave_qty);
					
					$("#lblDlgLeaveEmpId").html(res[0]);
					$("#lblDlgLeaveName").html(res[1]);
					$('#txtRepay').val(obj.leave_repay);
					$("#txtDlgLeaveCompanyID").val(res[12]);
					$("#txtDlgLeaveShiftID").val(res[13]);
					$("#txtDlgLeaveWorkDate").val(res[2]);
					$("#txtDlgLeaveLeaveID").val(res[10]);
					if(res[4] != null && res[4] != '' && res[4] != 'null'){
						$('#chkDlgLeaveRangDate').iCheck('check');
					}else{
						$('#chkDlgLeaveRangDate').iCheck('uncheck');
					}
					$('#chkDlgStartLeaveAf').iCheck('uncheck');
					$('#chkDlgStartLeaveMo').iCheck('uncheck');
					$('#chkDlgEndLeaveAf').iCheck('uncheck');
					$('#chkDlgEndLeaveMo').iCheck('uncheck');
					
					if(res[3]=="A"){
						$('#chkDlgStartLeaveAf').iCheck('check');
						$('#chkDlgStartLeaveMo').iCheck('check');

					}else{
						if(res[3]=="M"){
							$('#chkDlgStartLeaveMo').iCheck('check');
						}
						if(res[3]=="E"){
							$('#chkDlgStartLeaveAf').iCheck('check');
						}
					}
					
					if(res[4]=="A"){
						$('#chkDlgEndLeaveAf').iCheck('check');
						$('#chkDlgEndLeaveMo').iCheck('check');

					}else{
						if(res[4]=="M"){
							$('#chkDlgEndLeaveMo').iCheck('check');
						}
						if(res[4]=="E"){
							$('#chkDlgEndLeaveAf').iCheck('check');
						}
					}
					
					$("#txtDlgLeaveStartDate").val(res[5]);
			       	$("#txtDlgLeaveEndDate").val(res[6]);
			        $("#txtDlgLeaveTimeRemark").val(res[7]);
			        $("#txtFileUploadLeave").val(res[8]);
			        $('#lblDlgReqFileName').html(res[8]);
			        $("#txtDlgLeaveTransID").val(res[14]);
			        $("#btnCancelLeave" ).prop( "disabled", false );
			        
			        if(res[16]=='1'){
			        	 $("#btnSaveLeave" ).prop( "disabled", true );
			        	 $("#btnCancelLeave" ).prop( "disabled", true );
			        	 var class_doc='';
			        	
			        	 if(res[22]=="01"){
								class_doc = "text-attend-doc-status-reqp1";
								}
			        	 if(res[22]=="08"){
			        		 class_doc = "text-attend-doc-status-papproved";
								}
							if(res[22]=="09"){
							class_doc = "text-attend-doc-status-punapproved";
								}
							if(res[22]=="02"){
								class_doc = "text-attend-doc-status-reqp2";
								}
							if(res[22]=="03"){
								class_doc = "text-attend-doc-status-reqp3";
								}
			        	 $('#lblDlgLeaveDocNo').html(res[17]);
				         $('#lblDlgLeaveDocStatus').html(res[18]);
				         $('#lblDlgLeaveDocApprover').html(res[19]);
				         document.getElementById("lblDlgLeaveDocStatus").className = class_doc;
				         
				         if(res[22]=='01'){
				        	 $("#btnSaveLeave" ).prop( "disabled", true );
				        	 $("#btnCancelLeave" ).prop( "disabled", true );
				        	 
				        	 $("#lblDlgLeaveChkRangDate" ).prop( "disabled", false );
				        	 $("#chkDlgLeaveRangDate" ).prop( "disabled", false );
				        	 $("#chkDlgStartLeaveMo" ).prop( "disabled", false );
				        	 $("#chkDlgStartLeaveAf" ).prop( "disabled", false );
				        	 $("#txtDlgLeaveEndDate" ).prop( "disabled", false );
				        	 $("#chkDlgEndLeaveMo" ).prop( "disabled", false );
				        	 $("#chkDlgEndLeaveAf" ).prop( "disabled", false );
				        	 $("#txtDlgLeaveTimeRemark" ).prop( "disabled", false );
				        	 $("#fileUploadLeave" ).prop( "disabled", false );
				        	 
				        }else
				        {
				        	if(res[22]=='08'){
				        		 $("#btnSaveLeave" ).prop( "disabled", true );
					        	 $("#btnCancelLeave" ).prop( "disabled", false );
					        }else{
				        	 $("#btnSaveLeave" ).prop( "disabled", true );
				        	 $("#btnCancelLeave" ).prop( "disabled", true );}
				        	
				        	$("#lblDlgLeaveChkRangDate" ).prop( "disabled", true );
				        	$("#chkDlgLeaveRangDate" ).prop( "disabled", true );
				        	$("#chkDlgStartLeaveMo" ).prop( "disabled", true );
				        	$("#chkDlgStartLeaveAf" ).prop( "disabled", true );
				        	$("#txtDlgLeaveEndDate" ).prop( "disabled", true );
				        	$("#chkDlgEndLeaveMo" ).prop( "disabled", true );
				        	$("#chkDlgEndLeaveAf" ).prop( "disabled", true );
				        	$("#txtDlgLeaveTimeRemark" ).prop( "disabled", true );
				        	$("#fileUploadLeave" ).prop( "disabled", true );
				        }
				         
			        }else{
			        	var class_doc='';
			        	
			        	 if(res[15]=="01"){
								class_doc = "text-attend-doc-status-reqp1";
								}
			        	 if(res[15]=="08"){
			        		 class_doc = "text-attend-doc-status-papproved";
								}
							if(res[15]=="09"){
							class_doc = "text-attend-doc-status-punapproved";
								}
							if(res[15]=="02"){
								class_doc = "text-attend-doc-status-reqp2";
								}
							if(res[15]=="03"){
								class_doc = "text-attend-doc-status-reqp3";
								}
			        	$('#lblDlgLeaveDocNo').html(res[14]);
			        	$('#lblDlgLeaveDocStatus').html(res[20]);
			        	$('#lblDlgLeaveDocApprover').html(res[21]);
				         document.getElementById("lblDlgLeaveDocStatus").className = class_doc;
				         
			        	if(res[15]=='01'){
				        	 $("#btnSaveLeave" ).prop( "disabled", false );
				        	 $("#btnCancelLeave" ).prop( "disabled", false );
				        	 $("#lblDlgLeaveChkRangDate" ).prop( "disabled", false );
				        	 $("#chkDlgLeaveRangDate" ).prop( "disabled", false );
				        	 $("#chkDlgStartLeaveMo" ).prop( "disabled", false );
				        	 $("#chkDlgStartLeaveAf" ).prop( "disabled", false );
				        	 $("#txtDlgLeaveEndDate" ).prop( "disabled", false );
				        	 $("#chkDlgEndLeaveMo" ).prop( "disabled", false );
				        	 $("#chkDlgEndLeaveAf" ).prop( "disabled", false );
				        	 $("#txtDlgLeaveTimeRemark" ).prop( "disabled", false );
				        	 $("#fileUploadLeave" ).prop( "disabled", false );
				        }else
				        {
				        	if(res[15]=='08'){
				        		 $("#btnSaveLeave" ).prop( "disabled", true );
					        	 $("#btnCancelLeave" ).prop( "disabled", false );
					        }else{
				        	 $("#btnSaveLeave" ).prop( "disabled", true );
				        	 $("#btnCancelLeave" ).prop( "disabled", true );}
				        	
				        	$("#lblDlgLeaveChkRangDate" ).prop( "disabled", true );
				        	$("#chkDlgLeaveRangDate" ).prop( "disabled", true );
				        	$("#chkDlgStartLeaveMo" ).prop( "disabled", true );
				        	$("#chkDlgStartLeaveAf" ).prop( "disabled", true );
				        	$("#txtDlgLeaveEndDate" ).prop( "disabled", true );
				        	$("#chkDlgEndLeaveMo" ).prop( "disabled", true );
				        	$("#chkDlgEndLeaveAf" ).prop( "disabled", true );
				        	$("#txtDlgLeaveTimeRemark" ).prop( "disabled", true );
				        	$("#fileUploadLeave" ).prop( "disabled", true );
				        }
			        }
			        
			        
			        document.getElementById("pDlgLeaveDocNo").style.display = "block";
			        document.getElementById("pDlgLeaveDocStatus").style.display = "block";
			        document.getElementById("pDlgLeaveDocApprover").style.display = "block";
			        
					$('#dlgLeave').modal({backdrop: 'static', keyboard: false})  ;
				},
				error : function() {
					HideWaiting();
					ShowErrorConnectMessage();
				}
			});
		}catch(ex)
		{
			HideWaiting();
			ShowErrorMsg('0006',ex);
		}

	}
	function DownLoadFile(){
		var url='member-download-fileleave?FileName='+$('#lblDlgReqFileName').html();
		window.open(url);
	}
	 function InsertLeave(x) { 
		 try
			{
			ShowWaiting();
		 	var work_date = $("#txtDlgLeaveWorkDate").val();
		 	var start_date =$("#txtDlgLeaveStartDate").val();
	       	var end_date =$("#txtDlgLeaveEndDate").val();
	       	var check_start_date ='';
	       	var check_end_date ='';
	    	var work_datearr =work_date.split('/');
		       if (work_datearr[0].length == 1) {
		    	   work_datearr[0] = '0' + work_datearr[0];
		       }
		       if (work_datearr[1].length == 1) {
		    	   work_datearr[1] = '0' + work_datearr[1];
		       }
		       if (work_datearr[2] > 2500) {
		    	   work_datearr[2] = work_datearr[2] - 543;
		       }
		       work_date = work_datearr[0] + '/' + work_datearr[1] + '/' + work_datearr[2];
		       var start_date_db ='';
		       if(start_date != null && start_date != ''){
		       var res_start =start_date.split('/');
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
		        start_date_db=res_start[0] + '/' + res_start[1] + '/' + res_start[2];
		       }
		       var end_date_db='';
		       if(end_date != null && end_date != ''){
			       var res_end =end_date.split('/');
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
			        end_date_db=res_end[0] + '/' + res_end[1] + '/' + res_end[2];
		       }
	       	if(start_date == null || start_date ==''){
	       		HideWaiting();
      			ShowErrorMsg('0011',null);
	       	}else{
	       	 var chk_rang = document.getElementById('chkDlgLeaveRangDate').checked;
	       	 var chk_start_m = document.getElementById('chkDlgStartLeaveMo').checked;
	       	 var chk_start_a = document.getElementById('chkDlgStartLeaveAf').checked;
	       	 var chk_end_m = document.getElementById('chkDlgEndLeaveMo').checked;
	       	 var chk_end_a = document.getElementById('chkDlgEndLeaveAf').checked;
	       	
	       	 var check =0;
	       	 	if(chk_rang && (end_date ==null || end_date =='')){
	       	 		check++;
	       	 	}
	       		if(check ==0){
	       			if(chk_rang && (end_date < start_date)){
		       	 		check++;
		       	 	}
	       			if(check ==0){
	       				var is_rang ='0';
	       				if(chk_rang){
	       					is_rang ='1';
	       				}
	       			var start_flag ='';
	       			var end_flag ='';
	       			if((!chk_start_m)&& (!chk_start_a)){
       					start_flag ='A';
       				}else{
       					if((chk_start_m)&& (chk_start_a)){
	       					start_flag ='A';
	       				}else{
	       					if(chk_start_m){
	       						start_flag ='M';
	       					}
	       					if(chk_start_a){
	       						start_flag ='E'
	       					}
	       				}
       				}
	       			
	       			if(chk_rang){
	       				
	       				if((!chk_end_m)&& (!chk_end_a)){
	       					end_flag ='A';
	       				}else{
	       					if((chk_end_m)&& (chk_end_a)){
	       						end_flag ='A';
		       				}else{
		       					if(chk_end_m){
		       						end_flag ='M';
		       					}
		       					if(chk_end_a){
		       						end_flag ='E'
		       					}
		       				}
	       				}
		       			
	       				
	       			}
	       			else{
	       				//end_flag ='A';
	       				end_date_db=start_date_db;
	       			}
	       			 //var emp_id = document.getElementById('ddlUser');
	       	         var formData = new FormData();
	       	         var file = null;
	       	         if($('input[type=file]')[0].files[0] != null){
	       	       		 file=	$('input[type=file]')[0].files[0];
	       	         }
	       	         var url='member-insertworktimeleave';
	       	         if(file ==null || file==''){
	       	        	url='member-insertworktimeleave-null';
	       	         }else {
	       	          formData.append('file', file);
	       	        	 }
	       	      
		       	  	 check_start_date =res_start[2] +''+ res_start[1]+'' + res_start[0];
			       	 check_end_date =res_end[2]+'' + res_end[1] +''+ res_end[0];
			       	 var i_check_start_date =parseInt(check_start_date);
			         var i_check_end_date =parseInt(check_end_date);
			         var i_diff = (i_check_end_date -i_check_start_date)+1;
			         var oneDay = 24*60*60*1000; // hours*minutes*seconds*milliseconds
				    	var firstDate = new Date(res_start[2],res_start[1],res_start[0]);
		            	var secondDate = new Date(res_end[2],res_end[1],res_end[0]);
		            	var diffDays = Math.round(Math.abs((firstDate.getTime() - secondDate.getTime())/(oneDay)));
				        i_diff =diffDays+1;
			         var emp_type = $('#txtDlgLeaveEmpType').val();
			         check =0;
			         if(($("#txtDlgLeaveLeaveID").val()=='S1'||$("#txtDlgLeaveLeaveID").val()=='S3'||$("#txtDlgLeaveLeaveID").val()=='S5')&& i_diff >2&& x=='S'){
			        	 if(file ==null || file==''){
			        		 if(emp_type!="0002") check++;
			        	 }
			         }
			        
		        	 
			         if(check ==0){
			        	 
			        	 
			        	 if($("#txtDlgLeaveTimeRemark").val() != null && $("#txtDlgLeaveTimeRemark").val() != ''){
	       	         formData.append('emp_id', $('#lblDlgLeaveEmpId').html());
	       	         formData.append('company_id',  $("#txtDlgLeaveCompanyID").val());
	       	         formData.append('shift_id', $("#txtDlgLeaveShiftID").val());
	       	         formData.append('work_date', work_date);
	       	         formData.append('leave_id', $("#txtDlgLeaveLeaveID").val());
	       	         formData.append('is_rangdate', is_rang);
	       	         formData.append('start_flag', start_flag);
	       	         formData.append('end_flag', end_flag);
	       	         formData.append('start_date', start_date_db);
	       	         formData.append('end_date', end_date_db);
	       	         formData.append('remark', $("#txtDlgLeaveTimeRemark").val());
	       	      	 formData.append('save_case',x);
	       	      	 formData.append('trans_id',$("#txtDlgLeaveTransID").val());
	       	      	 
	       	      var i_check_spe =0;
	       			if(ValidateSpecialChar($("#txtDlgLeaveTimeRemark").val())){
	       				i_check_spe++;
     		  		}
	       			if('C'!==x){
		       			if(!verifiedLeaveDate()){
		       			 	HideWaiting();
		       				return;	       				
	     		  		}
	       			}
	       			if(i_check_spe == 0){ 	 
		       	         $.ajax({
		       	             url : url,
		       	             data : formData,
		       	             processData : false,
		       	             contentType : false,
		       	             type : 'POST',
		       	             success : function(obj) {
		       	            	
		       					HideWaiting();
		       					if(obj.success==1){
		       						$("#btnCloseDlgLeave").click();
		       					ShowSuccessMsg('0003',obj.message);
		       					PreWorkTime3();
		       					}else{
		       						ShowErrorMsg('00022',obj.message);
		       						}
		       	             },
		       	             error : function(err) {
		       	            	ShowErrorConnectMessage();
		       	             }
		       	         });}else{
			       				
			       				HideWaiting();
			       				ShowErrorMsg('0033',null);
			       			}
	       	         
	       	         
			        	 }else{
			        		 HideWaiting();
				      		ShowErrorMsg('0013',null);
			        	 }
			         }else{
			        	 HideWaiting();
			        	 ShowErrorMsg('0021',null);
			        	
			         }
	       	         
	       	         
	       			}else{
	       				HideWaiting();
		      			ShowErrorMsg('0009',null);
	       			}
	       			
	       		}else{
	       			HideWaiting();
	      			ShowErrorMsg('0011',null);
	       		}
	       	
	       		
	       	}
		}
		catch(ex)
		{
			HideWaiting();
			ShowErrorMsg('0006',ex);
		}
     }
	 function PreShowOTRequest(obj){
			try
			{
		
			var res = obj.split('|');
			var index = document.getElementById('ddlOTList'+res[0]).selectedIndex;
			if(index >0){
			var index_t = index-1;
			var start_date = $('#txtOTStartDate'+res[0]+index_t).val();
			var end_date = $('#txtOTEndDate'+res[0]+index_t).val();
			var start_time = $('#txtOTStartTime'+res[0]+index_t).val();
			var end_time = $('#txtOTEndTime'+res[0]+index_t).val();
			var ot1_h = $('#txtOTOt1H'+res[0]+index_t).val();
			var ot15_h = $('#txtOTOt15H'+res[0]+index_t).val(); 
			var ot2_h = $('#txtOTOt2H'+res[0]+index_t).val();
			var ot3_h = $('#txtOTOt3H'+res[0]+index_t).val();
			var remark = $('#txtOTRemark'+res[0]+index_t).val();
			var request_doc_status = $('#txtOTRequestStatus'+res[0]+index_t).val();
			var request_approver = $('#txtOTRequestApprover'+res[0]+index_t).val();
			var request_status_code  =$('#txtOTRequestStatusCode'+res[0]+index_t).val();
			var req_docno = $('#txtOTDocNo'+res[0]+index_t).val();
	        var data =res[0]+'|'+res[1]+'|'+res[2]+'|'+res[3]+'|'+res[4]+'|'+res[5]+'|'+res[6]+'|'+res[7]+'|'+res[8]+'|'+res[9]+'|'+res[10];
	        data += '|'+start_date+'|'+end_date;
			data +='|'+start_time+'|'+end_time+'|'+ot1_h+'|'+ot15_h;
			data +='|'+ot2_h+'|'+ot3_h+'|'+remark+'|'+request_doc_status+'|'+request_approver;
			data +='|'+req_docno+'|'+request_status_code;
			data +='|'+res[11]+'|'+res[12]+'|'+res[13]; //for day and holiday description
			
			var id_name = "ddlOTList"+res[0];
			document.getElementById(id_name).className=CheckStatusStyle(request_status_code);
			
			ShowOTRequest(data);
			} else {
				var id_name = "ddlOTList"+res[0];
				document.getElementById(id_name).className="status-default"; 
			}
			}catch(ex)
			{
				HideWaiting();
				ShowErrorMsg('0006',ex);
			}
		}
		function ShowOTRequest(obj)
		{
			//alert(obj);
			var res = obj.split('|');
			try
			{
				var row = res[0];
				$('#ddlOT'+res[0]).hide();
				 $("#ddlOT"+res[0]).fadeTo(500, 500).slideUp(500, function () {
		             $("#ddlOT"+res[0]).show();
		         });
				var date_in_real ='';
				var time_in_real ='&nbsp;____&nbsp;';
				var date_out_real ='';
				var time_out_real ='&nbsp;____&nbsp;';
				if(res[5] != null && res[6] !='' && res[6] != ' '&& res[6] != 'null'){
					date_in_real=res[6];
				}
				if(res[7] != null && res[7] !=''&& res[7] != ' '&& res[7] != 'null'){
					time_in_real=res[7];
				}
				if(res[8] != null && res[8] !=''&& res[8] != ' '&& res[8] != 'null'){
					date_out_real=res[8];
				}else{
					date_out_real=res[10];
				}
				if(res[9] != null && res[9] !=''&& res[9] != ' '&& res[9] != 'null'){
					time_out_real=res[9];
				}

				$("#lblDlgOTHead").html("OT");
				$("#lblDlgOTEmpId").html(res[1]);
				$("#lblDlgOTName").html(res[2]);
				$("#txtDlgOTCompanyID").val(res[4]);
				$("#txtDlgOTShiftID").val(res[5]);
				$("#txtDlgOTWorkDate").val(res[3]);
				
 				$("#lblDlgOTShiftStartDate").html($('#txtShiftStartDate'+row).val()+' '+$('#txtShiftStartTime'+row).val());
				$("#lblDlgOTShiftEndDate").html($('#txtShiftEndDate'+row).val()+' '+$('#txtShiftEndTime'+row).val());
 				$("#lblDlgOTRealStartDate").html(date_in_real+' '+time_in_real);
 				$("#lblDlgOTRealEndDate").html(date_out_real+' '+time_out_real);
				$("#txtDlgOTStartDate").val(res[11]);
				$("#txtDlgOTStartTime").val(res[13]);
				$("#txtDlgOTEndDate").val(res[12]);
				$("#txtDlgOTEndTime").val(res[14]);
				 $('#lblDlgOTOt1').html(res[15]);
				 $('#lblDlgOTOt15').html(res[16]);
				 $('#lblDlgOTOt2').html(res[17]);
				 $('#lblDlgOTOt3').html(res[18]);
				 $('#txtDlgOTRemark').val(res[19]);
				 $('#txtDlgOTRow').val(row);
				var class_doc='';
	        	
	        	 if(res[23]=="01"){
						class_doc = "text-attend-doc-status-reqp1";
						}
	        	 if(res[23]=="08"){
	        		 class_doc = "text-attend-doc-status-papproved";
						}
					if(res[23]=="09"){
					class_doc = "text-attend-doc-status-punapproved";
						}
					if(res[23]=="02"){
						class_doc = "text-attend-doc-status-reqp2";
						}
					if(res[23]=="03"){
						class_doc = "text-attend-doc-status-reqp3";
						}
	        	$('#lblDlgOTDocNo').html(res[22]);
	        	$('#lblDlgOTDocStatus').html(res[20]);
	        	$('#lblDlgOTDocApprover').html(res[21]);
	        	if(res[24]=="T" || res[24]=="H") {
	        		document.getElementById("divDlgOTStar").style.display = "block";
	        	} else {
	        		document.getElementById("divDlgOTStar").style.display = "none";
	        	} 
	        	$("#lblDlgOTDay").html("วัน" +res[25]);
	        	if(res[24]=="T" && res[26].length>0) {
	        		$("#lblDlgOTHoliday").html("("+res[26]+")");
	        	} else {
	        		$("#lblDlgOTHoliday").html("");
	        	}
		         document.getElementById("lblDlgOTDocStatus").className = class_doc;
	        	if(res[23]=='01'){
	        		 $("#btnCancelOT" ).prop( "disabled", false );
		        	 $("#btnSaveOT" ).prop( "disabled", false );
						$("#txtDlgOTStartTime").prop( "disabled", false );
						$("#txtDlgOTEndDate").prop( "disabled", false );
						$("#txtDlgOTEndTime").prop( "disabled", false );
						
		        	 
		        }else
		        {
		        	 $("#btnCancelOT" ).prop( "disabled", true );
		        	 $("#btnSaveOT" ).prop( "disabled", true );
		        		$("#txtDlgOTStartTime").prop( "disabled", true );
						$("#txtDlgOTEndDate").prop( "disabled", true );
						$("#txtDlgOTEndTime").prop( "disabled", true );
		        }
	        
	       	        
	        document.getElementById("pDlgOTDocNo").style.display = "block";
	        document.getElementById("pDlgOTDocStatus").style.display = "block";
	        document.getElementById("pDlgOTDocApprover").style.display = "block";
	        
				$('#dlgOT').modal({backdrop: 'static', keyboard: false})  ;
				

			}catch(ex)
			{
				HideWaiting();
				ShowErrorMsg('0006',ex);
			}

		}
	function  CalculateOT(x){
		try{
		var strat_time=$('#txtDlgOTStartTime').val();
		var end_time=$('#txtDlgOTEndTime').val();
// 		var strdt = $('#txtDlgOTStartDate').val().split('/');
		var strdt = $("#txtDlgOTWorkDate").val().split('/');
		
		var ShiftStartdt = $('#lblDlgOTShiftStartDate').text().split('/');
		var endt = $('#txtDlgOTEndDate').val().split('/'); 
		var legdate = parseInt(ShiftStartdt[0])- parseInt(strdt[0]);
		
		if(parseInt(strdt[1]+strdt[0]) > parseInt(endt[1]+endt[0])){
			ShowErrorMsg('0009',null);
			return;
		}
		var zero ="0";
		 $('#lblDlgOTOt1').html(zero);
		 $('#lblDlgOTOt15').html(zero);
		 $('#lblDlgOTOt2').html(zero);
		 $('#lblDlgOTOt3').html(zero);
		 var re = /^([0-9]|0[0-9]|1[0-9]|2[0-3]).[0-5][0-9]$/;
		 var count =0;
			 var ss_time =strat_time.split('.');
			 var ee_time =end_time.split('.');

				 if(ss_time[0]>23){
				 	$('#txtDlgOTStartTime').val(''); 
				 }

				 if(ss_time[1]>59){
				  $('#txtDlgOTStartTime').val(''); 
				}


				 if(ee_time[0]>23){
						
					 $('#txtDlgOTEndTime').val('');
				 }

				 if(ee_time[1]>59){
						
					 $('#txtDlgOTEndTime').val('');
				 }

			 
	        if (re.test(strat_time)) {
	        	count++;
	        }
		 

	        if (re.test(end_time)) {
	        	count++;
	        }
	        if(x==1){
	        	if($('#txtDlgOTStartDate').val().length==10){
	        		//$('#txtDlgOTEndDate').val($('#txtDlgOTStartDate').val());
	        	}
	        }
	        if(x==3){
	        	if($('#txtDlgOTEndDate').val().length==10){
	        		//$('#txtDlgOTStartDate').val($('#txtDlgOTEndDate').val());
	        	}
	        }  
// 		if(count==2 && $('#txtDlgOTStartDate').val().length==10&& $('#txtDlgOTEndDate').val().length==10){
		if(count==2 && $('#txtDlgOTWorkDate').val().length==10&& $('#txtDlgOTEndDate').val().length==10){
// 			var check_start_date =$('#txtDlgOTStartDate').val();
			var check_start_date = $("#txtDlgOTWorkDate").val();
			var check_end_date = $('#txtDlgOTEndDate').val();
// 			 var res_check_start_date =check_start_date.split('/');
			var res_check_start_date =check_start_date.split('/')
		    var res_check_end_date =check_end_date.split('/');
		     
		     if (res_check_start_date[0].length == 1) {
		    	 res_check_start_date[0] = '0' + res_check_start_date[0];
		        }
		        if (res_check_start_date[1].length == 1) {
		        	res_check_start_date[1] = '0' + res_check_start_date[1];
		        }
		        if (res_check_start_date[2] > 2500) {
		        	res_check_start_date[2] = res_check_start_date[2] - 543;
		        }
		        check_start_date = res_check_start_date[2] + '' + res_check_start_date[1] + '' + res_check_start_date[0];
		        
		        if (res_check_end_date[0].length == 1) {
		        	res_check_end_date[0] = '0' + res_check_end_date[0];
		        }
		        if (res_check_end_date[1].length == 1) {
		        	res_check_end_date[1] = '0' + res_check_end_date[1];
		        }
		        if (res_check_end_date[2] > 2500) {
		        	res_check_end_date[2] = res_check_end_date[2] - 543;
		        }
		        check_end_date = res_check_end_date[2] + '' + res_check_end_date[1] + '' + res_check_end_date[0];
		        
		        var i_check_start_date =parseInt(check_start_date);
		        var i_check_end_date =parseInt(check_end_date);
		        var i_diff = i_check_end_date -i_check_start_date;
		        var oneDay = 24*60*60*1000; // hours*minutes*seconds*milliseconds
		    	var firstDate = new Date(res_check_start_date[2],parseInt(res_check_start_date[1])-1,res_check_start_date[0]);
            	var secondDate = new Date(res_check_end_date[2],parseInt(res_check_end_date[1])-1,res_check_end_date[0]);
            	var diffDays = Math.round(Math.abs((firstDate.getTime() - secondDate.getTime())/(oneDay)));
            	i_diff =diffDays;
		        if(i_diff >= 0 && i_diff <=1){   
		        	
// 					var ot1 =0;
// 					var ot15 =0;
// 					var ot2 =0;
// 					var ot3 =0;
					
// 					var max_row=$("#txtMaxRow").val();
// 					var select_date =$('#txtDlgOTStartDate').val();
// 					var shift_start_time ='';
// 					var shift_end_time ='';
// 					var shift_start_brtime ='';
// 					var shift_end_brtime ='';
// 					var shift_typework ='';
// 					for(var i=0;i<max_row;i++){
// 						if(select_date ==$('#txtWorkDateHide'+i).val()){
// 							shift_start_time = $('#txtShiftStartTime'+i).val();
// 							shift_end_time =$('#txtShiftEndTime'+i).val();
// 							shift_start_brtime =$('#txtShiftStartBreakTime'+i).val();
// 							shift_end_brtime =$('#txtShiftEndBreakTime'+i).val();
// 							shift_typework =$('#txtWorkTypeHide'+i).val();
// 							i=max_row;
// 						}
// 					}
// 					var resshift_starttime = shift_start_time.split('.');
// 					var resshift_endtime = shift_end_time.split('.');
// 					var resshift_start_brtime = shift_start_brtime.split('.');
// 					var resshift_end_brtime = shift_end_brtime.split('.');
// 					var resshift_start_selecttime = $('#txtDlgOTStartTime').val().split('.');
// 					var resshift_end_selecttime = $('#txtDlgOTEndTime').val().split('.');
// 					var emp_type = $('#txtEmpType').val();
					
// 					 //Cal OT Minute
// 					 var  i_before_time =  ( (parseInt(resshift_starttime[0])*60) +parseInt(resshift_starttime[1]) )-
// 					    ((parseInt(resshift_start_selecttime[0])*60) + parseInt(resshift_start_selecttime[1]));
					   
// 					 var  i_after_time =  ( (parseInt(resshift_end_selecttime[0])*60) +parseInt(resshift_end_selecttime[1]) )-
// 					    ((parseInt(resshift_endtime[0])*60) + parseInt(resshift_endtime[1]));
					    
// 					  var i_during_stime =   ( (parseInt(resshift_start_brtime[0])*60) +parseInt(resshift_start_brtime[1]) )-
// 					    ((parseInt(resshift_starttime[0])*60) + parseInt(resshift_starttime[1]));
					  
// 					  var i_during_etime =   ( (parseInt(resshift_endtime[0])*60) +parseInt(resshift_endtime[1]) )-
// 					    ((parseInt(resshift_end_brtime[0])*60) + parseInt(resshift_end_brtime[1]));
					  
// 					  if(shift_typework =='W'){ 
// 						  $('#lblDlgOTOt15').html(parseInt(Math.round(i_after_time) / 60)+(parseInt(Math.round(i_after_time) % 60)/100));
// 					  }else{
// 					   if(emp_type =='0001'){ 
// 						   $('#lblDlgOTOt1').html(parseInt(Math.round((i_during_stime +i_during_etime)) / 60)+(parseInt(Math.round((i_during_stime +i_during_etime)) % 60)/100));
// 					   }
// 					    if(emp_type =='0002'){ 
// 					    	 $('#lblDlgOTOt2').html(parseInt(Math.round((i_during_stime +i_during_etime)) / 60)+(parseInt(Math.round((i_during_stime +i_during_etime)) % 60)/100));
// 					    }
// 					    $('#lblDlgOTOt3').html(parseInt(Math.round(i_after_time) / 60)+(parseInt(Math.round(i_after_time) % 60)/100));
// 					  }
			  
		         var start_time =$("#txtDlgOTStartTime").val();
		 	       var res_start_time =start_time.split('.');
		 	       var end_time =$("#txtDlgOTEndTime").val();
		 	       var res_end_time =end_time.split('.');
		 	      
		 	       
// 		 	       var start_date =$("#txtDlgOTStartDate").val();
				   var start_date =$("#txtDlgOTWorkDate").val();
		 	       var end_date =$("#txtDlgOTEndDate").val();
		 	   
		 	       var s_date =res_start_time[0]+res_start_time[1];
		 	       var e_date =res_end_time[0]+res_end_time[1];
		 	       
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
		 	     
		 	       var start_date_db=res_start[0] + '/' + res_start[1] + '/' + res_start[2];
		 	       var end_date_db=res_end[0] + '/' + res_end[1] + '/' + res_end[2];
// 		 	      var emp_id = document.getElementById('ddlUser');
		 	     var emp_id = $("#lblDlgOTEmpId").html();
		 	      
		 							var data = {}; 
		 	    	       			data["codempid"] = emp_id;
		 	    	       			data["start_date"] = start_date_db;
		 	    	       			data["end_date"] = end_date_db;
		 	    	       			data["start_time"] = res_start_time[0]+res_start_time[1];
		 	    	       			data["end_time"] = res_end_time[0]+res_end_time[1];
		 	    	       			
		 	    	       			jQuery.ajax({
		 	    	       				url : 'member-getcalculateot',
		 	    	       				type : "Post",
		 	    	       				contentType : "application/json",
		 	    	       				data: JSON.stringify(data),
		 	    	       				dataType : 'json',
		 	    	       				success : function(obj) {		 	    	       				
		 	    	       				$('#lblDlgOTOt1').html(obj[0].ot1_h);
		 	    	       				 $('#lblDlgOTOt15').html(obj[0].ot15_h);
		 	    	       				$('#lblDlgOTOt2').html(obj[0].ot2_h);
		 	    	       				$('#lblDlgOTOt3').html(obj[0].ot3_h);
		 	    	       					HideWaiting();
		 	    	       					
		 	    	       				},
		 	    	       				error : function() {
		 	    	       					HideWaiting();
		 	    	       					ShowErrorConnectMessage();
		 	    	       				}
		 	    	       			});
		        }else{
		        	ShowErrorMsg('0019',null);
		        	
		        }
		}
		}
	catch(ex)
	{
		HideWaiting();
		ShowErrorMsg('0006',ex);
	}
	}
	function InsertOT(x){
		try{
			ShowWaiting();
		 	var start_time =$("#txtDlgOTStartTime").val();
	       var res_start_time =start_time.split('.');
	       var end_time =$("#txtDlgOTEndTime").val();
	       var res_end_time =end_time.split('.');
	      
	       
	       var start_date =$("#txtDlgOTStartDate").val();
	       var end_date =$("#txtDlgOTEndDate").val();
	       
	       var s_date =res_start_time[0]+res_start_time[1];
	       var e_date =res_end_time[0]+res_end_time[1];
	       
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
	     
	       var start_date_db=res_start[0] + '/' + res_start[1] + '/' + res_start[2];
	       var end_date_db=res_end[0] + '/' + res_end[1] + '/' + res_end[2];
	      
	    
	       var work_date =$("#txtDlgOTWorkDate").val();
	       var work_datearr =work_date.split('/');
	       if (work_datearr[0].length == 1) {
	    	   work_datearr[0] = '0' + work_datearr[0];
	       }
	       if (work_datearr[1].length == 1) {
	    	   work_datearr[1] = '0' + work_datearr[1];
	       }
	       if (work_datearr[2] > 2500) {
	    	   work_datearr[2] = work_datearr[2] - 543;
	       }
	       work_date = work_datearr[0] + '/' + work_datearr[1] + '/' + work_datearr[2];
	       
	       if(end_date < start_date){
	    	   HideWaiting();
	    	   ShowErrorMsg('0009',null);
	       }else{
	    	   var check=0;
	    	   if(end_date == start_date){
	    		   if(e_date <=s_date){
	    			   check++;
	    			   HideWaiting();
	    			   ShowErrorMsg('0017',null);
	    	       }
	    		  
	    	   }
	    	   if(check==0){
	    		   
	    		   var sum = parseFloat( $('#lblDlgOTOt1').html())+ parseFloat( $('#lblDlgOTOt15').html())
	    		   + parseFloat( $('#lblDlgOTOt2').html())
	    		   + parseFloat( $('#lblDlgOTOt3').html());
	    		   if(sum >0){
	    			   if($('#txtDlgOTRemark').val()!= null && $('#txtDlgOTRemark').val() != '' && $('#txtDlgOTRemark').val() != 'null'){
	    				   var check_start_date =$('#txtDlgOTStartDate').val();
	    					var check_end_date = $('#txtDlgOTEndDate').val();
	    					 var res_check_start_date =check_start_date.split('/');
	    				     var res_check_end_date =check_end_date.split('/');
	    				       
	    				     if (res_check_start_date[0].length == 1) {
	    				    	 res_check_start_date[0] = '0' + res_check_start_date[0];
	    				        }
	    				        if (res_check_start_date[1].length == 1) {
	    				        	res_check_start_date[1] = '0' + res_check_start_date[1];
	    				        }
	    				        if (res_check_start_date[2] > 2500) {
	    				        	res_check_start_date[2] = res_check_start_date[2] - 543;
	    				        }
	    				        check_start_date = res_check_start_date[2] + '' + res_check_start_date[1] + '' + res_check_start_date[0];
	    				        
	    				        if (res_check_end_date[0].length == 1) {
	    				        	res_check_end_date[0] = '0' + res_check_end_date[0];
	    				        }
	    				        if (res_check_end_date[1].length == 1) {
	    				        	res_check_end_date[1] = '0' + res_check_end_date[1];
	    				        }
	    				        if (res_check_end_date[2] > 2500) {
	    				        	res_check_end_date[2] = res_check_end_date[2] - 543;
	    				        }
	    				        check_end_date = res_check_end_date[2] + '' + res_check_end_date[1] + '' + res_check_end_date[0];
	    				        
	    				        var i_check_start_date =parseInt(check_start_date);
	    				        var i_check_end_date =parseInt(check_end_date);
	    				        var i_diff = i_check_end_date -i_check_start_date;
	    				        var oneDay = 24*60*60*1000; // hours*minutes*seconds*milliseconds
	    				    	var firstDate = new Date(res_check_start_date[2],parseInt(res_check_start_date[1])-1,res_check_start_date[0]);
	    		            	var secondDate = new Date(res_check_end_date[2],parseInt(res_check_end_date[1])-1,res_check_end_date[0]);
	    		            	var diffDays = Math.round(Math.abs((firstDate.getTime() - secondDate.getTime())/(oneDay)));
	    		            	i_diff =diffDays;
	    				        if(i_diff >= 0 && i_diff <=1){   
				    				  // var emp_id = document.getElementById('ddlUser');
				    				  
				    				  var row = $('#txtDlgOTRow').val();
	    				        	 var type_work = $('#txtWorkTypeHide'+row).val();
	    				        	 var shift_start = $('#txtShiftStartTime'+row).val();
	    				        	 var shift_end = $('#txtShiftEndTime'+row).val();
	    				        	 var res_shift_start = shift_start.split('.');
	    				        	 var res_shift_end =shift_end.split('.');
	    				        	 var i_shift_start =parseInt(res_shift_start[0]+''+res_shift_start[1]);
	    				        	 var i_shift_end =parseInt(res_shift_end[0]+''+res_shift_end[1]);
	    				        	 var i_start = parseInt(res_start_time[0]+''+res_start_time[1]);
	    							var count_start =0;
	    							if(type_work == 'W' && x=='S'){
	    								if(i_start <i_shift_end){
	    									count_start++;
	    								}
	    							}
	    							// if(count_start == 0){
	    								 /*
	    								 var row_next =parseInt($('#txtDlgOTRow').val())+1;
	 	    				        	 var type_work_next = $('#txtWorkTypeHide'+row_next).val();
	 	    				        	 var shift_start_next = $('#txtShiftStartTime'+row_next).val();
	 	    				        	 var shift_end_next = $('#txtShiftEndTime'+row_next).val();
	 	    				        	 var res_shift_start_next = shift_start_next.split('.');
	 	    				        	 var res_shift_end_next =shift_end_next.split('.');
	 	    				        	 var i_shift_start_next =parseInt(res_shift_start_next[0]+''+res_shift_start_next[1]);
	 	    				        	 var i_shift_end_next =parseInt(res_shift_end_next[0]+''+res_shift_end_next[1]);
	 	    				        	 var i_start_next = parseInt(res_end_time[0]+''+res_end_time[1]);
	 	    				        	var count_next =0;
	 	    				        	if(check_start_date != check_end_date){
	 	    				        	if(type_work_next == 'W' && x=='S'){
		    								if(i_start_next >i_shift_start_next){
		    									count_next++;
		    								}
		    							}}
	    								 */
	    								count_next =0;
	 	    				        	if(count_next ==0){
				    				   var data = {}
				    				   data["save_case"] = x;
				    				   data["trans_id"] = $("#lblDlgOTDocNo").html();
				    	       			data["codempid"] = $("#lblDlgOTEmpId").html();
				    	       			data["company_id"] = $("#txtDlgOTCompanyID").val();
				    	       			data["cod_shift"] = $("#txtDlgOTShiftID").val();
				    	       			data["work_date"] = work_date;
				    	       			data["start_date"] = start_date_db;
				    	       			data["end_date"] = end_date_db;
				    	       			data["start_time"] = res_start_time[0]+res_start_time[1];
				    	       			data["end_time"] = res_end_time[0]+res_end_time[1];
				    	       			data["remark"] = $("#txtDlgOTRemark").val();
				    	       			
				    	       		 var i_check_spe =0;
				    	       			if(ValidateSpecialChar($("#txtDlgOTRemark").val())){
				    	       				i_check_spe++;
					       		  		}
						    	       	if(i_check_spe == 0){
						    	       			jQuery.ajax({
						    	       				url : 'member-insertworktimeot',
						    	       				type : "Post",
						    	       				contentType : "application/json",
						    	       				data: JSON.stringify(data),
						    	       				dataType : 'json',
						    	       				success : function(obj) {
						    	       					
						    	       					HideWaiting();
						    	       					if(obj.success==1){
						    	       					$("#btnCloseDlgOT").click();
						    	       					ShowSuccessMsg('0003',obj.message);
						    	       					PreWorkTime3();
						    	       					}else{
						    	       						ShowErrorMsg('00022',obj.message);
						    	       						}
						    	       				},
						    	       				error : function() {
						    	       					HideWaiting();
						    	       					ShowErrorConnectMessage();
						    	       				}
						    	       			});
						    	       	}else{
						       				
						       				HideWaiting();
						       				ShowErrorMsg('0033',null);
						       			}
				    	       			
	 	    				        	}else{
	 	    				        		HideWaiting();
		    								 ShowErrorMsg('0030',null);
	 	    				        	}
	    							 //}else{
	    								// HideWaiting();
	    								 //ShowErrorMsg('0029',null);
	    							 //}
				    	       			
	    				        }else{
	    				        	ShowErrorMsg('0019',null);
	    				        	
	    				        }
	    			   }else{
	    				   HideWaiting();
		    			   ShowErrorMsg('0013',null); 
	    			   }
	    		   }else{
	    			   HideWaiting();
	    				ShowErrorMsg('0018',null);
	    		   }
	    		 
	    		  
	    	   }
	       }
		}
		catch(ex)
		{
			HideWaiting();
			ShowErrorMsg('0006',ex);
		}
	}
	function Clear()
	{
		  $('#divWorkTime').html('');
	}
	
	function verifiedLeaveDate(){
		day = $('#txtRepay').val()!= null && $('#txtRepay').val() != ''? parseInt($('#txtRepay').val()):0;
		var txtDlgLeaveLeaveID = $("#txtDlgLeaveLeaveID").val();
		var leaveStartDate = $('#txtDlgLeaveStartDate').val().split("/");		
		var leaveEndDate = $('#txtDlgLeaveEndDate').val().split("/");	
		
		if( 'P5' === txtDlgLeaveLeaveID){
			console.log(day);
			if(0==day){
					ShowErrorMsg('0041',null);
					return false;
			}
			if($('#chkDlgLeaveRangDate').prop('checked')){
				var cal=0;			
				for(var i = parseInt(leaveStartDate[0]);i<= parseInt(leaveEndDate[0]);i++){
					if(!weekendate(leaveEndDate[2],leaveEndDate[1],i)){
						cal++;
					}
				}
				if(cal>day){
					ShowErrorMsg('0042',day);
					return false;
				}
			}
			
		}		
		return true;
	}
	function weekendate (year,mon,day){
		var toDate = new Date();
		toDate.setFullYear(parseInt(year)-543);
		toDate.setMonth(parseInt(mon)-1);
		toDate.setDate(parseInt(day));
		return (toDate.getDay() == 6 || toDate.getDay() == 0);
	}
	function todate (year,mon,day,hour,min){
		var toDate = new Date();
		toDate.setFullYear(parseInt(year)-543);
		toDate.setMonth(parseInt(mon)-1);
		toDate.setDate(parseInt(day));
		toDate.setHours(parseInt(hour));
		toDate.setMinutes(parseInt(min));		
		return toDate;
	}
	</script>
<div style="background-color: white;" class="testscoll">
	<input type="text" style="display: none;" id="txtMaxRow"> <input
		type="text" style="display: none;" id="txtEmpType">
	<div class="row">
		<div class="col-lg-12">
			<!-- general form elements -->
			<div class="box collapsed-box">
				<div class="box-header">

					<div style="min-height: 12px;"></div>
					<div class="box-tools pull-right">
						<span class="btn btn-box-tool" data-widget="collapse"><img
							src="resources/Images/dot.png" style="width: 20px; height: 20px;">
						</span>
					</div>
				</div>
				<!-- /.box-header -->
				<!-- form start -->
				<form class="form-horizontal"
					style="padding-left: 10px; padding-right: 10px;">
					<div class="box-body">
						<div class="row">
							<div class="form-group">
								<label for="ddlCompany" class="col-sm-2 control-label"><spring:message
										code="member.worktime.criteria.company" /></label>
								<div class="col-sm-6">
									<select id="ddlCompany" class="form-control select2"
										onchange="InitDropDown();" style="width: 100%;"
										data-placeholder="เลือกหน่วยงาน">
									</select>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="form-group">
								<label for="inputUser" id="lblChkUser"
									class="col-sm-2 control-label">
									<!-- input id="chkUser" type="checkbox" class="minimal" />&nbsp;-->
									<spring:message code="member.worktime.criteria.user" />
								</label>
								<div class="col-sm-6">
									<select id="ddlUser" class="select2" style="width: 100%;">
									</select>
								</div>

							</div>
						</div>

						<div class="row">
							<div class="form-group">
								<label class="col-sm-2 control-label"><spring:message
										code="member.worktime.criteria.date" /></label>

								<div class="col-sm-10">
									<input type="text" id="txtStartDate"
										class="custom-text-horizon-rangdate2" maxlength="10"
										data-inputmask="'mask': '99/99/9999'" data-mask
										data-provide="datepicker">
									<!-- 		                   <input type="text" class="custom-text-horizon-rangdate2"  maxlength="10" id="txtStartDate" data-inputmask="'mask': '99/99/9999'" data-mask data-provide="datepicker" > -->
									<label class="control-label">-</label> <input type="text"
										class="custom-text-horizon-rangdate2" maxlength="10"
										id="txtEndDate" data-inputmask="'mask': '99/99/9999'"
										data-mask data-provide="datepicker">
								</div>

							</div>
						</div>
						<div class="row">
							<div class="form-group">
								<label for="ddlDocStatus" class="col-sm-2 control-label"><spring:message
										code="member.worktime.criteria.option" /></label>
								<div class="col-sm-6">
									<select id="ddlOption" class="form-control select2"
										style="width: 100%;">
									</select>
								</div>
							</div>
						</div>

						<div class="row">
							<div class="form-group">
								<label class="col-sm-2 control-label"></label>
								<div class="col-sm-6">
									<button type="button" class="btn pull-right custom-button"
										onclick="PreWorkTime2();">
										<span class="glyphicon glyphicon-search"></span>&nbsp;
										<spring:message code="member.history.criteria.search" />
									</button>
								</div>
							</div>
						</div>
					</div>
					<!-- /.box-body -->

				</form>

			</div>
		</div>

	</div>
	<div class="row" style="padding-bottom: 3px;">
		<div class="col-sm-12 text-right custom-info-button"
			id="statusInformation">
			<i class="glyphicon glyphicon-info-sign" data-toggle="popover"
				data-placement="left" style="cursor: pointer;" id="iconInformation"></i>
			<div style="border: 1px solid; display: none;"
				id="ShowStatusInformation">
				<table style="min-width: 200px;">
					<tr>
						<td colspan="2"><label class="custom-font">ข้อมูลสีของสถานะคำร้อง</label></td>
					</tr>
					<tr>
						<td><label class="text-attend-time-error"
							style="cursor: default;"></label>&nbsp;&nbsp;</td>
						<td><label class="custom-font-label-thin custom-font">การปฏิบัติงานผิดปกติ</label></td>
					</tr>
					<tr>
						<td><label class="text-attend-doc-status-req1"
							style="cursor: default;"></label>&nbsp;&nbsp;</td>
						<td><label class="custom-font-label-thin custom-font">รออนุมัติลำดับที่1</label></td>
					</tr>
					<tr>
						<td><label class="text-attend-doc-status-req2 custom-font"
							style="cursor: default;"></label>&nbsp;&nbsp;</td>
						<td><label class="custom-font-label-thin custom-font">รออนุมัติลำดับที่2</label></td>
					</tr>
					<tr>
						<td><label class="text-attend-doc-status-approved"
							style="cursor: default;"></label>&nbsp;&nbsp;</td>
						<td><label class="custom-font-label-thin custom-font">รายการอนุมัติ</label></td>
					</tr>
					<tr>
						<td><label class="text-attend-doc-status-unapproved"
							style="cursor: default;"></label>&nbsp;&nbsp;</td>
						<td><label class="custom-font-label-thin custom-font">รายการไม่อนุมัติ</label></td>
					</tr>
				</table>
			</div>
		</div>
	</div>
	<div class="row">
		<div class="col-sm-12">

			<div id="divWorkTime"></div>
		</div>
	</div>
</div>
<!-- Modal -->
<div class="modal fade" id="dlgEditTime" role="dialog">
	<div class="modal-dialog">

		<!-- Modal content-->
		<div class="modal-content">
			<div class="modal-header"
				style="border-bottom: 1px solid; border-color: #c6beb7;">
				<button type="button" id="btnCloseEditTime" class="close"
					data-dismiss="modal">&times;</button>
				<div class="modal-title">
					<div class="col-sm-12 col-xs-12">
						<label id="lblDlgEditTimeHead"></label> &nbsp;-&nbsp;<label
							id="lblDlgEditTimeEmpId"></label>&nbsp;<label
							id="lblDlgEditTimeName"></label>
					</div>
				</div>
			</div>
			<div class="modal-body">
				<input type="text" id="txtDlgEditTimeCompanyID"
					style="display: none;"> <input type="text"
					id="txtDlgEditTimeShiftID" style="display: none;"> <input
					type="text" id="txtDlgEditTimeStartTime" style="display: none;">
				<input type="text" id="txtDlgEditTimeEndTime" style="display: none;">
				<input type="text" id="txtDlgEditTimeStartDate"
					style="display: none;"> <input type="text"
					id="txtDlgEditTimeEndDate" style="display: none;"> <input
					type="text" id="txtDlgEditTimeShiftDate" style="display: none;">
				<label id="lblDlgEditTimeDate" style="display: none"></label> <label
					id="lblDlgReqEditTimeTransId" style="display: none"></label>
				<table width="100%">
					<tr>
						<!-- to show day and holiday description -->
						<td>
							<div class="col-sm-12 col-xs-12">
								<div id="divDlgEditTimeStar"
									style="float: left; color: red; display: none;">
									<i class="glyphicon glyphicon-star"></i> &nbsp;
								</div>
								<label id="lblDlgEditTimeDay">วัน</label> &nbsp; <label
									id="lblDlgEditTimeHoliday"></label>
							</div>
						</td>
					</tr>
					<tr>
						<td>
							<div class="col-sm-3 col-xs-6">
								<label><spring:message
										code="member.worktime.dialog.shifttime" /></label>
							</div>
							<div class="col-sm-9 col-xs-12">
								<label class="custom-font-label-thin"
									id="lblDlgEditTimeDateShift"></label>
							</div>
						</td>
					</tr>
					<tr>
						<td>
							<div class="col-sm-3 col-xs-6">
								<label><spring:message
										code="member.worktime.dialog.realtime" /></label>
							</div>
							<div class="col-sm-9 col-xs-12">
								<label class="custom-font-label-thin"
									id="lblDlgEditTimeDateReal"></label>
							</div>
						</td>
					</tr>
					<tr>
						<td>
							<div class="col-sm-3 col-xs-6">
								<label><spring:message
										code="member.worktime.dialog.edittime" /></label>
							</div>
							<div class="col-sm-9 col-xs-12">
								<label class="custom-font-label-thin"
									id="lblDlgEditTimeDateRequest"></label>
							</div>
						</td>
					</tr>
					<tr>
						<td>
							<div class="col-sm-3 col-xs-6">
								<label><spring:message
										code="member.worktime.dialog.cause" /></label>
							</div>
							<div class="col-sm-9 col-xs-12">
								<select id="ddlDlgEditTimeCause" class="form-control"
									style="width: 100%;">
								</select>
							</div>
						</td>
					</tr>
					<tr>
						<td>
							<div style="height: 10px;"></div>
						</td>
					</tr>
					<tr>
						<td>
							<div class="col-sm-12 col-xs-12">
								<label><spring:message
										code="member.worktime.dialog.detail" /></label>
							</div>
							<div class="col-sm-12 col-xs-12">
								<input type="text" id="txtDlgEditTimeRemark"
									class="form-control" maxlength="200">
							</div>
						</td>
					</tr>
				</table>
			</div>
			<div class="modal-footer">
				<button type="button"
					class="btn btn-primary pull-left custom-button"
					style="display: none;" data-dismiss="modal">
					&nbsp;
					<spring:message code="center.cancel" />
				</button>
				<button type="button"
					class="btn btn-primary pull-right custom-button"
					onclick="SaveEditWorkTime();">
					&nbsp;
					<spring:message code="center.save" />
				</button>
			</div>
		</div>

	</div>
</div>
<div class="modal fade" id="dlgRequestEditTime" role="dialog">
	<div class="modal-dialog">

		<!-- Modal content-->
		<div class="modal-content">
			<div class="modal-header"
				style="border-bottom: 1px solid; border-color: #c6beb7;">
				<button type="button" id="btnReqCloseEditTime" class="close"
					data-dismiss="modal">&times;</button>
				<div class="modal-title">
					<div class="col-sm-12 col-xs-12">
						<label id="lblDlgReqEditTimeHead"></label> &nbsp;-&nbsp;<label
							id="lblDlgReqEditTimeEmpId"></label>&nbsp;<label
							id="lblDlgReqEditTimeName"></label>
					</div>
				</div>
				<div class="modal-title">
					<div class="col-sm-3 col-xs-5">
						<label>เลขที่เอกสาร</label>
					</div>
					<div class="col-sm-9 col-xs-7">
						<label class="custom-font-label-thin" id="lblEdittimeDocNo"></label>
					</div>
				</div>
				<div class="modal-title">
					<div class="col-sm-3 col-xs-5">
						<label><spring:message
								code="member.worktime.dialog.docstatus" /></label>
					</div>
					<div class="col-sm-9 col-xs-7">
						<label id="lblDlgReqEditTimeStatus"></label>
					</div>
				</div>
				<div class="modal-title">
					<div class="col-sm-3 col-xs-5">
						<label><spring:message
								code="member.worktime.dialog.approver" /></label>
					</div>
					<div class="col-sm-9 col-xs-7">
						<label class="custom-font-label-thin"
							id="lblDlgReqEditTimeApprover"></label>
					</div>
				</div>
			</div>
			<input type="text" id="txtDlgReqEditTimeCompanyID"
				style="display: none;"> <input type="text"
				id="txtDlgReqEditTimeShiftID" style="display: none;"> <input
				type="text" id="txtDlgReqEditTimeShiftDate" style="display: none;">
			<label id="lblDlgReqEditTimeDate" style="display: none;"></label>
			<div class="modal-body">
				<table width="100%">

					<tr>
						<td>
							<div class="col-sm-12 col-xs-12">
								<div id="divDlgReqEditTimeStar"
									style="float: left; color: red; display: none;">
									<i class="glyphicon glyphicon-star"></i>&nbsp;
								</div>
								<label id="lblDlgReqEditTimeDay"></label> &nbsp; <label
									id="lblDlgReqEditTimeHoliday"></label>
							</div>
						</td>
					</tr>
					<tr>
						<td>
							<div class="col-sm-3 col-xs-6">
								<label><spring:message
										code="member.worktime.dialog.shifttime" /></label>
							</div>
							<div class="col-sm-9 col-xs-12">
								<label class="custom-font-label-thin"
									id="lblDlgReqEditTimeDateShit"></label>
							</div>
						</td>
					</tr>
					<tr>
						<td>
							<div class="col-sm-3 col-xs-6">
								<label><spring:message
										code="member.worktime.dialog.realtime" /></label>
							</div>
							<div class="col-sm-9 col-xs-12">
								<label class="custom-font-label-thin"
									id="lblDlgReqEditTimeDateReal"></label>
							</div>
						</td>
					</tr>
					<tr>
						<td>
							<div class="col-sm-3 col-xs-6">
								<label class="custom-edittime-date"><spring:message
										code="member.worktime.dialog.edittime" /></label>
							</div>
							<div class="col-sm-9 col-xs-12">
								<label class="custom-font-label-thin text-attend-time-normal"
									id="lblDlgReqEditTimeStartDate"></label> - <input type="text"
									class="text-cutom-border text-center" maxlength="10"
									style="width: 85px; height: 25px;"
									id="txtDlgReqEditTimeEndDate"
									data-inputmask="'mask': '99/99/9999'" data-mask
									data-provide="datepicker" value="">
							</div>
						</td>
					</tr>
					<tr>
						<td>
							<div class="col-sm-3 col-xs-6">
								<label class="custom-edittime-time"></label>
							</div>
							<div class="col-sm-9 col-xs-12">
								<input type="text" style="width: 85px; height: 25px;"
									class="custom-font-label-thin text-cutom-border text-center"
									data-inputmask="'mask': '99.99'" data-mask maxlength="5"
									id="txtDlgReqEditTimeStartTime" value=""> - <input
									type="text" style="width: 85px; height: 25px;"
									class="custom-font-label-thin text-cutom-border text-center"
									data-inputmask="'mask': '99.99'" data-mask maxlength="5"
									id="txtDlgReqEditTimeEndTime" value="">
							</div>
						</td>
					</tr>
					<tr>
						<td>
							<div style="height: 10px;"></div>
						</td>
					</tr>
					<tr>
						<td>
							<div class="col-sm-3 col-xs-6">
								<label><spring:message
										code="member.worktime.dialog.cause" /></label>
							</div>
							<div class="col-sm-9 col-xs-12">
								<select id="ddlDlgReqEditTimeCause" class="form-control"
									style="width: 100%;">
								</select>
							</div>
						</td>
					</tr>
					<tr>
						<td>
							<div style="height: 10px;"></div>
						</td>
					</tr>
					<tr>
						<td>
							<div class="col-sm-12 col-xs-12">
								<label><spring:message
										code="member.worktime.dialog.detail" /></label>
							</div>
							<div class="col-sm-12 col-xs-12">
								<input type="text" id="txtDlgReqEditTimeRemark"
									class="form-control" maxlength="200">
							</div>
						</td>
					</tr>
				</table>
			</div>
			<div class="modal-footer">
				<button type="button"
					class="btn btn-primary pull-left custom-button"
					id="btnDlgReqEditTimeCancel"
					onclick="SaveEditWorkTimeRequest('C');">
					&nbsp;
					<spring:message code="center.cancel" />
				</button>
				<button type="button"
					class="btn btn-primary pull-right custom-button"
					id="btnDlgReqEditTimeSave" onclick="SaveEditWorkTimeRequest('S');">
					&nbsp;
					<spring:message code="center.save" />
				</button>
			</div>

			<div>
				<div style="padding-left: 15px; padding-right: 15px;">
					<label>รายการก่อนหน้า</label> <span
						class="fa fa-sort-desc pull-right" style="cursor: pointer;"
						id="spnDlgReqEditTimeShow" onclick="ShowHideRequestEditTime();"></span>
				</div>
				<div id="divEditTimeList" style="width: 100%;"></div>
			</div>
		</div>

	</div>
</div>

<!-- Leave -->
<div class="modal fade" id="dlgLeave" role="dialog">
	<div class="modal-dialog">

		<!-- Modal content-->
		<div class="modal-content">
			<div class="modal-header"
				style="border-bottom: 1px solid; border-color: #c6beb7;">
				<button type="button" id="btnCloseDlgLeave" class="close"
					data-dismiss="modal">&times;</button>
				<div class="modal-title">
					<div class="col-sm-12 col-xs-12">
						<label id="lblDlgLeaveHead"></label>&nbsp;-&nbsp; <label
							id="lblDlgLeaveEmpId"></label>&nbsp;<label id="lblDlgLeaveName"></label>
					</div>
				</div>

				<div class="modal-title" id="pDlgLeaveDocNo">
					<div class="col-sm-3 col-xs-6">
						<label>เลขที่เอกสาร</label>
					</div>
					<div class="col-sm-9 col-xs-6" style="padding-left: 0px;">
						<label class="custom-font-label-thin" id="lblDlgLeaveDocNo"></label>
					</div>
				</div>
				<div class="modal-title" id="pDlgLeaveDocStatus">
					<div class="col-sm-3 col-xs-6">
						<label>สถานะเอกสาร</label>
					</div>
					<div class="col-sm-9 col-xs-6" style="padding-left: 0px;">
						<label id="lblDlgLeaveDocStatus"></label>
					</div>
				</div>
				<div class="modal-title" id="pDlgLeaveDocApprover">
					<div class="col-sm-3 col-xs-6">
						<label><spring:message
								code="member.worktime.dialog.approver" /></label>
					</div>
					<div class="col-sm-9 col-xs-6" style="padding-left: 0px;">
						<label class="custom-font-label-thin" id="lblDlgLeaveDocApprover"></label>
					</div>
				</div>
			</div>
			<div class="modal-body">
				<input type="text" id="txtRepay" style="display: none;"> <input
					type="text" id="txtDlgLeaveCompanyID" style="display: none;">
				<input type="text" id="txtDlgLeaveShiftID" style="display: none;">
				<input type="text" id="txtDlgLeaveWorkDate" style="display: none;">
				<input type="text" id="txtDlgLeaveLeaveID" style="display: none;">
				<input type="text" id="txtDlgLeaveTransID" style="display: none;">
				<input type="text" id="txtDlgLeaveEmpType" style="display: none;">
				<div id="divDlgLeaveData">
					<table width="100%">
						<!-- tr>
          	<td>
          		<div class="col-sm-12 col-xs-12">
          			<div id="divDlgLeaveStar" style="float: left; color: red; display: none;">
          				<i class="glyphicon glyphicon-star"></i> &nbsp;
          			</div>
          			<label id="lblDlgLeaveDay"></label> &nbsp;
          			<label id="lblDlgLeaveHoliday"></label>
          		</div>
          	</td>
          </tr -->
						<tr>
							<td>
								<div class="col-sm-12 col-xs-12">
									<label><spring:message
											code="member.worktime.dialog.leavepermiss" /></label>&nbsp;&nbsp;:&nbsp;&nbsp;<label
										id="lblDlgLeavePermiss"></label>
								</div>
							</td>
						</tr>
						<tr>
							<td>
								<div class="col-sm-12 col-xs-12">
									<label for="chkDlgLeaveRangDate" id="lblDlgLeaveChkRangDate">
										<input id="chkDlgLeaveRangDate" type="checkbox"
										class="minimal" />&nbsp;&nbsp; <spring:message
											code="member.worktime.dialog.rangtime" />
									</label> &nbsp;&nbsp;
									<!-- label class="custom-font-label-thin-small">(กรณีไม่ระบุเวลา เช้าหรือบ่าย ระบบจะคิดเต็มวัน)</label -->
								</div>
							</td>
						</tr>
						<tr>
							<td style="vertical-align: top;">
								<div class="col-sm-6 col-xs-12"
									style="padding-left: 0px; padding-right: 0px;">
									<div class="col-sm-3 col-xs-3">
										<label><spring:message
												code="member.worktime.criteria.date" /></label>
									</div>
									<div>
										<input type="text" class="custom-text-horizon-rangdate2"
											maxlength="10" id="txtDlgLeaveStartDate"
											data-inputmask="'mask': '99/99/9999'" data-mask
											data-provide="datepicker" disabled style="height: 25px;">
									</div>
								</div>
								<div class="col-sm-1 col-xs-3">
									<label>&nbsp;</label>
								</div>
								<div class="col-sm-5 col-xs-9 custom-leave-checkbox-gap"
									style="padding-left: 0px;">
									<label for="chkDlgStartLeaveMo" id="lblDlgStartLeaveChkMo">
										<input id="chkDlgStartLeaveMo" type="checkbox" class="minimal" />
										&nbsp;<spring:message code="member.worktime.dialog.morning" />
									</label> &nbsp;&nbsp;&nbsp;&nbsp;<label for="chkDlgStartLeaveAf"
										id="lblDlgStartLeaveChkAf"> <input
										id="chkDlgStartLeaveAf" type="checkbox" class="minimal" />
										&nbsp;<spring:message code="member.worktime.dialog.afternoon" />
									</label>
								</div>
							</td>
						</tr>
						<tr id="trDlgLeaveTo" style="display: none;">
							<td>
								<div class="col-sm-6 col-xs-12"
									style="padding-left: 0px; padding-right: 0px;">
									<div class="col-sm-3 col-xs-3">
										<label><spring:message
												code="member.worktime.dialog.to" /></label>
									</div>
									<div>
										<input type="text" class="custom-text-horizon-rangdate2"
											maxlength="10" id="txtDlgLeaveEndDate"
											data-inputmask="'mask': '99/99/9999'" data-mask
											data-provide="datepicker" style="height: 25px;">
									</div>
								</div>
								<div class="col-sm-1 col-xs-3">
									<label>&nbsp;</label>
								</div>
								<div class="col-sm-5 col-xs-9 custom-leave-checkbox-gap"
									style="padding-left: 0px;">
									<label for="chkDlgEndLeaveMo" id="lblDlgEndLeaveChkMo">
										<input id="chkDlgEndLeaveMo" type="checkbox" class="minimal" />
										&nbsp;<spring:message code="member.worktime.dialog.morning" />
									</label> &nbsp;&nbsp;&nbsp;&nbsp;<label for="chkDlgEndLeaveAf"
										id="lblDlgEndLeaveChkAf"> <input id="chkDlgEndLeaveAf"
										type="checkbox" class="minimal" /> &nbsp;<spring:message
											code="member.worktime.dialog.afternoon" />
									</label>
								</div>
							</td>
						</tr>
						<tr>
							<td>
								<div style="height: 10px;"></div>
							</td>
						</tr>
						<tr>
							<td>
								<div class="col-sm-12 col-xs-12">
									<label><spring:message
											code="member.worktime.dialog.leavedetail" /></label>
								</div>
							</td>
						</tr>
						<tr>
							<td>
								<div class="col-sm-12 col-xs-12">
									<input type="text" id="txtDlgLeaveTimeRemark"
										class="form-control" maxlength="200">
								</div>
							</td>
						</tr>
						<tr>
							<td>
								<div style="height: 10px;"></div>
							</td>
						</tr>
						<tr>
							<td>
								<div class="col-sm-12 col-xs-12">
									<label><spring:message
											code="member.worktime.dialog.attfile" /></label> &nbsp;<label
										class="custom-font-label-thin-small">(ใบรับรองแพทย์
										หรือเอกสารประกอบการลา)</label>
								</div> <!-- div class="col-sm-10 col-xs-8" -->
								<div class="col-xs-12" style="padding-top: 0px;">
									<label class="custom-font-label-thin-small">ขนาดไฟล์ไม่เกิน
										2 MB</label> <label class="custom-font-label-thin-small">ประเภทไฟล์ที่รองรับ
										.pdf, .jpg, .png, .gif, .bmp</label>
								</div>
							</td>
						</tr>
						<tr>
							<td>
								<div class="col-sm-12 col-xs-12">
									<input type="text" id="txtFileUploadLeave" readonly="readonly"
										class="custom-text-input-file" /> &nbsp; <label
										class="btn btn-default btn-file pull-right"> <spring:message
											code="member.worktime.dialog.browse" /> <input type="file"
										style="display: none;" id="fileUploadLeave">
									</label>
								</div>
								<div class="col-sm-12 col-xs-12" id="chkEmpType"
									style="display: none;">
									<label class="custom-font-label-thin-small" style="color: red;">*หมายเหตุ
										กรณีไม่แนบใบรับรองแพทย์จะไม่ได้รับค่าจ้างในวันที่ขอลา</label>
								</div>
							</td>
						</tr>
						<tr>
							<td>
								<div class="col-sm-12 col-xs-12">
									<a style="cursor: pointer; text-decoration: underline;"
										id="lblDlgReqFileName" onclick="DownLoadFile();"> </a>
								</div>
							</td>
						</tr>
					</table>
				</div>

			</div>
			<div class="modal-footer">
				<button type="button"
					class="btn btn-primary pull-left custom-button" id="btnCancelLeave"
					data-dismiss="modal" onclick="InsertLeave('C');">
					&nbsp;
					<spring:message code="center.cancel" />
				</button>
				<button type="button"
					class="btn btn-primary pull-right custom-button" id="btnSaveLeave"
					onclick="InsertLeave('S');">
					&nbsp;
					<spring:message code="center.save" />
				</button>
			</div>
		</div>

	</div>
</div>


<div class="modal fade" id="dlgOT" role="dialog">
	<div class="modal-dialog">

		<!-- Modal content-->
		<div class="modal-content">
			<div class="modal-header"
				style="border-bottom: 1px solid; border-color: #c6beb7;">
				<button type="button" id="btnCloseDlgOT" class="close"
					data-dismiss="modal">&times;</button>
				<div class="modal-title">
					<div class="col-sm-12 col-xs-12">
						<label id="lblDlgOTHead"></label> &nbsp;-&nbsp;<label
							id="lblDlgOTEmpId"></label>&nbsp;<label id="lblDlgOTName"></label>
					</div>
				</div>
				<div class="modal-title" id="pDlgOTDocNo">
					<div class="col-sm-3 col-xs-6">
						<label>เลขที่เอกสาร</label>
					</div>
					<div class="col-sm-9 col-xs-6" style="padding-left: 0px;">
						<label class="custom-font-label-thin" id="lblDlgOTDocNo"></label>
					</div>
				</div>
				<div class="modal-title" id="pDlgOTDocStatus">
					<div class="col-sm-3 col-xs-6">
						<label>สถานะเอกสาร</label>
					</div>
					<div class="col-sm-9 col-xs-6" style="padding-left: 0px;">
						<label id="lblDlgOTDocStatus"></label>
					</div>
				</div>
				<div class="modal-title" id="pDlgOTDocApprover">
					<div class="col-sm-3 col-xs-6">
						<label><spring:message
								code="member.worktime.dialog.approver" /></label>
					</div>
					<div class="col-sm-9 col-xs-6" style="padding-left: 0px;">
						<label class="custom-font-label-thin" id="lblDlgOTDocApprover"></label>
					</div>
				</div>
			</div>
			<div class="modal-body">
				<input type="text" id="txtDlgOTCompanyID" style="display: none;">
				<input type="text" id="txtDlgOTShiftID" style="display: none;">
				<input type="text" id="txtDlgOTWorkDate" style="display: none;">
				<input type="text" id="txtDlgOTTransID" style="display: none;">
				<input type="text" id="txtDlgOTRow" style="display: none;">
				<div id="divDlgLeaveData">
					<table width="100%">
						<tr>
							<td>
								<div class="col-sm-12 col-xs-12">
									<div id="divDlgOTStar"
										style="float: left; color: red; display: none;">
										<i class="glyphicon glyphicon-star"></i> &nbsp;
									</div>
									<label id="lblDlgOTDay"></label> &nbsp; <label
										id="lblDlgOTHoliday"></label>
								</div>
							</td>
						</tr>
						<tr>
							<td colspan="4">
								<div class="col-sm-3 col-xs-12">
									<label><spring:message
											code="member.worktime.dialog.shifttime" /></label>
								</div>
								<div class="col-sm-9 col-xs-12" style="padding-right: 0px;">
									<label id="lblDlgOTShiftStartDate"
										class="custom-font-label-thin"></label>&nbsp;-&nbsp; <label
										id="lblDlgOTShiftEndDate" class="custom-font-label-thin"></label>
								</div>
							</td>
						</tr>

						<tr>
							<td colspan="4">
								<div class="col-sm-3 col-xs-12">
									<label><spring:message
											code="member.worktime.dialog.realtime" /></label>
								</div>
								<div class="col-sm-9 col-xs-12" style="padding-right: 0px;">
									<label id="lblDlgOTRealStartDate"
										class="custom-font-label-thin"></label>&nbsp;-&nbsp; <label
										id="lblDlgOTRealEndDate" class="custom-font-label-thin"></label>
								</div>
							</td>
						</tr>

						<tr>
							<td colspan="4">
								<div class="col-sm-3 col-xs-12">
									<label><spring:message
											code="member.worktime.dialog.requesttime" /></label>
								</div>
								<div class="col-sm-3 col-xs-5">
									<input type="text" class="custom-text-horizon-rangdate2"
										maxlength="10" id="txtDlgOTStartDate"
										data-inputmask="'mask': '99/99/9999'" data-mask
										data-provide="datepicker" style="height: 25px; width: 100px;"
										onchange="CalculateOT('1');"><br /> <input
										type="hidden"
										style="width: 100px; height: 25px; text-align: center; margin-top: 3px;"
										id="txtDlgOTStartTime" data-inputmask="'mask': '99.99'"
										data-mask class="custom-font-label-thin text-cutom-border"
										onkeyup="CalculateOT('2');"> <input type="text"
										style="width: 100px; height: 25px; text-align: center; margin-top: 3px;"
										id="txtDlgOTStartTimeShift" data-inputmask="'mask': '99.99'"
										data-mask class="custom-font-label-thin text-cutom-border">
								</div>
								<div class="col-xs-1">
									<label>-</label>
								</div>
								<div class="col-sm-3 col-xs-5">
									<input type="text" class="custom-text-horizon-rangdate2"
										maxlength="10" id="txtDlgOTEndDate"
										data-inputmask="'mask': '99/99/9999'" data-mask
										data-provide="datepicker" style="height: 25px; width: 100px;"
										onchange="CalculateOT('3');"><br /> <input type="text"
										style="width: 100px; height: 25px; text-align: center; margin-top: 3px;"
										id="txtDlgOTEndTime" data-inputmask="'mask': '99.99'"
										data-mask class="custom-font-label-thin text-cutom-border"
										onkeyup="CalculateOT('4');">
								</div>
							</td>
						</tr>

						<tr>
							<td colspan="4" style="vertical-align: top;">
								<div class="col-sm-3 col-xs-12">
									<label></label>&nbsp;&nbsp;
								</div>
								<div class="col-sm-3 col-xs-5"
									style="padding-top: 0px; padding-bottom: 0px;">
									<label><spring:message
											code="member.worktime.dialog.ot1" /></label>&nbsp;<label
										class="custom-font-label-thin" id="lblDlgOTOt1">0</label>
								</div>
								<div class="col-xs-1">
									<label>&nbsp;</label>
								</div>
								<div class="col-sm-3 col-xs-5"
									style="padding-top: 0px; padding-bottom: 0px;">
									<label><spring:message
											code="member.worktime.dialog.ot15" /></label>&nbsp;<label
										class="custom-font-label-thin" id="lblDlgOTOt15">0</label>
								</div>
							</td>
						</tr>

						<tr>
							<td colspan="4" style="vertical-align: top;">
								<div class="col-sm-3 col-xs-12">
									<label></label>&nbsp;&nbsp;
								</div>
								<div class="col-sm-3 col-xs-5"
									style="padding-top: 0px; padding-bottom: 0px;">
									<label><spring:message
											code="member.worktime.dialog.ot2" /></label>&nbsp;<label
										class="custom-font-label-thin" id="lblDlgOTOt2">0</label>
								</div>
								<div class="col-xs-1">
									<label>&nbsp;</label>
								</div>
								<div class="col-sm-3 col-xs-5"
									style="padding-top: 0px; padding-bottom: 0px;">
									<label><spring:message
											code="member.worktime.dialog.ot3" /></label>&nbsp;<label
										class="custom-font-label-thin" id="lblDlgOTOt3">0</label>
								</div>
							</td>
						</tr>
						<tr>
							<td colspan="4">
								<div style="height: 10px;"></div>
							</td>
						</tr>
						<tr>
							<td colspan="4">
								<div class="col-sm-12 col-xs-12">
									<label><spring:message
											code="member.worktime.dialog.detail" /></label>
								</div>
							</td>
						</tr>
						<tr>
							<td colspan="4">
								<div class="col-sm-12 col-xs-12">
									<input type="text" id="txtDlgOTRemark" class="form-control"
										maxlength="200">
								</div>
							</td>
						</tr>
						<tr>
							<td colspan="4">
								<div style="height: 7px;"></div>
							</td>
						</tr>
					</table>
				</div>

			</div>
			<div class="modal-footer">
				<button type="button"
					class="btn btn-primary pull-left custom-button" id="btnCancelOT"
					data-dismiss="modal" onclick="InsertOT('C');">
					&nbsp;
					<spring:message code="center.cancel" />
				</button>
				<button type="button"
					class="btn btn-primary pull-right custom-button" id="btnSaveOT"
					onclick="InsertOT('S');">
					&nbsp;
					<spring:message code="center.save" />
				</button>
			</div>
		</div>

	</div>
</div>
<script type="text/javascript">
            $(function () {
                $("#fileUploadLeave").bind("change", function () {
                    var regex = /^([a-zA-Z0-9\s_\\.\-:])+(.jpg|.png|.doc|.docx|.pdf|.txt)$/;
//                     if (regex.test($("#fileUploadLeave").val().toLowerCase())) {
                        if (typeof (FileReader) != "undefined") {
                        	var fullPath = document.getElementById('fileUploadLeave').value;
                        	 var startIndex = (fullPath.indexOf('\\') >= 0 ? fullPath.lastIndexOf('\\') : fullPath.lastIndexOf('/'));
                        	    var filename = fullPath.substring(startIndex);
                        	    if (filename.indexOf('\\') === 0 || filename.indexOf('/') === 0) {
                        	        filename = filename.substring(1);
                        	    }
                        	$("#txtFileUploadLeave").val(filename);
                      
                        } else {
                            alert("This browser does not support HTML5.");
                        }
//                     } else {
//                         alert("Please upload a valid CSV file.");
//                     }
                    waitingDialog.hide();
                });
            });
        </script>
