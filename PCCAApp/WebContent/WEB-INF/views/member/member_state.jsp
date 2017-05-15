<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
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
					url : 'util-getmemberfollower',
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
	function SetDropDown(obj)
	{
		try
		{
		 $('#ddlUser') .find('option').remove().end();
         var select = document.getElementById('ddlUser');
         for (var i = 0; i < obj.length; i++) {
             var opt = document.createElement('option');
           //  if(obj.length == 1) {
           // 	opt.hidden = true;
           //  }
             opt.value = obj[i].ddl_value;
             opt.innerHTML = obj[i].ddl_text;
            // if(i==0){
            // 	opt.selected =true;
             //}
             select.appendChild(opt);
         }
         
         HideWaiting();
         var d = new Date();
         var mont = d.getMonth() + 1;
         if (mont < 10) {
             mont = '0' + mont;
         }
        document.getElementById('ddlMonth').value=mont;
         
         var year =d.getFullYear();
         $('#ddlYear') .find('option').remove().end();
         var select = document.getElementById('ddlYear');
         for (var i = -2; i < 1; i++) {
             var opt = document.createElement('option');
             opt.value = year+i;
             opt.innerHTML = year+543+i;
			 select.appendChild(opt);
			if(i==0){
				opt.selected =true;
			}
         }
         PreWorkTime();
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
			ShowWaiting();
			Clear();
			InitData();
		}
		catch(ex)
		{
			HideWaiting();
			ShowErrorMsg('0006',ex);
		}
	}
	function GetMonthShortName(x){
		var name= '';
		if(x=='01'){
			name='ม.ค.';
		}
		if(x=='02'){
			name='ก.พ.';
		}
		if(x=='03'){
			name='มี.ค.';
		}
		if(x=='04'){
			name='เม.ย.';
		}
		if(x=='05'){
			name='พ.ค.';
		}
		if(x=='06'){
			name='มิ.ย.';
		}
		if(x=='07'){
			name='ก.ค.';
		}
		if(x=='08'){
			name='ส.ค.';
		}
		if(x=='09'){
			name='ก.ย.';
		}
		if(x=='10'){
			name='ต.ค.';
		}
		if(x=='11'){
			name='พ.ย.';
		}
		if(x=='12'){
			name='ธ.ค.';
		}
		return name;
	}
	function InitData(){
		var emp_id = document.getElementById('ddlUser');
		var month = document.getElementById('ddlMonth');
		var year = document.getElementById('ddlYear');
		var search_case = document.getElementById('ddlCase');
		 var em_id ='';
    	// if(emp_id.selectedIndex >0){
    		 em_id =emp_id.value;
    	 //}
           			var data = {}
              		data["codempid"] = em_id;
              		data["month"] = month.value;
              		data["year"] = year.value;
              		data["search_case"] = search_case.value;
              		jQuery.ajax({
            			url : 'member-getstate',
            			type : "Post",
            			contentType : "application/json",
            			data: JSON.stringify(data),
            			dataType : 'json',
            			success : function(obj) {
            				if(obj.length>0){
            			   var month_name =GetMonthShortName(month.value);
            			   var th_style='style="background-color:#587493; color:white; text-align:center;"';
            			   var th_style2='style="background-color:#B1BBC6;"';
            				var str='<table class="table" style="text-align:center; margin-bottom:40px;">';
            				 str=str+'<tr>';
        					 str=str+'<th class="custom-state-table-c1" '+th_style+'></th>';
        					 str=str+'<th class="custom-state-table-c2" '+th_style+'></th>';
        					 str=str+'<th class="custom-state-table-c3" '+th_style+'>เดือน  '+month_name+'</th>';
        					 str=str+'<th class="custom-state-table-c4" '+th_style+'></th>';
        					 str=str+'<th class="custom-state-table-c5" '+th_style+'></th>';
        					 str=str+'<th class="custom-state-table-c6" '+th_style+'>ปี '+(parseInt(year.value)+parseInt(543))+'</th>';
        					 str=str+'<th class="custom-state-table-c7" '+th_style+'></th>';
        					 str=str+'</tr>';
        					 str=str+'<tr>';
        					 str=str+'<th class="custom-state-table-c1 text-left" '+th_style2+'>ประเภท</th>';
        					 str=str+'<th class="custom-state-table-c2 text-center" '+th_style2+'>ครั้ง</th>';
        					 str=str+'<th class="custom-state-table-c3 text-center" '+th_style2+'>วัน</th>';
        					 str=str+'<th class="custom-state-table-c4 text-center" '+th_style2+'>ชม.นาที</th>';
        					 str=str+'<th class="custom-state-table-c5 text-center" '+th_style2+'>ครั้ง</th>';
        					 str=str+'<th class="custom-state-table-c6 text-center" '+th_style2+'>วัน</th>';
        					 str=str+'<th class="custom-state-table-c7 text-center" '+th_style2+'>ชม.นาที</th>';
        					 str=str+'</tr>';
            				for (var i = 0; i < obj.length; i++) {
            					var month_style = 'vertical-align:middle;';
                			   	var year_style = 'vertical-align:middle;';
            			   		if(obj[i].data_month_amt>0 || obj[i].day_month_amt>0 /*|| obj[i].hour_minute_month_amt!="00:00"*/) {
            						month_style = month_style+'font-weight:bold; color:red;';
            					} if(obj[i].data_year_amt>0 || obj[i].day_year_amt>0 /*|| obj[i].hour_minute_year_amt!="00:00"*/) {
            						year_style= year_style+ 'font-weight:bold; color:red;';
            					}
            					
//             					if(obj[i].day_month_amt.indexOf(".")>-1){
//             			   			var s1 = obj[i].day_month_amt.split('.');
//             			   			if(s1[1]>0){
//             			   				s1[1]=5;
//             			   				obj[i].day_month_amt=s1[0]+"."+s1[1];
//             			   			}
//             						alert(obj[i].day_month_amt);
//             			   		}		
								
//             					alert(obj[i].day_month_amt);
                			   	if(obj[i].state_type =='กลับก่อน'){
                			   	 str=str+'<tr>';
            					 str=str+'<td class="custom-state-table-c1 custom-row stats-row" style="text-align:left; vertical-align: middle;">'+obj[i].state_type+'</td>';
            					 str=str+'<td class="custom-state-table-c2 custom-row stats-row" style="'+month_style+'">'+obj[i].data_month_amt+'</td>';
            					 str=str+'<td class="custom-state-table-c3 custom-row stats-row" >-</td>';
            					 str=str+'<td class="custom-state-table-c4 custom-row stats-row" >-</td>';
            					 str=str+'<td class="custom-state-table-c5 custom-row stats-row" style="'+year_style+'">'+obj[i].data_year_amt+'</td>';
            					 str=str+'<td class="custom-state-table-c6 custom-row stats-row" >-</td>';
            					 str=str+'<td class="custom-state-table-c7 custom-row stats-row" >-</td>';
            					 str=str+'</tr>';
                			   	}else{
                			   		
                					 str=str+'<tr>';
                					 str=str+'<td class="custom-state-table-c1 custom-row stats-row" style="text-align:left; vertical-align: middle;">'+obj[i].state_type+'</td>';
                					 str=str+'<td class="custom-state-table-c2 custom-row stats-row" style="'+month_style+'">'+obj[i].data_month_amt+'</td>';
                					 str=str+'<td class="custom-state-table-c3 custom-row stats-row" style="'+month_style+'">'+obj[i].day_month_amt+'</td>';
                					 str=str+'<td class="custom-state-table-c4 custom-row stats-row" style="'+month_style+'">'+obj[i].hour_minute_month_amt+'</td>';
                					 str=str+'<td class="custom-state-table-c5 custom-row stats-row" style="'+year_style+'">'+obj[i].data_year_amt+'</td>';
                					 str=str+'<td class="custom-state-table-c6 custom-row stats-row" style="'+year_style+'">'+obj[i].day_year_amt+'</td>';
                					 str=str+'<td class="custom-state-table-c7 custom-row stats-row" style="'+year_style+'">'+obj[i].hour_minute_year_amt+'</td>';
                					 str=str+'</tr>';
                			   	}
            					
            					          					 
            				}
            				 str=str+'</table>';
            				 
            				
            				$('#divState').html(str);
            				 HideWaiting();
            				}else{
            					HideWaiting();
            					Clear();
            	        		str ='<div style="width:100%;text-align: center;"><label  class="control-label">ไม่พบข้อมูล</label></div>';
            	        		 $('#divState').html(str);
            				}
            				
            				
            			},
            			error : function() {
            				HideWaiting();
            				ShowErrorConnectMessage();
            			}
            		 });
            
                
	}
	
	function Clear()
	{
		  $('#divState').html('');
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
				<form class="form-horizontal">
					<div class="box-body">
						<div class="row">
							<div class="col-sm-12">
								<div class="form-group">
									<label for="inputUser" id="lblChkUser"
										class="col-sm-2 control-label"> <!-- input id="chkUser" type="checkbox" class="minimal" />&nbsp;-->
										<spring:message code="member.worktime.criteria.user" />
									</label>
									<div class="col-sm-6">
										<select id="ddlUser" class="select2" style="width: 100%;">
										</select>
									</div>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-sm-12">
								<div class="form-group">
									<label for="inputUser" class="col-sm-2 control-label">
										เดือน </label>
									<div class="col-sm-2">
										<select class="form-control" data-placeholder="เลือกสมาชิก"
											id="ddlMonth" style="width: 100%;">
											<option value="01">มกราคม</option>
											<option value="02">กุมภาพันธ์</option>
											<option value="03">มีนาคม</option>
											<option value="04">เมษายน</option>
											<option value="05">พฤษภาคม</option>
											<option value="06">มิถุนายน</option>
											<option value="07">กรกฎาคม</option>
											<option value="08">สิงหาคม</option>
											<option value="09">กันยายน</option>
											<option value="10">ตุลาคม</option>
											<option value="11">พฤศจิกายน</option>
											<option value="12">ธันวาคม</option>
										</select>
									</div>
									<label for="inputUser"
										class="col-sm-1 control-label custom-line-height"> ปี
									</label>
									<div class="col-sm-2">
										<select class="form-control" id="ddlYear" style="width: 100%;">

										</select>
									</div>
								</div>
							</div>

						</div>
						<div class="row">
							<div class="col-sm-12">
								<div class="form-group">
									<label class="col-sm-2 control-label">รายการที่แสดง </label>
									<div class="col-sm-6">
										<select id="ddlCase" class="select2" style="width: 100%;">
											<option value="0">ทั้งหมด</option>
											<option value="1" selected>เฉพาะที่มีรายการ</option>
										</select>
									</div>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-sm-12">
								<div class="form-group">
									<label for="inputUser" class="col-sm-4 control-label">
									</label>
									<div class="col-sm-4">
										<button type="button" onclick="PreWorkTime2();"
											class="btn pull-right custom-button">
											<span class="glyphicon glyphicon-search"></span>&nbsp;ค้นหา
										</button>
									</div>
								</div>
							</div>
						</div>
					</div>

				</form>

			</div>
		</div>

	</div>
	<div class="row">
		<div class="col-sm-12">

			<div id="divState"></div>
		</div>
	</div>
</div>
