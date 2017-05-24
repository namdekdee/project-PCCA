<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<script>
	$(document).ready(
			function() {
				$("waitEdit").click(function() {
					$(".collapse1").collapse('toggle');
				});

				$("waitApprv").click(function() {
					$(".collapse").collapse('toggle');
				});

				$('.glyphicon').click(
						function() {
							$(this).toggleClass("glyphicon-chevron-down")
									.toggleClass("glyphicon-chevron-up");
						});
			});
</script>
<div>
	<div class="row" style="background-color: #dddddd; height: 3.5em;">

		<div class="col-md-4 col-xs-2 text-left" style="padding-top: 1em;">
			<span class="badge">5</span>
		</div>
		<div class="col-md-4 col-xs-8 text-center" style="padding-top: 1em;">
			<label style="font-size: x-large; margin-top: -.3em;"
				class="PageTitle">เบิกทดรองจ่าย</label>
		</div>
		<div class="col-md-4 col-xs-2 text-right" style="padding-top: 1em;">
			<label id="lblDlgName" class="glyphicon glyphicon-search"></label>
		</div>
	</div>
	<br>
	<div class="row">
		<div class="col-md-6 col-md-offset-3">
			<a href="ca_request" class="btn btn-success btn-lg btn-block"
				role="button" aria-pressed="true">เบิกทดรองจ่าย</a>
		</div>
	</div>
	<br>
	<div class="row">
		<div class="col-md-6 col-md-offset-3">
			<a href="ca_report" class="btn btn-success btn-lg btn-block" role="button"
				aria-pressed="true">รายงาน</a>
		</div>
	</div>
	<br>
	<div class="row">
		<div class="col-md-6 col-md-offset-3">
			<a href="ca_setup" class="btn btn-success btn-lg btn-block" role="button"
				aria-pressed="true">Setup</a>
		</div>
	</div>
	<br>
	<div class="row"
		style="background-color: gold; padding-top: .5em; display: flex; flex-flow: row nowrap;">
		<div class="col-xs-6 text-left" id="waitAprv" onclick="">
			<a class="accordion-toggle" data-toggle="collapse"
				data-parent="#accordion" href="#collapse"> <span
				class="glyphicon glyphicon-chevron-down" style="color: black;">
					<label id="lblDlgName" style="color: black;">รออนุมัติ</label>
			</span></a>
		</div>
		<div class="col-xs-6 text-right">
			<span class="badge">5</span>
		</div>
	</div>
	<div class="panel-group">
		<div class="panel panel-default">
			<div id="collapse" class="panel-collapse collapse ">
				<div class="panel-body">
					<div class="row " style="text-align: center;">
						<table class="table table-striped">
							<tbody>
								<tr>
									<td>558000<br> งานภายนอก
									</td>
									<td>3,500บาท <br> เชียงใหม่
									</td>
									<td>1มค60 <br> 16กพ60
									</td>
								</tr>
								<tr>
									<td class="col-sm-3">558000 <br> งานภายนอก
									</td>
									<td class="col-sm-3">3,500บาท <br> เชียงใหม่
									</td>
									<td class="col-sm-3">1มค60 <br> 16กพ60
									</td>
								</tr>
								<tr>
									<td class="col-sm-3">558000 <br> งานภายนอก
									</td>
									<td class="col-sm-3">3,500บาท <br> เชียงใหม่
									</td>
									<td class="col-sm-3">1มค60 <br> 16กพ60
									</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>


	<br>
	<div class="row"
		style="background-color: #ff3333; padding-top: .5em; display: flex; flex-flow: row nowrap;">
		<div class="col-xs-6 text-left" id="waitEdit" onclick="">
			<a class="accordion-toggle" data-toggle="collapse"
				data-parent="#accordion" href="#collapse1"> <span
				class="glyphicon glyphicon-chevron-down" style="color: black;">
					<label id="lblDlgName" style="color: black;">รอแก้ไข</label>
			</span></a>
		</div>
		<div class="col-xs-6 text-right">
			<span class="badge">5</span>
		</div>
	</div>
	<div class="panel-group">
		<div class="panel panel-default">
			<div id="collapse1" class="panel-collapse collapse ">
				<div class="panel-body">
					<div class="row " style="text-align: center;">
						<table class="table table-striped">
							<tbody>
								<tr>
									<td>558000<br> งานภายนอก
									</td>
									<td>3,500บาท <br> เชียงใหม่
									</td>
									<td>1มค60 <br> 16กพ60
									</td>
								</tr>
								<tr>
									<td class="col-sm-3">558000 <br> งานภายนอก
									</td>
									<td class="col-sm-3">3,500บาท <br> เชียงใหม่
									</td>
									<td class="col-sm-3">1มค60 <br> 16กพ60
									</td>
								</tr>
								<tr>
									<td class="col-sm-3">558000 <br> งานภายนอก
									</td>
									<td class="col-sm-3">3,500บาท <br> เชียงใหม่
									</td>
									<td class="col-sm-3">1มค60 <br> 16กพ60
									</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>




</div>