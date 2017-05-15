<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<div>
	<div class="row"
		style="background-color: #DCDCDC; padding-top: .5em; display: flex; flex-flow: row nowrap; height: 2.5em;">

		<div class="col-md-4 col-xs-4 text-left">
			<label id="lblDlgName">(3)</label>
		</div>
		<div class="col-md-4 col-xs-4 text-center">
			<label id="lblDlgName">เบิกทดรองจ่าย</label>
		</div>
		<div class="col-md-4 col-xs-4 text-right">
			<label id="lblDlgName" class="glyphicon glyphicon-search"></label>
		</div>
	</div>
	<br>
	<div class="row">
		<div class="col-md-6 col-md-offset-3">
			<a href="#" class="btn btn-success btn-lg btn-block" role="button"
				aria-pressed="true">เบิกทดรองจ่าย</a>
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
		style="background-color: #00ace6; height: 2.5em; padding-top: .5em; display: flex; flex-flow: row nowrap;">
		<div class="col-xs-6 text-left">
			<label id="lblDlgName">รออนุมัติ</label>
		</div>
		<div class="col-xs-6 text-right">
			<label id="lblDlgName">(3)</label>
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
		style="background-color: red; height: 2.5em; padding-top: .5em; display: flex; flex-flow: row nowrap;">
		<div class="col-xs-6 text-left">
			<label id="lblDlgName">รอแก้ไข</label>
		</div>
		<div class="col-xs-6 text-right">
			<label id="lblDlgName">(1)</label>
		</div>
	</div>



</div>