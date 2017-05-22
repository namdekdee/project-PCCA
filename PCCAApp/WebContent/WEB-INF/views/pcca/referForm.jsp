<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<style>
<!--
table#tbRefForm {
	width: 70%;
	margin: 0px auto;
}

.checkboxRf {
	min-height: 20px;
	margin-bottom: 0;
	font-weight: 400;
	cursor: pointer;
}
-->
</style>
<script>
	function showResult() {

		$('#searchResult').show();
	}
</script>
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
					<label for="ddlCaList"
						class="col-sm-2 col-sm-offset-1 control-label"> <%-- 									<spring:message code="member.worktime.criteria.company" /> --%>
						รหัสพนักงาน/ชื่อ
					</label>
					<div class="col-sm-6">
						<input type="text" id="inputCaObj" class="form-control"
							placeholder="ระบุ...">
					</div>
					<div class="col-sm-2 " style="display: flex;">
						<button type="button" style="width: 120px;"
							class="btn btn-primary center-block" id="btnSearch"
							onclick="showResult();">ค้นหา</button>
					</div>
				</div>
			</div>
			<br>

		</div>
	</form>

	<div id="searchResult" style="display: none;">
		<form class="form-horizontal"
			style="padding-left: 10px; padding-right: 10px;">
			<div class="box-body">
				<div class="row">
					<table id="tbRefForm" class="table table-striped">
						<tbody>
							<tr>
								<td class="col-sm-2"
									style="text-align: center; vertical-align: middle;"><div
										class="checkboxRf">
										<label> <input id="chkRefer" type="checkbox"
											class="minimal" style="position: absolute; opacity: 0;">
										</label>
									</div></td>
								<td class="col-sm-5">59001 <br> 4590000001 <br>
									คลังน้ำมันหนองแค <br> 10 มีค 60
								</td>
								<td class="col-sm-4">อัครพงษ์ <br> <br> สระบุรี <br>
									12มีค60
								</td>
							</tr>
							<tr>
								<td style="text-align: center; vertical-align: middle;"><div
										class="checkboxRf">
										<label> <input id="chkRefer" type="checkbox"
											class="minimal" style="position: absolute; opacity: 0;">
										</label>
									</div></td>
								<td>59001 <br> 4590000001 <br> คลังน้ำมันหนองแค <br>
									10 มีค 60
								</td>
								<td>อัครพงษ์ <br> <br> สระบุรี <br> 12มีค60
								</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
		</form>
	</div>
	<!-- Ens Search Result -->

	<footer class="footer">
	<div class="row">
		<div class="form-group">
			<div class="col-sm-2 col-sm-offset-9" style="display: flex;">
				<button type="button" style="width: 120px;"
					class="btn btn-success center-block" id="btnOK"
					onclick="location.href='reimburse_home;'">ตกลง</button>
			</div>
		</div>
	</div>
	</footer>

</div>