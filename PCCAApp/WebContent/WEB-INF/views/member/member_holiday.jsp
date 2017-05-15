<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<script>
	$(document).ready(
			function() {
				ShowWaiting();
				 var d = new Date();
				 var year =d.getFullYear();
		         $('#ddlYear') .find('option').remove().end();
		         var select = document.getElementById('ddlYear');
		         for (var i = 0; i < 2; i++) {
		             var opt = document.createElement('option');
		             opt.value = year+i;
		             opt.innerHTML = year+543+i;
					 select.appendChild(opt);
					if(i==0){
						opt.selected =true;
					}
		         }
		         
		         InitHoliday();
				
				$('input[id="chkUser"]').on('ifChecked', function(event){
					  document.getElementById("ddlUser").disabled=false;
					});
				$('input[id="chkUser"]').on('ifUnchecked', function(event){
					  document.getElementById("ddlUser").disabled=true;
					});
				
			});
	
    function InitHoliday(){
    	var year = document.getElementById('ddlYear');
    	var yearInt = parseInt(year.value)+543;
    	$('#lblYear').html(yearInt); 
    	var data = {}
    	data["year"] = year.value;
    	jQuery.ajax({
			url : 'member-getholiday',
			type : "Post",
			contentType : "application/json",
			data: JSON.stringify(data),
			dataType : 'json',
			success : function(obj) {
				SetHoliday(obj);
			},
			error : function() {
				HideWaiting();
				ShowErrorConnectMessage();
			}
		});
    }
	function SetHoliday(obj){
	
		//var str ="<table class='table list-header'> <!-- tr><th style='width: 10px'><spring:message code='member.holiday.seq'/></th> <th style='width: 120px'><spring:message code='member.holiday.date'/></th><th><spring:message code='member.holiday.desc'/></th></tr -->";
		var str='<table class="table" style="margin-bottom: 40px;"><tr><th style="width: 10px;" class="list-header text-center"><spring:message code="member.holiday.seq"/></th>';
			str= str+'<th class="list-header" style="padding-left:12%;" colspan="2"><spring:message code="member.holiday.holiday"/>';
			//str= str+'<div class="col-sm-9 col-xs-12"><spring:message code="member.holiday.desc"/></div>';
			str= str+'</th></tr>'; 
		for (var i = 0; i < obj.length; i++) {
			var day = obj[i].dtedate.split(/[ ]+/);
			//str =str+"<tr><td>"+(i+1)+"</td><td>"+obj[i].dtedate+"</td><td>"+obj[i].desholdyt+"</td></tr>";
			str= str+'<tr><td class="text-center custom-row">'+(i+1)+'</td><td class="custom-row">';
			//str= str+'<div style="float: left; padding-left: 15px; width:200px;"><label class="custom-font-label-thin">'+obj[i].dtedate+'</label></div>';
			str= str+'<div style="float: left; padding-left: 30px; width:200px;"><label class="custom-font-label-thin" style="width:65px;">'+day[0]+'</label>';
			str= str+'<label class="custom-font-label-thin">'+day[1]+'</label></div>';
			str= str+'<div class="col-sm-8 col-xs-12" style="padding-left:30px;">'+obj[i].desholdyt+'</div>';
			str= str+'</td><tr>';
        }
		str= str+'</table>'
		/*var str='<ul class="products-list product-list-in-box" style="margin:5px;">';
     		str=str+'<li class="item list-header"><div class="col-sm-1 col-xs-3">';
			str=str+'<label><spring:message code="member.holiday.seq"/></label></div>';
			str=str+'<div class="col-sm-3 col-xs-4"><label><spring:message code="member.holiday.date"/></label></div>';
			str=str+'<div class="col-sm-6 col-xs-5"><label><spring:message code="member.holiday.desc"/></label></div></li>';
     	for (var i = 0; i < obj.length; i++) {
			str=str+'<li class="item holiday-list"><div class="col-sm-1 col-xs-2">';
			str=str+'<label class="font-thin font-large-profile">'+(i+1)+'</label></div>';
			str=str+'<div class="col-sm-3 col-xs-5"><label class="font-thin font-large-profile">'+obj[i].dtedate+'</label></div>';
			str=str+'<div class="col-sm-6 col-xs-4"><label class="font-thin font-large-profile">'+obj[i].desholdyt+'</label></div></li>';
     	}
     	str = str+'</ul>';*/

		  $('#divHoliday').html(str);
		  $('#lblYear').html(obj[0].holiday_year);
		  
			HideWaiting();
	}
	</script>
<div style="background-color: white;" class="testscoll">
	<div class="row">
		<div class="col-lg-12">
			<!-- general form elements -->
			<div class="box collapsed-box">
				<div class="box-header">
					<h3 class="box-title">
						<spring:message code="member.holiday.holidayyear" />
						&nbsp;&nbsp;<label id="lblYear" class="font-thin"> </label>
					</h3>
					<div style="min-height: 12px;"></div>
					<div class="box-tools pull-right">
						<span class="btn btn-box-tool" data-widget="collapse"><img
							src="resources/Images/dot.png" style="width: 20px; height: 20px;">
						</span>
					</div>
				</div>
				<!-- /.box-header -->
				<!-- form start -->
				<form class="form-horizontal">
					<div class="box-body">
						<div class="row">
							<div class="col-sm-12">
								<div class="form-group">
									<div class="col-sm-2"></div>
									<!--label   class="col-sm-2 control-label">ปี
									</label -->
									<div class="col-sm-6">
										<select class="form-control" id="ddlYear" style="width: 100%;">

										</select>
									</div>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-sm-12">
								<div class="form-group">
									<label for="inputUser" class="col-sm-4 control-label">
									</label>
									<div class="col-sm-4">
										<button type="button" onclick="InitHoliday();"
											class="btn pull-right custom-button">
											<span class="glyphicon glyphicon-search"></span>&nbsp;ค้นหา
										</button>
									</div>
								</div>
							</div>
						</div>
					</div>

				</form>

			</div>
		</div>

	</div>
	<div class="row">
		<div class="col-sm-12">
			<div class="box-body no-padding">
				<div id="divHoliday"></div>

			</div>
		</div>
	</div>
</div>

