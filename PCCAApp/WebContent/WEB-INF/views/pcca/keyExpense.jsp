<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<style>
.listHead {
	padding-top: 10px;
	margin-bottom: 0;
	text-align: center;
}
</style>
<script>
	$('document').ready(function() {
		initdropdown();
		$('#TransportForm').hide();
		$('#ServiceForm').hide();
		//$('#Accommodation').hide();
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

	function AddExpense() {

		alert("AddExpense");

		// 		var length = $("#divExpenseForm").length,
		// 		//create new id
		// 		newId = "divExpenseForm-" + length,
		// 		//clone first element with new id
		// 		clone = $("#divExpenseForm").clone().attr("id", newId);
		// 		//append clone on the end
		// 		$("#divExpenseForm").append(clone);
		// 		//$("#addFromCaCompany").clone().appendTo("#addFromCaCompany");

	}

	function showDiv(ddlType) {
		if (ddlType.value == 'ddlPhone') {
			alert("showDiv");
			document.getElementById('ServiceForm').style.display = "block";
			$('#TransportForm').hide();
			$('#Accommodation').hide();
		} else if (ddlType.value == 'ddlTrasport') {
			alert("showDiv");
			document.getElementById('TransportForm').style.display = "block";
			$('#ServiceForm').hide();
			$('#Accommodation').hide();
		} else if (ddlType.value == 'ddlAccom') {
			alert("showDiv");
			document.getElementById('Accommodation').style.display = "block";
			$('#ServiceForm').hide();
			$('#TransportForm').hide();
		}

	}
</script>

<div>
	<div class="row"
		style="background-color: #DCDCDC; padding-top: .5em; display: flex; flex-flow: row nowrap; height: 2.5em;">

		<div class="col-md-4 col-xs-2 text-left">
			<span class="badge">5</span><br>
		</div>
		<div class="col-md-4 col-xs-8 text-center">
			<label id="lblDlgName" class="PageTitle">บันทึกรายการค่าใช้จ่าย</label>
		</div>
		<div class="col-md-4 col-xs-2 text-right">
			<label id="lblDlgName" class="glyphicon glyphicon-remove-circle"></label>
		</div>
	</div>

	<div class="box-body">
		<div class="row">
			<div class="form-group">
				<label for="lblvat" class="col-sm-3 control-label"> <%-- 									<spring:message code="member.worktime.criteria.company" /> --%>
					20 มีค 60
				</label> <label for="ddlCaList" class="col-sm-2 control-label" required>
					<%-- 									<spring:message code="member.worktime.criteria.company" /> --%>
					รวมจำนวนเงิน
				</label>
				<div class="col-sm-3">
					<input type="text" id="inputCaObj" class="form-control"
						placeholder="0.00" readonly>
				</div>
				<span class="glyphicon glyphicon-btc control-label"
					aria-hidden="true"></span>
			</div>
		</div>
	</div>


	<div id="divExpenseForm">
		<form class="form-horizontal"
			style="padding-left: 10px; padding-right: 10px;">

			<div class="row col-sm-8 col-sm-offset-2"
				style="background-color: #00b359;">
				<div class="form-group">
					<label for="ddlCaList" class="col-sm-6 listHead" required>
						<%-- 									<spring:message code="member.worktime.criteria.company" /> --%>
						รายการหลัก
					</label> <label for="ddlCaList" class="col-sm-6 listHead" required>
						<%-- 									<spring:message code="member.worktime.criteria.company" /> --%>
						รายการย่อย
					</label>
				</div>
			</div>
			<div class="row col-sm-8 col-sm-offset-2"
				style="padding-top: 10px; background-color: white;">
				<div class="form-group">
					<div class="col-sm-6">
						<select id="ddlCompany" class="form-control" style="width: 100%;"
							data-placeholder="เลือก" onchange="showDiv(this)">
							<%-- 							<select id="ddlCompany" class="form-control select2" style="width: 100%;" --%>
							<!-- 							data-placeholder="เลือกบริษัท"> -->
							<option value="ddlPhone">ค่าโทรศัพท์,อินเทอร์เน็ต</option>
							<option value="ddlTrasport">ค่าเดินทาง</option>
							<option value="ddlAccom">ค่าใช้จ่ายพนักงาน</option>
						</select>
					</div>
					<div class="col-sm-6">
						<select id="ddlCompany" class="form-control" style="width: 100%;"
							data-placeholder="เลือก">
							<%-- 							<select id="ddlCompany" class="form-control select2" style="width: 100%;" --%>
							<!-- 							data-placeholder="เลือกบริษัท"> -->
							<option value="phone">ค่าโทรศัพท์</option>
							<option value="trans">ค่าเดินทาง</option>
							<option value="accom">ค่าที่พัก</option>
						</select>
					</div>
				</div>
			</div>
		</form>

	</div>
	<div id="ServiceForm" style="background-color: white;">
		<form class="form-horizontal"
			style="padding-left: 10px; padding-right: 10px;">
			<div class="box-body col-sm-8 col-sm-offset-2"
				style="background-color: white;">
				<div class="row">
					<div class="form-group">
						<label for="lblvat" class="col-sm-3 control-label"> <%-- 									<spring:message code="member.worktime.criteria.company" /> --%>
							รายการที่เบิก
						</label>
						<div class="col-sm-5">
							<input type="text" id="inputCaObj" class="form-control"
								placeholder="ระบุ...">
						</div>
					</div>
				</div>
				<div class="row">
					<div class="form-group">
						<label for="lblvat" class="col-sm-3 control-label"> <%-- 									<spring:message code="member.worktime.criteria.company" /> --%>
							จำนวน
						</label>
						<div class="col-sm-3">
							<input type="text" id="inputCaObj" class="form-control"
								placeholder="ระบุ...">
						</div>
						<div class="col-sm-2">
							<select id="ddlCompany" class="form-control" style="width: 100%;"
								data-placeholder="เลือก">
								<%-- 							<select id="ddlCompany" class="form-control select2" style="width: 100%;" --%>
								<!-- 							data-placeholder="เลือกบริษัท"> -->
								<option value="ddlother">อื่นๆ</option>
							</select>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="form-group">
						<label for="lblvat" class="col-sm-3 control-label"> <%-- 									<spring:message code="member.worktime.criteria.company" /> --%>

						</label>
						<div class="col-sm-3">
							<input type="text" id="inputCaObj" class="form-control"
								placeholder="ระบุ..." readonly>
						</div>
						<div class="col-sm-2">
							<select id="ddlCompany" class="form-control" style="width: 100%;"
								data-placeholder="เลือก" disabled="disabled">
								<%-- 							<select id="ddlCompany" class="form-control select2" style="width: 100%;" --%>
								<!-- 							data-placeholder="เลือกบริษัท"> -->
								<option value="ddlother">อื่นๆ</option>
							</select>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="form-group">
						<label for="lblvat" class="col-sm-3 control-label"> <%-- 									<spring:message code="member.worktime.criteria.company" /> --%>
							อัตราแลกเปลี่ยน 1:
						</label>
						<div class="col-sm-2">
							<input type="text" id="inputCaObj" class="form-control"
								placeholder="ระบุ...">
						</div>
					</div>
				</div>
				<div class="row">
					<div class="form-group">
						<label for="lblvat" class="col-sm-3 control-label"> <%-- 									<spring:message code="member.worktime.criteria.company" /> --%>
							เลขที่ใบเสร็จ
						</label>
						<div class="col-sm-3">
							<input type="text" id="inputCaObj" class="form-control"
								placeholder="ระบุ...">
						</div>
					</div>
				</div>
				<div class="row">
					<div class="form-group">
						<div class="col-sm-2 col-sm-offset-2">
							<div class="checkbox">
								<label> <input id="chkVat" type="checkbox"
									class="minimal" style="position: absolute; opacity: 0;">
									VAT
								</label>
							</div>
						</div>
						<div class="col-sm-2">
							<div class="checkbox">
								<label> <input id="chkWht" type="checkbox"
									class="minimal" style="position: absolute; opacity: 0;">
									WHT
								</label>
							</div>
						</div>
						<div class="col-sm-2">
							<div class="checkbox">
								<label> <input id="chkWht" type="checkbox"
									class="minimal" style="position: absolute; opacity: 0;">
									ไม่ทราบ
								</label>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-sm-3 col-sm-offset-5 control-label">
						<button type="button" style="width: 150px;"
							class="btn btn-primary pull-right" id="btnAddCaList"
							onclick="AddExpense();">เพิ่มรายการ</button>
					</div>
				</div>
			</div>
		</form>
	</div>

	<div id="TransportForm" style="background-color: white;">
		<form class="form-horizontal"
			style="padding-left: 10px; padding-right: 10px;">
			<div class="box-body col-sm-8 col-sm-offset-2"
				style="background-color: white;">
				<div class="row">
					<div class="form-group">
						<label for="lblvat" class="col-sm-3 control-label"> <%-- 									<spring:message code="member.worktime.criteria.company" /> --%>
							ระบุสถานที่เริ่มต้น
						</label>
						<div class="col-sm-6">
							<input type="text" id="inputCaObj" class="form-control"
								placeholder="ระบุ...">
						</div>
					</div>
				</div>
				<div class="row">
					<div class="form-group">
						<label for="lblvat" class="col-sm-3 control-label"> <%-- 									<spring:message code="member.worktime.criteria.company" /> --%>
							ออกจาก
						</label>
						<div class="col-sm-3">
							<select id="ddlFrom" class="form-control" style="width: 100%;"
								data-placeholder="เลือก">
								<%-- 							<select id="ddlCompany" class="form-control select2" style="width: 100%;" --%>
								<!-- 							data-placeholder="เลือกบริษัท"> -->
								<option value="ddlHome">ที่พัก</option>
								<option value="ddlWork">ที่ทำงาน</option>
							</select>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="form-group">
						<label for="lblvat" class="col-sm-3 control-label">
							ทะเบียนรถ </label>
						<div class="col-sm-3">
							<input type="text" id="inputCaObj" class="form-control"
								placeholder="ระบุ...">
						</div>
					</div>
				</div>
				<div class="row">
					<div class="form-group">
						<label for="lblvat" class="col-sm-3 control-label"> <%-- 									<spring:message code="member.worktime.criteria.company" /> --%>
							เลขไมล์เริ่มต้น
						</label>
						<div class="col-sm-2">
							<input type="text" id="inputCaObj" class="form-control"
								placeholder="ระบุ...">
						</div>
						<label for="lblvat" class="col-sm-2 control-label"> <%-- 									<spring:message code="member.worktime.criteria.company" /> --%>
							เลขไมล์สิ้นสุด
						</label>
						<div class="col-sm-2">
							<input type="text" id="inputCaObj" class="form-control"
								placeholder="ระบุ...">
						</div>
					</div>
				</div>
				<div class="row">
					<div class="form-group">
						<label for="lblvat" class="col-sm-3 control-label"> <%-- 									<spring:message code="member.worktime.criteria.company" /> --%>
							ระยะทาง
						</label>
						<div class="col-sm-2">
							<input type="text" id="inputCaObj" class="form-control"
								placeholder="ระบุ...">
						</div>
						<label for="lblvat" class="col-sm-2 control-label"> <%-- 									<spring:message code="member.worktime.criteria.company" /> --%>
							จำนวนเงิน
						</label>
						<div class="col-sm-2">
							<input type="text" id="inputCaObj" class="form-control"
								placeholder="ระบุ...">
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-sm-3 col-sm-offset-3 control-label">
						<button type="button" style="width: 150px;"
							class="btn btn-primary pull-right" id="btnAddCaList"
							onclick="AddExpense();">เพิ่มรายการ</button>
					</div>
					<div class="col-sm-3  control-label">
						<button type="button" style="width: 150px;"
							class="btn btn-success pull-right" id="btnAddCaList"
							onclick="AddExpense();">บันทึก</button>
					</div>
				</div>

			</div>

		</form>
	</div>

	<div id="Accommodation" style="background-color: white;">
		<form class="form-horizontal"
			style="padding-left: 10px; padding-right: 10px;">
			<div class="box-body col-sm-8 col-sm-offset-2"
				style="background-color: white;">
				<div class="row">
					<div class="form-group">
						<label for="lblvat" class="col-sm-3 control-label"> <%-- 									<spring:message code="member.worktime.criteria.company" /> --%>
							จังหวัด
						</label>
						<div class="col-sm-3">
							<select id="ddlFrom" class="form-control" style="width: 100%;"
								data-placeholder="เลือกจังหวัด">
								<%-- 							<select id="ddlCompany" class="form-control select2" style="width: 100%;" --%>
								<!-- 							data-placeholder="เลือกบริษัท"> -->
								<option value=""></option>
								<option value=""></option>
							</select>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="form-group">
						<label for="lblvat" class="col-sm-3 control-label"> <%-- 									<spring:message code="member.worktime.criteria.company" /> --%>
							อำเภอ
						</label>
						<div class="col-sm-3">
							<select id="ddlFrom" class="form-control" style="width: 100%;"
								data-placeholder="เลือกอำเภอ">
								<%-- 							<select id="ddlCompany" class="form-control select2" style="width: 100%;" --%>
								<!-- 							data-placeholder="เลือกบริษัท"> -->
								<option value=""></option>
								<option value=""></option>
							</select>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="form-group">
						<label for="lblvat" class="col-sm-3 control-label"> <%-- 									<spring:message code="member.worktime.criteria.company" /> --%>
							ตำบล
						</label>
						<div class="col-sm-3">
							<select id="ddlFrom" class="form-control" style="width: 100%;"
								data-placeholder="เลือกตำบล">
								<%-- 							<select id="ddlCompany" class="form-control select2" style="width: 100%;" --%>
								<!-- 							data-placeholder="เลือกบริษัท"> -->
								<option value=""></option>
								<option value=""></option>
							</select>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="form-group">
						<label for="lblvat" class="col-sm-3 control-label"> <%-- 									<spring:message code="member.worktime.criteria.company" /> --%>
							จำนวนคืน
						</label>
						<div class="col-sm-2">
							<input type="text" id="inputCaObj" class="form-control"
								placeholder="ระบุ...">
						</div>
						<label for="lblvat" class="col-sm-2 control-label"> <%-- 									<spring:message code="member.worktime.criteria.company" /> --%>
							ค่าที่พัก
						</label>
						<div class="col-sm-2">
							<input type="text" id="inputCaObj" class="form-control"
								placeholder="ระบุ...">
						</div>
						<div class="col-sm-2">
							<input type="text" id="inputCaObj" class="form-control"
								placeholder="ระบุ..." readonly>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="form-group">
						<label for="lblvat" class="col-sm-3 control-label"> <%-- 									<spring:message code="member.worktime.criteria.company" /> --%>
							อัตราแลกเปลี่ยน 1$:
						</label>
						<div class="col-sm-2">
							<input type="text" id="inputCaObj" class="form-control"
								placeholder="ระบุ...">
						</div>
					</div>
				</div>
				<div class="row">
					<div class="form-group">
						<label for="lblvat" class="col-sm-3 control-label"> <%-- 									<spring:message code="member.worktime.criteria.company" /> --%>
							ตั้งแต่วันที่
						</label>
						<div class="col-sm-2">
							<input type="text" id="inputCaObj" class="form-control"
								placeholder="20 มีค 60" readonly>
						</div>
						<label for="lblvat" class="col-sm-2 control-label"> <%-- 									<spring:message code="member.worktime.criteria.company" /> --%>
							ถึงวันที่
						</label>
						<div class="col-sm-2">
							<input type="text" id="inputCaObj" class="form-control"
								placeholder="21 มีค 60" readonly>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="form-group">
						<label for="lblvat" class="col-sm-3 control-label"> <%-- 									<spring:message code="member.worktime.criteria.company" /> --%>
							รหัสพนักงานที่เข้าพัก
						</label>
						<div class="col-sm-6">
							<input type="text" id="inputCaObj" class="form-control"
								placeholder="" readonly>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="form-group">
						<label for="lblvat" class="col-sm-3 control-label">
							เลขที่ใบเสร็จ </label>
						<div class="col-sm-6">
							<input type="text" id="inputCaObj" class="form-control"
								placeholder="">
						</div>
					</div>
				</div>
				<div class="row">
					<div class="form-group">
						<div class= "col-sm-2 col-sm-offset-2">
							<div class="checkbox">
								<label> <input id="chkVat" type="checkbox"
									class="minimal" style="position: absolute; opacity: 0;">
									VAT
								</label>
							</div>
						</div>
						<div class="col-sm-2">
							<div class="checkbox">
								<label> <input id="chkWht" type="checkbox"
									class="minimal" style="position: absolute; opacity: 0;">
									WHT
								</label>
							</div>
						</div>
						<div class="col-sm-2">
							<div class="checkbox">
								<label> <input id="chkWht" type="checkbox"
									class="minimal" style="position: absolute; opacity: 0;">
									ไม่ทราบ
								</label>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-sm-3 col-sm-offset-3 control-label">
						<button type="button" style="width: 150px;"
							class="btn btn-primary pull-right" id="btnAddCaList"
							onclick="AddExpense();">เพิ่มรายการ</button>
					</div>
					<div class="col-sm-3  control-label">
						<button type="button" style="width: 150px;"
							class="btn btn-success pull-right" id="btnAddCaList"
							onclick="AddExpense();">บันทึก</button>
					</div>
				</div>

			</div>

		</form>
	</div>


</div>