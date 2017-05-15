<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<header class="main-header">
	<!-- Logo -->
	<a href="#" class="logo"> <!-- mini logo for sidebar mini 50x50 pixels -->
		<span class="logo-mini">PCCA</span> <!--class="logo-mini"><b>H</b>IS</span> //logo for regular state and mobile devices -->

		<span class="logo-lg"><b>PCCA</b></span>
	</a>
	<!-- Header Navbar: style can be found in header.less -->
	<nav class="navbar navbar-static-top">
		<!-- Sidebar toggle button-->
		<a href="#" class="sidebar-toggle" data-toggle="offcanvas"
			role="button"> <span class="sr-only">Toggle navigation</span>
		</a>

		<div class="navbar-custom-menu">
			<ul class="nav navbar-nav">
				<li class="dropdown user user-menu"><a href="#"
					class="dropdown-toggle" data-toggle="dropdown"> <!-- span class="hidden-xs" id="lblUserRight"></span>&nbsp;<i class="fa fa-gears"></i -->
						<i class="glyphicon glyphicon-user"></i>
				</a>
					<ul class="dropdown-menu">
						<!-- User image -->
						<li class="user-header" style="height: Auto"><img
							id="imgUserRightDown" src="resources/Images/logo.png"
							class="img-circle" alt="User Image">
							<p id="lblEmpIDMain"></p>
							<p id="lblNameMain">
								<!-- span id="lblNamePosition">split a name and a position away</span -->
							</p>
							<p id="lblPositionMain"></p></li>
						<!-- Menu Body -->
						<li class="user-body">
							<div class="row">
								<!-- div class="pull-left" -->
								<div align="center">
									<a href="member-profile" class="btn btn-default btn-flat">
										<span id="lblProfile"></span>
									</a>
								</div>
								<!-- div class="pull-right">
									<a href="account-logout" class="btn btn-default btn-flat"> <span id="lblSignOut"></span>
									</a>
								</div -->
							</div> <!-- /.row -->
						</li>
					</ul></li>
				<li class="dropdown notifications-menu" style="display: none;"><a
					href="#" class="dropdown-toggle" data-toggle="dropdown"> <img
						id="imgLang" src="resources/Images/lang/flags_iso/16/th.png" />
				</a>
					<ul class="dropdown-menu" style="max-height: 120px;">
						<li class="header">เลือกภาษา/Choose language</li>
						<li>
							<!-- inner menu: contains the actual data -->
							<ul class="menu">
								<li><a onclick="ChangeLang('th');" style="cursor: pointer;">
										<img src="resources/Images/lang/flags_iso/16/th.png" />
										ไทย/Thai
								</a></li>
								<li><a onclick="ChangeLang('us');" style="cursor: pointer;">
										<img src="resources/Images/lang/flags_iso/16/us.png" />
										English/English
								</a></li>
							</ul>
						</li>

					</ul></li>
				<!-- Control Sidebar Toggle Button -->
				<li><a href="#" data-toggle="control-sidebar"
					style="display: none;"><i class="fa fa-gears"></i></a></li>
			</ul>
		</div>
	</nav>
</header>