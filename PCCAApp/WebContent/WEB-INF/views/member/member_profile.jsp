<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<script>
	$(document).ready(
			function() {
				ShowWaiting();
				jQuery.ajax({
					url : 'util-getmemberfollower',
					type : "Post",
					contentType : "application/json",
					dataType : 'json',
					success : function(obj) {
						SetDropDownMember(obj);
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
				
			});
	function SetDropDownMember(obj)
	{
		
		try
		{
		 $('#ddlUser')
         .find('option')
         .remove()
         .end()
         ;

         var select = document.getElementById('ddlUser');
         for (var i = 0; i < obj.length; i++) {
             var opt = document.createElement('option');
             opt.value = obj[i].ddl_value;
             opt.innerHTML = obj[i].ddl_text;
             select.appendChild(opt);
         }
         PreInitMember();
		}catch(ex)
		{
			HideWaiting();
			ShowErrorMsg('0006',ex);
		}
		
		 
         
	}
	function PreInitMember()
	{
		InitMember();
	}
	function PreInitMember2()
	{
		ShowWaiting();
		InitMember();
	}
	function InitMember()
	{
		try
		{
		var emp_id = document.getElementById('ddlUser');
		  var data = {}
		data["codempid"] = emp_id.value;
		jQuery.ajax({
			url : 'member-getmemberprofile',
			type : "Post",
			contentType : "application/json",
			 data: JSON.stringify(data),
			dataType : 'json',
			success : function(obj) {
				$('#lblEmpID').html(obj.codempid);
				if(obj.namempt == null || obj.namempt ==''){
					$('#lblName').html("-");
				}
				else{
					$('#lblName').html(obj.namempt);
				}
				if(obj.namempe == null || obj.namempe ==''){
					$('#lblNameEn').html("-");
				}
				else{
					$('#lblNameEn').html(obj.namempe);
				}
				if(obj.dteempdb == null || obj.dteempdb ==''){
					$('#lblBirthDate').html("-");
				}
				else{
					$('#lblBirthDate').html(obj.dteempdb);
				}
				
				if(obj.age_year >0){
					$('#lblAge').html(obj.age_year);
				}else{
					$('#lblAge').html("-");
				}
				if(obj.age_month >0){
					$('#lblAgeMonth').html(obj.age_month);
				}else{
					$('#lblAgeMonth').html("-");
				}
				
				if(obj.codedlvnamt == null || obj.codedlvnamt ==''){
					$('#lblEdu').html("-");
				}
				else{
					$('#lblEdu').html(obj.codedlvnamt);
				}

				if(obj.codmajsbnamt == null || obj.codmajsbnamt ==''){
					$('#lblMajor').html("-");
				}
				else{
					$('#lblMajor').html(obj.codmajsbnamt);
				}

				$('#lblInstitute').html("-");
				
				if(obj.nampost == null || obj.nampost ==''){
					$('#lblPosition').html("-");
				}
				else{
					$('#lblPosition').html(obj.nampost);
				}
				if(obj.nampose == null || obj.nampose ==''){
					$('#lblPositionEn').html("-");
				}
				else{
					$('#lblPositionEn').html(obj.nampose);
				}
				
				if(obj.typemp == null || obj.typemp ==''){
					$('#lblTypemp').html("-");
				}
				else{
					$('#lblTypemp').html(obj.typemp);
				}
				
				if(obj.namcenttha == null || obj.namcenttha ==''){
					$('#lblDepartMent').html("-");
				}
				else{
					$('#lblDepartMent').html(obj.namcenttha);
				}
				if(obj.namcenteng == null || obj.namcenteng ==''){
					$('#lblDepartMentEn').html("-");
				}
				else{
					$('#lblDepartMentEn').html(obj.namcenteng);
				}
				if(obj.namempmt == null || obj.namempmt ==''){
					$('#lblEmpType').html("-");
				}
				else{
					$('#lblEmpType').html(obj.namempmt);
				}
				
				if(obj.dteempmt == null || obj.dteempmt ==''){
					$('#lblMemberDate').html("-");
				}
				else{
					$('#lblMemberDate').html(obj.dteempmt);
				}

				if(obj.dteoccup == null || obj.dteoccup ==''){
					$('#divEmpDate').css('display','block');
					$('#lblEmpDate').html("-");
					$('#lblEmpDateToH').html('<spring:message code="member.history.empdateto"/>');
					if(obj.dteduepr == null || obj.dteduepr ==''){
						$('#lblEmpDateTo').html("-");
					}
					else{
						$('#lblEmpDateTo').html(obj.dteduepr);
					}
				}
				else{
					$('#divEmpDate').css('display','none');
					$('#lblEmpDate').html(obj.dteoccup);
					$('#lblEmpDateToH').html('');
					
					
				}
				
				
				

				if(obj.qtywork_year >0){
					$('#lblExpen').html(obj.qtywork_year);
				}else{
					$('#lblExpen').html("-");
				}
				if(obj.qtywork_month >0){
					$('#lblExpenMonth').html(obj.qtywork_month);
				}else{
					$('#lblExpenMonth').html("-");
				}
				
				if(obj.status_desc == null || obj.status_desc ==''){
					$('#lblEmpStatus').html("-");
				}
				else{
					$('#lblEmpStatus').html(obj.status_desc);
				}
				if(obj.leader_name == null || obj.leader_name ==''){
					$('#lblLeader').html("-");
				}
				else{
					$('#lblLeader').html(obj.leader_name);
				}
				  
				  var str='<ul class="products-list product-list-in-box">';
				 var str2='<ul class="products-list product-list-in-box" style="margin-top:20px;">';
					  for (var i = 0; i < obj.movement.length; i++) {
						
						  str2 =str2+'<li class="item profile-list"><div class="col-sm-4">';
						  str2 =str2+'<label class="font-bold font-large-profile">'+(i+1)+'.</label>';
						  str2 =str2+'&nbsp;<label class="font-bold font-large-profile">'+obj.movement[i].codtrn_name+'</label>';
						  str2 =str2+'</div><div class="col-sm-4">';
						  str2 =str2+'<label class="font-thin font-large-profile" >มีผล&nbsp;</label>';
						  str2 =str2+'<label class="font-thin font-large-profile" >'+obj.movement[i].dteeffec+'&nbsp;</label>';
						  str2 =str2+'<label class="font-thin font-large-profile" >'+obj.movement[i].codpos_name_new+'</label>';
						  str2 =str2+'&nbsp;&nbsp;<label class="font-thin font-large-profile">'+obj.movement[i].typemp_new+'</label>';
						  str2 =str2+'</div><div class="col-sm-4">';
						  str2 =str2+'<label class="font-thin font-large-profile">'+obj.movement[i].codcomp_name_new+'</label>';
						  str2 =str2+'</div></li>';
						  //if(i==obj.movement.length-1) {
							//  str2=str2+'<div class="row"><div class="col-sm-4"><label class="font-thin">'+(i+1)+'</label>&nbsp;<label class="font-thin">'+obj.movement[i].codtrn_name+'</label></div><div class="col-sm-4"><label class="font-thin" style="background-color: #00a65a;">เธกเธตเธเธฅ&nbsp;</label><label class="font-thin" style="background-color: #00a65a;">'+obj.movement[i].dteeffec+'&nbsp;</label><label class="font-thin" style="background-color: #00a65a;">'+obj.movement[i].codpos_name_new+'</label></div><div class="col-sm-4"><label class="font-thin">'+obj.movement[i].codcomp_name_new+'</label>&nbsp;&nbsp;<label class="font-thin">เธฃเธฐเธ”เธฑเธ&nbsp;'+obj.movement[i].typemp_new+'</label></div></div>';
							  //str=str+'<li class="item"><div class="row"><div class="col-sm-12"><label class="font-thin">'+(i+1)+'</label>&nbsp;<label class="font-thin">'+obj.movement[i].codtrn_name+'</label></div></div><div class="row"><div class="col-sm-12"><label class="font-thin" style="background-color: #00a65a;">เธกเธตเธเธฅ&nbsp;</label><label class="font-thin" style="background-color: #00a65a;">'+obj.movement[i].dteeffec+'&nbsp;</label><label class="font-thin" style="background-color: #00a65a;">'+obj.movement[i].codpos_name_new+'</label></div></div><div class="row"><div class="col-sm-12"><label class="font-thin">'+obj.movement[i].codcomp_name_new+'</label>&nbsp;&nbsp;<label class="font-thin">เธฃเธฐเธ”เธฑเธ&nbsp;'+obj.movement[i].typemp_new+'</label></div></div></li>';
							  //}else{
						//	str2=str2+'<div class="row"><div class="col-sm-4"><label class="font-thin">'+(i+1)+'</label>&nbsp;<label class="font-thin">'+obj.movement[i].codtrn_name+'</label></div><div class="col-sm-4"><label class="font-thin" >เธกเธตเธเธฅ&nbsp;</label><label class="font-thin" >'+obj.movement[i].dteeffec+'&nbsp;</label><label class="font-thin" >'+obj.movement[i].codpos_name_new+'</label></div><div class="col-sm-4"><label class="font-thin">'+obj.movement[i].codcomp_name_new+'</label>&nbsp;&nbsp;<label class="font-thin">เธฃเธฐเธ”เธฑเธ&nbsp;'+obj.movement[i].typemp_new+'</label></div></div>';
						 // str=str+'<li class="item"><div class="row"><div class="col-sm-12"><label class="font-thin">'+(i+1)+'</label>&nbsp;<label class="font-thin">'+obj.movement[i].codtrn_name+'</label></div></div><div class="row"><div class="col-sm-12"><label class="font-thin">เธกเธตเธเธฅ</label>&nbsp;<label class="font-thin">'+obj.movement[i].dteeffec+'</label>&nbsp;<label class="font-thin">'+obj.movement[i].codpos_name_new+'</label></div></div><div class="row"><div class="col-sm-12"><label class="font-thin">'+obj.movement[i].codcomp_name_new+'</label>&nbsp;&nbsp;<label class="font-thin">เธฃเธฐเธ”เธฑเธ&nbsp;'+obj.movement[i].typemp_new+'</label></div></div></li>';
						  //}
					  }
					  str=str+'</ul>';
					  str2=str2+'<li class="item profile-list"></li></ul>';
				  // $('#divMoveMent').html(str);
				   $('#divMoveMent2').html(str2);
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
	</script>
<div style="background-color: white;">
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
								<label class="col-sm-2 control-label"></label>
								<div class="col-sm-6">
									<button type="button" class="btn pull-right custom-button"
										onclick="PreInitMember2();">
										<span class="glyphicon glyphicon-search"></span>&nbsp;
										<spring:message code="member.history.criteria.search" />
									</button>
								</div>
							</div>
						</div>

					</div>

				</form>

			</div>
		</div>

	</div>
	<div class="row">
		<div class="col-lg-12">
			<form class="form-horizontal">

				<div class="row">
					<div class="col-sm-12">
						<!-- Custom Tabs -->
						<div class="nav-tabs-custom" style="box-shadow: none;">
							<ul class="nav nav-tabs custom-tabs">
								<li class="active"><a href="#tab_1" data-toggle="tab"><spring:message
											code="member.history.tab1" /></a></li>
								<li><a href="#tab_2" data-toggle="tab"><spring:message
											code="member.history.tab2" /></a></li>
							</ul>
							<div class="tab-content" style="box-shadow: none;">
								<div class="tab-pane active" id="tab_1">
									<div class="box-body">
										<div class="row custom-row">
											<div class="col-xs-6 col-sm-2">
												<label for="lblEmpID" class="font-large-profile"><spring:message
														code="memberั.history.empid" /></label> &nbsp;
											</div>
											<div class="col-xs-6 col-sm-10">
												<label id="lblEmpID" class="font-thin font-large-profile"></label>
											</div>
										</div>
										<div class="row custom-row">
											<div class="col-xs-12 col-sm-2">
												<label for="lblName" class="font-large-profile"><spring:message
														code="member.history.name" /></label> &nbsp;
											</div>
											<div class="col-xs-12 col-sm-10">
												<label id="lblName" class="font-thin font-large-profile">
												</label>
											</div>
										</div>
										<div class="row custom-row">
											<div class="col-xs-12 col-sm-2">
												<label for="lblNameEn" class="font-large-profile"><spring:message
														code="member.history.name_en" /></label> &nbsp;
											</div>
											<div class="col-xs-12 col-sm-10">
												<label id="lblNameEn" class="font-thin font-large-profile">
												</label>
											</div>
										</div>
										<div class="row custom-row">
											<div class="col-xs-3 col-sm-2">
												<label for="lblBirthDate" class="font-large-profile"><spring:message
														code="member.history.birthdate" /></label>

											</div>
											<div class="col-xs-6 col-sm-2">
												<label id="lblBirthDate"
													class="font-thin font-large-profile"> </label>
											</div>
											<div class="row col-xs-12 col-sm-8">
												<label for="lblAge"
													class="font-large-profile col-xs-4 col-sm-1"
													style="padding-right: 0px;"><spring:message
														code="member.history.age" /></label> <label id="lblAge"
													class="font-thin font-large-profile"> </label> <label
													for="lblAgeYear" class="font-large-profile"><spring:message
														code="member.history.year" /></label>&nbsp; <label
													id="lblAgeMonth" class="font-thin font-large-profile">
												</label> <label for="lblAgeMonth" class="font-large-profile"><spring:message
														code="member.history.month" /></label>&nbsp;
											</div>
										</div>
										<div class="row custom-row">
											<div class="col-xs-12 col-sm-2">
												<label for="lblEdu" class="font-large-profile"><spring:message
														code="member.history.education" /></label>
											</div>
											<div class="col-xs-12 col-sm-10">
												<label id="lblEdu" class="font-thin font-large-profile">
												</label>
											</div>
										</div>
										<div class="row custom-row">
											<div class="col-xs-12 col-sm-2">
												<label for="lblMajor" class="font-large-profile"><spring:message
														code="member.history.major" /></label> &nbsp;
											</div>
											<div class="col-xs-12 col-sm-10">
												<label id="lblMajor" class="font-thin font-large-profile">
												</label>
											</div>
										</div>
										<div class="row custom-row">
											<div class="col-xs-12 col-sm-2">
												<label for="lblInstitute" class="font-large-profile"><spring:message
														code="member.history.institute" /></label> &nbsp;
											</div>
											<div class="col-xs-12 col-sm-10">
												<label id="lblInstitute"
													class="font-thin font-large-profile"> </label>
											</div>
										</div>
										<div class="row custom-row">
											<div class="col-xs-12 col-sm-2">
												<label for="lblPosition" class="font-large-profile"><spring:message
														code="member.history.position" /></label> &nbsp;
											</div>
											<div class="col-xs-12 col-sm-10">
												<label id="lblPosition" class="font-thin font-large-profile">
												</label>
											</div>
										</div>
										<div class="row custom-row">
											<div class="col-xs-12 col-sm-2">
												<label for="lblPositionEn" class="font-large-profile"><spring:message
														code="member.history.position_en" /></label> &nbsp;
											</div>
											<div class="col-xs-12 col-sm-10">
												<label id="lblPositionEn"
													class="font-thin font-large-profile"> </label>
											</div>
										</div>
										<div class="row custom-row">
											<div class="col-sm-12 col-sm-2">
												<label for="lblTypemp" class="font-large-profile"><spring:message
														code="member.history.typemp" /></label>
											</div>
											<div class="col-sm-12 col-sm-10">
												<label id="lblTypemp" class="font-thin font-large-profile">
												</label>
											</div>
										</div>
										<div class="row custom-row">
											<div class="col-xs-12 col-sm-2">
												<label for="lblDepartMent" class="font-large-profile"><spring:message
														code="member.history.department" /></label> &nbsp;
											</div>
											<div class="col-xs-12 col-sm-10">
												<label id="lblDepartMent"
													class="font-thin font-large-profile"> </label>
											</div>
										</div>
										<div class="row custom-row">
											<div class="col-xs-12 col-sm-2">
												<label for="lblDepartMentEn" class="font-large-profile"><spring:message
														code="member.history.department_en" /></label> &nbsp;
											</div>
											<div class="col-xs-12 col-sm-10">
												<label id="lblDepartMentEn"
													class="font-thin font-large-profile"> </label>
											</div>
										</div>
										<div class="row custom-row">
											<div class="col-sm-12 col-sm-2">
												<label for="lblEmpType" class="font-large-profile"><spring:message
														code="member.history.emptype" /></label> &nbsp;
											</div>
											<div class="col-sm-12 col-sm-10">
												<label id="lblEmpType" class="font-thin font-large-profile">
												</label>
											</div>
										</div>
										<div class="row custom-row">
											<div class="col-xs-12 col-sm-2">
												<label for="lblMemberDate" class="font-large-profile"><spring:message
														code="member.history.memberdate" /></label> &nbsp;
											</div>
											<div class="col-xs-12 col-sm-10">
												<label id="lblMemberDate"
													class="font-thin font-large-profile"> </label>
											</div>
										</div>
										<div class="row custom-row" id="divEmpDate">
											<div class="col-sm-12">
												<label for="lblEmpDate" class="font-large-profile"><spring:message
														code="member.history.empdate" /></label> &nbsp; <label
													id="lblEmpDate" class="font-thin font-large-profile">
												</label> &nbsp; <label for="lblEmpDateTo" id="lblEmpDateToH"
													class="font-large-profile"><spring:message
														code="member.history.empdateto" /></label> &nbsp; <label
													id="lblEmpDateTo" class="font-thin font-large-profile">
												</label>
											</div>
										</div>
										<div class="row custom-row">
											<div class="col-xs-12 col-sm-2">
												<label for="lblExpen" class="font-large-profile"><spring:message
														code="member.history.experience" /></label> &nbsp;
											</div>
											<div class="col-xs-12 col-sm-10">
												<label id="lblExpen" class="font-thin font-large-profile">
												</label> <label for="lblExpenYear" class="font-large-profile"><spring:message
														code="member.history.year" /></label>&nbsp; <label
													id="lblExpenMonth" class="font-thin font-large-profile">
												</label>&nbsp; <label for="lblExpenMonth" class="font-large-profile"><spring:message
														code="member.history.month" /></label>&nbsp;
											</div>
										</div>
										<div class="row custom-row">
											<div class="col-xs-12 col-sm-2">
												<label for="lblEmpStatus" class="font-large-profile"><spring:message
														code="member.history.empstatus" /></label> &nbsp;
											</div>
											<div class="col-xs-12 col-sm-10">
												<label id="lblEmpStatus"
													class="font-thin font-large-profile"> </label>
											</div>
										</div>
										<div class="row custom-row">
											<div class="col-xs-12 col-sm-2">
												<label for="lblLeader" class="font-large-profile"><spring:message
														code="member.history.leader" /></label> &nbsp;
											</div>
											<div class="col-xs-12 col-sm-10">
												<label id="lblLeader" class="font-thin font-large-profile">
												</label>
											</div>
										</div>
									</div>
								</div>

								<!-- /.tab-pane -->
								<div class="tab-pane" id="tab_2">
									<!-- /.box-header -->
									<div>
										<div id="divMoveMent2"></div>
										<div id="divMoveMent" width="100%"></div>
									</div>
								</div>
							</div>

						</div>
					</div>
					<!-- /.col -->
				</div>


				<!-- /.box-footer -->
			</form>


		</div>

	</div>

</div>
