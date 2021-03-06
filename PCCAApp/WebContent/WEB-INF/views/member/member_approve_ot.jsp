<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<script>
$(document).ready(
		function() {
			try
			{
				
			ShowWaiting();
			SetDropDownCompany();
			
			$('#iconInformation').popover({
				html: true,
				content: function(){
					return $('#ShowStatusInformation').html();
				}
			});
			
			$('input[id="selectAll"]').on('ifChecked', function(event){
				//$('input[type="checkbox"]', '#divApproveEditTime').prop('checked', true);
				$('.minimal2').iCheck('check');
				});
			
			$('input[id="selectAll"]').on('ifUnchecked', function(event){
                    //$('input[type="checkbox"]', '#divApproveEditTime').prop('checked', false);
				$('.minimal2').iCheck('uncheck');
				});
			
			
			
			}catch(ex)
			{
				HideWaiting();
				ShowErrorMsg('0006',ex);
			}
			
		});
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
		             select.appendChild(opt);
		         }
			},
			error : function() {
				HideWaiting();
				ShowErrorConnectMessage();
			}
		});
	
     
		SetDropDownDocStatus();
	}catch(ex)
	{
		HideWaiting();
		ShowErrorMsg('0006',ex);
	}
	
	 
     
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
				 $('#ddlCompany') .find('option').remove().end();
		         var select = document.getElementById('ddlCompany');
		         for (var i = 0; i < obj.length; i++) {
		             var opt = document.createElement('option');
		             opt.value = obj[i].ddl_value;
		             opt.innerHTML = obj[i].ddl_text;
		             select.appendChild(opt);
		         }
		         SetDropDown();
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
	function SetDropDownDocStatus()
	{
		try
		{
         jQuery.ajax({
				url : 'util-getdocumentstatus',
				type : "Post",
				contentType : "application/json",
				dataType : 'json',
				success : function(obj) {
					 $('#ddlDocStatus') .find('option').remove().end();
			         var select = document.getElementById('ddlDocStatus');
			         for (var i = 0; i < obj.length; i++) {
			             var opt = document.createElement('option');
			             
			             opt.value = obj[i].ddl_value;
			             opt.innerHTML = obj[i].ddl_text;
						 select.appendChild(opt);
						if(obj[i].ddl_value=='11'){
							//alert(obj[i].ddl_value);
							//$('#ddlDocStatus>option:eq('+obj[i].ddl_value+')').attr('selected', true);
							opt.selected =true;
						}
			         }
			         PreWorkTime();
			        
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
	
	function PreWorkTime()
	{
		try
		{
		
			InitApproveEditTime();
		}
		catch(ex)
		{
			HideWaiting();
			ShowErrorMsg('0006',ex);
		}
	}
	function PreWorkTime2()
	{
		try
		{
			$("#divSelectAll").show();
   		 $("#divButton").show();
			ShowWaiting();
			InitApproveEditTime();
		}
		catch(ex)
		{
			HideWaiting();
			ShowErrorMsg('0006',ex);
		}
	}
	function InitApproveEditTime()
	{
		var emp_id = document.getElementById('ddlUser');
		var company_id = document.getElementById('ddlCompany');
    
		var doc_status = document.getElementById('ddlDocStatus');
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
                 }
        	}
        }
               
                if(check_valid==0){
                	 var com_id ='';
                	 var docq_status ='';
                	 var em_id ='';
                	 if(emp_id.selectedIndex >0){
                		 em_id =emp_id.value;
                	 }
                	 if(company_id.selectedIndex >0){
                		 com_id =company_id.value;
                	 }
                	 if(doc_status.selectedIndex >0){
                		 docq_status =doc_status.value;
                	 }
                	  var data = {}
              		data["codempid"] = em_id;
              		data["start_date"] = start_date_db;
              		data["end_date"] = end_date_db;
              		data["company_id"] = com_id;
              		data["status"] = docq_status;
              		var i_check=0;
              		jQuery.ajax({ 
            			url : 'member-getmemberworktime-ot-approve',
            			type : "Post",
            			contentType : "application/json",
            			 data: JSON.stringify(data),
            			dataType : 'json',
            			success : function(obj) {
            				if(obj.length>0){
            					document.getElementById('statusInformation').style.display = "block";
                				var str='<ul class="products-list product-list-in-box">';
                				 for (var i = 0; i < obj.length; i++) {
                					 if(obj[i].case_doc=='10') continue;
                					 
                					 var ot_desc = ''+obj[i].ot1_h+','+obj[i].ot15_h+','+obj[i].ot2_h+','+obj[i].ot3_h+'';
                					 str =str+'<li class="item" style="border-bottom:1px solid; border-color:#A09488">';
                					 if(obj[i].curr_status =='Y' && (obj[i].case_doc=='1'||obj[i].case_doc=='2'||obj[i].case_doc=='3')){
                						 str =str+'<input type="text" id="txtTransID'+i_check+'" style="display:none;" class="custom-text-horizon" value="'+obj[i].trans_id+'">';
                					 }else{
                						 str =str+'<input type="text"  style="display:none;" class="custom-text-horizon" value="'+obj[i].trans_id+'">';
                					 }
                					 str=str+'<div class="row" style="padding-left: 20px;line-height: 3px;">';
                					 str=str+' <input type="text" style="display:none;" id="txtShiftStartDate" value="'+obj[i].dtestrtw+'">';
                					 str=str+' <input type="text" style="display:none;" id="txtShiftStartTime"  value="'+obj[i].timstrtw+'" > ';
                					 str=str+' <input type="text" style="display:none;" id="txtShiftEndDate" value="'+obj[i].dteendw+'">';
                					 str=str+' <input type="text" style="display:none;" id="txtShiftEndTime"  value="'+obj[i].timendw+'" > ';
                					 str=str+'</div>';
                					
                					 str =str+'<div class="row custom-status-list">';
                					 str =str+'<table class="col-md-8 col-sm-12 col-xs-12">';
                					 
                					 str =str+'<tr><td rowspan="7" width="5%">';
                					 if(obj[i].curr_status =='Y' && (obj[i].case_doc=='1'||obj[i].case_doc=='2'||obj[i].case_doc=='3')){
                						 str =str+'&nbsp;<input  type="checkbox" class="minimal2"  id="chk'+i_check+'" />';
                					 }else{
                						 str =str+'&nbsp;';
                					 }
                					 str =str+'</td>';
                					 str =str+'<td colspan="3">';
                					 str =str+'<div class="col-sm-12 col-xs-12"><label  class="custom-font-label-thin">'+obj[i].codempid+'&nbsp;'+obj[i].namempt+'</label>';
                					 str =str+'</div>';
                					 str =str+'<div class="col-sm-12 col-xs-12">';
                					 str =str+'<label class="custom-font-label-thin">'+obj[i].namcenttha+'</label>';
                					 str =str+'</div></td>';
                					 str =str+'</tr>';
                					 str =str+'<tr><td colspan="3"><div class="col-sm-12 col-xs-12">';
                					 if(obj[i].typwork=="T" || obj[i].typwork=="H") {
                					 	str =str+'<div style="float: left; color:red;"><i class="glyphicon glyphicon-star"></i>&nbsp;</div>';
                					 }
                					 
                					 str =str+'<label class="custom-font-label-thin">วัน'+obj[i].short_date+'</label>&nbsp;';
                					 if(obj[i].typwork=="T" && obj[i].holiday_desc.length>0) {
                					 	str =str+'<label class="custom-font-label-thin">('+obj[i].holiday_desc+')</label>';
                					 }
                					 str =str+'</div></td></tr><tr>';
                					 //str =str+'<td colspan="3"><div class="col-sm-3 col-xs-12" style="vertical-align: middle;" >'; 
                					 str =str+'<td colspan="3"><div class="col-sm-3 col-xs-6" style="vertical-align: middle;" >'; 
                					
                					 if(obj[i].case_doc=='1'){
                						 str =str+'<label class="custom-font-label-thin text-approve-doc-status-req" onclick="ShowRequest(&quot;'+obj[i].codempid+'|'+obj[i].namempt+'|'+obj[i].trans_id+'|'+obj[i].start_date+'|'+obj[i].start_time+'|'+obj[i].end_date+'|'+obj[i].end_time+'|'+obj[i].dtein+'|'+obj[i].timin+'|'+obj[i].dteout+'|'+obj[i].timout+'|'+obj[i].leave_desc+'|'+obj[i].remark+'|'+ot_desc+'|'+obj[i].namcenttha+'|'+obj[i].nampost+'|'+obj[i].dtestrtw+'|'+obj[i].timstrtw+'|'+obj[i].dteendw+'|'+obj[i].timendw+'|'+obj[i].typwork+'|'+obj[i].short_date+'|'+obj[i].holiday_desc+'&quot;);" >'+obj[i].trans_id+'</label>';
                					 }
                					 if(obj[i].case_doc=='2'){
                						 str =str+'<label class="custom-font-label-thin text-approve-doc-status-req" onclick="ShowRequest(&quot;'+obj[i].codempid+'|'+obj[i].namempt+'|'+obj[i].trans_id+'|'+obj[i].start_date+'|'+obj[i].start_time+'|'+obj[i].end_date+'|'+obj[i].end_time+'|'+obj[i].dtein+'|'+obj[i].timin+'|'+obj[i].dteout+'|'+obj[i].timout+'|'+obj[i].leave_desc+'|'+obj[i].remark+'|'+ot_desc+'|'+obj[i].namcenttha+'|'+obj[i].nampost+'|'+obj[i].dtestrtw+'|'+obj[i].timstrtw+'|'+obj[i].dteendw+'|'+obj[i].timendw+'|'+obj[i].typwork+'|'+obj[i].short_date+'|'+obj[i].holiday_desc+'&quot;);" >'+obj[i].trans_id+'</label>';
                					 }
                					 if(obj[i].case_doc=='3'){
                						 str =str+'<label class="custom-font-label-thin text-approve-doc-status-req" onclick="ShowRequest(&quot;'+obj[i].codempid+'|'+obj[i].namempt+'|'+obj[i].trans_id+'|'+obj[i].start_date+'|'+obj[i].start_time+'|'+obj[i].end_date+'|'+obj[i].end_time+'|'+obj[i].dtein+'|'+obj[i].timin+'|'+obj[i].dteout+'|'+obj[i].timout+'|'+obj[i].leave_desc+'|'+obj[i].remark+'|'+ot_desc+'|'+obj[i].namcenttha+'|'+obj[i].nampost+'|'+obj[i].dtestrtw+'|'+obj[i].timstrtw+'|'+obj[i].dteendw+'|'+obj[i].timendw+'|'+obj[i].typwork+'|'+obj[i].short_date+'|'+obj[i].holiday_desc+'&quot;);" >'+obj[i].trans_id+'</label>';
                					 }
                					 if(obj[i].case_doc=='8'){
                						 str =str+'<label class="custom-font-label-thin text-approve-doc-status-approved" onclick="ShowRequest(&quot;'+obj[i].codempid+'|'+obj[i].namempt+'|'+obj[i].trans_id+'|'+obj[i].start_date+'|'+obj[i].start_time+'|'+obj[i].end_date+'|'+obj[i].end_time+'|'+obj[i].dtein+'|'+obj[i].timin+'|'+obj[i].dteout+'|'+obj[i].timout+'|'+obj[i].leave_desc+'|'+obj[i].remark+'|'+ot_desc+'|'+obj[i].namcenttha+'|'+obj[i].nampost+'|'+obj[i].dtestrtw+'|'+obj[i].timstrtw+'|'+obj[i].dteendw+'|'+obj[i].timendw+'|'+obj[i].typwork+'|'+obj[i].short_date+'|'+obj[i].holiday_desc+'&quot;);" >'+obj[i].trans_id+'</label>';
                					 }
                					 if(obj[i].case_doc=='9'){
                						 str =str+'<label class="custom-font-label-thin text-approve-doc-status-unapproved" onclick="ShowRequest(&quot;'+obj[i].codempid+'|'+obj[i].namempt+'|'+obj[i].trans_id+'|'+obj[i].start_date+'|'+obj[i].start_time+'|'+obj[i].end_date+'|'+obj[i].end_time+'|'+obj[i].dtein+'|'+obj[i].timin+'|'+obj[i].dteout+'|'+obj[i].timout+'|'+obj[i].leave_desc+'|'+obj[i].remark+'|'+ot_desc+'|'+obj[i].namcenttha+'|'+obj[i].nampost+'|'+obj[i].dtestrtw+'|'+obj[i].timstrtw+'|'+obj[i].dteendw+'|'+obj[i].timendw+'|'+obj[i].typwork+'|'+obj[i].short_date+'|'+obj[i].holiday_desc+'&quot;);" >'+obj[i].trans_id+'</label>';
                					 }
                					 //if(obj[i].case_doc=='10'){
                					//	 str =str+'<label class="custom-font-label-thin text-approve-doc-status-canceled" onclick="ShowRequest(&quot;'+obj[i].codempid+'|'+obj[i].namempt+'|'+obj[i].trans_id+'|'+obj[i].start_date+'|'+obj[i].start_time+'|'+obj[i].end_date+'|'+obj[i].end_time+'|'+obj[i].leave_desc+'|'+obj[i].remark+'|'+ot_desc+'&quot;);" >'+obj[i].trans_id+'</label>';
                					 //} for canceled document
                					 str =str+'</div><div class="col-xs-6" style="padding-top:3px;">';
                					 //str =str+'</div><div style="float: left;padding-top:5px; padding-left:15px;">';
                					 str =str+'<label class="custom-font-label-thin">'+obj[i].dtein+'</label>';	 
                					 str =str+'</div></td></tr>';
                					 str =str+'<tr><td colspan="3"><div class="col-sm-12 col-xs-12">';
                					 str =str+'<label class="font-bold">OT1:</label>&nbsp;<label class="custom-font-label-thin">'+obj[i].ot1_h+'</label>&nbsp;&nbsp;&nbsp;';
                					 str =str+'<label class="font-bold">OT1.5:</label>&nbsp;<label class="custom-font-label-thin">'+obj[i].ot15_h+'</label><br/>';
                					 str =str+'<label class="font-bold">OT2:</label>&nbsp;<label class="custom-font-label-thin">'+obj[i].ot2_h+'</label>&nbsp;&nbsp;&nbsp;';
                					 str =str+'<label class="font-bold">OT3:</label>&nbsp;<label class="custom-font-label-thin">'+obj[i].ot3_h+'</label>';
                					 str =str+'</div></td></tr>'
                					 str =str+'<tr><td><div style="height: 10px;"></div>';
                					 str =str+'<tr><td colspan="3"><div class="col-sm-3 col-xs-12">';
                					 str =str+'<label><spring:message code="member.worktime.dialog.detail"/></label></div>';
                					 str =str+'<div class="col-sm-9 col-xs-12"><label class="custom-font-label-thin">'+obj[i].remark+'</label>';
          							 str =str+'</div></td></tr><tr><td colspan="3">';
                					 str =str+'<div class="col-sm-3 col-xs-12">';
                					 str =str+'<label>';
                					 str =str+'<spring:message code="member.worktime.data.remark"/>';
                					 str =str+'</label></div>';
                					 str= str+'<div class="col-sm-9 col-xs-12">';
                					 if(obj[i].curr_status =='Y' && (obj[i].case_doc=='1'||obj[i].case_doc=='2'||obj[i].case_doc=='3')){
                						 str =str+'<input type="text" id="txtRemark'+i_check+'" style="width:90%;height: 25px;" class="form-control" maxlength="200" >'; //maxlength change from 1500 to 200
                						 i_check++;
                					 }else{
                						 str =str+'<input type="text"  style="width:90%;height: 25px;" class="form-control" disabled>';
                					 }
                					 
                					 str =str+'</div></td></tr></table>';
                					 str =str+'</li>';
                				 }
                				 
                				 str =str+'</ul>';
                				 $('#divApproveEditTime').html(str);
                				 HideWaiting();
                				 InitPluginMain();
                               	 
            				}
            				else
            					{
            					Clear();
            	        		HideWaiting();
            	        		 $("#divSelectAll").hide();
            	        		 $("#divButton").hide();
            	        		str ='<div style="width:100%;text-align: center;"><label  class="control-label">ไม่พบข้อมูล</label></div>';
            	        		 $('#divApproveEditTime').html(str);
            					}
            			},
            			error : function() {
            				HideWaiting();
            				ShowErrorConnectMessage();
            			}
            		 });
            
                }
        		
	}
	
	function Clear()
	{
		  $('#divApproveEditTime').html('');
	}
	function Approve(x)
	{
		ShowWaiting();
		var count =0;
		var count_id =0;
		var trans_id='';
		var remark='';
		  $.each($('#divApproveEditTime input[type="checkbox"]'), function (index, value) {
              var item_id = $(this).attr('id');
              var status = 1;
              var lfckv = document.getElementById(item_id).checked;
              if (lfckv) {
            	  
            	 // if(document.getElementById(item_id).style.display != 'none'){
						 if(count==0){
							 trans_id = $("#txtTransID"+count_id+"").val();
							 remark =$("#txtRemark"+count_id+"").val();
						 }else{
							 trans_id =trans_id+','+ $("#txtTransID"+count_id+"").val();
							 remark =remark+','+$("#txtRemark"+count_id+"").val();
						 }
		                  count++;
            	//}
              }
              count_id++;
          });
      if(count >0){
    	  var data = {}
 			data["trans_id"] = trans_id;
 			data["remark"] = remark;
 			data["status"] = x;
			
 			 var i_check_spe =0;
 			if(ValidateSpecialChar(remark)){
 				i_check_spe++;
		  		}
		 	if(i_check_spe == 0){
		 			jQuery.ajax({
		 				url : 'member-updateworktimeot',
		 				type : "Post",
		 				contentType : "application/json",
		 				data: JSON.stringify(data),
		 				dataType : 'json',
		 				success : function(obj) {
		 					PreWorkTime2();
		 					HideWaiting();
		 					if(obj.success==1){
		 					ShowSuccessMsg('0003',obj.message);
		 					PreWorkTime();
		 					InitMenuMain();
		 					}else{
		 						ShowErrorMsg('0002',obj.message);
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
    	ShowErrorMsg('0014',null);
      }
	}
	function ShowRequest(obj)
	{
		var res = obj.split('|');
		var ot_res = res[13].split(',');
		//edit here
		var date_in_real ='';
		var time_in_real ='&nbsp;____&nbsp;';
		var date_out_real ='';
		var time_out_real ='&nbsp;____&nbsp;';
		if(res[7] != null && res[7] !='' && res[7] != ' '&& res[7] != 'null'){
			date_in_real=res[7];
		}
		if(res[8] != null && res[8] !=''&& res[8] != ' '&& res[8] != 'null'){
			time_in_real=res[8];
		}
		if(res[9] != null && res[9] !=''&& res[9] != ' '&& res[9] != 'null'){
			date_out_real=res[9];
		}//else{
			//date_out_real=res[10];
		//}
		if(res[10] != null && res[10] !=''&& res[10] != ' '&& res[10] != 'null'){
			time_out_real=res[10];
		}

		$('#lblDlgReqLeaveHead').html(res[2]);
		$('#lblDlgReqEmpID').html(res[0]);
		$('#lblDlgReqEmpName').html(res[1]);
		$('#lblDlgReqStartDate').html(res[3]);
		$('#lblDlgReqStartTime').html(res[4]);
		$('#lblDlgReqEndDate').html(res[5]);
		$('#lblDlgReqEndTime').html(res[6]);
		//$("#lblDlgOTShiftStartDate").html($('#txtShiftStartDate').val()+' '+$('#txtShiftStartTime').val());
		//$("#lblDlgOTShiftEndDate").html($('#txtShiftEndDate').val()+' '+$('#txtShiftEndTime').val());
		$('#lblDlgOTShiftStartDate').html(res[16]+' '+res[17]);
		$('#lblDlgOTShiftEndDate').html(res[18]+' '+res[19]);
		if(res[20]=="T" || res[20]=="H") {
			document.getElementById('divDlgOTStar').style.display = "block";
		} else {
			document.getElementById('divDlgOTStar').style.display = "none";
		}
		$('#lblDlgOTDay').html("วัน"+ res[21]);
		if(res[20]=="T" && res[22].length>0) {
			$('lblDlgOTHoliday').html("("+res[22]+")");
		} else {
			$('lblDlgOTHoliday').html("");
		}
		$('#lblDlgOTRealStartDate').html(date_in_real+" "+time_in_real);
		$('#lblDlgOTRealEndDate').html(date_out_real+" "+time_out_real);
		$('#lblDlgReqRemark').html(res[12]);
		$('#lblDlgReqDepartment').html(res[14]);
		$('#lblDlgReqPosition').html(res[15]);
	
		//$('#lblDlgReqOT').html(res[13]);
		$('#lblDlgOTOt1').html(ot_res[0]);
		$('#lblDlgOTOt15').html(ot_res[1]);
		$('#lblDlgOTOt2').html(ot_res[2]);
		$('#lblDlgOTOt3').html(ot_res[3]);
		$('#dlgRequestOT').modal({backdrop: 'static', keyboard: false})  
	}
	function DownLoadFile(){
		var url='member-download-fileleave?FileName='+$('#lblDlgReqFileName').html();
		window.open(url);
// 		 var data = {}
// 			data["file_name"] = $('#lblDlgReqFileName').html();
// 			jQuery.ajax({
// 				url : 'member-download-fileleave?FileName='+$('#lblDlgReqFileName').html(),
// 				type : "Get",
// 				contentType : "application/json",
// 				success : function(obj) {
// 					alert('success');
// 				},
// 				error : function() {
// 					HideWaiting();
// 					ShowErrorConnectMessage();
// 				}
// 			});
	}
	</script>
<div style="background-color: white;">
	<div class="row">
		<div class="col-lg-12">
			<!-- general form elements -->
			<div class="box collapsed-box">
				<div class="box-header">

					<div style="min-height: 12px;"></div>
					<div class="box-tools pull-right">
						<span type="button" class="btn btn-box-tool"
							data-widget="collapse"><img src="resources/Images/dot.png"
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
								<label for="ddlUser" class="col-sm-2 control-label"><spring:message
										code="member.worktime.criteria.user" /></label>
								<div class="col-sm-6">
									<select id="ddlUser" class="form-control select2"
										style="width: 100%;" data-placeholder="เลือกพนักงาน">
									</select>
								</div>

							</div>
						</div>

						<div class="row">
							<div class="form-group">
								<label class="col-sm-2 control-label"><spring:message
										code="member.worktime.criteria.operatedate" /></label>

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
								<label for="ddlDocStatus" class="col-sm-2 control-label"><spring:message
										code="member.worktime.criteria.docstatus" /></label>
								<div class="col-sm-6">
									<select id="ddlDocStatus" class="form-control select2"
										style="width: 100%;" data-placeholder="เลือกสถานะคำร้อง">
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

	<div class="row">
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
						<td><label class="text-attend-doc-status-req2 custom-font"
							style="cursor: default;"></label>&nbsp;&nbsp;</td>
						<td><label class="custom-font-label-thin custom-font">รออนุมัติ</label></td>
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

	<div class="row" id="divSelectAll"
		style="padding-left: 15px; border-bottom: 1px solid #f4f4f4;">
		<!-- &nbsp;<label for="chkAll" id="lblChkUser">
		<input id="selectAll" type="checkbox" class="minimal" />
		<spring:message code="member.worktime.criteria.selectall"/>
			</label -->
		<div>
			<table class="col-sm-4 col-md-3 col-xs-6">
				<tr>
					<td class="selectall-width"><input id="selectAll"
						type="checkbox" class="minimal" /></td>
					<td colspan="3">
						<div style="padding-left: 0px;">
							<label for="chkAll" id="lblChkUser"><spring:message
									code="member.worktime.criteria.selectall" /></label>
						</div>
					</td>
				</tr>
			</table>
		</div>
	</div>

	<div class="row" style="padding-top: 10px;">
		<input type="text" id="otReqNumber" style="display: none;" />
		<div class="col-sm-12">
			<div id="divApproveEditTime"></div>
		</div>
	</div>
	<div class="box-footer" id="divButton">
		<button type="button" class="btn btn-primary pull-right "
			id="btnUnApprove" onclick="Approve('09');">ไม่อนุมัติ</button>
		<button type="button" class="btn btn-primary" id="btnApprove"
			onclick="Approve('08');">อนุมัติ</button>
	</div>
</div>

<div class="modal fade" id="dlgRequestOT" role="dialog">
	<div class="modal-dialog">

		<!-- Modal content-->
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" id="btnReqCloseOT" class="close"
					data-dismiss="modal">&times;</button>
				<!-- p class="modal-title">
          <label  id="lblDlgReqLeaveHead"></label>
          </p -->
				<div class="modal-title">
					<div class="col-sm-3 col-xs-5">
						<label>เลขที่เอกสาร</label>
					</div>
					<div class="col-sm-8 col-xs-6">
						<label class="custom-font-label-thin" id="lblDlgReqLeaveHead"></label>
					</div>
				</div>
				<div class="modal-title">
					<div class="col-sm-3 col-xs-5">
						<label>พนักงาน</label>
					</div>
					<div class="col-sm-9 col-xs-7">
						<label class="custom-font-label-thin" id="lblDlgReqEmpID"></label>&nbsp;
						<label class="custom-font-label-thin" id="lblDlgReqEmpName"></label>
					</div>
				</div>
				<div class="modal-title">
					<div class="col-sm-3 col-xs-5">
						<label>ตำแหน่ง</label>
					</div>
					<div class="col-sm-9 col-xs-7">
						<label class="custom-font-label-thin" id="lblDlgReqPosition"></label>
					</div>
				</div>
				<div class="modal-title">
					<div class="col-sm-3 col-xs-5">
						<label>หน่วยงาน</label>
					</div>
					<div class="col-sm-9 col-xs-7">
						<label class="custom-font-label-thin" id="lblDlgReqDepartment"></label>
					</div>
				</div>
			</div>
			<div class="modal-body">
				<table width="100%">
					<!-- tr>
	          <td>
	          	<div class="col-sm-12 col-xs-12">
	          		<label  id="lblDlgReqEmpID"></label>&nbsp;&nbsp;<label  id="lblDlgReqEmpName"></label>
	          	</div>
	          </td>
          </tr -->
					<tr>
						<td><label id="lblDlgReqLeaveDesc"></label></td>
					</tr>

					<tr>
						<td>
							<div class="col-sm-12 col-xs-12">
								<div id="divDlgOTStar"
									style="float: left; color: red; display: none;">
									<i class="glyphicon glyphicon-star"></i> &nbsp;
								</div>
								<label id="lblDlgOTDay"></label>&nbsp; <label
									id="lblDlgOTHoliday"></label>
							</div>
						</td>
					</tr>
					<tr>
						<td>
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
						<td>
							<div class="col-sm-3 col-xs-12">
								<label><spring:message
										code="member.worktime.dialog.realtime" /></label>
							</div>
							<div class="col-sm-9 col-xs-12" style="padding-right: 0px;">
								<label id="lblDlgOTRealStartDate" class="custom-font-label-thin"></label>&nbsp;-&nbsp;

								<label id="lblDlgOTRealEndDate" class="custom-font-label-thin"></label>
							</div>
						</td>
					</tr>
					<tr>
						<td>
							<div class="col-sm-3 col-xs-12">
								<label><spring:message
										code="member.worktime.dialog.requesttime" /></label>
							</div>
							<div class="col-sm-9 col-xs-12" style="padding-right: 0px;">
								<label id="lblDlgReqStartDate" class="custom-font-label-thin"></label>
								<label id="lblDlgReqStartTime" class="custom-font-label-thin"></label>&nbsp;-&nbsp;
								<label id="lblDlgReqEndDate" class="custom-font-label-thin"></label>
								<label id="lblDlgReqEndTime" class="custom-font-label-thin"></label>
							</div>
						</td>
					</tr>

					<tr>
						<td>
							<!-- label  id="lblDlgReqOT" >
				</label -->
							<div class="col-sm-3 col-xs-12">
								<label></label>&nbsp;&nbsp;
							</div>
							<div class="col-sm-9 col-xs-12">
								<div class="col-sm-4 col-xs-6" style="padding-left: 0px;">
									<label><spring:message
											code="member.worktime.dialog.ot1" /></label>&nbsp;<label
										id="lblDlgOTOt1" class="custom-font-label-thin">0</label>
								</div>
								<div class="col-sm-5 col-xs-6">
									<label><spring:message
											code="member.worktime.dialog.ot15" /></label>&nbsp;<label
										id="lblDlgOTOt15" class="custom-font-label-thin">0</label>
								</div>
								<div class="col-sm-4 col-xs-6" style="padding-left: 0px;">
									<label><spring:message
											code="member.worktime.dialog.ot2" /></label>&nbsp;<label
										id="lblDlgOTOt2" class="custom-font-label-thin">0</label>
								</div>
								<div class="col-sm-5 col-xs-6">
									<label><spring:message
											code="member.worktime.dialog.ot3" /></label>&nbsp;&nbsp;<label
										id="lblDlgOTOt3" class="custom-font-label-thin">0</label>
								</div>
							</div>

						</td>
					</tr>
					<tr>
						<td style="padding-top: 0px;">
							<div class="col-sm-3 col-xs-12">
								<label></label>&nbsp;&nbsp;
							</div>

						</td>
					</tr>

					<tr>
						<td>
							<div class="col-sm-3 col-xs-12">
								<label>รายละเอียด</label>
							</div>
							<div class="col-sm-9 col-xs-12">
								<label class="custom-font-label-thin" id="lblDlgReqRemark"></label>
							</div>
						</td>
					</tr>

					<tr>
						<td><a style="cursor: pointer; text-decoration: underline;"
							id="lblDlgReqFileName" onclick="DownLoadFile();"> </a></td>
					</tr>
				</table>
			</div>

		</div>

	</div>
</div>

