<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<script>
	$(document)
			.ready(
					function() {
						$('#chkRefer')
								.click(
										function() {
											if (document
													.getElementById('chkRefer').checked)
												window.open("referForm",
														"อ้างอิงใบปฏิบัติงาน",
														"width=500,height=500");
										});

						if (status == "Approve") {
							alert("Expense Approve");
							document.getElementById('lblHeadName').innerHTML = 'อนุมัติค่าใช้จ่าย';
							$("#reimburse :input").prop("disabled", true);
							$("#reimBtn1").hide();
							$("#reimBtn2").hide();
							$("#apprvComment").show();
							$("#apprvComment :input").prop("disabled", false);
							$("#apprvBtn").show();
							$("#apprvBtn :input").prop("disabled", false);
						} else {
							alert("Requester Edit");
							$("#reimBtn1").hide();
							$("#reimBtn2").hide();
							$("#reqEditBtn1").show();
							$("#apprvComment").show();
							$("#apprvComment :input").prop("disabled", true);
							$("#reqEditBtn2").show();

						}
					});

	function payin() {
		alert();
		document.getElementById('lblHeadName').innerHTML = 'Upload ใบนำฝาก';
		$("#reimBtn1").hide();
		$("#reimBtn2").hide();
		$("#reimburse :input").prop("disabled", true);
		var elems = document.getElementsByClassName("btnSave");
		for (var i = 0; i < elems.length; i++) {
			elems[i].innerHTML = "ตรวจสอบ";
		}
		$("#payinBtn :input").prop("disabled", false);
		$("#payinBtn").show();

	}
</script>
<style>
table#tbReim {
	width: 70%;
	margin: 0px auto;
}
</style>
<div id="reimburse">
	<div class="row"
		style="background-color: #DCDCDC; padding-top: .5em; display: flex; flex-flow: row nowrap; height: 2.5em;">

		<div class="col-md-4 col-xs-2 text-left">
			<span class="badge">5</span>
		</div>
		<div class="col-md-4 col-xs-8 text-center">
			<label id="lblHeadName" class="PageTitle">สรุปค่าใช้จ่าย</label>
		</div>
		<div class="col-md-4 col-xs-2 text-right">
			<label id="lblDlgName" class="glyphicon glyphicon-remove-circle"></label>
		</div>
	</div>

	<div class="row" style="background-color: rgba(81, 239, 0, 0.17);">
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
			<div class="row" id="addCompanyDiv">
				<div class="form-group" id="fromCompanyDiv">
					<label id="lblCaCompany" class="col-sm-3 control-label" required>
						<%-- 						<spring:message code="member.worktime.criteria.company" /> --%>
						เบิกจากบริษัท
					</label>
					<div class="col-sm-6">
						<select id="ddlCompany" class="form-control select2"
							style="width: 100%;" data-placeholder="เลือกบริษัท">

							<option value="PTG">PTG</option>
							<option value="PTG1">PTG1</option>
						</select>
					</div>
				</div>
			</div>

			<div class="row">
				<div class="form-group " id="haveForm">
					<div class="col-sm-6 col-sm-offset-3">
						<input id="chkRefer" type="checkbox"
							style="width: 20px; height: 20px;"> <label>มีใบปฏิบัติงาน</label>
						<input type="text" id="inputCaAmount" class="form-control"
							placeholder="ระบุ...">
					</div>
				</div>
			</div>

			<div class="row">
				<div class="form-group">
					<label class="col-sm-3 control-label" id="lblStartDate" required>
						<%-- 						<spring:message code="member.worktime.criteria.date" /> --%>
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
				<hr class="col-xs-12 col-lg-12"
					style="background-color: rgba(0, 166, 90, 0.29);">
				<label class="col-sm-2 col-sm-offset-3">1 มีค 60</label>

				<div class="col-sm-2 text-center">
					<label>จำนวนเงิน</label>
				</div>
				<div class="col-sm-2">
					<input type="text" id="inputCaAmount" class="form-control"
						placeholder="0.00" readonly>
				</div>
				<div class="col-sm-2">
					<button type="button" class="btn btn-success center-block btnSave"
						style="width: 80%;" onclick="location.href='keyExpense';">บันทึก</button>
				</div>
			</div>

			<div class="row">
				<hr class="col-xs-12 col-lg-12"
					style="background-color: rgba(0, 166, 90, 0.29);">
				<label class="col-sm-2 col-sm-offset-3">1 มีค 60</label>

				<div class="col-sm-2 text-center">
					<label>จำนวนเงิน</label>
				</div>
				<div class="col-sm-2">
					<input type="text" id="inputCaAmount" class="form-control"
						placeholder="0.00" readonly>
				</div>
				<div class="col-sm-2">
					<button type="button" class="btn btn-success center-block btnSave"
						style="width: 80%;" onclick="location.href='keyExpense';">บันทึก</button>
				</div>
			</div>



		</div>
		<!-- box-body -->
	</form>

	<div class="row" style="background-color: rgb(210, 240, 204);">
		<div class="col-xs-12 col-sm-7 col-md-6 col-md-offset-2">
			<label id="lblCaNo">รวม 3 วัน</label>
		</div>
		<div class="col-xs-6 col-md-4" style="text-align: justify;">0.00
			บาท</div>
		<br>
		<div class="col-xs-12 col-sm-7 col-md-6 col-md-offset-2">
			<label id="lblEmpId">เบิกไปแล้ว</label>
		</div>
		<div class="col-xs-6 col-md-4">
			<label id="lblEmpName">8,000.00 บาท</label>
		</div>
		<br>
		<div class="col-xs-12 col-sm-7 col-md-6 col-md-offset-2"
			style="background: red;">
			<label id="lblEmpPos">คืนเงินเต็มจำนวน</label>
		</div>
		<div class="col-xs-6 col-md-2" style="background: red;">
			<label id="lblEmpBranch">8,000.00 บาท</label>
		</div>
	</div>

	<div id="reqEditBtn1" class="row" style="display: none;">
		<br>
		<div class="form-group">
			<div class="col-sm-2 col-sm-offset-3" style="display: flex;">
				<button type="button" style="width: 150px;"
					class="btn btn-primary center-block" id="btnPayin" onclick="">พิมพ์ใบนำฝาก</button>
			</div>
			<div>
				<div class="col-sm-2 " style="display: flex;">
					<button type="button" style="width: 150px;"
						class="btn btn-primary center-block" id="btnUpload" onclick="">Upload</button>
				</div>
			</div>
		</div>
	</div>

	<div id="apprvComment" style="display: none;">
		<form class="form-horizontal"
			style="padding-left: 10px; padding-right: 10px;">
			<div class="box-body">
				<div class="row" id="addCompanyDiv">
					<div class="form-group" id="fromCompanyDiv">
						<label id="" class="col-sm-3 control-label" required>
							ความเห็นจากผู้อนุมัติ </label>
						<div class="col-sm-4">
							<textarea class="form-control" rows="4" id="commentAprv"></textarea>
						</div>
					</div>
				</div>
			</div>
		</form>
	</div>

	<div id="reqEditBtn2" class="row" style="display: none;">
		<div class="form-group">
			<div class="col-sm-2 col-sm-offset-3" style="display: flex;">
				<button type="button" style="width: 150px;"
					class="btn btn-warning center-block" id="btnSaveDraft" onclick="">บันทึกชั่วคราว</button>
			</div>
			<div>
				<div class="col-sm-2 " style="display: flex;">
					<button type="button" style="width: 150px;"
						class="btn btn-success center-block" id="btnReqAprv" onclick="">ส่งอนุมัติ</button>
				</div>
			</div>
		</div>
	</div>

	<br>

	<div id="reimBtn1" class="row">
		<div class="form-group">
			<div class="col-sm-2 col-sm-offset-3" style="display: flex;">
				<button type="button" style="width: 150px;"
					class="btn btn-warning center-block" id="btnTempSave" onclick="">บันทึกชั่วคราว</button>
			</div>
			<div>
				<div class="col-sm-2" style="display: flex;">
					<button type="button" style="width: 150px;"
						class="btn btn-success center-block" id="btnReqApprove" onclick="">ส่งอนุมัติ</button>
				</div>
			</div>
			<div>
				<div class="col-sm-2 " style="display: flex;">
					<button type="button" style="width: 150px;"
						class="btn btn-primary center-block" id="btnUpload" onclick="">Upload</button>
				</div>
			</div>
		</div>
	</div>
	<div id="payinBtn" class="row" style="display: none;">
		<div class="form-group">
			<div class="col-sm-2 col-sm-offset-3" style="display: flex;">
				<button type="button" style="width: 150px;"
					class="btn btn-primary center-block" id="btnPayin" onclick="">พิมพ์ใบนำฝาก</button>
			</div>
			<div>
				<div class="col-sm-2 " style="display: flex;">
					<button type="button" style="width: 150px;"
						class="btn btn-primary center-block" id="btnUpload" onclick="">Upload</button>
				</div>
			</div>
			<div>
				<div class="col-sm-2" style="display: flex;">
					<button type="button" style="width: 150px;"
						class="btn btn-success center-block" id="btnReqApprove" onclick="">ส่งอนุมัติ</button>
				</div>
			</div>
		</div>
	</div>



	<div id="apprvBtn" class="row" style="display: none;">
		<div class="form-group">
			<div class="col-sm-2 col-sm-offset-3" style="display: flex;">
				<button type="button" style="width: 150px;"
					class="btn btn-warning center-block" id="btnReqEdit" onclick="">ส่งแก้ไข</button>
			</div>
			<div>
				<div class="col-sm-2 " style="display: flex;">
					<button type="button" style="width: 150px;"
						class="btn btn-primary center-block" id="btnViewPayin" onclick="">ดูใบนำฝาก</button>
				</div>
			</div>
			<div id="">
				<div class="col-sm-2" style="display: flex;">
					<button type="button" style="width: 150px;"
						class="btn btn-success center-block" id="btnAprv" onclick="">อนุมัติ</button>
				</div>
			</div>
		</div>
	</div>

	<br>
	<div id="reimBtn2" class="row">
		<div class="form-group">
			<div class="col-sm-2 col-sm-offset-3" style="display: flex;">
				<button type="button" style="width: 150px;"
					class="btn btn-primary center-block" id="btnPrint"
					onclick="payin();">พิมพ์ใบนำส่ง</button>
			</div>
			<div class="col-sm-2" style="display: flex;">
				<button type="button" style="width: 150px;"
					class="btn btn-primary center-block" id="btnPrintWHT" onclick="">พิมพ์ใบ
					WHT</button>
			</div>
		</div>
	</div>
</div>




