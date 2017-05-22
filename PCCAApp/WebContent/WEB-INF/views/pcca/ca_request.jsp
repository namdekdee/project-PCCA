<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<script>
	$('document').ready(function() {
		initdropdown();
		$('#myModal').modal('show');

		var length = 1;
		$("#btnAddCaList").click(function() {
			alert();
			clone = $("#addList").clone()
			$("#addList").append(clone).attr('id', 'aa-' + length++);
		})

	});

	function popUpReq() {
		if (document.getElementById("ddlCaList").value == "forComp") {
			// 			alert("ModalForComp");
			$('#modalRequest').modal('show');
			document.getElementById("lblForComp").style.display = 'block';

		} else {
			// 			alert("Modal");
			$('#modalRequest').modal('show');

		}

	}
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

		//alert($(".form-group").length)

		var length = $("#formCompanyDiv").length,
		//create new id
		newId = "AmountCaDiv-" + length,
		//clone first element with new id
		clone = $("#AmountCaDiv").clone().attr("id", newId);
		//append clone on the end
		$("#addCompanyDiv").append(clone);
		//$("#addFromCaCompany").clone().appendTo("#addFromCaCompany");

		//get length of selections
		length = $("#formCompanyDiv").length,
		//create new id
		newId = "formCompanyDiv-" + length,
		//clone first element with new id
		clone = $("#formCompanyDiv").clone().attr("id", newId);
		clone.children('.form-control').attr('id', 'ddlCompany-' + length++);
		//append clone on the end
		$("#addCompanyDiv").append(clone);
		//get length of selections
	}
</script>
<div>
	<div class="row"
		style="background-color: #DCDCDC; padding-top: .5em; display: flex; flex-flow: row nowrap; height: 2.5em;">

		<div class="col-md-4 col-xs-2 text-left">
			<span class="badge">5</span>
		</div>
		<div class="col-md-4 col-xs-8 text-center">
			<label id="lblDlgName" class="PageTitle">ขอเบิกเงินทดรอง</label>
		</div>
		<div class="col-md-4 col-xs-2 text-right">
			<label id="lblDlgName" class="glyphicon glyphicon-remove-circle"></label>
		</div>
	</div>

	<div class="row" style="background-color: rgba(81, 239, 0, 0.17);">
		<div class="col-xs-12 col-sm-7 col-md-7 col-md-offset-1"
			style="padding-top: 5px;">
			<label id="lblCaNo">เลขที่รายการ 555555</label>
		</div>
		<div class="col-xs-6 col-md-4"
			style="text-align: justify; padding-top: 5px;">
			<label id="lblCaNo">PTG</label>
		</div>
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
					<label for="ddlCaList" class="col-sm-3 control-label" required>
						<%-- 									<spring:message code="member.worktime.criteria.company" /> --%>
						รายการที่ขอเบิก <span style="color: red;">*</span>
					</label>
					<div class="col-sm-6">
						<select id="ddlCaList" class="form-control select2" onchange=""
							style="width: 100%;" data-placeholder="เลือกรายการที่ขอเบิก">
							<option value="forComp">ค่าใช้จ่ายเพื่อบริษัท</option>
							<option value="openBranch">ค่าใช้จ่ายเพื่อเปิดสาขา</option>
							<option value="forRegist">ค่าใช้จ่ายเพื่อจดสิทธิ์</option>
						</select>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="form-group">
					<label for="inputCaObj" id="lblCaObj"
						class="col-sm-3 control-label"> <!-- input id="chkUser" type="checkbox" class="minimal" />&nbsp;-->
						<%-- 										<spring:message code="member.history.criteria.user" /> --%>
						วัตถุประสงค์
					</label>
					<div class="col-sm-6">
						<input type="text" id="inputCaObj" class="form-control"
							placeholder="ระบุ..." maxlength="50">
					</div>

				</div>
			</div>

			<div class="row">
				<div class="form-group">
					<label class="col-sm-3 control-label" id="lblStartDate" required>
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
					<label for="ddlDateGetCash" class="col-sm-3 control-label" required>
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
			<div id="addList">
				<div class="row" id="addCompanyDiv">
					<div class="form-group" id="formCompanyDiv">
						<label id="lblCaCompany" class="col-sm-3 control-label" required>เบิกจากบริษัท</label>
						<div class="col-sm-6">
							<select id="ddlCompany" class="form-control" style="width: 100%;"
								data-placeholder="เลือกบริษัท">
								<option value="PTG">PTG พีทีจี เอ็นเนอยี</option>
								<option value="PTC">PTC พีทีซี</option>
								<option value="PUN">PUN กาแฟพันธุ์ไทย</option>
								<option value="PTGLG">PTGLG พีทีจี โลจิสติก</option>
							</select>
						</div>
					</div>
				</div>

				<div class="row" id="addAmountCaDiv">
					<div class="form-group" id="AmountCaDiv">
						<label id="lblCaAmount" class="col-sm-3 control-label">
							จำนวนเงิน </label>
						<div class="col-sm-2">
							<input type="text" id="inputCaAmount" class="form-control"
								placeholder="ระบุ...">
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-sm-3 col-sm-offset-5 control-label">
					<button type="button" style="width: 150px;"
						class="btn btn-primary center-block" id="btnAddCaList"
						onclick="length++">เพิ่มรายการ</button>
				</div> 
			</div>

			<div class="row">
				<div class="col-sm-2 col-sm-offset-3">
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
					<div class="col-sm-2 col-sm-offset-3" style="display: flex;">
						<button type="button" style="width: 80%;"
							class="btn btn-primary center-block" id="btnCaCancel"
							onclick="location.href='ca_home';">ยกเลิก</button>
					</div>
					<div>
						<div class="col-sm-2" style="display: flex;">
							<button type="button" style="width: 80%;"
								class="btn btn-primary center-block" id="btnCaReqApprove"
								onclick="popUpReq();">ขออนุมัติ</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</form>
</div>
<!-- /.box-body -->

<!-- Modal Approver-->
<div class="modal fade" id="myModal" role="dialog">
	<div class="modal-dialog modal-sm">

		<!-- Modal content-->
		<div class="modal-content" style="background-color: #ffff33;">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h4 class="modal-title">รายการหนี้คงค้าง</h4>
			</div>
			<div class="modal-body">
				<div class="table-responsive">
					<table class="table table-striped">
						<tbody>
							<tr class="active">
								<td class="col-sm-4">เลขที่รายการ 525523<br>งานภายนอก
									เชียงใหม่
								</td>
								<td class="col-sm-4">1,000 บาท</td>
							</tr>
							<tr class="success">
								<th class="col-sm-4">เลขที่รายการ 525523<br>งานภายนอก
									เชียงใหม่
								</th>

								<td class="col-sm-4">1,000 บาท</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary center-block"
					data-dismiss="modal">รับทราบ</button>
			</div>
		</div>

	</div>
</div>

<!-- Modal Request-->
<div class="modal fade" id="modalRequest" role="dialog">
	<div class="modal-dialog modal-sm">

		<!-- Modal content-->
		<div class="modal-content" style="background-color: #ffff33;">
			<div class="modal-body">
				<label style="text-align: center;">ถ้าอนุมัติภายในวันที่ <br>
					$Date <br> จะได้รับเงินวันที่ <br> $Date<br> <br>
					โปรดเคลียร์เงินทดรองภายในเวลาที่บริษัทกำหนด
				</label> <label id="lblForComp" style="text-align: center; display: none;">กรณีเบิกค่าใช้จ่ายในการเดินทาง
					ต้องทำใบปฏิบัติงานภายนอกภายใน15วัน</label>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary center-block"
					data-dismiss="modal">รับทราบ</button>
			</div>
		</div>

	</div>
</div>



