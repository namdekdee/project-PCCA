<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<div>
	<div class="row"
		style="background-color: rgba(57, 221, 107, 0.62); height: 3.5em;">

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
			<a href="#" class="btn btn-success btn-lg btn-block" role="button"
				aria-pressed="true">รายงาน</a>
		</div>
	</div>
	<br>
	<div class="row">
		<div class="col-md-6 col-md-offset-3">
			<a href="#" class="btn btn-success btn-lg btn-block" role="button"
				aria-pressed="true">Setup</a>
		</div>
	</div>
	<br>
	<div class="row"
		style="background-color: gold; height: 2.5em; padding-top: .5em; display: flex; flex-flow: row nowrap;">
		<div class="col-xs-6 text-left">
			<label id="lblDlgName">รออนุมัติ</label>
		</div>
		<div class="col-xs-6 text-right">
			<span class="badge">5</span>
		</div>
	</div>
	<br>

	<div class="row">
		<div class="col-sm-12">

			<div id="divWaitForApprove"></div>
		</div>
	</div>

	<br>
	<div class="row"
		style="background-color: #ff3333; height: 2.5em; padding-top: .5em; display: flex; flex-flow: row nowrap;">
		<div class="col-xs-6 text-left">
			<label id="lblDlgName">รอแก้ไข</label>
		</div>
		<div class="col-xs-6 text-right">
			<span class="badge">5</span>
		</div>
	</div>



</div>