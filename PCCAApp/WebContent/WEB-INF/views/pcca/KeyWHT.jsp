<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">


<div>
	<div class="row"
		style="background-color: #DCDCDC; padding-top: .5em; display: flex; flex-flow: row nowrap;">

		<div class="col-md-4 col-xs-2 text-left">
			<span class="badge">5</span><br>
		</div>
		<div class="col-md-4 col-xs-8 text-center">
			<label id="lblHeadName"
				style="display: inline-block; word-break: break-word;">บันทึก
				With Holding Tax</label>
		</div>
		<div class="col-md-4 col-xs-2 text-right">
			<label id="lblDlgName" class="glyphicon glyphicon-remove-circle"></label>
		</div>
	</div>

	<form class="form-horizontal"
		style="padding-left: 10px; padding-right: 10px;">
		<div class="box-body">
			<div class="row">
				<div class="form-group">
					<div class="col-sm-3 col-sm-offset-2 control-label">
						<div class="radio">
							<label class="radio-inline" style="font-weight: 700;"><input
								type="radio" name="radioWHT" value="radioWHT" class="setRadio">&nbsp;&nbsp;
								หัก WHT</label>
						</div>
					</div>
					<div class="col-sm-3 control-label">
						<div class="radio">
							<label class="radio-inline" style="font-weight: 700;"><input
								type="radio" name="radioNoWHT" value="radioNoWHT"
								class="setRadio">&nbsp;&nbsp; ไม่หัก WHT</label>
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="form-group">
					<label class="col-sm-3 control-label" required>
						<%-- 																		<spring:message code="member.worktime.criteria.company" /> --%>
						จำนวนเงิน
					</label>
					<div class="col-sm-3">
						<input type="text" id="inputAmt" class="form-control"
							placeholder="0.00" readonly>
					</div>
					<label class="col-sm-2 control-label" required> <%-- 																		<spring:message code="member.worktime.criteria.company" /> --%>
						หัก%
					</label>
					<div class="col-sm-2">
						<select id="percentAmt" class="form-control" style="width: 100%;">
							<option value="5">5.00</option>
							<option value="10">10.00</option>
						</select>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="form-group">
					<label class="col-sm-3 control-label" required> <%-- 																		<spring:message code="member.worktime.criteria.company" /> --%>
						จำนวนเงินจ่าย
					</label>
					<div class="col-sm-3">
						<input type="text" id="inputPaidAmt" class="form-control"
							placeholder="0.00" readonly>
					</div>
					<label class="col-sm-2 control-label" required> <%-- 																		<spring:message code="member.worktime.criteria.company" /> --%>
						จำนวนเงินหัก
					</label>
					<div class="col-sm-3">
						<input type="text" id="inputAmtWHT" class="form-control"
							placeholder="0.00" readonly>
					</div>
				</div>
			</div>

			<div class="row">
				<div class="form-group">
					<label class="col-sm-3 control-label"> TAX-ID </label>
					<div class="col-sm-3">
						<input type="text" id="inputTaxId" class="form-control"
							placeholder="ระบุ...">
					</div>
					<label class="col-sm-2 control-label"> Branch </label>
					<div class="col-sm-3">
						<input type="text" id="inputBranch" class="form-control"
							placeholder="ระบุ...">
					</div>
				</div>
			</div>

			<div class="row">
				<div class="form-group">
					<label class="col-sm-3 control-label"> วันที่ </label>
					<div class="col-sm-2">
						<input type="text" id="inputDate" class="form-control"
							placeholder="30 มี ค 60" readonly>
					</div>
					<label class="col-sm-3 control-label" required> <%-- 																		<spring:message code="member.worktime.criteria.company" /> --%>
						ประเภทเงินได้
					</label>
					<div class="col-sm-2">
						<select id="ddlCompany" class="form-control" style="width: 100%;"
							data-placeholder="เลือกบริษัท">

							<option value="personal">บุคคลธรรมดา</option>
							<option value="corporate">นิติบุคคล</option>
						</select>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="form-group">
					<label class="col-sm-3 control-label" required> <%-- 					<spring:message code="member.worktime.criteria.company" /> --%>
						ชื่อผู้รับเงิน
					</label>
					<div class="col-sm-5">
						<input type="text" id="inputName" class="form-control"
							placeholder="ระบุ...">
					</div>
				</div>
			</div>
			<div class="row">
				<div class="form-group">
					<label class="col-sm-3 control-label"> <%-- 																		<spring:message code="member.worktime.criteria.company" /> --%>
						ที่อยู่ผู้รับเงิน
					</label>
					<div class="col-sm-5">
						<textarea class="form-control" rows="5" id="txtAddr"></textarea>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="form-group">
					<div class="col-sm-2 col-sm-offset-4 " style="display: flex;">
						<button type="button" style="width: 150px;"
							class="btn btn-success center-block" id="btnWHTOk" onclick="">ตกลง</button>
					</div>
				</div>
			</div>

		</div>
	</form>

</div>

