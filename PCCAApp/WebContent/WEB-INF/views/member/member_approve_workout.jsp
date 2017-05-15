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
		
			InitApprove();
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
			InitApprove();
		}
		catch(ex)
		{
			HideWaiting();
			ShowErrorMsg('0006',ex);
		}
	}
	function InitApprove()
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
            			url : 'member-getmemberworkout-approve',
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
                					 str =str+'<li class="item" style="border-bottom:1px solid; border-color:#A09488">';
                					 if(obj[i].curr_status =='Y' && (obj[i].case_doc=='1'||obj[i].case_doc=='2'||obj[i].case_doc=='3')){
                						 str =str+'<input type="text" id="txtTransID'+i_check+'" style="display:none;" class="custom-text-horizon" value="'+obj[i].trans_id+'">';
                					 }else{
                						 str =str+'<input type="text"  style="display:none;" class="custom-text-horizon" value="'+obj[i].trans_id+'">';
                					 }
                					 
                					
                					 str =str+'<div class="row custom-status-list">'; 
                					 str =str+'<table class="col-md-8 col-sm-12 col-xs-12">';
                					 str =str+'<tr><td rowspan="6" width="5%">';
                					 if(obj[i].curr_status =='Y' && (obj[i].case_doc=='1'||obj[i].case_doc=='2'||obj[i].case_doc=='3')){
                						 str =str+'&nbsp;<input  type="checkbox" class="minimal2" style="border: 1px solid;" id="chk'+i_check+'" />';
                					 }else{
                						 str =str+'&nbsp;';
                					 }
                					 str =str+'</td><td colspan="3" >';
                					 str =str+'<div class="col-sm-12 col-xs-12"><label class="custom-font-label-thin" >'+obj[i].codempid+'&nbsp;'+obj[i].namempt+'</label></div>'; 
                					 //str =str+'<div class="col-sm-12 col-xs-12"><label class="custom-font-label-thin" >'+obj[i].nampost+'</label></div>';
                					 str =str+'<div class="col-sm-12 col-xs-12"><label class="custom-font-label-thin" >'+obj[i].namcenttha+'</label></div>';
                					 str =str+'</td></tr>';
                					
                					 str =str+'<tr>';
                					 str =str+'<td colspan="3"><div style="padding-left:15px; float:left;"><!-- div class="col-md-4 col-sm-12 col-xs-12" -->';
                					 var style_doc ='';
                					 if(obj[i].case_doc=='1'){
                						 style_doc ='text-approve-doc-status-req';
                						
                					 }
                					 if(obj[i].case_doc=='2'){
                						 style_doc ='text-approve-doc-status-req';
                						 
                					 }
                					 if(obj[i].case_doc=='3'){
                						 style_doc ='text-approve-doc-status-req';
                						
                					 }
                					 if(obj[i].case_doc=='8'){
                						 style_doc ='text-approve-doc-status-approved';
                						 
                					 }
                					 if(obj[i].case_doc=='9'){
                						 style_doc ='text-approve-doc-status-unapproved';
                						 
                					 }
                					 
                					 var doc_no =obj[i].doc_no;
    	        					 if(obj[i].status !='1'){
    	        						 doc_no = '99'+doc_no;
    	        					 }
                					 str =str+'<label class="custom-font-label-thin '+style_doc+'" onclick="ShowRequest(&quot;'+obj[i].trans_id+'|'+obj[i].codempid+'|'+obj[i].namempt+'|'+obj[i].nampost+'|'+obj[i].namcenttha+'|'+obj[i].objective+'|'+obj[i].place+'|'+obj[i].place_flag+'|'+obj[i].start_place+'|'+obj[i].start_date+'|'+obj[i].start_time+'|'+obj[i].end_place+'|'+obj[i].end_date+'|'+obj[i].end_time+'|'+obj[i].private_flag+'|'+obj[i].company_id+'|'+obj[i].doc_no+'|'+obj[i].status+'|'+obj[i].namcenttha+'|'+obj[i].nampost+'&quot;);" >'+doc_no+'</label>';
                					 
                					 //if(obj[i].case_doc=='10'){
                						 //str =str+'<label class="custom-font-label-thin text-approve-doc-status-canceled" onclick="ShowRequest(&quot;'+obj[i].codempid+'|'+obj[i].namempt+'|'+obj[i].trans_id+'|'+obj[i].start_date+'|'+obj[i].start_time+'|'+obj[i].end_date+'|'+obj[i].end_time+'|'+obj[i].leave_desc+'|'+obj[i].remark+'|'+obj[i].file_name+'&quot;);" >'+obj[i].trans_id+'</label>';
                					 //}  for cancled document
                					 //str =str+'</div><div class="col-sm-8 col-xs-12">';
                					 if(obj[i].trans_id.substring(0,2) == "99")  {
                						 str =str+'&nbsp;<label class="label-right" style="padding-top:5px;">(ขอยกเลิก)</label>&nbsp;';
                					 }
                		
                					// str =str+'<label class="custom-font-label-thin">'+obj[i].namcenttha+'</label>';
                					 str =str+'</div>';
                					// str =str+'</td></tr>';
                					 //if(obj[i].curr_status =='Y' && (obj[i].case_doc=='1'||obj[i].case_doc=='2'||obj[i].case_doc=='3')){
                						// str =str+'<input  type="checkbox" class="minimal2"  id="chk'+i_check+'" />&nbsp;';
                					 //}else{
                						// str =str+'&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;';
                					// }
  
                					
                					// if(obj[i].dteout != null && obj[i].dteout != ''&& obj[i].dteout != ' '){
                    					// str =str+'&nbsp;<label   class="custom-font-label-thin-small ">แก้ไข</label>';
                    					// }
                					 //str =str+'<tr><td colspan="3">';
                					 str =str+'<div class="col-md-8 col-sm-12 col-xs-12" style="padding-top:5px;">';
                					 str =str+'<label class="custom-font-label-thin">'+obj[i].start_date+'</label>&nbsp;';
                					 str =str+'<label class="custom-font-label-thin">'+obj[i].start_time+'</label>&nbsp;-&nbsp;';
                					 str =str+'<label class="custom-font-label-thin">'+obj[i].end_date+'</label>&nbsp;';
                					 str =str+'<label class="custom-font-label-thin">'+obj[i].end_time+'</label></div>'; 
                					 str =str+'</td></tr>';
                					 str =str+'<tr><td><div style="height: 10px;"></div></td></tr>';
                					 str =str+'<tr><td colspan="3"><div class="col-sm-12 col-xs-12">';
                					 str =str+'<i class="glyphicon glyphicon-map-marker"></i>&nbsp;<label class="custom-font-label-thin">'+obj[i].place+'</label>';
                					 str =str+'</div></td></tr>';
                					 str =str+'<tr><td><div class="label-width">';
                					 str =str+'<label><spring:message code="member.workout.objective"/></label></div>';
                					 str =str+'<div class="col-sm-9 col-xs-12"><label class="custom-font-label-thin">'+obj[i].objective+'</label>';
                					 str =str+'</div></td></tr>';
          							 str =str+'<tr><td colspan="3">';
                					 //str =str+'<div class="row" style="padding-left: 14px;line-height: 30px;">';
                					 str =str+'<div class="label-width">';
                					 str =str+'<label>';
                					 str =str+'<spring:message code="member.worktime.data.remark"/>';
                					 str =str+'</label></div><div class="col-sm-9 col-xs-12">';
                					 if(obj[i].curr_status =='Y' && (obj[i].case_doc=='1'||obj[i].case_doc=='2'||obj[i].case_doc=='3')){
                						 str =str+'<input type="text" id="txtRemark'+i_check+'" style="width:90%;height: 25px;" class="form-control" maxlength="200">'; //maxlength change from 1500 to 200
                						 i_check++;
                					 }else{
                						 str =str+'<input type="text"  style="width:90%;height: 25px;" class="form-control" disabled>';
                					 }
                					 
                					 str =str+'</div>';
                					 str =str+'</td></tr></table>';
                					 //str =str+'</div>';
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
		 				url : 'member-updateworkout',
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
		$('#lblDlgHead').html(res[16]);
		if(res[17]!='1'){
			$('#lblDlgHead').html('99'+res[16]);
		}
		
		$('#lblDlgTransID').html(res[0]);
		$('#lblDlgEmpID').html(res[1]);
		$('#lblDlgName').html(res[2]);
		$('#lblDlgPosition').html(res[3]);
		$('#lblDlgLocation').html(res[4]);
		$('#lblDlgObjective').html(res[5]);
		$('#lblDlgPlace').html(res[6]);
		$('#lblDlgStartPlace').html(res[8]);
		$('#lblDlgStartDate').html(res[9]);
		$('#lblDlgStartTime').html(res[10]);
		$('#lblDlgEndPlace').html(res[11]);
		$('#lblDlgEndDate').html(res[12]);
		$('#lblDlgEndTime').html(res[13]);
		$('#lblDlgCompanyID').html(res[15]);
		$('#lblDlgDocNo').html(res[16]);
		$('#lblDlgDepartment').html(res[18]);
		$('#lblDlgPosition').html(res[19]); 
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
		InitDiffDay();
		$('#dlgWorkOut').modal({backdrop: 'static', keyboard: false})  
	}
	function InitDiffDay(){
		var count_datetime = 0;
		if($("#lblDlgStartDate").html() != null && $("#lblDlgStartDate").html()){
			count_datetime++;
		}
		if($("#lblDlgEndDate").html() != null && $("#lblDlgEndDate").html()){
			count_datetime++;
		}
		if(count_datetime==2){
		 var start_date =$("#lblDlgStartDate").html();
	     var end_date =$("#lblDlgEndDate").html();
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
		<div class="col-sm-12">
			<div id="divApproveEditTime"></div>
		</div>
	</div>
	<div class="box-footer" id="divButton">
		<button type="button" class="btn btn-primary pull-right"
			id="btnUnApprove" onclick="Approve('09');">ไม่อนุมัติ</button>
		<button type="button" class="btn btn-primary" id="btnApprove"
			onclick="Approve('08');">อนุมัติ</button>
	</div>
</div>

<div class="modal fade" id="dlgWorkOut" role="dialog">
	<div class="modal-dialog">

		<!-- Modal content-->
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" id="btnCloseWorkOut" class="close"
					data-dismiss="modal">&times;</button>

				<div class="modal-title">
					<div class="col-sm-3 col-xs-5">
						<label>เลขที่เอกสาร</label>
					</div>
					<div class="col-sm-8 col-xs-6">
						<label class="custom-font-label-thin" id="lblDlgHead"></label>
					</div>
				</div>
				<div class="modal-title">
					<div class="col-sm-3 col-xs-5">
						<label>พนักงาน</label>
					</div>
					<div class="col-sm-9 col-xs-7">
						<label class="custom-font-label-thin" id="lblDlgEmpID"></label>&nbsp;
						<label class="custom-font-label-thin" id="lblDlgName"></label>
					</div>
				</div>
				<div class="modal-title">
					<div class="col-sm-3 col-xs-5">
						<label>ตำแหน่ง</label>
					</div>
					<div class="col-sm-9 col-xs-7">
						<label class="custom-font-label-thin" id="lblDlgPosition">
							- </label>
					</div>
				</div>
				<div class="modal-title">
					<div class="col-sm-3 col-xs-5">
						<label>หน่วยงาน</label>
					</div>
					<div class="col-sm-9 col-xs-7">
						<label class="custom-font-label-thin" id="lblDlgDepartment">
							- </label>
					</div>
				</div>

			</div>

			<div style="height: 100%;">
				<!-- div class="nav-tabs" -->
				<form class="form-horizontal">
					<div class="box-body">
						<label id="lblDlgCompanyID" style="display: none;"></label> <label
							id="lblDlgDocNo" style="display: none;"></label>
					</div>
				</form>
				<!-- /div -->

				<div class="nav-tabs">
					<div class="box-body">
						<div class="form-group">
							<div class="col-sm-3 col-xs-5">
								<label><spring:message code="member.workout.objective" /></label>
							</div>
							<div class="col-sm-9 col-xs-7">
								<label class="custom-font-label-thin" id="lblDlgObjective"></label>
							</div>
						</div>
						<div class="form-group">
							<div class="col-sm-3 col-xs-5">
								<label for="exampleInputPassword1"><spring:message
										code="member.workout.place" /></label>
							</div>
							<div class="col-sm-9 col-xs-7">
								<label class="custom-font-label-thin" id="lblDlgPlace"></label>
							</div>
						</div>

						<div class="form-group">
							<div class="col-md-4 col-sm-4 col-xs-12">
								<label> <input type="radio" name="r3" class="minimal"
									checked id="r1" value="1" disabled>&nbsp;<spring:message
										code="member.workout.province" />
								</label>
							</div>
							<div class="col-md-4 col-sm-4 col-xs-12">
								<label> <input type="radio" name="r3" class="minimal"
									id="r2" value="2" disabled>&nbsp;<spring:message
										code="member.workout.country" />
								</label>
							</div>
							<div class="col-md-4 col-sm-4 col-xs-12">
								<label><input type="radio" name="r3" class="minimal"
									id="r3" value="3" disabled>&nbsp;<spring:message
										code="member.workout.abroad" /> </label>
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
							<div class="row">
								<div class="col-md-2 col-sm-2 col-xs-4 text-right">
									<i class="glyphicon glyphicon-map-marker"></i> <label><spring:message
											code="member.workout.gobegin" /></label>
								</div>
								<div class="col-md-10 col-sm-10 col-xs-8">
									<label class="custom-font-label-thin" id="lblDlgStartPlace"></label>
								</div>
							</div>
							<div class="row">
								<div class="col-md-2 col-sm-2 col-xs-4 text-right">
									<label for="exampleInputEmail1"><spring:message
											code="member.workout.godatetime" /></label>
								</div>
								<div class="col-md-10 col-sm-10 col-xs-8">
									<label class="custom-font-label-thin" id="lblDlgStartDate"></label>
									&nbsp; <label class="custom-font-label-thin"
										id="lblDlgStartTime"></label>
								</div>
							</div>

						</div>
					</form>
					<form class="form-horizontal">
						<div class="box-body ">
							<div class="row">
								<div class="col-md-2 col-sm-2 col-xs-4 text-right">
									<i class="glyphicon glyphicon-map-marker"></i> <label
										for="exampleInputEmail1"><spring:message
											code="member.workout.retbegin" /></label>
								</div>
								<div class="col-md-10 col-sm-10 col-xs-8">
									<label class="custom-font-label-thin" id="lblDlgEndPlace"></label>
								</div>
							</div>
							<div class="row">
								<div class="col-md-2 col-sm-2 col-xs-4 text-right">
									<label for="exampleInputEmail1"><spring:message
											code="member.workout.retdatetime" /></label>
								</div>
								<div class="col-md-10 col-sm-10 col-xs-8">
									<label class="custom-font-label-thin" id="lblDlgEndDate"></label>
									&nbsp; <label class="custom-font-label-thin" id="lblDlgEndTime"></label>
								</div>
							</div>

						</div>
					</form>

				</div>
				<div class="nav-tabs">
					<form class="form-horizontal">
						<div class="box-body ">
							<div class="row">
								<div class="col-sm-12 font-bold">
									<!--รวม &nbsp;&nbsp;<label class="custom-font-label-thin" id="lblDlgDayNum" ></label>&nbsp;&nbsp;วัน-->
									<label class="pull-right"><input id="chkPrivate"
										type="checkbox" class="minimal " disabled>&nbsp;&nbsp;ใช้รถยนต์ส่วนตัว</label>
								</div>
							</div>
						</div>
					</form>
				</div>

			</div>

		</div>
	</div>
</div>

