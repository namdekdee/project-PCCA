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
				jQuery.ajax({
					url : 'util-getmemberfollower-all',
					type : "Post",
					contentType : "application/json",
					dataType : 'json',
					success : function(obj) {
						SetDropDown(obj);
					},
					error : function() {
						HideWaiting();
						ShowErrorConnectMessage();
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
	function SetDropDown(obj)
	{
		try
		{
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
         
         SetDropDownCompany();
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
			         PreWorkTime();
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
	
	
	function PreWorkTime()
	{
		try
		{
		
			InitData();
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
			$("#divSumaryOT").show();
   		 $("#divButton").show();
			ShowWaiting();
			InitData();
		}
		catch(ex)
		{
			HideWaiting();
			ShowErrorMsg('0006',ex);
		}
	}
	
	function InitData(){
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
                
                	  var data = {}
              		data["codempid"] = em_id;
              		data["start_date"] = start_date_db;
              		data["end_date"] = end_date_db;
              		data["company_id"] = com_id;
              		var i_check=0;
              		jQuery.ajax({
            			url : 'member-getsumaryot',
            			type : "Post",
            			contentType : "application/json",
            			 data: JSON.stringify(data),
            			dataType : 'json',
            			success : function(obj) {
            				var str='<ul class="products-list product-list-in-box" >';
            				 str=str+'<li class="item">';
        					 str=str+'<label   class="custom-font-label-thin custom-sumot-c1">พนักงาน</label>';
        					 str=str+'<label   class="custom-font-label-thin custom-sumot-c2">OT1</label>';
        					 str=str+'<label   class="custom-font-label-thin custom-sumot-c3">OT1.5</label>';
        					 str=str+'<label   class="custom-font-label-thin custom-sumot-c4">OT2</label>';
        					 str=str+'<label   class="custom-font-label-thin custom-sumot-c5">OT3</label>';
        					 str=str+'</li>';
            				for (var i = 0; i < obj.length; i++) {
            					
            					 str=str+'<li class="item">';
            					 str=str+'<div>';
            					 str=str+'<label   class="custom-font-label-thin custom-sumot-c1">'+obj[i].codempid+'</label>';
            					 str=str+'<label   class="custom-font-label-thin custom-sumot-c2">'+obj[i].ot1_h+'</label>';
            					 str=str+'<label   class="custom-font-label-thin custom-sumot-c3">'+obj[i].ot15_h+'</label>';
            					 str=str+'<label   class="custom-font-label-thin custom-sumot-c4">'+obj[i].ot2_h+'</label>';
            					 str=str+'<label   class="custom-font-label-thin custom-sumot-c5">'+obj[i].ot3_h+'</label>';
            					 str=str+'</div>';
            					 str=str+'<div style="line-height: 0.3px;">';
            					 str=str+'<label   class="custom-font-label-thin-small custom-sumot-c1">'+obj[i].namempt+'</label>';
            					 str=str+'<label   class="custom-font-label-thin custom-sumot-c2"></label>';
            					 str=str+'<label   class="custom-font-label-thin custom-sumot-c3"></label>';
            					 str=str+'<label   class="custom-font-label-thin custom-sumot-c4"></label>';
            					 str=str+'<label   class="custom-font-label-thin custom-sumot-c5"></label>';
            					 str=str+'</div>';
            					 str=str+'<div>';
            					 str=str+'<label   class="custom-font-label-thin-small custom-sumot-c1">'+obj[i].namcenttha+'</label>';
            					 str=str+'<label   class="custom-font-label-thin custom-sumot-c2"></label>';
            					 str=str+'<label   class="custom-font-label-thin custom-sumot-c3"></label>';
            					 str=str+'<label   class="custom-font-label-thin custom-sumot-c4"></label>';
            					 str=str+'<label   class="custom-font-label-thin custom-sumot-c5"></label>';
            					 str=str+'</div>';
            					 str=str+'</li>';            					 
            				}
            				 str=str+'</ul>';
            				 $('#divSumaryOT').html(str);
            				HideWaiting();
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
										style="width: 100%;" data-placeholder="เลือกหน่วยงาน">
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
									<button type="button" class="btn btn-info pull-right"
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

	<div class="row" style="padding-top: 10px;">
		<div class="col-sm-12">
			<div id="divSumaryOT"></div>
		</div>
	</div>

</div>

