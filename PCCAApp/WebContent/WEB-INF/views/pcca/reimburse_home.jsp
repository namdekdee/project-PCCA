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
						} else if (status == "requester edit") {
							alert("Requester Edit");
							document.getElementById('lblHeadName').innerHTML = 'แก้ไข';
							$("#reimBtn1").hide();
							$("#reimBtn2").hide();
							$("#reqEditBtn1").show();
							$("#apprvComment").show();
							$("#apprvComment :input").prop("disabled", true);
							$("#reqEditBtn2").show();
						} else if (status == "Account edit") {
							alert("Account Edit");
							document.getElementById('lblHeadName').innerHTML = 'Upload ใบนำฝาก';
							$("#reimburse :input").prop("disabled", true);
							$("#reimBtn1").hide();
							$("#reimBtn2").hide();
							$("#payinBtn :input").prop("disabled", false);
							$("#payinBtn").show();
							document.getElementById('inputCaAmount').style.backgroundColor = 'yellow';
						} else if (status == "Account Transfer") {
							alert("Account Transfer");
							document.getElementById('lblHeadName').innerHTML = 'แจ้งโอนเงิน';
							$("#reimburse :input").prop("disabled", true);
							$("#reimBtn1").hide();
							$("#reimBtn2").hide();
							$("#comntToAct").show();
							var elems = document
									.getElementsByClassName("btnSave");
							for (var i = 0; i < elems.length; i++) {
								elems[i].innerHTML = "ตรวจสอบ";
							}
							$("#actCmnt :input").prop("disabled", true);
							$("#actCmnt").show();
							$("#actTransferBtn").show();
						} else if (status == "DontGetCash") {
							alert("Don't Get Cash");
							document.getElementById('lblHeadName').innerHTML = 'แจ้งไม่ได้รับเงิน';
							$("#reimburse :input").prop("disabled", true);
							$("#reimBtn1").hide();
							$("#reimBtn2").hide();
							$("#comntToAct :input").prop("disabled", true);
							$("#comntToAct").show();
							var elems = document
									.getElementsByClassName("btnSave");
							for (var i = 0; i < elems.length; i++) {
								elems[i].innerHTML = "ตรวจสอบ";
							}
							$("#actCmnt").show();
							$("#dontGetCashBtn").show();
						} else {
							alert("Expense Approve");
							document.getElementById('lblHeadName').innerHTML = 'อนุมัติค่าใช้จ่าย';
							$("#reimburse :input").prop("disabled", true);
							$("#reimBtn1").hide();
							$("#reimBtn2").hide();
							$("#apprvComment").show();
							$("#apprvComment :input").prop("disabled", false);
							$("#apprvBtn").show();
							$("#apprvBtn :input").prop("disabled", false);
							$("#viewForm").show();
							$("#viewForm :input").prop("disabled", false);
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

.table-responsive>.table>tbody>tr>td, .table-responsive>.table>tbody>tr>th,
	.table-responsive>.table>tfoot>tr>td, .table-responsive>.table>tfoot>tr>th,
	.table-responsive>.table>thead>tr>td, .table-responsive>.table>thead>tr>th
	{
	white-space: normal;
}

table.table.tbCalAmount, .tbAmount {
	width: 80%;
	margin: 0 auto;
	background-color: rgba(204, 240, 218, 0.56);
	table-layout: fixed;
	word-wrap: initial;
}

.horz {
	margin-top: 20px;
	margin-bottom: 20px;
	border: 0;
	border-top: 1px solid rgba(0, 166, 90, 0.34);
	width: 80%;
}
</style>
<div id="reimburse">
	<div class="row"
		style="background-color: #DCDCDC; padding-top: .5em; display: flex; flex-flow: row nowrap;">

		<div class="col-md-4 col-xs-2 text-left">
			<span class="badge">5</span>
		</div>
		<div class="col-md-4 col-xs-8 text-center">
			<label id="lblHeadName">สรุปค่าใช้จ่าย</label>
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
			<div class="row">
				<div class="form-group">
					<label class="col-sm-3 control-label"> เบิกจากบริษัท </label>
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
					<div class="col-sm-2 col-sm-offset-3">
						<input id="chkRefer" type="checkbox"
							style="width: 20px; height: 20px;"> <label
							style="position: absolute; padding-top: 7px; margin-bottom: 0; padding-left: 10px;">
							มีใบปฏิบัติงาน</label>

					</div>
					<div class="col-sm-4">
						<input type="text" id="txtReferForm" class="form-control"
							placeholder="ระบุ...">
					</div>
					<div class="col-sm-1" id="viewForm" style="display: none;">
						<button type="button" class="btn btn-primary center-block btnSave"
							style="width: 130px;" onclick="">ดูใบปฏิบัติงาน</button>
					</div>
				</div>
			</div>

			<div class="row">
				<div class="form-group">
					<label class="col-sm-3 control-label" id="lblStartDate" required>
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
				<hr class="horz">
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
						style="width: 120px;" onclick="location.href='keyExpense';">บันทึก</button>
				</div>
			</div>

			<div class="row">
				<hr class="horz">
				<label class="col-sm-2 col-sm-offset-3">1 มีค 60</label>

				<div class="col-sm-2 text-center">
					<label>จำนวนเงิน</label>
				</div>
				<div class="col-sm-2">
					<input type="text" id="inputCaAmount" name="inputCaAmount"
						class="form-control" placeholder="0.00" readonly>
				</div>
				<div class="col-sm-2">
					<button type="button" class="btn btn-success center-block btnSave"
						style="width: 120px;" onclick="location.href='keyExpense';">บันทึก</button>
				</div>
			</div>
			<br>

			<div class="table-responsive">
				<table class="table table-hover tbCalAmount">
					<tbody>
						<tr>
							<td class="col-sm-2"></td>
							<td class="col-sm-6">รวม 3 วัน</td>
							<td class="col-sm-3">8,500.00 บาท</td>
							<td class="col-sm-1"></td>
						</tr>
						<tr>
							<td></td>
							<td>เบิกไปแล้ว</td>
							<td>9,000.00 บาท</td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td>คืนเงิน</td>
							<td>500.00 บาท</td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td>ยอดรวมหลังปรับปรุง</td>
							<td>8,200.00 บาท</td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td>คืนเงินเพิ่ม</td>
							<td>300.00 บาท</td>
							<td></td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
		<!-- box-body -->
	</form>
</div>
<div id="reqEditBtn1" class="row" style="display: none;">
	<br>
	<div class="form-group">
		<div class="col-sm-2 col-sm-offset-4" style="display: flex;">
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
					<div class="col-sm-5">
						<textarea class="form-control" rows="4" id="commentAprv"></textarea>
					</div>
				</div>
			</div>
		</div>
	</form>
</div>

<div id="reqEditBtn2" class="row" style="display: none;">
	<div class="form-group">
		<div class="col-sm-2 col-sm-offset-4" style="display: flex;">
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

<div id="comntToAct" style="display: none;">
	<form class="form-horizontal"
		style="padding-left: 10px; padding-right: 10px;">
		<div class="box-body">
			<div class="row">
				<div class="form-group">
					<label id="" class="col-sm-3 control-label" required>
						แจ้งการเงิน </label>
					<div class="col-sm-5">
						<textarea class="form-control" rows="4" id="commentToAct"></textarea>
					</div>
				</div>
			</div>
		</div>
	</form>
</div>
<div id="actCmnt" style="display: none;">
	<form class="form-horizontal"
		style="padding-left: 10px; padding-right: 10px;">
		<div class="box-body">
			<div class="row">
				<div class="form-group">
					<label id="" class="col-sm-3 control-label" required>
						ความเห็นการเงิน </label>
					<div class="col-sm-5">
						<textarea class="form-control" rows="4" id="txtActCmnt"></textarea>
					</div>
				</div>
			</div>
		</div>
	</form>
</div>

<div id="actTransferBtn" class="row" style="display: none;">
	<div class="form-group">
		<div class="col-sm-2 col-sm-offset-4" style="display: flex;">
			<button type="button" style="width: 150px;"
				class="btn btn-danger center-block" id="btnDontGetCash" onclick="">ไม่ได้เงิน</button>
		</div>
		<div class="col-sm-2" style="display: flex;">
			<button type="button" style="width: 150px;"
				class="btn btn-success center-block" id="btnGetCash" onclick="">ได้รับเงิน</button>
		</div>
	</div>
</div>

<div id="dontGetCashBtn" class="row" style="display: none;">
	<div class="form-group">
		<div class="col-sm-2 col-sm-offset-4" style="display: flex;">
			<button type="button" style="width: 150px;"
				class="btn btn-danger center-block" id="btnDontTrans" onclick="">ไม่โอนเงิน</button>
		</div>
		<div class="col-sm-2" style="display: flex;">
			<button type="button" style="width: 150px;"
				class="btn btn-success center-block" id="btnAlreadyTrans" onclick="">โอนเงินแล้ว</button>
		</div>
	</div>
</div>





