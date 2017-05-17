<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<div>
	<div class="row"
		style="background-color: #DCDCDC; padding-top: .5em; display: flex; flex-flow: row nowrap; height: 2.5em;">

		<div class="col-md-4 col-xs-2 text-left">
			<span class="badge">5</span>
		</div>
		<div class="col-md-4 col-xs-8 text-center">
			<label id="lblDlgName" class="PageTitle">อ้างอิงใบปฏิบัติงาน</label>
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
					<label for="ddlCaList" class="col-sm-2 col-sm-offset-1 control-label" required>
						<%-- 									<spring:message code="member.worktime.criteria.company" /> --%>
						รหัสพนักงาน/ชื่อ
					</label>
					<div class="col-sm-6">
						<input type="text" id="inputCaObj" class="form-control"
							placeholder="ระบุ...">
					</div>
				</div>
			</div>
			<br>
			<div class="row">
				<div class="form-group">
					<div class="col-sm-2 col-sm-offset-4" style="display: flex;">
						<button type="button" style="width: 150px;"
							class="btn btn-primary center-block" id="btnSearch" onclick="">ค้นหา</button>
					</div>
					<div class="col-sm-2" style="display: flex;">
						<button type="button" style="width: 150px;"
							class="btn btn-success center-block" id="btnOK" onclick="">ตกลง</button>
					</div>
				</div>
			</div>
		</div>
	</form>

</div>