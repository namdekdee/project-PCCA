<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<style>
table#shifttimeTable {
	position: relative;
	overflow: hidden;
	border-collapse: collapse;
}

/*thead*/
table#shifttimeTable>thead {
	position: relative;
	display: block;
	/*seperates the header from the body allowing it to be positioned*/
	width: 100%;
	overflow: visible;
}

table#shifttimeTable>thead tr th.normal-column {
	min-width: 120px;
	height: 32px;
}

table#shifttimeTable>thead tr th#fixHeader1, table#shifttimeTable>thead tr th#fixHeader2
	{
	position: relative;
	/*display: block; */
	height: 100%;
	background-color: #eee;
	z-index: 1000;
}

/*tbody*/
table#shifttimeTable>tbody {
	position: relative;
	display: block; /*seperates the tbody from the header*/
	width: 100%;
	height: 420px;
	overflow: scroll;
}

table#shifttimeTable>tbody td.normal-column {
	/*background-color: #bbc; */
	min-width: 120px;
}

table#shifttimeTable>tbody td, table#shifttimeTable>thead th {
	border: 1px solid black;
}

table#shifttimeTable>tbody tr td#fixBody1 {
	position: relative;
	/*display: block; seperates the first column from the tbody*/
	height: 100%;
	background-color: #eee;
	z-index: 1000;
}

table#shifttimeTable>tbody tr td#fixBody2 {
	/*the first cell in each tr*/
	position: relative;
	/*display: block; seperates the first column from the tbody*/
	width: 180px;
	height: 100%;
	background-color: #eee;
	z-index: 1000;
}

table#shifttimeTable>thead tr th#fixHeader1, table#shifttimeTable>tbody tr td#fixBody1
	{
	min-width: 35px;
}

table#shifttimeTable>thead tr th#fixHeader2, table#shifttimeTable>tbody tr td#fixBody2
	{
	min-width: 180px;
}

.nampost {
	font-size: x-small;
}

.isHoliday {
	background-color: #ff0000;
	color: #ffffff;
}
</style>

<script>
$(document).ready(
		function() {
			try
			{
			ShowWaiting();
			
				var date = new Date();				
		        var day_first = 21;
		        var day_last = 20;
		        var month = date.getMonth()+1;
		        var firstDay = new Date(date.getFullYear(), date.getMonth(), 1);
				var lastDay = new Date(date.getFullYear(), date.getMonth() + 1, 0);
		        var mont_f = date.getMonth() + 1;
		        var mont_l = date.getMonth() + 1;
		        var year = date.getFullYear();
		        day_first = 21;
	        	lastDay = 20;		        

		        if (day_first < 10) {
		        	day_first = '0' + day_first;
		        }
		        if (day_last < 10) {
		        	day_last = '0' + day_last;
		        }		        
		        if( parseInt(month+''+date.getDate())> parseInt(month+''+20)){
		        	mont_l+=1
		        }else{
		        	mont_f-=1
		        }
		        
		        if (mont_f < 10) {
		        	mont_f = '0' + mont_f;
		        }
		        if (mont_l < 10) {
		        	mont_l = '0' + mont_l;
		        }
		        if (year < 2500) {
		            year = year + 543;
		        }		         
		         var start_date=day_first+'/'+mont_f+'/'+year;
		         var end_date=day_last+'/'+mont_l+'/'+year;
		        
 		         $("#txtStartDate").val(start_date);
 		         $("#txtEndDate").val(end_date);
 		            
			SetDropDownCompany(date.getMonth());
			
			}catch(ex) {
				HideWaiting();
				ShowErrorMsg('0006',ex);
			}
});

function daydiff(first, second) {
    return Math.round((second-first)/(1000*60*60*24));
}

function SetDropDownCompany(){
	try
	{
	
     jQuery.ajax({
			url : 'util-getcompany2', 
			type : "Post",
			contentType : "application/json",
			dataType : 'json',
			success : function(obj) {
				 $('#ddlCompany') .find('option').remove().end();
		         var select = document.getElementById('ddlCompany');
		         for (var i = 0; i < obj.length; i++) {
		             var opt = document.createElement('option');
		             opt.value = obj[i].ddl_value;
		             opt.innerHTML = obj[i].ddl_text;
		             select.appendChild(opt);
		         }
		         
		         SetDropDownDefault();
			},
			error : function() {
				HideWaiting();
				ShowErrorConnectMessage();
			}
		});
		
	}catch(ex)
	{
		HideWaiting();
		ShowErrorMsg('0006',ex);
	}	    
}

function SetDropDownDefault2() {
	$('#ddlUser') .find('option').remove().end();
    var select = document.getElementById('ddlUser');
   	 var opt = document.createElement('option');
        	opt.value = 'select';
        	opt.innerHTML = 'เลือก'; 
        	
        	select.appendChild(opt);
}

function SetDropDownDefault()
{
	try
	{
		
		var company_id = document.getElementById('ddlCompany');
		var com_id  ='';
		var urlLink = "util-getmemberfollower-default";
		var isEmptyList = false;
		 if(company_id.selectedIndex >0){
    		 com_id =company_id.value;
    	 }else if(company_id.value!="select"){
 			com_id =company_id.value;
 			urlLink = "util-getmemberfollower-shifttime";
 			
 		} else {
    		 isEmptyList = true; 
    	 }
		 
		
    	var data = {}
    	data["company"] = com_id;
   			
		 jQuery.ajax({
			 	url : urlLink,
				type : "Post",
				contentType : "application/json",
				data: JSON.stringify(data),
				dataType : 'json',
				success : function(obj) {
					$('#ddlUser') .find('option').remove().end();
			         var select = document.getElementById('ddlUser');
// 			         if(isEmptyList) {
			        	 var opt = document.createElement('option');
			             	opt.value = 'select';
			             	opt.innerHTML = 'เลือก'; 
			             	
			             	select.appendChild(opt);
// 			         } else { 
			         	for (var i = 0; i < obj.length; i++) {
			             	var opt = document.createElement('option');
			             	opt.value = obj[i].ddl_value;
			             	opt.innerHTML = obj[i].ddl_text;
// 			             	if(i==1){
// 			             		opt.selected =true;
// 			             	}
			             	select.appendChild(opt);
			         	}
// 			         } //end else
			         SetShifttimeObj();
			         //InitEditShiftTime(null);
				},
				error : function() {
					HideWaiting();
					ShowErrorConnectMessage();
				}
			});
	
	 
	}catch(ex)
	{
		HideWaiting();
		ShowErrorMsg('0006',ex);
	}
	
	 
     
}

function fixHeader() {
    $('table#shifttimeTable > thead').css("left", -$("table#shifttimeTable > tbody").scrollLeft()); //fix the thead relative to the body scrolling
    $('table#shifttimeTable > thead th#fixHeader1').css("left", $("table#shifttimeTable > tbody").scrollLeft());
    $('table#shifttimeTable > thead th#fixHeader2').css("left", $("table#shifttimeTable > tbody").scrollLeft());
    $('table#shifttimeTable > tbody td#fixBody1').css("left", $("table#shifttimeTable > tbody").scrollLeft()); //fix the first column of tdbody
    $('table#shifttimeTable > tbody td#fixBody2').css("left", $("table#shifttimeTable > tbody").scrollLeft()); //fix the first column of tdbody
}

function isOlderThanSevenDays(date) {
	var nowDate = new Date().getTime()/1000;
	var date_part = date.split("/");
	var date_timestamp = Math.round(new Date((parseInt(date_part[2])-543)+"/"+date_part[1]+"/"+date_part[0]+" 00:00:00").getTime()/1000);
	var sevendays = (60*60*24)*7;
	if(date_timestamp<nowDate) {
		if(nowDate-date_timestamp > sevendays) {
			return true;
		}
	} 
	return false;
}

function getNextDate(nowDate) {
	var date_part = nowDate.split("/");
	var timestamp1 = Math.round(new Date((parseInt(date_part[2])-543)+"/"+date_part[1]+"/"+date_part[0]+" 00:00:00").getTime()/1000);
	var timestamp2 = timestamp1 + (60*60*24);
	var newDate = new Date(timestamp2 * 1000),	
							yyyy = newDate.getFullYear(),
							mm = ('0' + (newDate.getMonth() + 1)).slice(-2),	
							dd = ('0' + newDate.getDate()).slice(-2),			
							hh = newDate.getHours(),
							h = hh,
							min = ('0' + newDate.getMinutes()).slice(-2),	
							ampm = 'AM',
							time;
	return time = dd+"/"+mm+"/"+(yyyy);
}

function toADdate(date) {
	var date_part = date.split('/');
	var yyyy = parseInt(date_part[2]);
	return date_part[0]+"/"+date_part[1]+"/"+(yyyy-543);
}

function SaveEditShifttime(number) {
	ShowWaiting();
	var obj_length = parseInt(number);
	var data =[];
	
	for(var i=0; i<number; i++) {
		var item = {};
		var isAdd = false;
		
		var dtework = document.getElementById("txtPrevDtework"+i).value;
		var holiday_chk = document.getElementById("chkHolidayChange"+i).checked;
		var shifttime_chk = document.getElementById("chkShifttimeChange"+i).checked;
		
		//if(holiday_chk) {
			var prevHoliday = document.getElementById("txtPrevHoliday"+i).value;
			var currHoliday = document.getElementById("selectHolidayMode"+i).value;
			var remark = document.getElementById("txtRemark"+i).value;
			
			if(prevHoliday == currHoliday) { 
				item["typework"] = prevHoliday;
				item["typework_old"] = prevHoliday;
			} else {
				item["typework"] = currHoliday;
				item["typework_old"] = prevHoliday;
				if(remark.length>0)  {
					item["remark"] = remark;
				}
				isAdd = true;
			}
		//} 
		//if(shifttime_chk) {
			var prevShifttime = document.getElementById("txtPrevShifttime"+i).value;
			var prevRangetime = document.getElementById("lblPrevRangeShifttime"+i).textContent;
			var currShifttimeSelect = document.getElementById("ddlOption"+i); 
			var currShifttime = currShifttimeSelect.options[currShifttimeSelect.selectedIndex].text;
			var currRangetime = document.getElementById("ddlOption"+i).value;
			
			if(prevShifttime == currShifttime) {
				//item["codshift"] = '';
				item["codshift"] = prevShifttime;
				item["codshift_old"] = prevShifttime;
				var time = prevRangetime.split(" - ");
				item["timstrtw_old"] = time[0].replace(".","");
				item["timendw_old"] = time[1].replace(".","");
				item["timstrtw"] = time[0].replace(".","");
				item["timendw"] = time[1].replace(".","");
				item["dtestrtw"] = toADdate(dtework);
				//item["dteendw"] = toADdate(dtework);
				item["dtestrtw_old"] = toADdate(dtework);
				//item["dteendw_old"] = toADdate(dtework);
				if(parseInt(time[0]) > parseInt(time[1])) {
					item["dteendw"] = getNextDate(dtework); 
					item["dteendw_old"] = getNextDate(dtework);
				} else {
					item["dteendw"] = toADdate(dtework);
					item["dteendw_old"] = toADdate(dtework);
				}
			} else {
				item["codshift"] = currShifttime;
				item["codshift_old"] = prevShifttime;
				var time1 = currRangetime.split(" - ");
				item["timstrtw"] = time1[0].replace(".","");
				item["timendw"] = time1[1].replace(".","");
				item["dtestrtw"] = toADdate(dtework); 
				if(parseInt(time1[0]) > parseInt(time1[1])) {
					item["dteendw"] = getNextDate(dtework); 
				} else item["dteendw"] = toADdate(dtework);
				var time2 = prevRangetime.split(" - ");
				item["timstrtw_old"] = time2[0].replace(".","");
				item["timendw_old"] = time2[1].replace(".","");
				item["dtestrtw_old"] = toADdate(dtework);
				if(parseInt(time2[0]) > parseInt(time2[1])) {
					item["dteendw_old"] = getNextDate(dtework);
				} else item["dteendw_old"] = toADdate(dtework);
				isAdd = true;
			}
		//}
		if(isAdd) {
			item["codempid"] = document.getElementById("txtPrevEmpId"+i).value; 
		    item["dtework"] = toADdate(dtework);
			data.push(item);
		}
	}
	if(data.length>0) {
	//alert("Have data update"); 
	jQuery.ajax({
			url : 'member-update-editshifttime',
			type : "Post",
			contentType : "application/json",
			data: JSON.stringify(data),
			dataType : 'json',
			success : function(obj) {
				HideWaiting();
				if(obj.success==1){
					//$("#btnCloseEditTime").click();
					ShowSuccessMsg('0003',obj.message);
					SetShifttimeObj();
				}else{
					ShowErrorMsg('00022',obj.message);
					}
			},
			error : function() {
				HideWaiting();
				ShowErrorConnectMessage();
			}
		});
	} else {
		HideWaiting();	
		ShowErrorMsg('0034',null);
	}
}

function RollBackHoliday(index) {
	var select = document.getElementById("selectHolidayMode"+index);
	var previous_value = document.getElementById("txtPrevHoliday"+index).value;
	//var mark = document.getElementById("chkMarkHoliday"+param[0]).checked;
	
	select.value = previous_value;
	if(select.value=="W") {
		select.style.backgroundColor = "white";
		select.style.color = "black";
	} else  {
		if(select.value=="H"){
			select.style.backgroundColor = "red";
			select.style.color = "white";
		}else{ // "T"
			select.style.backgroundColor = "#ffff00";
			select.style.color = "white";
		}
		
	}
	document.getElementById("chkHolidayChange"+index).checked = false;
}

function RollBackHoliday2() {
	var index = $('#txtDlgShiftTimePreviousIndex').val();
	var select = document.getElementById("selectHolidayMode"+index);
	var previous_value = document.getElementById("txtPrevHoliday"+index).value;
	//var mark = document.getElementById("chkMarkHoliday"+param[0]).checked;
	
	select.value = previous_value;
	if(select.value=="W") {
		select.style.backgroundColor = "white";
		select.style.color = "black";
	} else  {
		if(select.value=="H"){
			select.style.backgroundColor = "red";
			select.style.color = "white";
		}else{ // "T"
			select.style.backgroundColor = "#ffff00";
			select.style.color = "white";
		}
		
	}
	document.getElementById("chkHolidayChange"+index).checked = false;
}

function SaveEditHoliday(key) {
	var previous_date = $('#txtDlgShiftTimePreviousDate').val();
	var previous_index_val = $('#txtDlgShiftTimePreviousIndex').val();
	var current_date = $('#switchtodate').val();
	var reason = $('#txtSwitchReason').val();
	var missing = 0;
	var select_from = $("#switchtodate > option:contains("+previous_date+")").index(); 
	var select_to = $("#switchtodate > option:contains("+current_date+")").index(); 

	if(previous_date==current_date){
		missing++;
		key = 'D';
	}

	if(reason.length == 0) missing++;
	
	if(missing == 0 && key=='S') {
		var previous_date_int = parseInt(previous_date.substring(0,2));
		var current_date_int = parseInt(current_date.substring(0,2));
		var previous_index = parseInt(previous_index_val);
		var current_index = 0;
		var diff = 0;
		var start_date = $('#txtDlgShiftTimeStartDate').val();
		var end_date = $('#txtDlgShiftTimeEndDate').val();
		var rowNumber = $('#txtDlgRowNumber').val();
		
		if(select_to >= select_from) { //check by index
			diff = select_to - select_from;
			current_index = previous_index + diff;
		} else {
			diff = select_from - select_to;
			current_index = previous_index - diff;
		}
		var current_date = document.getElementById('txtPrevDtework'+current_index).value;
		if(isOlderThanSevenDays(current_date)) {
			ShowErrorMsg('0037',null);
			RollBackHoliday(previous_index);
		} else {
			var select_current = document.getElementById('selectHolidayMode'+current_index);
			var select_previous = document.getElementById('selectHolidayMode'+previous_index);
		
			if(select_current.value == "W" && document.getElementById("txtPrevHoliday"+current_index).value != "T") {
				select_previous.value = "W";
				select_current.value = "H";
				$('#dlgShiftTime').modal('hide');
			} else if(select_current.value == "T") {
				select_previous.value = "H";
				select_current.value = "T";
				RollBackHoliday(previous_index);
			} else if(select_current.value == "H") {
				select_previous.value = "H";
				select_current.value = "H";
				ShowErrorMsg('0038',null);
				RollBackHoliday(previous_index);
			}
		
			$("#txtRemark"+previous_index).val(reason);
			$("#txtRemark"+current_index).val(reason);
			document.getElementById("chkHolidayChange"+current_index).checked= "true";
			document.getElementById("chkMarkHoliday"+current_index).checked = true;
			if(select_previous.value == "W") document.getElementById("chkMarkHoliday"+previous_index).checked = false;
			var parameter = current_index+"|"+select_current.value+"|"+" "+"|"+current_date+"|"+start_date+"|"+end_date+"|"+0+"|"+rowNumber+"|"+""+"|"+"";
			changeHolidayMode(parameter);
			
			document.getElementById("selectHolidayMode"+previous_index).style.backgroundColor = "white";
			document.getElementById("selectHolidayMode"+previous_index).style.color = "black";
		}
		
		
		
	} else {
		RollBackHoliday(parseInt(previous_index_val));
		if(key == 'S') {
			HideWaiting();
  			ShowErrorMsg('0013',null);
		}else if(key == 'D'){
			HideWaiting();
  			ShowErrorMsg('0016',null);
		}
	}
	 
}

function changeHolidayMode(str) { 
	var param = str.split("|"); 
	var check = document.getElementById("chkHolidayChange"+param[0]);
	var select = document.getElementById("selectHolidayMode"+param[0]);
	var mark = document.getElementById("chkMarkHoliday"+param[0]).checked;
	var start_date = param[4].substring(0,2);
	var end_date = param[5].substring(0,2);
	var diffDays = parseInt(param[6])+1;
	var row_number = parseInt(param[7]);
	var dayoff = parseInt(param[8]); 
	var username = param[9];    
	var totalChangeHoliday = document.getElementById('totalChangeHoliday'+row_number);
	var number_of_weeks = document.getElementById('availableDateForHoliday').value;
	
	if(number_of_weeks==4){
		number_of_weeks = eval(number_of_weeks)+1;
	}else if(number_of_weeks==5){
		number_of_weeks = eval(number_of_weeks)+1;
	}
	
	var allow_change_holiday = (dayoff*number_of_weeks);
	
		if(mark && select.value=="W") {
		 	$('#txtDlgRowNumber').val(row_number);
			$('#txtDlgShiftTimeStartDate').val(param[4]);
        	$('#txtDlgShiftTimeEndDate').val(param[5]);
        	$('#txtSwitchReason').val('');
        	
			var start_month = param[4].substring(4,5);
			var end_month = param[5].substring(4,5);
			
			$('#switchtodate') .find('option').remove().end();
	         var select_date = document.getElementById('switchtodate');
	         var selected_date = param[3];
	         $('#txtDlgShiftTimePreviousDate').val(selected_date);
	         $('#txtDlgShiftTimePreviousIndex').val(param[0]);
	         for (var i = 0; i < diffDays; i++) {
	        	 var date_val = document.getElementById("txtTheadDate"+i).textContent;
	        	 var typeDay = document.getElementById("txtDay"+i).value;
	        	 var typeWork = document.getElementById("txtTypeWork"+i).value;
	             var opt = document.createElement('option');
	             opt.value = date_val; 		//+"data-icon='glyphicon glyphicon-star'";
	             opt.innerHTML = typeDay+" "+date_val;

	             
	             if(opt.value==selected_date){
	             	opt.selected =true;
	             }
	             select_date.appendChild(opt);
	             if(typeWork=="true"){ 
	            	select_date.options[i].className = "isHoliday";
	             }
	             
	         }
	         check.checked="true";
	         
	         
			$('#dlgShiftTime').modal({backdrop: 'static', keyboard: false})
			
	} else if(!mark && select.value=="H") {
		
		if(totalChangeHoliday.value>=allow_change_holiday){
			select.value = "W";
			ShowErrorMsg('0036',username);
		} else {
			totalChangeHoliday.value = totalChangeHoliday.value+1;  //edit here
			check.checked="true";
		}
		
// 		comment 19/04/2017
// 		if(totalChangeHoliday.value>=allow_change_holiday){
// 			select.value = "W";
// 			ShowErrorMsg('0036',username);
// 		} else {
// 			totalChangeHoliday.value = totalChangeHoliday.value+1;  //edit here
// 			check.checked="true";
// 		}
		
	} else {
		check.checked="true";
	}
	if(select.value=="W") {
		select.style.backgroundColor = "white";
		select.style.color = "black";
	} else {
		if(select.value=="H"){
			select.style.backgroundColor = "red";
			select.style.color = "white";
		}else{
			select.style.backgroundColor = "#ffff00";
			select.style.color = "white";
		}
	}
}

function changeShifttime(str) {
	var param = str.split("|");
	document.getElementById("chkShifttimeChange"+param[0]).checked = "true;";
	var select = document.getElementById("ddlOption"+param[0]);
	var label = document.getElementById("lblRangeShifttime"+param[0]);
	label.innerHTML = select.value;
}

function SetShifttimeObj() {
	try
	{
		var data = {}
		data["codempid"] = '';
		data["start_date"] = '';
		data["end_date"] = '';
		data["company_id"] = '';
		 jQuery.ajax({
			 	url : 'member-getlist-shifttime',
				type : "Post",
				contentType : "application/json",
				data: JSON.stringify(data),
				dataType : 'json',
				success : function(obj) {					
			         PreShiftTime(obj);
				},
				error : function() {
					HideWaiting();
					ShowErrorConnectMessage();
				}
			});
	 
	}catch(ex)
	{
		HideWaiting();
		ShowErrorMsg('0006',ex);
	}
}

function InitDropDown(){
	var company_id = document.getElementById('ddlCompany');
	var com_id  ='';
	if(company_id.selectedIndex >0){
		 SetDropDown();   
	}else{
		 SetDropDownDefault2(); //in this case
	}
}

function SetDropDown()
{
	try
	{
		var company_id = document.getElementById('ddlCompany');
		var com_id  ='';
		 if(company_id.selectedIndex >0){
    		 com_id =company_id.value;
    	 }
    	var data = {}
    	data["company"] = com_id;
    	
		 jQuery.ajax({
			 	url : 'util-getmemberfollower-shifttime',
				type : "Post",
				contentType : "application/json",
				data: JSON.stringify(data),
				dataType : 'json',
				success : function(obj) {
					$('#ddlUser') .find('option').remove().end();
			         var select = document.getElementById('ddlUser');
			         for (var i = 0; i < obj.length; i++) {
			             var opt = document.createElement('option');
			             opt.value = obj[i].ddl_value;
			             opt.innerHTML = obj[i].ddl_text;
// 			             if(i==1){
// 			             	opt.selected =true;
// 			             }
			             
			             select.appendChild(opt);
			         }
			         
			         //InitDropDownTimeCause();
				},
				error : function() {
					HideWaiting();
					ShowErrorConnectMessage();
				}
			});
	 
	}catch(ex)
	{
		HideWaiting();
		ShowErrorMsg('0006',ex);
	}
}

function PreShiftTime(obj) {
	InitEditShiftTime(obj);
}

function PreShiftTime2() {
	ShowWaiting();
	//var company_id = document.getElementById('ddlCompany');
	//var com_id  ='';
	// if(company_id.selectedIndex >0){		
	//	 SetShifttimeObj();
	// } else {
	//	 HideWaiting();
	// } 
		var start_date = $("#txtStartDate").val();
    	var end_date= $("#txtEndDate").val();
    	var res_start =start_date.split('/');
        var res_end =end_date.split('/');
    	var oneDay = 24*60*60*1000; // hours*minutes*seconds*milliseconds
    	var intfirstDate = parseInt(res_start[2]+(res_start[1]-1)+res_start[0]);
    	var intsecondDate = parseInt(res_end[2]+res_end[1]-1+res_end[0]);
     	var firstDate = new Date(res_start[2],res_start[1]-1,res_start[0]);
     	var secondDate = new Date(res_end[2],res_end[1]-1,res_end[0]);
     	var diffDays = Math.round(Math.abs((firstDate.getTime() - secondDate.getTime())/(oneDay)));
		if(intsecondDate < intfirstDate){
         	Clear();
         	HideWaiting();
         	ShowErrorMsg('0009',null);
        } else {
        	
        	if(diffDays>31){
        		Clear();
            	HideWaiting();
            	ShowErrorMsg('0010',null);
        	}else if(diffDays<28){
            	Clear();
            	HideWaiting();
            	ShowErrorMsg('0047',null);
            } else { 
            	SetShifttimeObj();
            }
        }
}

function ShowPopOver() {
	$('[data-toggle="popover"]').popover({});
}

function InitEditShiftTime(ddl_object) {
  try { 	 
   if(ddl_object == null) {
	   HideWaiting();
	   var str='<section class="text-center" style="width:100%;><div style="width:100%;" class="text-center">ไม่พบข้อมูล</div></section>';
		$('#divEditShiftTime').html(str);
   } else {
	var emp_id = document.getElementById('ddlUser');
	var start_date = $("#txtStartDate").val();
    var end_date= $("#txtEndDate").val();
    
    if(start_date !=null && start_date !='' ){
    	if(end_date !=null && end_date !=''){
    		
    		var res_start =start_date.split('/');
            var res_end =end_date.split('/');
            
            if (res_start[0].length == 1) {
            	res_start[0] = '0' + res_start[0];
            }
            if (res_start[1].length == 1) {
            	res_start[1] = '0' + res_start[1];
            }
            if (res_start[2] > 2500) {
            	res_start[2] = res_start[2] - 543;
            }
            start_date = res_start[2] + '-' + res_start[1] + '-' + res_start[0];
            
            if (res_end[0].length == 1) {
            	res_end[0] = '0' + res_end[0];
            }
            if (res_end[1].length == 1) {
            	res_end[1] = '0' + res_end[1];
            }
            if (res_end[2] > 2500) {
            	res_end[2] = res_end[2] - 543;
            }
            end_date = res_end[2] + '-' + res_end[1] + '-' + res_end[0];
           
            var start_date_db=res_start[0] + '/' + res_start[1] + '/' + res_start[2];
            var end_date_db=res_end[0] + '/' + res_end[1] + '/' + res_end[2];
            
            var intfirstDate = parseInt(res_start[2]+(res_start[1]-1)+res_start[0]);
        	var intsecondDate = parseInt(res_end[2]+res_end[1]-1+res_end[0]);
            if(intsecondDate < intfirstDate){
            	Clear();
            	HideWaiting();
            	ShowErrorMsg('0009',null);
            } else {
            	var oneDay = 24*60*60*1000; // hours*minutes*seconds*milliseconds
             	var firstDate = new Date(res_start[2],res_start[1]-1,res_start[0]);
             	var secondDate = new Date(res_end[2],res_end[1]-1,res_end[0]);
             	var diffDays = Math.round(Math.abs((firstDate.getTime() - secondDate.getTime())/(oneDay)));             	
            	if(diffDays>31){
            		Clear();
                	HideWaiting();
                	ShowErrorMsg('0010',null);
                }else if(diffDays<28){
                	Clear();
                	HideWaiting();
                	ShowErrorMsg('0047',null);
                } 
            	else { 
            		 var isEmptyUser = false;
                	 var em_id ='';
                	 if(emp_id.selectedIndex >0){
                		 em_id =emp_id.value;
                	 } 
               		 var company_id = document.getElementById('ddlCompany');
             		 var com_id  ='';
             		 if(company_id.selectedIndex >0){
             	   	 	 com_id =company_id.value;
             		 }else if(company_id!="select" && emp_id.selectedIndex > 0){
             			com_id =company_id.value;
             			if(emp_id.value!="ALL"){
                   		 	em_id =emp_id.value;
                   	 	}else{
                   	 		em_id ='';
                   	 	}
             		 
              		 }else {
              			 isEmptyUser = true;
              		 }
             		
             		var data = {}
            		data["codempid"] = em_id;
            		data["start_date"] = start_date_db;
            		data["end_date"] = end_date_db;
            		data["company_id"] = com_id;
            		if(isEmptyUser) {
            			var str='<section class="text-center" style="width:100%;><div style="width:100%;" class="text-center">ไม่พบข้อมูล</div></section>';
    					$('#divEditShiftTime').html(str);
    					 $('#divButton').html('');
    					 HideWaiting();
            		} else { 
            		jQuery.ajax({
            			url : 'member-getmember-shifttime',
            			type : "Post",
            			contentType : "application/json",
            			 data: JSON.stringify(data),
            			dataType : 'json', 
            			success : function(obj) {            				 
            				if(obj.length > 0) {
            					var nowDate = new Date();
            					var mask_time="'mask': '99.99'";
                				var mask_date="'mask': '99/99/9999'";
                				var str = '<section style="width:100%; border:0px;">';
                				str +='<div class="panel panel-default" style="border:0px; height=500px;">';
                				str += '<input type="number" id="availableDateForHoliday" style="display:none;">';
                				//str += '<table id="shifttimeTable" class="border-table-scroll" border="1" style="min-width:100%;max-width:270%;width:'+ ((diffDays)*10) +'%;table-layout: fixed;">';
                				str += '<table id="shifttimeTable" class="border-table-scroll" style="width:100%;max-width:270%;table-layout: fixed;" >';
                				var thead1 = '<thead><tr>';
                					thead1 += '<th rowspan="2" id="fixHeader1" class="text-center">ที่</th>';
                					thead1 += '<th rowspan="2" id="fixHeader2" class="text-center">พนักงาน</th>';
                				var thead2 = '<tr>';
                				var tbody = '<tbody onscroll="fixHeader()"><tr>';
                				var footer = '';
                				var count = 0;
                				var totalHoliday = 0;
                				var totalHoliday_list = [];
                				var mark_day_list = [];
                				var isWrite = true;
                				var column_count = 0;
                				var isNewRow = false;
                				var isShowName = false; 
                				var tempID = "";
                				
                				for (var i = 0; i < obj.length; i++) {                					
                					if(i==0){
                						tempID = obj[i].codempid;
                					}else if(tempID!=obj[i].codempid){ 
                						tempID = obj[i].codempid;
                						isShowName = false;
                					}else{
                						tempID = obj[i].codempid;
                					}
                					
                					 var data_list = {}
                					 data_list["row"] = i;
                					 data_list["codempid"] = obj[i].codempid;
                					 data_list["namempt"] = obj[i].namempt;
                					 
                					 var isHoliday = false;
                					 var isSpecialHoliday = false;
                					 var mark_day = '';
                					 if(obj[i].typework=="H" || obj[i].typework=="T") {
                						 isHoliday = true;
                						 if(obj[i].typework=="T" && (obj[i].holiday != null && obj[i].holiday !='' && obj[i].holiday !='null' ) > 0) {
                							 isSpecialHoliday = true;
                						 }
                					 } 
                				     var redBG = 'background-color: red; color:white;';
                				     var yellowBG = 'background-color: #ffff00; color:#000000;'
                				     var isSunday = false;
                				     var isMark = false;                				     
                				     var splDtework = obj[i].dtework.split("/");
            						 var splDend =  end_date_db.split("/");
            						 var splStart = start_date_db.split("/");
            						 var intDtework = parseInt(splDtework[1]+splDtework[0]);
            						 var intSplDend = parseInt(splDend[1]+splDend[0]);
            						 var intSplStart= parseInt(splStart[1]+splStart[0]);
                					 if(i==0 || (i<=(diffDays+1) && isWrite)) {
                						 if(obj[i].day_eng.indexOf('Sunday') > -1) {
                							isSunday = true;
                							mark_day_list.push(obj[i].dtework.substring(0,2));
                						 }                						            						 
                						 if( intDtework == intSplDend ) {
                							 isWrite = false;
                						 }
                						 thead1 += '<th class="text-center normal-column" style="'+((isSunday)? redBG : '')+'">'+obj[i].day+'</th>';
                						 thead2 += '<th class="text-center vertical-center normal-column"><span style="color:red; display: '+((isSpecialHoliday) ? 'inline':'none')+';">';
                						 thead2 += '<i class="glyphicon glyphicon-star" data-content="'+obj[i].holiday+'" data-toggle="popover" data-placement="left" style="cursor:pointer;" onclick="ShowPopOver()">';
                						 thead2 += '</i>&nbsp;&nbsp;</span><label id="txtTheadDate'+i+'">'+obj[i].dtework+'</label>';
                						 thead2 += '<input type="text" style="display:none;" id="txtDay'+i+'" value="'+obj[i].dayTH+'">'
                						 thead2 += '<input type="text" style="display:none;" id="txtTypeWork'+i+'" value="'+isSpecialHoliday+'">'
                						 thead2 += '</th>';
                						
                					 }
                					 
                					 if(intSplStart==intDtework|| isNewRow) {
                						 if(i>0) {
                							 totalHoliday_list.push(totalHoliday);
                						 }
                						 totalHoliday = 0;
                						 column_count = parseInt(start_date_db.substring(0,2));
                						 count++;
                						 tbody += '</tr>';
                						 tbody += '<tr style="padding:0px;">';
                						 tbody += '<td id="fixBody1" class="text-center">'+count+'</td>';
                						 tbody += '<td id="fixBody2" class="text-center">'+obj[i].codempid+'<br>'+obj[i].namempt+ '<br><span class="nampost">' + obj[i].nampost+'</span></td>';
                						 tbody += '<td><input type="number" id="totalChangeHoliday'+count+'" value="0" style="display:none;"></td>';
                						 isNewRow = false;
                						 isShowName = true;  
                					 }else if(isShowName==false){  
                						 if(i>0) totalHoliday_list.push(totalHoliday);
                						 totalHoliday = 0;
                						 column_count = parseInt(obj[i].dtework.substring(0,2));
                						 count++;
                						 tbody += '</tr>';
                						 tbody += '<tr style="padding:0px;">';
                						 tbody += '<td id="fixBody1" class="text-center">'+count+'</td>';
                						 tbody += '<td id="fixBody2" class="text-center">'+obj[i].codempid+'<br>'+obj[i].namempt+ '<br><span class="nampost">' + obj[i].nampost+'</span></td>';
                						 tbody += '<td><input type="number" id="totalChangeHoliday'+count+'" value="0" style="display:none;"></td>';
                						 isNewRow = false;
                						 isShowName = true;  
                						
                					 }
                					 
                					 var col = ((column_count<10)? "0":"")+column_count;   
                					 if(obj[i].dtework.substring(0,2) == col) {
                						 //nothing to do
                					 } else {
                						 var until_date = parseInt(obj[i].dtework);
                						 while(column_count<until_date) {  
                							 tbody += '<td class="normal-column text-center" style="vertical-align: middle;">ไม่พบข้อมูล</td>';
                							 column_count++;
                						 }
                					 }
                					 
                					 tbody += '<td class="normal-column" style="vertical-align: top;">';
                					 tbody += '<table class="table text-center" style="margin: 0px;">';
                					 tbody += '<tr><td style="border:0px;">';
                					 if(mark_day_list.indexOf(obj[i].dtework.substring(0,2))>-1) {
                						 mark_day = "seventh"; 
                					 }
                					 if(obj[i].typework=="H" || obj[i].typework=="T")  {
                						 if(obj[i].typework=="H") totalHoliday++; //collect holiday from the first time
                						 isMark = true;
                					 }
                					 var dayoff = obj[i].dayoff;  //dayoff per a week
//                 					 var isOld = isOlderThanSevenDays(obj[i].dtework);
                					 var isOld = false;
                					 if(obj[i].daywork>30){
                						 isOld = isOlderThanSevenDays(obj[i].dtework);
                					 }
                					 
                					 tbody += '<input type="text" id="txtPrevEmpId'+i+'" value="'+obj[i].codempid+'" style="display:none;"/>';
                					 tbody += '<input type="text" id="txtPrevDtework'+i+'" value="'+obj[i].dtework+'" style="display:none;"/>';
                					 tbody += '<input type="checkbox" id="chkHolidayChange'+i+'" style="display:none;"/>';
                					 tbody += '<input type="text" id="txtPrevHoliday'+i+'" value="'+obj[i].typework+'" style="display:none;"/>';
                					 tbody += '<input type="checkbox" id="chkMarkHoliday'+i+'" style="display:none;" '+((isMark)?'checked':'')+'/>';
                					 
                					 /* Holiday / WorkDay */
                					 tbody += '<select id="selectHolidayMode'+i+'" class="select2" style="text-align: center; text-align-last:center; width:100%;'+((isHoliday)?(isSpecialHoliday)? yellowBG: redBG : '')+'" onchange="changeHolidayMode(&quot;'+i+'|'+obj[i].typework+'|'+mark_day+'|'+obj[i].dtework+'|'+start_date_db+'|'+end_date_db+'|'+diffDays+'|'+count+'|'+dayoff+'|'+obj[i].namempt+'&quot;)"'+((isSpecialHoliday || isOld) ? 'disabled':'')+'>';
                					 tbody += '<option style="background-color:white; color:black;" value="W"'+((isHoliday) ? '':' selected')+'>ทำงาน</option>';
                					 tbody += '<option style="background-color:white; color:black;" value="'+((isSpecialHoliday) ? 'T':'H')+'"'+((isHoliday) ? ' selected':'')+'>วันหยุด</option>';
                					 tbody += '</select></td></tr>';
                					 
                					 /* timeShift */
                					 tbody += '<tr><td style="border:0px;text-align: center;">';
                					 tbody += '<input type="checkbox" id="chkShifttimeChange' +i+ '" style="display:none;"/>';
                					 tbody += '<input type="text" id="txtPrevShifttime'+i+'" value="'+obj[i].codshift+'" style="display:none;"/>';
//                 					 tbody += '<select id="ddlOption'+i+'" class="select2" style="width:100%; text-align: center; text-align-last:center;" onchange="changeShifttime(&quot;'+i+'|'+obj[i].codshift+'&quot;)"'+((isSpecialHoliday || isOld) ? 'disabled':'')+'>';
                					 tbody += '<select id="ddlOption'+i+'" class="select2" style="width:100%; text-align: center; text-align-last:center;" onchange="changeShifttime(&quot;'+i+'|'+obj[i].codshift+'&quot;)"'+((isOld) ? 'disabled':'')+'>';
                					 for(var j=0; j<ddl_object.length; j++) {
                						 tbody += '<option style="background-color:white;" value="'+ddl_object[j].timstrtw+' - '+ddl_object[j].timendw+'" '+((ddl_object[j].codshift==obj[i].codshift)?'selected':'')+'>';
                						 tbody += ddl_object[j].codshift+'</option>';
                					 }
                					 tbody += '</select>';
                					 tbody += '</td></tr>';
                					 
                					 /* timeStart-timeEnd */
                					 tbody += '<tr><td style="border:0px;font-size:13px;padding-left:0px;padding-right:0px;"><label class="custom-font-label-thin" id="lblRangeShifttime'+i+'">'+obj[i].timstrtw+' - ';
                					 tbody += obj[i].timendw+'</label></td></tr>';
                					 tbody += '<tr style="display:none;"><td><label id="lblPrevRangeShifttime'+i+'">'+obj[i].timstrtw+' - ';
                					 tbody += obj[i].timendw+'</label></td></tr>';
                					 if(obj[i].reqleavename.length > 1) {
                						 tbody += '<tr><td style="border:0px; padding-left:0px; padding-right:0px;"><label class="custom-font-label-thin" id="lblLeaveReq">'+obj[i].reqleavename.replace(" ","<br>")+'</label>';
                						 tbody += '</td></tr>';
                					 }
                					 tbody += '<tr style="display:none;"><td><input type="text" id="txtRemark'+i+'" style="display:none;"/></td></tr>'
                					 tbody += '</table>';
                				     tbody += '</td>';
                				     column_count++;
                					 
                					 
                					 if(i==(obj.length-1)) totalHoliday_list.push(totalHoliday);
                					 if(intDtework == intSplDend ) {
            							 isNewRow=true;
            						 }
                				} //for loop of object
                				
                				thead1 += '</tr>';
                				thead2 += '</tr></thead>';
                				tbody += '</tr></tbody>';
                				footer += '<button type="button" class="btn btn-info pull-right"';
                				footer += ' onclick="SaveEditShifttime('+ obj.length +');">บันทึก</button>';
                				
                				str += thead1 + thead2 + tbody +'</tabel></div>';
                				str += '</section>';
                				$('#divEditShiftTime').html(str);
                				$('#divButton').html(footer);
                				$('#availableDateForHoliday').val(mark_day_list.length);
                				for(var i=0; i<totalHoliday_list.length; i++) {
                					$('#totalChangeHoliday'+(i+1)).val(totalHoliday_list[i]);
                				}
                				               			
                				
            				} //if object's length more than 0
            				else {
            					var str='<section class="text-center" style="width:100%;><div style="width:100%;" class="text-center">ไม่พบข้อมูล</div></section>';
            					$('#divEditShiftTime').html(str);
            				} //else object's length is 0
            				HideWaiting();	
            			},
            			error : function() {
            				HideWaiting();
            				ShowErrorConnectMessage();
            			}
            		});
                  }//end else isEmptyUser
            	}
            }
    		
    	}else{
    		Clear();
    		HideWaiting();
    		ShowErrorMsg('0011',null);
    	}
    } else{
    	Clear();
    	HideWaiting();
    	ShowErrorMsg('0011',null);
    }
   }
  } catch(ex) {
	  HideWaiting();
		ShowErrorMsg('0006',ex);
  }
}
  

  
  function Clear() {
		  $('#divEditShiftTime').html(''); 
		  $('#divButton').html('');
  }
  
  
	

</script>

<div style="background-color: white;" class="testscoll">
	<input type="text" style="display: none;" id="txtMaxRow"> <input
		type="text" style="display: none;" id="txtEmpType">


	<div class="row">
		<div class="col-lg-12">
			<!-- general form elements -->
			<div class="box collapsed-box">
				<div class="box-header">

					<div style="min-height: 12px;"></div>
					<div class="box-tools pull-right">
						<span class="btn btn-box-tool" data-widget="collapse"><img
							src="resources/Images/dot.png" style="width: 20px; height: 20px;">
						</span>
					</div>
				</div>
				<!-- /.box-header -->
				<!-- form start -->
				<form class="form-horizontal"
					style="padding-left: 10px; padding-right: 10px;">
					<div class="box-body">
						<div class="row">
							<div class="col-md-12 col-sm-12 col-xs-12">
								<div class="form-group">
									<label for="ddlCompany" class="col-sm-2 control-label"><spring:message
											code="member.worktime.criteria.company" /></label>
									<div class="col-sm-6">
										<select id="ddlCompany" class="form-control select2"
											onchange="InitDropDown();" style="width: 100%;"
											data-placeholder="เลือกหน่วยงาน">
										</select>
									</div>
								</div>
							</div>
						</div>

						<div class="row">
							<div class="col-md-12 col-sm-12 col-xs-12">
								<div class="form-group">
									<label for="inputUser" id="lblChkUser"
										class="col-sm-2 control-label">
										<!-- input id="chkUser" type="checkbox" class="minimal" />&nbsp;-->
										<spring:message code="member.worktime.criteria.user" />
									</label>
									<div class="col-sm-6">
										<select id="ddlUser" class="select2" style="width: 100%;">
										</select>
									</div>

								</div>
							</div>
						</div>

						<div class="row">
							<div class="col-md-12 col-sm-12 col-xs-12">
								<div class="form-group">
									<label class="col-sm-2 control-label"><spring:message
											code="member.worktime.criteria.date" /></label>

									<div class="col-sm-10">
										<input type="text" id="txtStartDate"
											class="custom-text-horizon-rangdate2" maxlength="10"
											data-inputmask="'mask': '99/99/9999'" data-mask
											data-provide="datepicker">
										<!-- 		                   <input type="text" class="custom-text-horizon-rangdate2"  maxlength="10" id="txtStartDate" data-inputmask="'mask': '99/99/9999'" data-mask data-provide="datepicker" > -->
										<label class="control-label">-</label> <input type="text"
											class="custom-text-horizon-rangdate2" maxlength="10"
											id="txtEndDate" data-inputmask="'mask': '99/99/9999'"
											data-mask data-provide="datepicker">
									</div>

								</div>
							</div>
						</div>

						<div class="row">
							<div class="col-md-12 col-sm-12 col-xs-12">
								<div class="form-group">
									<label class="col-sm-2 control-label"></label>
									<div class="col-sm-6">
										<button type="button" class="btn btn-info pull-right"
											onclick="PreShiftTime2();">
											<span class="glyphicon glyphicon-search"></span>&nbsp;
											<spring:message code="member.history.criteria.search" />
										</button>
									</div>
								</div>
							</div>
						</div>
					</div>
					<!-- /.box-body -->

				</form>

			</div>
		</div>

	</div>

	<!-- section style="width:100%; overflow-x: scroll;" -->
	<div class="row">
		<div class="col-lg-12">
			<div id="divEditShiftTime"></div>
			<div class="box-footer" id="divButton"></div>
		</div>
		<!-- /section -->

	</div>
</div>
<!-- Modal -->
<div class="modal fade" id="dlgShiftTime" role="dialog">
	<div class="modal-dialog" style="border: 1px solid;">

		<!-- Modal content-->
		<div class="modal-content">
			<div class="modal-header"
				style="border-bottom: 1px solid; border-color: #c6beb7;">
				<!--           <button type="button" id="btnCloseShiftTime" class="close" data-dismiss="modal" onclick="SaveEditHoliday('C');">&times;</button> -->
				<button type="button" id="btnCloseShiftTime" class="close"
					data-dismiss="modal" onclick="RollBackHoliday2()">&times;</button>
				<div class="modal-title">
					<div class="col-sm-11 col-xs-11" style="margin-top: 5px;">
						<label>สลับวันหยุด</label>
					</div>
				</div>
			</div>

			<div class="modal-body" style="border: 0px; margin-top: 15px;">
				<input type="text" id="txtDlgShiftTimePreviousIndex"
					style="display: none;"> <input type="text"
					id="txtDlgShiftTimePreviousDate" style="display: none;"> <input
					type="text" id="txtDlgShiftTimeStartDate" style="display: none;">
				<input type="text" id="txtDlgShiftTimeEndDate"
					style="display: none;"> <input type="number"
					id="txtDlgRowNumber" style="display: none;">

				<div class="col-md-12 col-sm-12 col-xs-12">
					<div class="col-md-5 col-sm-5 col-xs-5 text-right"
						style="padding-top: 5px;">
						<label>ต้องการสลับวันหยุดกับวันที่ :</label>&nbsp;
					</div>
					<div class="col-md-4 col-sm-4 col-xs-4">
						<select class="form-control" id="switchtodate">
							<option>เลือกวันที่</option>
						</select>
					</div>
					<div class="col-md-3 col-sm-3 col-xs-3"></div>
				</div>

				<div class="col-md-12 col-sm-12 col-xs-12" style="height: 15px;">
				</div>

				<div class="col-md-12 col-sm-12 col-xs-12 ">
					<div class="col-md-5 col-sm-5 col-xs-5 text-right"
						style="padding-top: 5px;">
						<label>เหตุผล :</label>&nbsp;
					</div>
					<div class="col-md-7 col-sm-7 col-xs-7">
						<input class="form-control" id="txtSwitchReason" />
					</div>
				</div>
				<div class="col-md-12 col-sm-12 col-xs-12">
					<div style="height: 30px;"></div>

				</div>
			</div>
			<div class="modal-footer" style="border: 0px;">
				<button type="button" class="btn btn-info pull-left"
					style="display: none;" data-dismiss="modal">
					&nbsp;
					<spring:message code="center.cancel" />
				</button>
				<button type="button" class="btn btn-info pull-right"
					onclick="SaveEditHoliday('S');">
					&nbsp;
					<spring:message code="center.save" />
				</button>
			</div>

		</div>

	</div>
</div>