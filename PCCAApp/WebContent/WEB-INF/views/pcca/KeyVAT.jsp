<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">


<div>
	<div class="row"
		style="background-color: #DCDCDC; padding-top: .5em; display: flex; flex-flow: row nowrap; height: 2.5em;">

		<div class="col-md-4 col-xs-2 text-left">
			<span class="badge">5</span><br>
		</div>
		<div class="col-md-4 col-xs-8 text-center">
			<label id="" class="PageTitle">บันทึก VAT</label>
		</div>
		<div class="col-md-4 col-xs-2 text-right">
			<label id="lblDlgName" class="glyphicon glyphicon-remove-circle"></label>
		</div>
	</div>
	<form class="form-horizontal"
		style="padding-left: 10px; padding-right: 10px;">
		<div class="box-body col-sm-offset-1">
			<div class="row">
				<div class="form-group">
					<label class="col-sm-3 control-label" required>
						<%-- 									<spring:message code="member.worktime.criteria.company" /> --%>
						จำนวนเงินจ่าย
					</label>
					<div class="col-sm-4">
						<input type="text" id="inputPaidAmt" class="form-control"
							placeholder="0.00" readonly>
					</div>

					<div class="col-sm-2 ">
						<div class="checkbox">
							<label> <input id="inputIncludeTax" type="checkbox"
								class="minimal" style="position: absolute; opacity: 0;">
								รวม VAT แล้ว
							</label>
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="form-group">
					<label class="col-sm-3 control-label"> <%-- 									<spring:message code="member.worktime.criteria.company" /> --%>
						VAT
					</label>
					<div class="col-sm-2">
						<input type="text" id="inputVat" class="form-control"
							placeholder="0.00" readonly>
					</div>
					<label class="col-sm-2 control-label"> <%-- 									<spring:message code="member.worktime.criteria.company" /> --%>
						VAT-BASE
					</label>
					<div class="col-sm-2">
						<input type="text" id="inputVatBase" class="form-control"
							placeholder="0.00" readonly>
					</div>
				</div>
			</div>

			<div class="row">
				<div class="form-group">
					<label class="col-sm-3 control-label" required>
						<%-- 									<spring:message code="member.worktime.criteria.company" /> --%>
						TAX-NUMBER เลขที่ใบกำกับภาษี
					</label>
					<div class="col-sm-4">
						<input type="text" id="inputTaxNo" class="form-control"
							placeholder="ระบุ...">
					</div>
				</div>
			</div>
			<div class="row">
				<div class="form-group">
					<label class="col-sm-3 control-label"> <%-- 									<spring:message code="member.worktime.criteria.company" /> --%>
						TAX-ID
					</label>
					<div class="col-sm-2">
						<input type="text" id=inputTaxId class="form-control"
							placeholder="ระบุ...">
					</div>
					<label class="col-sm-2 control-label"> <%-- 									<spring:message code="member.worktime.criteria.company" /> --%>
						Branch
					</label>
					<div class="col-sm-2">
						<input type="text" id="inputBranch" class="form-control"
							placeholder="ระบุ...">
					</div>
				</div>
			</div>


			<div class="row">
				<div class="form-group">
					<label class="col-sm-3 control-label"> <%-- 									<spring:message code="member.worktime.criteria.company" /> --%>
						วันที่
					</label>
					<div class="col-sm-2">
						<input type="text" id="inputDate" class="form-control"
							placeholder="30 มี ค 60" readonly>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="form-group">
					<label class="col-sm-3 control-label" required>
						<%-- 									<spring:message code="member.worktime.criteria.company" /> --%>
						ชื่อผู้ค้า
					</label>
					<div class="col-sm-5">
						<input type="text" id="inputCustName" class="form-control"
							placeholder="ระบุ...">
					</div>
				</div>
			</div>
			<div class="row">
				<div class="form-group">
					<label class="col-sm-3 control-label" required>
						<%-- 									<spring:message code="member.worktime.criteria.company" /> --%>
						ที่อยู่ผู้ค้า
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
							class="btn btn-success center-block" id="btnVatOk" onclick="">ตกลง</button>
					</div>
				</div>
			</div>


		</div>
	</form>


</div>
