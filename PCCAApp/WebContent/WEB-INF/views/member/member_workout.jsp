<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<style>
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
</style>
<script>
$(document).ready(
		function() {
			try
			{
			//ShowWaiting();
			SetDropDownCompany();
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
					}catch(ex)
					{
						HideWaiting();
						ShowErrorMsg('0006',ex);
					}
		});
		

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
			         
			         PreWorkOut();
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
// 					             if(i==1){
					             if(i==0){	 
					             	opt.selected =true;
					             }
					             select.appendChild(opt);
					         }
					         HideWaiting();
					         PreWorkOut();
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
		
		function PreWorkOut()
		{
			try
			{
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
	        // var start_date=day_first+'/'+mont+'/'+year;
	         //var end_date=day_last+'/'+mont+'/'+year;
	         var start_date ="01/01/"+year;
	         var end_date ="31/12/"+year;
	         $("#txtStartDate").val(start_date);
	         $("#txtEndDate").val(end_date);
			InitWorkOut();
			}
			catch(ex)
			{
				alert(ex);
				HideWaiting();
				ShowErrorMsg('0006',ex);
			}
		}
		
		function PreWorkOut2()
		{
			ShowWaiting();
			InitWorkOut();
		}
		function CheckStatusStyle(status) {
			var status_style = "";
			if(status=="01"){
				//status_style = "status-req1";
				status_style = "text-attend-doc-status-req1";
			}
	   	 	if(status=="08"){
	   		 	 //status_style = "status-approve";
	   		 	 status_style = "text-attend-doc-status-approved";
			}
			if(status=="09"){
				 //status_style = "status-unapprove";
				 status_style = "text-attend-doc-status-unapproved";
			}
			if(status=="02"){
				//status_style = "status-req2";
				status_style = "text-attend-doc-status-req2";
			}
			if(status=="03"){
				//status_style = "status-req3";
				status_style = "text-attend-doc-status-req3";
			}
			if(status=="10"){
				//status_style = "status-cancel";
				status_style = "text-attend-doc-status-cancel";
				}
			
			return status_style;
		}
		function InitWorkOut()
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
	                	//if(diffDays>30){
	                		if(1 != 1){
	                		Clear();
	                    	HideWaiting();
	                    	ShowErrorMsg('0010',null);
	                	}else
	                		{
	                		 var em_id ='';
	                    	 if(emp_id.selectedIndex >0){
	                    		 em_id =emp_id.value;
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
	        		data["company_id"] = com_id;
	        		
	        		jQuery.ajax({
	        			url : 'member-getmemberworkout',
	        			type : "Post",
	        			contentType : "application/json",
	        			 data: JSON.stringify(data),
	        			dataType : 'json',
	        			success : function(obj) {
	        				if(obj.length>0){
	        				document.getElementById('statusInformation').style.display = "block";	
	        				var str='<ul class="products-list product-list-in-box" >';
	        				$("#txtMaxRow").val(obj.length);
	        				$('#txtEmpType').val(obj[0].emp_type);
	        				
	        				for (var i = 0; i < obj.length; i++) {
	        					 var data_list = {}
	        					 data_list["row"] = i;
	        					 data_list["codempid"] = obj[i].codempid;
	        					 data_list["namempt"] = obj[i].namempt;
	        					 var style_doc =CheckStatusStyle(obj[i].status_approve);
	        					 str=str+'<li class="item ">';
	        					 str=str+'<div class="col-sm-12 col-xs-12">';
	        					 var doc_no =obj[i].doc_no;
	        					 if(obj[i].status !='1' && obj[i].status_approve!='10' ){
	        						 doc_no = '99'+doc_no;
	        					 }
	        					 obj[i].objective = obj[i].objective.replace(/"/g, '');
	        					 console.log(obj[i].trans_id+'|'+obj[i].codempid+'|'+obj[i].namempt+'|'+obj[i].nampost+'|'+obj[i].namcenttha+'|'+obj[i].objective+'|'+obj[i].place+'|'+obj[i].place_flag+'|'+obj[i].start_place+'|'+obj[i].start_date+'|'+obj[i].start_time+'|'+obj[i].end_place+'|'+obj[i].end_date+'|'+obj[i].end_time+'|'+obj[i].private_flag+'|'+obj[i].company_id+'|'+obj[i].doc_no+'|'+obj[i].status_approve+'|'+obj[i].status+'|'+obj[i].approver+'|'+obj[i].approve_status_desc);
	        					 str=str+'<label  class="custom-font-label-thin-small">'+obj[i].codempid+' '+obj[i].namempt+' </label></div>';
	        					 str=str+'<div class = "col-md-1 col-sm-3 col-xs-12"><label class="custom-font-label '+style_doc+' text-center" style="cursor:pointer;"  onclick="EditWorkOut(&quot;'+obj[i].trans_id+'|'+obj[i].codempid+'|'+obj[i].namempt+'|'+obj[i].nampost+'|'+obj[i].namcenttha+'|'+obj[i].objective+'|'+obj[i].place+'|'+obj[i].place_flag+'|'+obj[i].start_place+'|'+obj[i].start_date+'|'+obj[i].start_time+'|'+obj[i].end_place+'|'+obj[i].end_date+'|'+obj[i].end_time+'|'+obj[i].private_flag+'|'+obj[i].company_id+'|'+obj[i].doc_no+'|'+obj[i].status_approve+'|'+obj[i].status+'|'+obj[i].approver+'|'+obj[i].approve_status_desc+'&quot;);">'+doc_no+'</label></div>';
	        					 str=str+'<div class = "col-md-11 col-sm-9 col-xs-12 custom-gap-width" style="padding-top:4px;"><label class="font-thin">'+obj[i].start_date+' '+obj[i].start_time+' - '+obj[i].end_date+' '+obj[i].end_time+'</label></div>';
	        					 str=str+'<div class="col-md-12 col-sm-12 col-xs-12"><i class="glyphicon glyphicon-map-marker"></i>&nbsp;<label class="font-thin" style= padding-top:4px;padding-left:2px;border-radius: 5px;>'+obj[i].place+'</label></div>';
	        					 str=str+'</li>';
	        				 }
	        				  str=str+'</ul>';
	        				 $('#divWorkOut').html(str);
	        				 //InitPluginMain();
	                       HideWaiting();
	        				}else{
	        					HideWaiting();
	        					Clear();
	        	        		HideWaiting();
	        	        		str ='<div style="width:100%;text-align: center;"><label  class="control-label">ไม่พบข้อมูล</label></div>';
	        	        		 $('#divWorkOut').html(str);
	        	        		
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
		


		
	function Clear()
	{
		  $('#divWorkOut').html('');
	} 
	function TimeValidate(sender){
		var select_time =$(sender).val();
		 var re = /^([0-9]|0[0-9]|1[0-9]|2[0-3]).[0-5][0-9]$/;
		 var count =0;
			 var ss_time =select_time.split('.');
				 if(ss_time[0]>23){
					 $(sender).val('');
				 }
				 if(ss_time[1]>59){
					 $(sender).val('');
				}

	        if (!re.test(strat_time)) {
	        	 $(sender).val('');
	        } 
	}
</script>

<div style="background-color: white;">
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
								src="resources/Images/dot.png"
								style="width: 20px; height: 20px;"> </span>
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
											onchange="SetDropDown();" style="width: 100%;"
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
										<spring:message code="member.history.criteria.user" />
									</label>
									<div class="col-sm-6">
										<select id="ddlUser" class="select2"
											data-placeholder="เลือกสมาชิก" style="width: 100%;">
										</select>
									</div>

								</div>
							</div>

							<div class="row">
								<div class="form-group">
									<label class="col-sm-2 control-label"><spring:message
											code="member.worktime.criteria.date" /></label>

									<div class="col-sm-10">
										<input type="text" class="custom-text-horizon-rangdate2"
											maxlength="10" id="txtStartDate"
											data-inputmask="'mask': '99/99/9999'" data-mask
											data-provide="datepicker"> <label
											class="control-label">-</label> <input type="text"
											class="custom-text-horizon-rangdate2" maxlength="10"
											id="txtEndDate" data-inputmask="'mask': '99/99/9999'"
											data-mask data-provide="datepicker">

									</div>

								</div>
							</div>


							<div class="row">
								<div class="form-group">
									<label class="col-sm-2 control-label"></label>
									<div class="col-sm-6">
										<button type="button"
											class="btn btn-info pull-right custom-button"
											onclick="PreWorkOut2();">
											<span class="glyphicon glyphicon-search"></span>&nbsp;
											<spring:message code="member.history.criteria.search" />
										</button>
									</div>
								</div>
							</div>
							<div class="row">
								<div class="col-sm-6">
									<label style="width: 100%;"> </label>
								</div>
							</div>
						</div>

						<!-- /.box-body -->

					</form>

				</div>
			</div>

		</div>
		<div class="nav-tabs" style="padding-bottom: 15px;">
			<div class="row">
				<div class="col-lg-12">
					<div class="box-tools pull-right">
						<span onclick="InitAddWorkOut();" title="Add"
							class="badge custom-button" style="cursor: pointer;"><i
							class="fa fa-plus"></i></span>&nbsp;&nbsp;&nbsp;
					</div>
				</div>
			</div>
		</div>
		<div class="row" style="margin-top: 10px; padding-bottom: 3px;">
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
						<tr>
							<td><label class="text-attend-doc-status-cancel"
								style="cursor: default;"></label>&nbsp;&nbsp;</td>
							<td><label class="custom-font-label-thin custom-font">ยกเลิกรายการ</label></td>
						</tr>
					</table>
				</div>
			</div>
		</div>

		<div class="row">
			<div class="col-sm-12">

				<div id="divWorkOut"></div>
			</div>
		</div>
	</div>



</div>
<!-- Add Dailog -->
<div class="container" style="width: 90%; height: auto;">
	<!-- Modal -->
	<div class="modal fade" id="dlgAddWorkOut" role="dialog"
		style="overflow-y: initial !important">
		<div class="modal-dialog">
			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" id="btnCloseAddDlgWorkout"
						data-dismiss="modal">&times;</button>
					<div class="modal-title">
						<div class="col-sm-12 col-xs-12">
							<label id="lblDlgWorkOutHeadTitle" style="display: none;">C&nbsp;</label>
							<label id="lblDlgWorkOutHead"> <spring:message
									code="member.workout.outsideoperations" /></label>&nbsp;-&nbsp; <label
								id="lblDlgEmpID"></label>&nbsp;<label id="lblDlgName"></label>
						</div>
					</div>

					<div class="modal-title" id="pDlgWorkOutDocNo">
						<div class="col-sm-3 col-xs-6">
							<label>เลขที่เอกสาร</label>
						</div>
						<div class="col-sm-9 col-xs-6" style="padding-left: 0px;">
							<label class="custom-font-label-thin" id="lblDlgDocNoPre"></label>
						</div>
					</div>
					<div class="modal-title" id="pDlgWorkOutDocStatus">
						<div class="col-sm-3 col-xs-6">
							<label>สถานะเอกสาร</label>
						</div>
						<div class="col-sm-9 col-xs-6" style="padding-left: 0px;">
							<label id="lblDlgWorkOutDocStatus"></label>
						</div>
					</div>
					<div class="modal-title" id="pDlgWorkOutDocApprover">
						<div class="col-sm-3 col-xs-6">
							<label><spring:message
									code="member.worktime.dialog.approver" /></label>
						</div>
						<div class="col-sm-9 col-xs-6" style="padding-left: 0px;">
							<label class="custom-font-label-thin"
								id="lblDlgWorkOutDocApprover"></label>
						</div>
					</div>
				</div>

				<div style="height: 100%;">

					<label id="lblDlgCompanyID" style="display: none;"></label> <label
						id="lblDlgTransID" style="display: none;"></label> <label
						id="lblDlgDocNo" style="display: none;"></label> <label
						id="lblDlgStatus" style="display: none;"></label>






					<div class="nav-tabs">
						<div class="box-body">
							<div class="form-group col-md-12 col-sm-12 col-xs-12">
								<label><spring:message code="member.workout.objective" /></label>
								<input type="text" class="form-control" id="txtDlgObjective"
									value="" maxlength="400">
							</div>
							<div class="form-group col-md-12 col-sm-12 col-xs-12">
								<label for="exampleInputPassword1"><spring:message
										code="member.workout.place" /></label> <input type="text"
									class="form-control" id="txtDlgPlace" maxlength="500">
							</div>
							<!--  class="flat-red" -->
							<div class="form-group col-md-12 col-sm-12 col-xs-12">
								<div class="col-md-4 col-sm-4 col-xs-12">
									<label> <input type="radio" class="minimal" name="r3"
										checked id="r1" value="1">&nbsp;<spring:message
											code="member.workout.province" />
									</label>
								</div>
								<div class="col-md-4 col-sm-4 col-xs-12">
									<label> <input type="radio" class="minimal" name="r3"
										id="r2" value="2">&nbsp;<spring:message
											code="member.workout.country" />
									</label>
								</div>
								<div class="col-md-4 col-sm-4 col-xs-12">
									<label> <input type="radio" class="minimal" name="r3"
										id="r3" value="3">&nbsp;<spring:message
											code="member.workout.abroad" />
									</label>
								</div>
							</div>
						</div>
					</div>

					<div class="nav-tabs">
						<div class="box-header">
							<div class="col-md-12 col-sm-12 col-xs-12">
								<label for="exampleInputEmail1"><spring:message
										code="member.workout.travel" /></label>
							</div>
						</div>
						<form class="form-horizontal">

							<div class="box-body ">
								<table width="100%">
									<tr>
										<td>
											<div class="col-md-3 col-sm-12 col-xs-12 label-right"
												style="padding-top: 5px;">
												<i class="glyphicon glyphicon-map-marker"></i> <label><spring:message
														code="member.workout.gobegin" /></label>
											</div>

											<div class="col-md-9 col-sm-12 col-xs-12">
												<input type="text" class="text-horizon"
													id="txtDlgStartPlace" style="width: 90%;" maxlength="50">
											</div>
										</td>

									</tr>

									<tr>
										<td>
											<div class="col-md-3 col-sm-12 col-xs-12 label-right"
												style="margin-top: 7px;">
												&nbsp;&nbsp; <label for="exampleInputEmail1"><spring:message
														code="member.workout.godatetime" /></label>
											</div>
											<div class="col-md-9 col-sm-12 col-xs-12"
												style="margin-top: 5px;">
												<input type="text"
													style="width: 100px; height: 30px; text-align: center;"
													class="text-horizon" maxlength="10"
													data-inputmask="'mask': '99/99/9999'" data-mask
													data-provide="datepicker" id="txtDlgStartDate"
													onchange="InitDiffDay();" /> <input type="text"
													style="width: 100px; height: 30px; text-align: center;"
													id="txtDlgStartTime" data-inputmask="'mask': '99.99'"
													data-mask class="custom-font-label-thin text-cutom-border"
													onkeyup="TimeValidate(this);">
											</div>
										</td>
									</tr>

									<tr>
										<td>
											<div class="col-md-3 col-sm-12 col-xs-12 label-right"
												style="margin-top: 7px;">
												<i class="glyphicon glyphicon-map-marker"></i> <label
													for="exampleInputEmail1"><spring:message
														code="member.workout.retbegin" /></label>
											</div>
											<div class="col-md-9 col-sm-12 col-xs-12"
												style="margin-top: 7px;">
												<input type="text" class="text-horizon" id="txtDlgEndPlace"
													style="width: 90%;" maxlength="50">
											</div>
										</td>

									</tr>
									<tr>
										<td>
											<div class="col-md-3 col-sm-12 col-xs-12 label-right"
												style="margin-top: 7px;">
												&nbsp;&nbsp; <label for="exampleInputEmail1"><spring:message
														code="member.workout.retdatetime" /></label>
											</div>
											<div class="col-md-9 col-sm-12 col-xs-12"
												style="margin-top: 5px;">
												<input type="text"
													style="width: 100px; height: 30px; text-align: center;"
													class="text-horizon" maxlength="10"
													data-inputmask="'mask': '99/99/9999'" data-mask
													data-provide="datepicker" id="txtDlgEndDate"
													onchange="InitDiffDay();" /> <input type="text"
													style="width: 100px; height: 30px; text-align: center;"
													id="txtDlgEndTime" data-inputmask="'mask': '99.99'"
													data-mask class="custom-font-label-thin text-cutom-border"
													onkeyup="TimeValidate(this);">
											</div>
										</td>
									</tr>
								</table>
								<div class="row">
									<div class="col-sm-12"></div>
								</div>
								<div class="row" style="padding-top: 7px;">
									<div class="col-sm-12"></div>
								</div>

							</div>
						</form>
						<form class="form-horizontal">
							<div class="box-body ">
								<div class="row">
									<div class="col-sm-12"></div>
								</div>
								<div class="row" style="padding-top: 7px;">
									<div class="col-sm-12">&nbsp;&nbsp;&nbsp;&nbsp;</div>
								</div>

							</div>
						</form>

					</div>
					<div class="nav-tabs">
						<form class="form-horizontal">
							<div class="box-body ">
								<div class="row">
									<div class="col-md-12 col-sm-12 col-xs-12">
										&nbsp;&nbsp;<label id="lblDlgDayNum" style="display: none;"></label>&nbsp;&nbsp;
										<label class="pull-right"><input id="chkPrivate"
											type="checkbox" class="minimal">&nbsp;ใช้รถยนต์ส่วนตัว</label>
									</div>
								</div>
							</div>
						</form>
					</div>
				</div>

				<div class="modal-footer">
					<button type="button" class="btn custom-button pull-left"
						id="btnCancelWorkOut" onclick="SaveWorkOut('C');">
						&nbsp;
						<spring:message code="center.cancel" />
					</button>
					<button type="button" class="btn custom-button pull-right"
						id="btnSaveWorkOut" onclick="SaveWorkOut('S');">
						&nbsp;
						<spring:message code="center.save" />
					</button>
				</div>

			</div>
		</div>
	</div>
</div>

<script> //Add WorkOut
function InitDiffDay(){
	var count_datetime = 0;
	if($("#txtDlgStartDate").val() != null && $("#txtDlgStartDate").val()){
		count_datetime++;
	}
	if($("#txtDlgEndDate").val() != null && $("#txtDlgEndDate").val()){
		count_datetime++;
	}
	if(count_datetime==2){
	 var start_date =$("#txtDlgStartDate").val();
     var end_date =$("#txtDlgEndDate").val();
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
     start_date = res_start[2] + '' + res_start[1] + '' + res_start[0];
     
     if (res_end[0].length == 1) {
     	res_end[0] = '0' + res_end[0];
     }
     if (res_end[1].length == 1) {
     	res_end[1] = '0' + res_end[1];
     }
     if (res_end[2] > 2500) {
     	res_end[2] = res_end[2] - 543;
     }
     end_date = res_end[2] + '' + res_end[1] + '' + res_end[0];
     
     var start_diff =(parseInt(start_date)) ;
		var end_diff = (parseInt(end_date)) ;
		var day_diff = end_diff-start_diff;
		
		$('#lblDlgDayNum').html(day_diff);
		
	}
}
function InitAddWorkOut(){
	try{
		$('#pDlgWorkOutDocNo').hide();
		$('#pDlgWorkOutDocStatus').hide();
		$('#pDlgWorkOutDocApprover').hide();
		$('#lblDlgTransID').html('');
		$('#divDlgDocNo').hide();
		$('#lblDlgEmpID').html('');
		$('#lblDlgName').html('');
		$('#lblDlgPosition').html('');
		$('#lblDlgLocation').html('');
		$('#txtDlgObjective').val('');
		$('#txtDlgPlace').val('');
		$('#txtDlgStartPlace').val('');
		$('#txtDlgStartDate').val('');
		$('#txtDlgStartTime').val('');
		$('#txtDlgEndPlace').val('');
		$('#txtDlgEndDate').val('');
		$('#txtDlgEndTime').val('');
		$('#lblDlgCompanyID').html('');
		$('#lblDlgDocNo').html('');
		$('#lblDlgStatus').html('');
		$('#lblDlgDocNoPre').html('');
		$('#chkPrivate').iCheck('uncheck');
		 $("#btnCancelWorkOut" ).prop( "disabled", true );
		 $("#btnSaveWorkOut" ).prop( "disabled", false );
		document.getElementById('lblDlgWorkOutHeadTitle').style.display = "none";
		 
		//set disabled fields
			$("#txtDlgObjective" ).prop( "disabled", false );
			$("#txtDlgPlace" ).prop( "disabled", false );
			$("#r1" ).prop( "disabled", false );
			$("#r2" ).prop( "disabled", false );
			$("#r3" ).prop( "disabled", false );
			//document.getElementById('r1').disabled = false;
			$("#txtDlgStartPlace" ).prop( "disabled", false );
			$("#txtDlgStartDate" ).prop( "disabled", false );
			$("#txtDlgStartTime" ).prop( "disabled", false );
			$("#txtDlgEndPlace" ).prop( "disabled", false );
			$("#txtDlgEndDate" ).prop( "disabled", false );
			$("#txtDlgEndTime" ).prop( "disabled", false );
			$("#chkPrivate" ).prop( "disabled", false ); 
			
		var emp_id = document.getElementById('ddlUser');
		 if(emp_id.selectedIndex >0){
			 em_id =emp_id.value;
			  var data = {}
				data["codempid"] = emp_id.value;
				jQuery.ajax({
					url : 'member-getmemberprofile',
					type : "Post",
					contentType : "application/json",
					 data: JSON.stringify(data),
					dataType : 'json',
					success : function(obj) {
						 $('#lblDlgEmpID').html(emp_id.value);
						 $('#lblDlgName').html(obj.namempt);
						 $('#lblDlgPosition').html(obj.nampost);
						 $('#lblDlgLocation').html(obj.namcenttha);
						 $('#lblDlgCompanyID').html(obj.codcomp);
							 $('#dlgAddWorkOut').modal({backdrop: 'static', keyboard: false})  ;
					},
					error : function() {
						HideWaiting();
						ShowErrorConnectMessage();
					}
				});
		 }else{
			 ShowErrorMsg('0022',null);
		 }
	}
	catch(ex)
	{
		HideWaiting();
		ShowErrorMsg('0006',ex);
	}
}
</script>
<script>//EditWorkOut
	function EditWorkOut(x){
	var res =x.split('|');
	var isDisabled = false;
	$('#pDlgWorkOutDocNo').show();
	$('#pDlgWorkOutDocStatus').show();
	$('#pDlgWorkOutDocApprover').show();
	
		$('#lblDlgTransID').html(res[0]);
		$('#divDlgDocNo').show();
		$('#lblDlgEmpID').html(res[1]);
		$('#lblDlgName').html(res[2]);
		$('#lblDlgPosition').html(res[3]);
		$('#lblDlgLocation').html(res[4]);
		$('#txtDlgObjective').val(res[5]);
		$('#txtDlgPlace').val(res[6]);
		$('#txtDlgStartPlace').val(res[8]);
		$('#txtDlgStartDate').val(res[9]);
		$('#txtDlgStartTime').val(res[10]);
		$('#txtDlgEndPlace').val(res[11]);
		$('#txtDlgEndDate').val(res[12]);
		$('#txtDlgEndTime').val(res[13]);
		$('#lblDlgCompanyID').html(res[15]);
		$('#lblDlgDocNo').html(res[16]);
		$('#lblDlgStatus').html(res[17]);
		$('#lblDlgDocNoPre').html(res[16]);
		$('#lblDlgWorkOutDocStatus').html(res[20]);
		$('#lblDlgWorkOutDocApprover').html(res[19]);
		if(res[18]!='1' && res[17]!='10'){
			$('#lblDlgDocNoPre').html('99'+res[16]);
		}
		if((res[17]=="01" || res[17]=="02") && res[18]!='1') {
			//alert("in case");
			document.getElementById('lblDlgWorkOutHeadTitle').style.display="inline";
		} else document.getElementById('lblDlgWorkOutHeadTitle').style.display="none";
		
		if(res[17]!="01" || res[18]=="0") {
			//alert("in case"); 
			isDisabled = true;
			$('#r1').iCheck('disable');
			$('#r2').iCheck('disable');
			$('#r3').iCheck('disable'); 
		} else {
			isDisabled = false;
			$('#r1').iCheck('enable');
			$('#r2').iCheck('enable');
			$('#r3').iCheck('enable'); 
		}
		
		//set disabled fields
		$("#txtDlgObjective" ).prop( "disabled", isDisabled );
		$("#txtDlgPlace" ).prop( "disabled", isDisabled );
		$("#txtDlgStartPlace" ).prop( "disabled", isDisabled );
		$("#txtDlgStartDate" ).prop( "disabled", isDisabled );
		$("#txtDlgStartTime" ).prop( "disabled", isDisabled );
		$("#txtDlgEndPlace" ).prop( "disabled", isDisabled );
		$("#txtDlgEndDate" ).prop( "disabled", isDisabled );
		$("#txtDlgEndTime" ).prop( "disabled", isDisabled );
		$("#chkPrivate" ).prop( "disabled", isDisabled );
		
		var class_doc='';
		 if(res[17]=="01"){
				class_doc = "text-attend-doc-status-reqp1";
				}
		 	 if(res[17]=="08"){
		 		 class_doc = "text-attend-doc-status-papproved";
						}
			if(res[17]=="09"){
			class_doc = "text-attend-doc-status-punapproved";
				}
			if(res[17]=="02"){
				class_doc = "text-attend-doc-status-reqp2";
				}
			if(res[17]=="03"){
				class_doc = "text-attend-doc-status-reqp3";
				}
		document.getElementById("lblDlgWorkOutDocStatus").className = class_doc;

		if(res[7]==1){
			$('#r1').iCheck('check');
		var radiobtn1 = document.getElementById("r1");
		radiobtn1.checked = true;
		}
		if(res[7]==2){
			$('#r2').iCheck('check');
			var radiobtn2 = document.getElementById("r2");
			radiobtn2.checked = true;
			}
		if(res[7]==3){
			$('#r3').iCheck('check');
			var radiobtn3 = document.getElementById("r3");
			radiobtn3.checked = true;
			}
		if(res[14]=='Y'){
			$('#chkPrivate').iCheck('check');
		}else{
			$('#chkPrivate').iCheck('uncheck');
		}
		if(res[18]=='0'){
			 if(res[17]=='01' || res[17]=='10'){
				 $("#btnCancelWorkOut" ).prop( "disabled", true );
				 $("#btnSaveWorkOut" ).prop( "disabled", true );
			 }else{
				 $("#btnCancelWorkOut" ).prop( "disabled", true );
				 $("#btnSaveWorkOut" ).prop( "disabled", true );
			 }
		}else{
			 if(res[17]=='01'){
			 $("#btnCancelWorkOut" ).prop( "disabled", false );
			 $("#btnSaveWorkOut" ).prop( "disabled", false );
			 } else if(res[17]=='08') {
				 $("#btnCancelWorkOut" ).prop( "disabled", false );
				 $("#btnSaveWorkOut" ).prop( "disabled", true );
			 } else{
				 $("#btnCancelWorkOut" ).prop( "disabled", true );
				 $("#btnSaveWorkOut" ).prop( "disabled", true );
			 }
		}
		InitDiffDay();
		 $('#dlgAddWorkOut').modal({backdrop: 'static', keyboard: false})  ;
	}
</script>
<script>
	function SaveWorkOut(x)
	{
		try
		{
		ShowWaiting();
		var count_datetime = 0;
		if($("#txtDlgStartDate").val() != null && $("#txtDlgStartDate").val()){
			count_datetime++;
		}
		if($("#txtDlgEndDate").val() != null && $("#txtDlgEndDate").val()){
			count_datetime++;
		}
		if($("#txtDlgStartTime").val() != null && $("#txtDlgStartTime").val()){
			count_datetime++;
		}
		if($("#txtDlgEndTime").val() != null && $("#txtDlgEndTime").val()){
			count_datetime++;
		}
	   if(count_datetime==4){
       var start_time =$("#txtDlgStartTime").val();
       var res_start_time =start_time.split('.');
       var end_time =$("#txtDlgEndTime").val();
       var res_end_time =end_time.split('.');
       
       var start_date =$("#txtDlgStartDate").val();
       var end_date =$("#txtDlgEndDate").val();

       
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
       start_date = res_start[2] + '' + res_start[1] + '' + res_start[0];
       
       if (res_end[0].length == 1) {
       	res_end[0] = '0' + res_end[0];
       }
       if (res_end[1].length == 1) {
       	res_end[1] = '0' + res_end[1];
       }
       if (res_end[2] > 2500) {
       	res_end[2] = res_end[2] - 543;
       }
       end_date = res_end[2] + '' + res_end[1] + '' + res_end[0];
       var start_date_db=res_start[0] + '/' + res_start[1] + '/' + res_start[2];
       var end_date_db=res_end[0] + '/' + res_end[1] + '/' + res_end[2];
      var n_s_date = parseInt(start_date);
      var n_e_date = parseInt(end_date);
      var n_s_time = parseInt(s_date);
      var n_e_time = parseInt(e_date);
     var check=0;
       if(n_e_date < n_s_date){
    	   HideWaiting();
    	   ShowErrorMsg('0009',null);
       }else{
    	   if(n_e_date == n_s_date){
    		   if(n_e_time <=n_s_time){
    			   check++;
    			   HideWaiting();
    			   ShowErrorMsg('0009',null);
    	       }
    		  
    	   }
    	  
    	   if(check==0){
    		   if($("#txtDlgObjective").val() != null && $("#txtDlgObjective").val() != ''){
       		  	 if($("#txtDlgPlace").val() != null && $("#txtDlgPlace").val() != ''){
       		  		 if($("#txtDlgStartPlace").val() != null && $("#txtDlgStartPlace").val() != ''){
	 	       			
	       		  		 if($("#txtDlgEndPlace").val() != null && $("#txtDlgEndPlace").val() != ''){
	       		  			 
	       		  			/* var valid_start_time =start_date+''+ res_start_time[0]+''+res_start_time[1];
	       		  			 var valid_end_time = end_date+''+res_end_time[0]+''+res_end_time[1];
	       		  			 alert(valid_start_time);
	       		  			 alert(valid_end_time);
	       		  			 var valid_hour = parseInt(valid_end_time) - parseInt(valid_start_time);
	       		  			 alert(valid_hour);
	       		  			 if(valid_hour >= 180){*/
	       		  				 
	       		  			
	       			         
		       		  		var data = {}
		       		  		data["trans_id"] = $("#lblDlgTransID").html();
		       		  		data["doc_no"]=$('#lblDlgDocNo').html();
			       			data["codempid"] = $("#lblDlgEmpID").html();
			       			data["company_id"] = $("#lblDlgCompanyID").html();
			       			data["objective"] = $("#txtDlgObjective").val();
			       			data["place"] = $("#txtDlgPlace").val();
			       			data["start_place"] = $("#txtDlgStartPlace").val();
			       			data["end_place"] = $("#txtDlgEndPlace").val();
			       			data["start_date"] = start_date_db;
			       			data["end_date"] = end_date_db;
			       			data["start_time"] = res_start_time[0]+':'+res_start_time[1];
			       			data["end_time"] = res_end_time[0]+':'+res_end_time[1];
			       			data["day_qty"] = parseInt($('#lblDlgDayNum').html());
			       			data["save_case"] = x;
			       			data["status"] = $('#lblDlgStatus').html();
	    	       			if (document.getElementById('r1').checked) {
	    	       			  data["place_flag"] = document.getElementById('r1').value;
	    	       			}
	    	       			else if (document.getElementById('r2').checked) {
	    	       			  data["place_flag"] = document.getElementById('r2').value;
	    	       			}
	    	       			else {
	    	       			  data["place_flag"] = document.getElementById('r3').value;
	    	       			}
	    	       			
	    	       			if (document.getElementById('chkPrivate').checked) {
	    	       			  data["private_flag"] = "Y";
	    	       			}else {
	    	       				data["private_flag"] = "N";}
	    	       			
	    	       			var i_check_spe =0;
	    	       			if(ValidateSpecialChar($("#txtDlgObjective").val())){
	    	       				i_check_spe++;
		       		  		}
	    	       			if(ValidateSpecialChar($("#txtDlgPlace").val())){
	    	       				i_check_spe++;
		       		  		}
	    	       			if(ValidateSpecialChar($("#txtDlgStartPlace").val())){
	    	       				i_check_spe++;
		       		  		}
	    	       			if(ValidateSpecialChar($("#txtDlgEndPlace").val())){
	    	       				i_check_spe++;
		       		  		}
	    	       			
// 	    	       			alert("trans_id : "+$("#lblDlgTransID").html()+"  doc_no : "+$('#lblDlgDocNo').html()+" codempid : "+$("#lblDlgCompanyID").html()
// 	    	       					+" objective : "+$("#txtDlgObjective").val()+" place : "+$("#txtDlgPlace").val()+" start_place : "+$("#txtDlgStartPlace").val()
// 	    	       					+" end_place : "+$("#txtDlgEndPlace").val()+" start_date : "+start_date_db+"  end_date : "+end_date_db+" start_time : "+res_start_time[0]+':'+res_start_time[1]
// 	    	       					+" end_time : "+res_end_time[0]+':'+res_end_time[1]+" day_qty : "+x+"  status : "+$('#lblDlgStatus').html());
	    	       			
	    	       			
	    	       			if(i_check_spe == 0){
			       			jQuery.ajax({
			       				url : 'member-insertworkout',
			       				type : "Post",
			       				contentType : "application/json",
			       				data: JSON.stringify(data),
			       				dataType : 'json',
			       				success : function(obj) {
// 			       					alert("obj.success >> "+obj.success);
			       					HideWaiting();
			       					if(obj.success==1){
			       						$("#btnCloseAddDlgWorkout").click();
				       					ShowSuccessMsg('0003',obj.message);
				       					InitWorkOut();
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
	       		  			// }else{
	       		  		//	HideWaiting();
		         			 //ShowErrorMsg('0031',null); 
	       		  			 //}
	         			}
	         			else{
	         			 HideWaiting();
	         			 ShowErrorMsg('0026',null);
	         			}
     	       		
        			}
        			else{
        			 HideWaiting();
        			 ShowErrorMsg('0025',null);
        			}
	       		
       			}
       			else{
       			 HideWaiting();
       			 ShowErrorMsg('0024',null);
       			}
       			
       	   }else{
       		   HideWaiting();
       		 ShowErrorMsg('0023',null);
       	   }
    	   }
    	  
	
       	}
	   }else{
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
</script>


