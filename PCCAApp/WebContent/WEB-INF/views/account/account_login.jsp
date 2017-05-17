<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="shortcut icon" type="image/x-icon"
	href="resources/Images/logo.png" />
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>Hris | Log in</title>
<!-- Tell the browser to be responsive to screen width -->
<meta
	content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no"
	name="viewport">
<!-- Bootstrap 3.3.6 -->
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/bootstrap/css/bootstrap.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/bootstrap/css/font-awesome.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/bootstrap/css/font-awesome.min.css">
<!-- Theme style -->
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/dist/css/AdminLTE.min.css">
<!-- iCheck -->
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/plugins/iCheck/square/blue.css">

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
<script type='text/javascript'>
        $(window).on('load', function () {
            $('form').validate({
                rules: {
                    username: {
                        minlength: 3,
                        maxlength: 15,
                        required: true
                    },
                    password: {
                        minlength: 3,
                        maxlength: 15,
                        required: true
                    }
                },
                highlight: function (element) {
                    $(element).closest('.form-control').closest('.has-feedback').addClass('has-error');
                },
                unhighlight: function (element) {
                    $(element).closest('.form-control').closest('.has-feedback').removeClass('has-error');
                },
                submitHandler: function () {
                    Login();
                },
                errorElement: 'span',
                errorClass: 'help-block',
                errorPlacement: function (error, element) {
                    if (element.parent('.input-group').length) {
                        error.insertAfter(element.parent());
                    } else {
                        error.insertAfter(element);
                    }
                }
            });


        });
        
        function Login() {     
        	try
        	{
        	waitingDialog.show('Please Wait...'); setTimeout(function () { waitingDialog.hide(); }, 50000);
           var data = {}
			data["codempid"] = $("#txtUsername").val();
			data["password"] = $("#txtPassword").val();
           jQuery.ajax({
               url: 'login',
               type: "Post",
               contentType: "application/json",
               data: JSON.stringify(data),
	           dataType: 'json',
               success: function (data) {
            	   waitingDialog.hide();
                   if(data.success==1){
                	   if(data.default_page != null && data.default_page != '' ){
                   		window.location = data.default_page;
                	   }else{
                		   window.location = "home";
                	   }
                	}
                   else{
                	   ShowErrorMsg('0008',null);
                	}

               },
               error: function () {
            	   waitingDialog.hide();
            	   ShowErrorConnectMessage();
               }
           });
        	}
        	catch (ex) {
        		 waitingDialog.hide();
        		 ShowErrorMsg('0006',ex);
			}
        }
        
        
        <!--original script 12052017-->
//         function Login() {     
//         	try
//         	{
//         	waitingDialog.show('Please Wait...'); setTimeout(function () { waitingDialog.hide(); }, 50000);
//            var data = {}
// 			data["codempid"] = $("#txtUsername").val();
// 			data["password"] = $("#txtPassword").val();
//            jQuery.ajax({
//                url: 'login',
//                type: "Post",
//                contentType: "application/json",
//                data: JSON.stringify(data),
// 	           dataType: 'json',
//                success: function (data) {
//             	   waitingDialog.hide();
//                    if(data.success==1){
//                 	   if(data.default_page != null && data.default_page != '' ){
//                    		window.location = data.default_page;
//                 	   }else{
//                 		   window.location = "home";
//                 	   }
//                 	}
//                    else{
//                 	   ShowErrorMsg('0008',null);
//                 	}

//                },
//                error: function () {
//             	   waitingDialog.hide();
//             	   ShowErrorConnectMessage();
//                }
//            });
//         	}
//         	catch (ex) {
//         		 waitingDialog.hide();
//         		 ShowErrorMsg('0006',ex);
// 			}
//         }
        
        function ShowErrorCustomMessage(ex) {
    		$("#spnError").text(ex);
    		$("#dlgErrorMain").modal();
    		window.scrollTo(0, 0);
    	}
        function ShowErrorConnectMessage() {
        	var res ='0007 : ไม่สามารถเชื่อต่อ service ได้';
        	$("#spnError").text(res);
			$("#dlgErrorMain").modal();
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
    				window.scrollTo(0, 0);
    			},
    			error : function() {

    				ShowErrorConnectMessage();
    			}
    		});
    	}
    </script>

<style>
body, html {
	height: 100%
}

.div-login {
	height: 100%
}
</style>
</head>
<body style="background-color: white; overflow-y: hidden;">
	<div style="overflow: hidden;" class="div-login">

		<table style="height: 100%; width: 100%;">
			<tr>
				<td align="center" style="vertical-align: middle;">

					<div class="login-box">
						<div id="divValid" class="alert alert-danger alert-dismissible"
							hidden="hidden">
							<button type="button" class="close" data-hide="alert">&times;</button>
							<h4>
								<i class="icon fa fa-info"></i>Error!
							</h4>
							CRA-00001: user name or password not found.

						</div>
						<div id="divTran" class="alert alert-danger alert-dismissible"
							hidden="hidden">
							<button type="button" class="close" data-hide="alert">&times;</button>
							<h4>
								<i class="icon fa fa-info"></i>Error!
							</h4>
							CRA-00001: ไม่สามารถเชื่อมต่อ Service ได้
						</div>

						<!-- /.login-logo -->
						<div class="login-box-body">
							<center>
								<h1 href=".#">
									<b>HR</b>IS
								</h1>
								<br />
								<div class="login-logo">
									<a href=".#"><img src="resources/Images/logo.png" /></a>
								</div>
								<br />
							</center>
							<form>
								<div class="form-group has-feedback">
									<input type="text" class="form-control" id="txtUsername"
										name="username" placeholder="User Name" /> <span
										class="glyphicon glyphicon-user form-control-feedback"></span>
								</div>
								<div class="form-group has-feedback">
									<input type="password" class="form-control" id="txtPassword"
										name="password" placeholder="Password" /> <span
										class="glyphicon glyphicon-lock form-control-feedback"></span>
								</div>
								<div class="row">
									<div class="col-xs-8">
										<div class="checkbox icheck" style="display: none;">
											<label> <input type="checkbox"> Remember Me
											</label>
										</div>
									</div>
									<!-- /.col -->
									<div class="col-xs-4">
										<button type="submit"
											class="btn btn-primary btn-block btn-flat">Sign In</button>
									</div>
									<!-- /.col -->
								</div>
							</form>


							<a href="#" style="display: none;">I forgot my password</a><br>
							<a href="register.html" class="text-center"
								style="display: none;">Register a new membership</a>

						</div>
						<!-- /.login-box-body -->
					</div> <!-- /.login-box -->
				</td>
			</tr>
		</table>
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
	<!-- jQuery 2.2.3 -->
	<script
		src="<%=request.getContextPath()%>/resources/plugins/jQuery/jquery-2.2.3.min.js"></script>
	<!-- Bootstrap 3.3.6 -->
	<script
		src="<%=request.getContextPath()%>/resources/bootstrap/js/bootstrap.min.js"></script>
	<!-- iCheck -->
	<script
		src="<%=request.getContextPath()%>/resources/plugins/iCheck/icheck.min.js"></script>
	<script
		src="<%=request.getContextPath()%>/resources/bootstrap/js/jquery.validate.min.js"></script>
	<script>
  $(function () {
    $('input').iCheck({
      checkboxClass: 'icheckbox_square-blue',
      radioClass: 'iradio_square-blue',
      increaseArea: '20%' // optional
    });
  });
</script>
	<script>
        var waitingDialog = waitingDialog || (function ($) {
            'use strict';

            // Creating modal dialog's DOM
            var $dialog = $(
                '<div class="modal fade" data-backdrop="static" data-keyboard="false" tabindex="-1" role="dialog" aria-hidden="true" style="padding-top:35%; overflow-y:visible;">' +
                '<div>' +
                '<div >' +
                    '<center><div>' +
                        '<div style="color:white;"><span class="glyphicon glyphicon-refresh glyphicon-refresh-animate"></span> Loading...</div>' +
                    '</div></center>' +
                '</div></div></div>');

            return {
                /**
                 * Opens our dialog
                 * @param message Custom message
                 * @param options Custom options:
                 * 				  options.dialogSize - bootstrap postfix for dialog size, e.g. "sm", "m";
                 * 				  options.progressType - bootstrap postfix for progress bar type, e.g. "success", "warning".
                 */
                show: function (message, options) {
                    // Assigning defaults
                    if (typeof options === 'undefined') {
                        options = {};
                    }
                    if (typeof message === 'undefined') {
                        message = 'Loading';
                    }
                    var settings = $.extend({
                        dialogSize: 'm',
                        progressType: '',
                        onHide: null // This callback runs after the dialog was hidden
                    }, options);

                    // Configuring dialog
                    $dialog.find('.modal-dialog').attr('class', 'modal-dialog').addClass('modal-' + settings.dialogSize);
                    $dialog.find('.progress-bar').attr('class', 'progress-bar');
                    if (settings.progressType) {
                        $dialog.find('.progress-bar').addClass('progress-bar-' + settings.progressType);
                    }
                    $dialog.find('h3').text(message);
                    // Adding callbacks
                    if (typeof settings.onHide === 'function') {
                        $dialog.off('hidden.bs.modal').on('hidden.bs.modal', function (e) {
                            settings.onHide.call($dialog);
                        });
                    }
                    // Opening dialog
                    $dialog.modal();
                },
                /**
                 * Closes dialog
                 */
                hide: function () {
                    $dialog.modal('hide');
                }
            };

        })(jQuery);
    </script>
</body>
</html>