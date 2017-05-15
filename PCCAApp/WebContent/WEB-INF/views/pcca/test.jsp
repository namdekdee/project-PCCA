<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<style>
#btnCaCancel.btn-primary {
	background-color: #e62e00;
	border-color: transparent;
}

#btnCaReqApprove.btn-primary {
	background-color: #009900;
	border-color: transparent;
}

#btnCaReqApprove:hover {
	background-color: #008000;
}

#btnCaCancel:hover {
	background-color: #cc2900;
}
</style>
<script>
	$('document').ready(function() {
		initdropdown();
	});

	function initdropdown() {
		SetDropDownCompany('ddlCaList');
	}

	function SetDropDownCompany(id) {
		try {

			jQuery.ajax({
				url : 'util-getcompany',
				type : "Post",
				contentType : "application/json",
				dataType : 'json',
				success : function(obj) {
					console.log(obj);
					$('#' + id).find('option').remove().end();
					var select = document.getElementById(id);
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

		} catch (ex) {
			HideWaiting();
			ShowErrorMsg('0006', ex);
		}
	}

	function AddCaList() {

		alert($(".form-group").length)

		var length = $("#fromCompanyDiv").length,
		//create new id
		newId = "AmountCaDiv-" + length,
		//clone first element with new id
		clone = $("#AmountCaDiv").clone().attr("id", newId);
		//append clone on the end
		$("#addCompanyDiv").append(clone);
		//$("#addFromCaCompany").clone().appendTo("#addFromCaCompany");

		//get length of selections
		length = $("#fromCompanyDiv").length,
		//create new id
		newId = "fromCompanyDiv-" + length,
		//clone first element with new id
		clone = $("#fromCompanyDiv").clone().attr("id", newId);
		clone.children('.form-control').attr('id',
				'ddlCompany-' + length++);
		//append clone on the end
		$("#addCompanyDiv").append(clone);
		//get length of selections
	}
</script>
<div>
	<div class="row"
		style="background-color: #DCDCDC; padding-top: .5em; display: flex; flex-flow: row nowrap; height: 2.5em;">

		<div class="col-md-4 col-xs-4 text-left">
			<label id="lblDlgName">(3)</label>
		</div>
		<div class="col-md-4 col-xs-4 text-center">
			<label id="lblDlgName">ขอเบิกเงินทดรอง</label>
		</div>
		<div class="col-md-4 col-xs-4 text-right">
			<label id="lblDlgName" class="glyphicon glyphicon-remove-circle"></label>
		</div>
	</div>

	<div class="row" style="background-color: #C0C0C0;">
		<div class="col-xs-12 col-sm-7 col-md-7 col-md-offset-1">
			<label id="lblCaNo">เลขที่รายการ 555555</label>
		</div>
		<div class="col-xs-6 col-md-4" style="text-align: justify;">PTG</div>
		<br>
		<div class="col-xs-12 col-sm-7 col-md-7 col-md-offset-1">
			<label id="lblEmpId">12345</label>
		</div>
		<div class="col-xs-6 col-md-4">
			<label id="lblEmpName">นายอัครพงษ์ สกุลดี</label>
		</div>
		<br>
		<div class="col-xs-12 col-sm-7 col-md-7 col-md-offset-1">
			<label id="lblEmpPos">ผู้จัดการสถานี</label>
		</div>
		<div class="col-xs-6 col-md-4">
			<label id="lblEmpBranch">สาขาเขาย้อย</label>
		</div>
	</div>
	<br>

	<form class="form-horizontal"
		style="padding-left: 10px; padding-right: 10px;">
		<div class="box-body">
			<div class="row">
				<div class="form-group">
					<label for="ddlCaList" class="col-sm-2 control-label" required>
						<%-- 									<spring:message code="member.worktime.criteria.company" /> --%>
						รายการที่ขอเบิก <span style="color: red;">*</span>
					</label>
					<div class="col-sm-6">
						<select id="ddlCaList" class="form-control select2" onchange=""
							style="width: 100%;" data-placeholder="เลือกรายการที่ขอเบิก">
						</select>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="form-group">
					<label for="inputCaObj" id="lblCaObj"
						class="col-sm-2 control-label"> <!-- input id="chkUser" type="checkbox" class="minimal" />&nbsp;-->
						<%-- 										<spring:message code="member.history.criteria.user" /> --%>
						วัตถุประสงค์
					</label>
					<div class="col-sm-6">
						<input type="text" id="inputCaObj" class="form-control"
							placeholder="ระบุ...">
					</div>

				</div>
			</div>

			<div class="row">
				<div class="form-group">
					<label class="col-sm-2 control-label" id="lblStartDate" required>
						<%-- 					<spring:message code="member.worktime.criteria.date" /> --%>
						ตั้งแต่วันที่ <span style="color: red;">*</span>
					</label>

					<div class="col-sm-2">
						<input type="text" class="custom-text-horizon-rangdate2"
							maxlength="10" id="txtStartDate"
							data-inputmask="'mask': '99/99/9999'" data-mask
							data-provide="datepicker">
					</div>
					<div>
						<label class="col-sm-2 control-label" id="lblEndDate">ถึงวันที่</label>
						<div class="col-sm-2">
							<input type="text" class="custom-text-horizon-rangdate2"
								maxlength="10" id="txtEndDate"
								data-inputmask="'mask': '99/99/9999'" data-mask
								data-provide="datepicker">
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="form-group">
					<label for="ddlDateGetCash" class="col-sm-2 control-label" required>
						<%-- 									<spring:message code="member.worktime.criteria.company" /> --%>
						วันที่ขอรับเงิน <span style="color: red;">*</span>
					</label>
					<div class="col-sm-2">
						<select id="ddlDateGetCash" class="form-control select2"
							onchange="SetDropDown();" style="width: 100%;"
							data-placeholder="เลือกวันที่">
						</select>
					</div>
					<div>
						<label class="col-sm-2 control-label" id="lblPaidDate">จะจ่ายเงินวันที่</label>
						<div class="col-sm-2">
							<input type="text" id="inputPaidDate" class="form-control"
								placeholder="16 กพ 60" readonly>
						</div>
					</div>
				</div>
			</div>
			<div class="row" id="addCompanyDiv">
				<div class="form-group" id="fromCompanyDiv">
					<label id="lblCaCompany" class="col-sm-2 control-label" required>
						<%-- 									<spring:message code="member.worktime.criteria.company" /> --%>
						เบิกจากบริษัท
					</label>
					<div class="col-sm-6">
						<select id="ddlCompany" class="form-control select2" style="width: 100%;"
							data-placeholder="เลือกบริษัท">
							<option value="volvo">Volvo</option>
							<option value="saab">Saab</option>
						</select>
					</div>
				</div>
			</div>
			<div class="row" id="addAmountCaDiv">
				<div class="form-group" id="AmountCaDiv">
					<label class="col-sm-2 control-label" id="lblCaAmount" required>
						<%-- 					<spring:message code="member.worktime.criteria.date" /> --%>
						จำนวนเงิน <span style="color: red;">*</span>
					</label> <span class="col-sm-2"> <input type="text"
						id="inputCaAmount" class="form-control" placeholder="ระบุ...">
					</span>
				</div>
			</div>

			<div class="row">
				<div class="col-sm-3 control-label">
					<button type="button" style="width: 150px;"
						class="btn btn-primary pull-right" id="btnAddCaList"
						onclick="AddCaList();">เพิ่มรายการ</button>
				</div>
			</div>

			<div class="row">
				<div class="col-sm-2 col-sm-offset-2">
					<div class="checkbox">
						<label> <input id="inputAcceptCond" type="checkbox"
							class="minimal" style="position: absolute; opacity: 0;">
							รับทราบเงื่อนไข
						</label>
					</div>
				</div>
			</div>
			<br>

			<div class="row">
				<div class="form-group">
					<div class="col-sm-2 col-sm-offset-2" style="display: flex;">
						<button type="button" style="width: 150px;"
							class="btn btn-primary pull-right" id="btnCaCancel" onclick="">ยกเลิก</button>
					</div>
					<div>
						<div class="col-sm-2" style="display: flex;">
							<button type="button" style="width: 150px;"
								class="btn btn-primary" id="btnCaReqApprove" onclick="">ขออนุมัติ</button>
						</div>
					</div>
				</div>
			</div>
		</div>
</div>
<!-- /.box-body -->




