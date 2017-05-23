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
			<label id="lblDlgName"
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
					<div class="col-sm-4 col-sm-offset-2 control-label">
						<div class="radio">
							<label><input type="radio" name="optradio">หัก
								WHT</label>
						</div>
					</div>
					<div class="col-sm-3 control-label">
						<div class="radio">
							<label><input type="radio" name="optradio">ไม่หัก
								WHT</label>
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="form-group">
					<label for="ddlCaList" class="col-sm-4 control-label" required>
						<%-- 																		<spring:message code="member.worktime.criteria.company" /> --%>
						จำนวนเงิน
					</label>
					<div class="col-sm-3">
						<input type="text" id="inputCaObj" class="form-control"
							placeholder="0.00" readonly>
					</div>
					<label for="ddlCaList" class="col-sm-1 control-label" required>
						<%-- 																		<spring:message code="member.worktime.criteria.company" /> --%>
						หัก%
					</label>
					<div class="col-sm-2">
						<select id="ddlCompany" class="form-control" style="width: 100%;"
							data-placeholder="เลือกบริษัท">
							<option value="5">5.00</option>
							<option value="10">10.00</option>
						</select>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="form-group">
					<label for="ddlCaList" class="col-sm-4 control-label" required>
						<%-- 																		<spring:message code="member.worktime.criteria.company" /> --%>
						จำนวนเงินจ่าย
					</label>
					<div class="col-sm-3">
						<input type="text" id="inputCaObj" class="form-control"
							placeholder="0.00" readonly>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="form-group">
					<label for="ddlCaList" class="col-sm-4 control-label" required>
						<%-- 																		<spring:message code="member.worktime.criteria.company" /> --%>
						จำนวนเงินหัก
					</label>
					<div class="col-sm-3">
						<input type="text" id="inputCaObj" class="form-control"
							placeholder="0.00" readonly>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="form-group">
					<label for="lblvat" class="col-sm-4 control-label"> TAX-ID
					</label>
					<div class="col-sm-2">
						<input type="text" id="inputCaObj" class="form-control"
							placeholder="ระบุ...">
					</div>
				</div>
			</div>

			<div class="row">
				<div class="form-group">
					<label for="lblvat" class="col-sm-4 control-label"> Branch
					</label>
					<div class="col-sm-2">
						<input type="text" id="inputCaObj" class="form-control"
							placeholder="ระบุ...">
					</div>
				</div>
			</div>
			<div class="row">
				<div class="form-group">
					<label for="lblvat" class="col-sm-4 control-label"> วันที่
					</label>
					<div class="col-sm-2">
						<input type="text" id="inputCaObj" class="form-control"
							placeholder="30 มี ค 60" readonly>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="form-group">
					<label for="ddlCaList" class="col-sm-4 control-label" required>
						<%-- 					<spring:message code="member.worktime.criteria.company" /> --%>
						ชื่อผู้รับเงิน
					</label>
					<div class="col-sm-4">
						<input type="text" id="inputCaObj" class="form-control"
							placeholder="ระบุ...">
					</div>
				</div>
			</div>
			<div class="row">
				<div class="form-group">
					<label for="ddlCaList" class="col-sm-4 control-label" required>
						<%-- 																		<spring:message code="member.worktime.criteria.company" /> --%>
						ที่อยู่ผู้รับเงิน
					</label>
					<div class="col-sm-4">
						<textarea class="form-control" rows="5" id="comment"></textarea>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="form-group">
					<label for="ddlCaList" class="col-sm-4 control-label" required>
						<%-- 																		<spring:message code="member.worktime.criteria.company" /> --%>
						ประเภทเงินได้
					</label>
					<div class="col-sm-2">
						<select id="ddlCompany" class="form-control" style="width: 100%;"
							data-placeholder="เลือกบริษัท">

							<option value="personal">บุคคล</option>
							<option value=""></option>
						</select>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="form-group">
					<div class="col-sm-2 col-sm-offset-4 " style="display: flex;">
						<button type="button" style="width: 150px;"
							class="btn btn-success center-block" id="btnVatOk" onclick="">ตกลง</button>
					</div>
				</div>
			</div>

		</div>
	</form>

</div>

