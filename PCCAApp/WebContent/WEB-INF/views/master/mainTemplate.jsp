<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="shortcut icon" type="image/x-icon"
	href="resources/Images/logo.png" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>HRIS |</title>
<!-- Tell the browser to be responsive to screen width -->
<meta
	content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no"
	name="viewport">
<!-- Bootstrap 3.3.6 -->
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/bootstrap/css/bootstrap.min.css">
<!-- Font Awesome -->
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/bootstrap/css/font-awesome.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/bootstrap/css/font-awesome.min.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/bootstrap/css/ionicons.min.css">
<!-- Theme style -->
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/dist/css/AdminLTE.min.css">
<!-- AdminLTE Skins. Choose a skin from the css/skins
       folder instead of downloading all of them to reduce the load. -->
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/dist/css/skins/_all-skins.min.css">
<!-- iCheck -->
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/plugins/iCheck/flat/blue.css">
<!-- Morris chart -->
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/plugins/morris/morris.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/plugins/datatables/dataTables.bootstrap.css">
<!-- jvectormap -->
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/plugins/jvectormap/jquery-jvectormap-1.2.2.css">
<!-- Date Picker -->
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/plugins/datepicker/datepicker3.css">
<!-- Daterange picker -->
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/plugins/daterangepicker/daterangepicker.css">
<!-- bootstrap wysihtml5 - text editor -->
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.min.css">

<!-- iCheck for checkboxes and radio inputs -->
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/plugins/iCheck/all.css">
<!-- Bootstrap Color Picker -->
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/plugins/colorpicker/bootstrap-colorpicker.min.css">
<!-- Bootstrap time Picker -->
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/plugins/timepicker/bootstrap-timepicker.min.css">
<!-- Select2 -->
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/plugins/select2/select2.min.css">
<!-- Theme style -->
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/dist/css/AdminLTE.min.css">
<!-- AdminLTE Skins. Choose a skin from the css/skins
       folder instead of downloading all of them to reduce the load. -->
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/dist/css/skins/_all-skins.min.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/Style/CustomStyle.css">

<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
    <script src="<%=request.getContextPath()%>/resources/plugins/html5shiv/html5shiv.min.js"></script>
    <script src="<%=request.getContextPath()%>/resources/plugins/respond/respond.min.js"></script>
  <![endif]-->
<style type="text/css">
.glyphicon-refresh-animate {
	-animation: spin .7s infinite linear;
	-webkit-animation: spin2 .7s infinite linear;
}

@
-webkit-keyframes spin2 {from { -webkit-transform:rotate(0deg);
	
}

to {
	-webkit-transform: rotate(360deg);
}

}
@
keyframes spin {from { transform:scale(1)rotate(0deg);
	
}

to {
	transform: scale(1) rotate(360deg);
}
}
</style>
<script
	src="<%=request.getContextPath()%>/resources/plugins/jQuery/jquery-2.2.3.min.js"></script>
<script
	src="<%=request.getContextPath()%>/resources/Scripts/MasterRoot.js"></script>


<script>
	$(document).ready(
			
			
			function() {
				InitMenuMain();

			});
	
// 	window.onbeforeunload = function (event) {
// 	    var message = 'Important: Please click on \'Save\' button to leave this page.';
// 	    if (typeof event == 'undefined') {
// 	        event = window.event;
// 	    }
// 	    if (event) {
// 	        event.returnValue = message;
// 	    }
//   	    return message;
// 	};


function InitMenuMain(){
	var pathname = window.location.pathname;
	pathname = pathname.substring(9, pathname.length);
	var data = {}
	data["strPage"] = pathname;
	jQuery.ajax({
		url : 'getmenu',
		type : "Post",
		contentType : "application/json",
		data : JSON.stringify(data),
		dataType : 'json',
		success : function(obj) {
			if (obj.success == "1") {
				$('#divMenu').html(obj.menu);
				$('#divSiteMap').html(obj.sitemap);
				$('#lblProfile').html(obj.profile);
				$('#lblSignOut').html(obj.signout);
				$('#lblUser').html(obj.name);
				$('#lblUserRight').html(obj.nameright);
				if(obj.nameposition != null && obj.nameposition != '' && obj.nameposition !='null'){
					var str = obj.nameposition.split('-');
					var name = str[0];
					var position = str[1];
				//$('#lblNamePosition').html(obj.nameposition); 
				$('#lblNameMain').html(name);
				$('#lblPositionMain').html(position);
				}else{
					var v_null ='';
					//$('#lblNamePosition').html(v_null);
					$('#lblNameMain').html(v_null);
					$('#lblPositionMain').html(v_null);
				}
				$('#lblEmpIDMain').html(obj.codempid);
				document.title = obj.title;
				var lang = obj.lang;
				var image = document.getElementById('imgLang');
				image.src = "resources/Images/lang/flags_iso/16/"
						+ lang + ".png";
				var member = obj.memberno;
				var image_left = document
						.getElementById('imgUserLeft');
				image_left.src = "resources/Images/Member/"
						+ member + ".jpg";
				
				//Defalut Datepicker language
				$.fn.datepicker.defaults.language = lang;
				$.fn.datepicker.defaults.format = "dd/mm/yyyy";
				$('#txtLangMain').val(lang);
			    $('[data-provide="datepicker"]').datepicker({
					autoclose : true
				});

			} else {
				//alert("error login");
				window.location = "welcome";
			}
		},
		error : function() {

			//alert("error login");
			window.location = "welcome";

		}
	});
	
}
function saveFormData() {
    console.log('saved');
}

	function ChangeLang(lang) {
		var pathname = window.location.pathname;
		pathname = pathname.substring(9, pathname.length);
		var data = {}
		data["strPage"] = pathname;
		data["lang"] = lang;
		jQuery.ajax({
			url : 'setlang',
			type : "Post",
			contentType : "application/json",
			data : JSON.stringify(data),
			dataType : 'json',
			success : function(obj) {
				if (obj.success == "1") {
					$('#divMenu').html(obj.menu);
					$('#divSiteMap').html(obj.sitemap);
					$('#lblProfile').html(obj.profile);
					$('#lblSignOut').html(obj.signout);
					$('#lblUser').html(obj.name);
					$('#lblUserRight').html(obj.nameright);
					var str = obj.nameposition.split("-");
					var name = str[0];
					var position = str[1];
					//$('#lblNamePosition').html(obj.nameposition);
					$('#lblName').html(name);
					$('#lblPosition').html(position);
					$('#lblSince').html(obj.since);
					document.title = obj.title;
					var lang = obj.lang;
					var image = document.getElementById('imgLang');
					image.src = "resources/Images/lang/flags_iso/16/" + lang
							+ ".png";
					var member = obj.memberno;
					var image_left = document.getElementById('imgUserLeft');
					image_left.src = "resources/Images/Member/" + member
							+ ".jpg";
					var image_right = document.getElementById('imgUserRight');
					image_right.src = "resources/Images/Member/" + member
							+ ".jpg";
					var image_down = document
							.getElementById('imgUserRightDown');
					image_down.src = "resources/Images/Member/" + member
							+ ".jpg";
					if (obj.lang == "us") {
						$("p:lang(us)").css("display", "block");
						$("p:lang(th)").css("display", "none");
					} else {
						$("p:lang(th)").css("display", "block");
						$("p:lang(us)").css("display", "none");
					}
				} else {
					var msg='unsuccess';
					ShowErrorCustomMessage(msg);
				}
			},
			error : function() {
				ShowErrorConnectMessage();
			}
		});
	}

	function ShowConfirmMsg(template_id, msg_id) {
		var data = {}
		data["message_id"] = template_id;
		jQuery.ajax({
			url : 'util-getmsg',
			type : "Post",
			contentType : "application/json",
			data : JSON.stringify(data),
			dataType : 'json',
			success : function(obj) {
				var str = obj.message_desc;
				var res = str.replace("{0}", msg_id);
				$("#spnCrmDlg").text(res);
				$("#btnConfirmDlg").click();
			},
			error : function() {

				ShowErrorConnectMessage();
			}
		});
	}

	function ShowSuccessMsg(template_id, msg_id) {
		var data = {}
		data["message_id"] = template_id;
		jQuery.ajax({
			url : 'util-getmsg',
			type : "Post",
			contentType : "application/json",
			data : JSON.stringify(data),
			dataType : 'json',
			success : function(obj) {
				var str = obj.message_desc;
				var res = str.replace("{0}", msg_id);
				$("#spnSuccess").text(res);
				$("#dlgSuccessMain").modal();
				//window.scrollTo(0, 0);
			},
			error : function() {
				ShowErrorConnectMessage();
			}
		});
	}
	function ShowErrorMsg(template_id, msg_id) {
		var data = {}
		data["message_id"] = template_id;
		jQuery.ajax({
			url : 'util-getmsg',
			type : "Post",
			contentType : "application/json",
			data : JSON.stringify(data),
			dataType : 'json',
			success : function(obj) {
				var str = obj.message_desc;
				var res = str.replace("{0}", msg_id);
				$("#spnError").text(res);
				$("#dlgErrorMain").modal();
				//window.scrollTo(0, 0);
			},
			error : function() {

				ShowErrorConnectMessage();
			}
		});
	}

	function ConfirmDelete() {
		$("#btnPopupCloseDel").click();
		RefFuncDel();
	}

	function ShowWaiting() {
		waitingDialog.show('Please Wait...');
		setTimeout(function() {
			waitingDialog.hide();
		}, 50000);
	}
	function HideWaiting() {
		waitingDialog.hide();
	}
	function ShowErrorTran() {
		 $("#divTran").show();
         $("#divTran").fadeTo(15000, 500).slideUp(500, function () {
             $("#divTran").hide();
         });
         //window.scrollTo(0, 0);
	}
	function ShowErrorCustomMessage(ex) {
		$("#spnError").text(ex);
		$("#dlgErrorMain").modal();
		//window.scrollTo(0, 0);
	}
	function ShowErrorConnectMessage() {
    	var res ='0007 : ไม่สามารถเชื่อต่อ service ได้';
    	$("#spnError").text(res);
		$("#dlgErrorMain").modal();
	}
	function GetLangMain()
	{
		return $('#txtLangMain').val();
	}
	function ValidateSpecialChar(x){
		 var re = /"|'|--|[\/*]{2}/g;
			var str = x;
		    var result = re.test(str);
		 return result;
		
	}
	function InitPluginMain()
	{
		 $(".timepicker").timepicker({
				showInputs : false,
				minuteStep: 1,
		        showMeridian: false,
		        defaultTime: false
			});
		 
		 $('[data-provide="datepicker"]').datepicker({
				autoclose : true
			});
		//Initialize Select2 Elements
			$(".select2").select2();

			//Datemask dd/mm/yyyy
			$("#datemask").inputmask("dd/mm/yyyy", {
				"placeholder" : "dd/mm/yyyy"
			});
			//Datemask2 mm/dd/yyyy
			$("#datemask2").inputmask("mm/dd/yyyy", {
				"placeholder" : "mm/dd/yyyy"
			});
			//Money Euro
			$("[data-mask]").inputmask();

			//Date range picker
			$('#reservation').daterangepicker();
			//Date range picker with time picker
			$('#reservationtime').daterangepicker({
				timePicker : true,
				timePickerIncrement : 30,
				format : 'MM/DD/YYYY h:mm A'
			});
			//Date range as a button
			$('#daterange-btn').daterangepicker(
					{
						ranges : {
							'Today' : [ moment(), moment() ],
							'Yesterday' : [ moment().subtract(1, 'days'),
									moment().subtract(1, 'days') ],
							'Last 7 Days' : [ moment().subtract(6, 'days'),
									moment() ],
							'Last 30 Days' : [ moment().subtract(29, 'days'),
									moment() ],
							'This Month' : [ moment().startOf('month'),
									moment().endOf('month') ],
							'Last Month' : [
									moment().subtract(1, 'month').startOf(
											'month'),
									moment().subtract(1, 'month')
											.endOf('month') ]
						},
						startDate : moment().subtract(29, 'days'),
						endDate : moment()
					},
					function(start, end) {
						$('#daterange-btn span').html(
								start.format('MMMM D, YYYY') + ' - '
										+ end.format('MMMM D, YYYY'));
					});

			//Date picker
			$('#datepicker').datepicker({
				autoclose : true
			});
			
			//iCheck for checkbox and radio inputs
			$('input[type="checkbox"].minimal2')
					.iCheck({
						checkboxClass : 'icheckbox_minimal-blue',
						//checkboxClass : 'icheckbox_flat-blue',
						radioClass : 'iradio_minimal-blue'
					});
			

			//Colorpicker
			$(".my-colorpicker1").colorpicker();
			//color picker with addon
			$(".my-colorpicker2").colorpicker();

		
	}
	
</script>
<style type="text/css">
html, body {
	height: 100%;
	padding-bottom: 0;
	background-color: #F5F5F5;
	padding-right: 0 !important;
}
</style>
<style>
.datepicker {
	z-index: 1151 !important;
}
</style>
</head>
<body class="hold-transition skin-green sidebar-mini">
	<div class="wrapper">
		<tiles:insertAttribute name="header"></tiles:insertAttribute>
		</section>
		<tiles:insertAttribute name="sidebar"></tiles:insertAttribute>
		</section>

		<!-- Content Wrapper. Contains page content -->
		<div class="content-wrapper">
			<!-- Content Header (Page header) -->
			<div id="divSiteMap" runat="server">
				<section class="content-header">
				<h1 style="color: #eeeeee">DashboardDashboard</h1>
				<ol class="breadcrumb" style="color: #eeeeee">
					<li><a href="#" style="color: #eeeeee"><i
							class="fa fa-dashboard"></i> Home</a></li>
					<li class="active" style="color: #eeeeee">DashboardDashboardDashboard</li>
				</ol>
				</section>

			</div>

			<!-- Main content -->

			<section class="content"> <input type="text"
				id="txtLangMain" style="display: none;" />
			<div id="divTran" class="alert alert-danger alert-dismissible"
				hidden="hidden" style="max-width: 60%;">
				<button type="button" class="close" data-hide="alert">&times;</button>
				<h4>
					<i class="icon fa fa-info"></i>Error!
				</h4>
				CRA-00001: ไม่สามารถเชื่อมต่อ Service ได้
			</div>
			<div id="divError" class="alert alert-danger" hidden="hidden"
				style="max-width: 60%;">
				<button type="button" class="close" data-hide="alert">&times;</button>
				<strong>Error!</strong> <span id="spnError1"></span>
			</div>
			<div id="divSuccess" class="alert alert-success" hidden="hidden"
				style="max-width: 60%;">
				<button type="button" class="close" data-hide="alert">&times;</button>
				<strong>success</strong> <span id="spnSuccess1"></span>
			</div>
			<table style="width: 100%; height: 100%; min-height: 950px;">
				<tr>
					<td style="height: 100%; min-height: 950px; vertical-align: top;">
						<tiles:insertAttribute name="body"></tiles:insertAttribute>
					</td>
				</tr>
			</table>
			</section>
			<!-- /.content -->
		</div>
		<!-- /.content-wrapper -->
		<tiles:insertAttribute name="footer"></tiles:insertAttribute>
		</section>
		<tiles:insertAttribute name="sidebarcontrol"></tiles:insertAttribute>
		</section>

	</div>


	<!-- Confirm Dailog -->
	<button id="btnConfirmDlg" data-toggle="modal"
		data-target="#dlgConfirmDel" style="display: none;">btnConfirmDlg</button>
	<div class="container">
		<!-- Modal -->
		<div class="modal fade" id="dlgConfirmDel" role="dialog">
			<div class="modal-dialog">

				<!-- Modal content-->
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" id="btnPopupCloseDel"
							data-dismiss="modal">&times;</button>
						<h4 class="modal-title" style="color: #FF0000">
							<span id="spnCrmDlg">ยืนยันการลบ?</span>
						</h4>
					</div>
					<div class="row">
						<br />
					</div>
					<div class="row">
						<div style="padding-top: 20px; padding-right: 20px;">
							<table width="100%">
								<tr>
									<td align="right">
										<button type="button" class="btn btn-default"
											data-dismiss="modal">
											<span class="glyphicon glyphicon-remove"></span>&nbsp;ยกเลิก
										</button>
										<button type="button" class="btn btn-danger" id="btnCrmDel"
											onclick="ConfirmDelete();">
											<span class="glyphicon glyphicon-floppy-save"></span>&nbsp;ตกลง
										</button>
									</td>
								</tr>
								<tr>
									<td><br /></td>
								</tr>
							</table>

						</div>
					</div>

				</div>
			</div>
		</div>

	</div>
	<div class="container">
		<!-- Modal -->
		<div class="modal fade" id="dlgErrorMain" role="dialog">
			<div class="modal-dialog">

				<!-- Modal content-->
				<div class="modal-content alert alert-danger alert-dismissible">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<h4>
							<i class="icon fa fa-info"></i>Error!

						</h4>
						<span id="spnError"></span>
					</div>
					<div class="row">
						<br />
					</div>
					<div class="row">
						<div style="padding-top: 20px; padding-right: 20px;">
							<table width="100%">
								<tr>
									<td align="right"></td>
								</tr>
								<tr>
									<td><br /></td>
								</tr>
							</table>

						</div>
					</div>

				</div>
			</div>
		</div>

	</div>
	<div class="container">
		<!-- Modal -->
		<div class="modal fade" id="dlgSuccessMain" role="dialog">
			<div class="modal-dialog">

				<!-- Modal content-->
				<div class="modal-content alert alert-success">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<h4>
							<i class="icon fa fa-check"></i>Success

						</h4>
						<span id="spnSuccess"></span>
					</div>
					<div class="row">
						<br />
					</div>
					<div class="row">
						<div style="padding-top: 20px; padding-right: 20px;">
							<table width="100%">
								<tr>
									<td align="right"></td>
								</tr>
								<tr>
									<td><br /></td>
								</tr>
							</table>

						</div>
					</div>

				</div>
			</div>
		</div>

	</div>
	<!-- ./wrapper -->

	<!-- jQuery 2.2.3 -->
	<script
		src="<%=request.getContextPath()%>/resources/plugins/jQuery/jquery-2.2.3.min.js"></script>
	<!-- jQuery UI 1.11.4 -->
	<script
		src="<%=request.getContextPath()%>/resources/Scripts/jquery-ui.min.js"></script>
	<!-- Resolve conflict in jQuery UI tooltip with Bootstrap tooltip -->
	<script>
		$.widget.bridge('uibutton', $.ui.button);
	</script>
	<!-- Bootstrap 3.3.6 -->
	<script
		src="<%=request.getContextPath()%>/resources/bootstrap/js/bootstrap.min.js"></script>
	<!-- Morris.js charts -->
	<script
		src="<%=request.getContextPath()%>/resources/plugins/morris/morris.min.js"></script>
	<!-- Sparkline -->
	<script
		src="<%=request.getContextPath()%>/resources/plugins/sparkline/jquery.sparkline.min.js"></script>
	<!-- jvectormap -->
	<script
		src="<%=request.getContextPath()%>/resources/plugins/jvectormap/jquery-jvectormap-1.2.2.min.js"></script>
	<script
		src="<%=request.getContextPath()%>/resources/plugins/jvectormap/jquery-jvectormap-world-mill-en.js"></script>
	<!-- jQuery Knob Chart -->
	<script
		src="<%=request.getContextPath()%>/resources/plugins/knob/jquery.knob.js"></script>
	<!-- daterangepicker -->
	<script
		src="<%=request.getContextPath()%>/resources/plugins/moment/moment.min.js"></script>
	<script
		src="<%=request.getContextPath()%>/resources/plugins/raphael/raphael-min.js"></script>
	<script
		src="<%=request.getContextPath()%>/resources/plugins/daterangepicker/daterangepicker.js"></script>
	<!-- datepicker -->

	<!-- Bootstrap WYSIHTML5 -->
	<script
		src="<%=request.getContextPath()%>/resources/plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.all.min.js"></script>
	<!-- Slimscroll -->
	<script
		src="<%=request.getContextPath()%>/resources/plugins/slimScroll/jquery.slimscroll.min.js"></script>
	<!-- FastClick -->
	<script
		src="<%=request.getContextPath()%>/resources/plugins/fastclick/fastclick.js"></script>

	<!-- Select2 -->
	<script
		src="<%=request.getContextPath()%>/resources/plugins/select2/select2.full.min.js"></script>
	<!-- InputMask -->
	<script
		src="<%=request.getContextPath()%>/resources/plugins/input-mask/jquery.inputmask.js"></script>
	<script
		src="<%=request.getContextPath()%>/resources/plugins/input-mask/jquery.inputmask.date.extensions.js"></script>
	<script
		src="<%=request.getContextPath()%>/resources/plugins/input-mask/jquery.inputmask.extensions.js"></script>
	<!-- date-range-picker -->
	<script
		src="<%=request.getContextPath()%>/resources/plugins/daterangepicker/daterangepicker.js"></script>

	<!-- bootstrap datepicker -->
	<script
		src="<%=request.getContextPath()%>/resources/plugins/datepicker/bootstrap-datepicker.js"></script>
	<script
		src="<%=request.getContextPath()%>/resources/plugins/datepicker/bootstrap-datepicker-thai.js"></script>
	<script
		src="<%=request.getContextPath()%>/resources/plugins/datepicker/locales/bootstrap-datepicker.th.js"></script>
	<!-- bootstrap color picker -->
	<script
		src="<%=request.getContextPath()%>/resources/plugins/colorpicker/bootstrap-colorpicker.min.js"></script>
	<!-- bootstrap time picker -->
	<script
		src="<%=request.getContextPath()%>/resources/plugins/timepicker/bootstrap-timepicker.min.js"></script>
	<!-- SlimScroll 1.3.0 -->
	<script
		src="<%=request.getContextPath()%>/resources/plugins/slimScroll/jquery.slimscroll.min.js"></script>
	<!-- iCheck 1.0.1 -->
	<script
		src="<%=request.getContextPath()%>/resources/plugins/iCheck/icheck.min.js"></script>
	<!-- FastClick -->
	<script
		src="<%=request.getContextPath()%>/resources/plugins/fastclick/fastclick.js"></script>
	<!-- AdminLTE App -->
	<script
		src="<%=request.getContextPath()%>/resources/dist/js/app.min.js"></script>
	<!-- AdminLTE for demo purposes -->
	<script src="<%=request.getContextPath()%>/resources/dist/js/demo.js"></script>
	<script
		src="<%=request.getContextPath()%>/resources/bootstrap/js/jquery.validate.min.js"></script>
	<script
		src="<%=request.getContextPath()%>/resources/plugins/pagination/responsive-paginate.js"></script>
	<script
		src="<%=request.getContextPath()%>/resources/plugins/datatables/jquery.dataTables.min.js"></script>
	<script
		src="<%=request.getContextPath()%>/resources/plugins/datatables/dataTables.bootstrap.min.js"></script>
	<!-- Page script -->
	<script>
		$(function() {
			//Initialize Select2 Elements
			$(".select2").select2();

			//Datemask dd/mm/yyyy
			$("#datemask").inputmask("dd/mm/yyyy", {
				"placeholder" : "dd/mm/yyyy"
			});
			//Datemask2 mm/dd/yyyy
			$("#datemask2").inputmask("mm/dd/yyyy", {
				"placeholder" : "mm/dd/yyyy"
			});
			//Money Euro
			$("[data-mask]").inputmask();

			//Date range picker
			$('#reservation').daterangepicker();
			//Date range picker with time picker
			$('#reservationtime').daterangepicker({
				timePicker : true,
				timePickerIncrement : 30,
				format : 'MM/DD/YYYY h:mm A'
			});
			//Date range as a button
			$('#daterange-btn').daterangepicker(
					{
						ranges : {
							'Today' : [ moment(), moment() ],
							'Yesterday' : [ moment().subtract(1, 'days'),
									moment().subtract(1, 'days') ],
							'Last 7 Days' : [ moment().subtract(6, 'days'),
									moment() ],
							'Last 30 Days' : [ moment().subtract(29, 'days'),
									moment() ],
							'This Month' : [ moment().startOf('month'),
									moment().endOf('month') ],
							'Last Month' : [
									moment().subtract(1, 'month').startOf(
											'month'),
									moment().subtract(1, 'month')
											.endOf('month') ]
						},
						startDate : moment().subtract(29, 'days'),
						endDate : moment()
					},
					function(start, end) {
						$('#daterange-btn span').html(
								start.format('MMMM D, YYYY') + ' - '
										+ end.format('MMMM D, YYYY'));
					});

			//Date picker
			$('#datepicker').datepicker({
				//autoclose : true
			});
			
			//iCheck for checkbox and radio inputs
			$('input[type="checkbox"].minimal, input[type="radio"].minimal')
					.iCheck({
						checkboxClass : 'icheckbox_minimal-blue',
						//checkboxClass : 'icheckbox_flat-blue',
						//radioClass : 'iradio_minimal-blue'
						radioClass : 'iradio_flat-blue'
					});
			//Red color scheme for iCheck
			$(
					'input[type="checkbox"].minimal-red, input[type="radio"].minimal-red')
					.iCheck({
						checkboxClass : 'icheckbox_minimal-red',
						radioClass : 'iradio_minimal-red'
					});
			//Flat red color scheme for iCheck
			$('input[type="checkbox"].flat-red, input[type="radio"].flat-red')
					.iCheck({
						checkboxClass : 'icheckbox_flat-green',
						radioClass : 'iradio_flat-green'
					});

			//Colorpicker
			$(".my-colorpicker1").colorpicker();
			//color picker with addon
			$(".my-colorpicker2").colorpicker();

			//Timepicker
			$(".timepicker").timepicker({
				showInputs : false,
				minuteStep: 1,
                showMeridian: false,
                defaultTime: false
			});
		});
	</script>

	<script>
		var waitingDialog = waitingDialog
				|| (function($) {
					'use strict';

					// Creating modal dialog's DOM
					var $dialog = $('<div class="modal fade" data-backdrop="static" data-keyboard="false" tabindex="-1" role="dialog" aria-hidden="true" style="padding-top:35%; overflow-y:visible;">'
							+ '<div>'
							+ '<div >'
							+ '<center><div>'
							+ '<div style="color:white;"> <span class="glyphicon glyphicon-refresh glyphicon-refresh-animate"></span> Loading...</div>'
							+ '</div></center>' + '</div></div></div>');

					return {
						/**
						 * Opens our dialog
						 * @param message Custom message
						 * @param options Custom options:
						 * 				  options.dialogSize - bootstrap postfix for dialog size, e.g. "sm", "m";
						 * 				  options.progressType - bootstrap postfix for progress bar type, e.g. "success", "warning".
						 */
						show : function(message, options) {
							// Assigning defaults
							if (typeof options === 'undefined') {
								options = {};
							}
							if (typeof message === 'undefined') {
								message = 'Loading';
							}
							var settings = $.extend({
								dialogSize : 'm',
								progressType : '',
								onHide : null
							// This callback runs after the dialog was hidden
							}, options);

							// Configuring dialog
							$dialog.find('.modal-dialog').attr('class',
									'modal-dialog').addClass(
									'modal-' + settings.dialogSize);
							$dialog.find('.progress-bar').attr('class',
									'progress-bar');
							if (settings.progressType) {
								$dialog
										.find('.progress-bar')
										.addClass(
												'progress-bar-'
														+ settings.progressType);
							}
							$dialog.find('h3').text(message);
							// Adding callbacks
							if (typeof settings.onHide === 'function') {
								$dialog.off('hidden.bs.modal').on(
										'hidden.bs.modal', function(e) {
											settings.onHide.call($dialog);
										});
							}
							// Opening dialog
							$dialog.modal();
						},
						/**
						 * Closes dialog
						 */
						hide : function() {
							$dialog.modal('hide');
						}
					};

				})(jQuery);
	</script>
</body>
</html>