<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/Style/PccaStyle.css">
<script>
	$('document').ready(function() {

		$('#searchResult').hide();

	});

	function searchResult() {
		$('#search').hide();
		$('#searchResult').show();
	}
</script>

<div>
	<div class="row"
		style="background-color: #DCDCDC; padding-top: .5em; display: flex; flex-flow: row nowrap; height: 2.5em;">

		<div class="col-md-4 col-xs-2 text-left"></div>
		<div class="col-md-4 col-xs-8 text-center">
			<label id="lblDlgName" class="PageTitle">ค้นหา</label>
		</div>
		<div class="col-md-4 col-xs-2 text-right">
			<label id="lblDlgName" class="glyphicon glyphicon-remove-circle"></label>
		</div>
	</div>
</div>
<!-- End Div -->
<div id="search">
	<form class="form-horizontal"
		style="padding-left: 10px; padding-right: 10px;">
		<div class="box-body">
			<div class="row">
				<div class="form-group">
					<label class="col-sm-3 control-label"> <%-- 									<spring:message code="member.worktime.criteria.company" /> --%>
						รหัสพนักงาน
					</label>
					<div class="col-sm-6">
						<select id="ddlEmpID" class="form-control select2" onchange=""
							style="width: 100%;" data-placeholder="เลือกรหัสพนักงาน">
						</select>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="form-group">
					<label class="col-sm-3 control-label"> <!-- input id="chkUser" type="checkbox" class="minimal" />&nbsp;-->
						<%-- 										<spring:message code="member.history.criteria.user" /> --%>
						เลขคำขอ
					</label>
					<div class="col-sm-3">
						<input type="text" id="inputReqNo" class="form-control"
							placeholder="ระบุ...">
					</div>
				</div>
			</div>
			<div class="row">
				<div class="form-group">
					<label class="col-sm-3 control-label"> <%-- 									<spring:message code="member.worktime.criteria.company" /> --%>
						สถานะใบคำร้อง
					</label>
					<div class="col-sm-3">
						<select id="ddlReqStatus" class="form-control select2" onchange=""
							style="width: 100%;" data-placeholder="เลือกสถานะ">
						</select>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="form-group">
					<label class="col-sm-3 control-label"> <%-- 									<spring:message code="member.worktime.criteria.company" /> --%>
						รายการที่ขอเบิก
					</label>
					<div class="col-sm-4">
						<select id="ddlReqList" class="form-control select2" onchange=""
							style="width: 100%;" data-placeholder="เลือกรายการ">
						</select>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="form-group">
					<label class="col-sm-3 control-label"> <%-- 									<spring:message code="member.worktime.criteria.company" /> --%>
						วงเงินเบิก
					</label>
					<div class="col-sm-3">
						<select id="ddlCredit" class="form-control select2" onchange=""
							style="width: 100%;" data-placeholder="เลือกวงเงิน">
						</select>
					</div>
					<label class="col-sm-1 control-label"> <%-- 									<spring:message code="member.worktime.criteria.company" /> --%>
						จำนวนเงิน
					</label>
					<div class="col-sm-3">
						<select id="ddlAmount" class="form-control select2" onchange=""
							style="width: 100%;" data-placeholder="เลือกจำนวน">
						</select>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="form-group">
					<div class="col-sm-2 col-sm-offset-3">
						<label class="radio-inline" style="font-weight: 700;"><input
							type="radio" name="optRadio" value="radioReqAprvDay" class="setRadio">&nbsp;&nbsp; วันขออนุมัติ</label>
					</div>
					<div class="col-sm-3">
						<label class="radio-inline" style="font-weight: 700;"><input
							type="radio" name="optRadio" value="radioWorkDay" class="setRadio">&nbsp;&nbsp; วันปฏิบัติงาน</label>
					</div>

				</div>
			</div>
			<div class="row">
				<div class="form-group">
					<label class="col-sm-3 control-label" id="lblStartDate" required>
						<%-- 					<spring:message code="member.worktime.criteria.date" /> --%>
						ตั้งแต่วันที่
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
					<div class="col-sm-4"></div>
					<div class="col-sm-2">
						<button type="button" class="btn btn-success center-block"
							style="width: 80%;" onclick="searchResult();">ค้นหา</button>
					</div>
				</div>
			</div>


		</div>
	</form>



</div>
<!-- End Search -->

<div id="searchResult" style="display: none;">
	<form class="form-horizontal"
		style="padding-left: 10px; padding-right: 10px;">
		<div class="box-body">
			<div class="row">
				<div class="form-group">
					<div class="col-sm-5"></div>
					<div class="col-sm-2">
						<button type="button" class="btn btn-success center-block"
							style="width: 80%;" onclick="location.href='ca_search';">
							<i class="glyphicon glyphicon-backward"></i> ค้นหาใหม่
						</button>
					</div>
				</div>
			</div>
			<div class="row">
				<table class="table table-striped">
					<tbody>
						<tr>
							<td class="col-sm-2"></td>
							<td class="col-sm-5">เลขที่ 555555 <br> 12345 <br>
								งานภายนอก เชียงใหม่ <br> 25กพ50 - 2มีค59
							</td>
							<td class="col-sm-4">1กพ59 <br>นายอัครพงศ์ สกุลดี <br>
								6,500บาท <br> ได้รับเงิน
							</td>
						</tr>
						<tr>
							<td></td>
							<td>เลขที่ 555555 <br> 12345 <br> งานภายนอก
								เชียงใหม่ <br> 25กพ50 - 2มีค59
							</td>
							<td>1กพ59 <br>นายอัครพงศ์ สกุลดี <br> 6,500บาท <br>
								ได้รับเงิน
							</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
	</form>
</div>
<!-- Ens Search Result -->

