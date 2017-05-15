<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<script>

var constant = {
		flgReqts : [
		            {id:1,des:"เปิด"},
		            {id:0,des:'ปิด'}
				   ],
		actions : [
		          {id:'R',des:'บันทึกคำร้อง'},
		          {id:'C',des:'ยกเลิกคำร้อง'}
					]
}

$( document ).ready(function(){	
	initdroupdown();	
	searchReq();
	$("#prevDay").keydown(function (e) {
        // Allow: backspace, delete, tab, escape, enter and .
        if ($.inArray(e.keyCode, [46, 8, 9, 27, 13, 110, 190]) !== -1 ||
             // Allow: Ctrl+A, Command+A
            (e.keyCode === 65 && (e.ctrlKey === true || e.metaKey === true)) || 
             // Allow: home, end, left, right, down, up
            (e.keyCode >= 35 && e.keyCode <= 40)) {
                 // let it happen, don't do anything
                 return;
        }
        // Ensure that it is a number and stop the keypress
        if ((e.shiftKey || (e.keyCode < 48 || e.keyCode > 57)) && (e.keyCode < 96 || e.keyCode > 105)) {
            e.preventDefault();
        }
    });
});

function getVal(obj){
	return typeof obj != 'undefined' && obj != null && obj != '' ? obj: '';
}

function getActionDes(object){	
	for (var i = 0; i < constant.actions.length; i++){
		if (constant.actions[i].id == object){
			return constant.actions[i].des;
		}
	}
}

function getflgReqtsDes(object){	
	for (var i = 0; i < constant.flgReqts.length; i++){
		if (constant.flgReqts[i].id == object){
			return constant.flgReqts[i].des;
		}
	}
}

var initdroupdown = function(){
	dropdownflg('flgReqt');
	dropdownAction('action');
	dropdownDate('reqtStart');
	dropdownDate('reqtEnd');
	initDropDownWorkflow('wfID');
	initDropDownMenuItem('menuId')
}

var searchReq = function(){
	try
	{
		var  data = {};
		 $.ajax({
			url : 'admin-list-setup-reqs',
			type : "Post",
			contentType : "application/json",
			data: JSON.stringify(data),
			dataType : 'json',
			beforeSend:function(){
				ShowWaiting();
			},
			success : function(obj) {
				HideWaiting();
				drawtable(obj)
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

var drawtable = function (obj){
	var tbl = '';
	tbl +=' <table id="tblListReq" class="table table-bordered table-striped">';
	tbl +=' 	<thead>';
	tbl +=' 		<tr>';
	tbl +=' 			<th rowspan="2" class="text-center">เลือก</th>';
	tbl +=' 			<th rowspan="2" class="text-center">ลำดับ</th>';
	tbl +=' 			<th rowspan="2" class="text-center">เมนู</th>';
	tbl +=' 			<th rowspan="2" class="text-center">ประเภทคำร้อง</th>';
	tbl +=' 			<th rowspan="2" class="text-center">บันทึกย้อนหลัง</th>';
	tbl +=' 			<th rowspan="2" class="text-center">Action</th>';
	tbl +=' 			<th colspan="3" class="text-center">บันทึกคำร้องในรอบเงินเดือน</th>';
	tbl +=' 		</tr>';
	tbl +=' 		<tr>';
	tbl +=' 			<th class="text-center">วันที่เริ่ม</th>';
	tbl +=' 			<th class="text-center">วันที่สิ้นสุด</th>';
	tbl +=' 			<th class="text-center">สถานะ</th>';
	tbl +=' 		</tr>';
	tbl +=' 	</thead>';
	tbl +=' 	<tbody>	';
	tbl +=' 			{{body}}';
	tbl +=' 	</tbody>';
	tbl +=' </table>';	
	
	var tr = '';
	if(typeof obj !== 'undefined' && obj.length > 0 ){
		for(var i in obj){
			tr += '<tr>';
			tr += '<td class="text-center">'+'<input type="checkbox" name="chekreq" value="'+getVal(obj[i].menuId)+'|'+getVal(obj[i].wfID)+'"/>'+'</td>';
			tr += '<td class="text-center">'+(parseInt(i)+1)+'</td>';
			tr += '<td>'+getVal(obj[i].menuName)+'</td>';
			tr += '<td>'+getVal(obj[i].wfName)+'</td>';
			tr += '<td class="text-center">'+getVal(obj[i].prevDay)+'</td>';
			tr += '<td class="text-center">'+getActionDes(obj[i].action)+'</td>';
			tr += '<td class="text-center">'+getVal(obj[i].reqtStart)+'</td>';
			tr += '<td class="text-center">'+getVal(obj[i].reqtEnd)+'</td>';
			tr += '<td class="text-center"> <a href="#" onclick="modalupdateReq(\''+getVal(obj[i].menuId)+'|'+getVal(obj[i].wfID)+'\')" >'+getflgReqtsDes(obj[i].flgReqt)+'</a></td>';			
			tr += '</tr>'
			
		}
	}	
	tbl = tbl.replace('{{body}}',tr);	
	$('#boxlist').html(tbl);
	
	$('#tblListReq').DataTable({
		"bSort": false,
		"searching": false,
		"bPaginate": true,
	    "bLengthChange": false,
	    "pageLength": 10,
	    "bFilter": true,
	    "bInfo": false,
		oLanguage:{			
		    "sProcessing":   "กำลังดำเนินการ...",
		    "sLengthMenu":   "แสดง _MENU_ แถว",
		    "sZeroRecords":  "ไม่พบข้อมูล",
		    "sInfo":         "แสดง _START_ ถึง _END_ จาก _TOTAL_ แถว",
		    "sInfoEmpty":    "แสดง 0 ถึง 0 จาก 0 แถว",
		    "sInfoFiltered": "(กรองข้อมูล _MAX_ ทุกแถว)",
		    "sInfoPostFix":  "",
		    "sSearch":       "ค้นหา: ",
		    "sUrl":          "",
		    "oPaginate": {
		        "sFirst":    "หน้าแรก",
		        "sPrevious": "ก่อนหน้า",
		        "sNext":     "ถัดไป",
		        "sLast":     "หน้าสุดท้าย"
		    }
		}
	});
	
}

var modalupdateReq = function(str){
	var data = {};
	var vals = str.split('|');
	data.menuId = vals[0];
	data.wfID = vals[1];	
	$.ajax({
		url : 'admin-get-config-request',
		type : "Post",
		contentType : "application/json",
		data: JSON.stringify(data),
		dataType : 'json',
		success : function(obj) {
			$('#menuId').val(obj.menuId).prop('disabled',true);
			$('#wfID').val(obj.wfID).prop('disabled',true);
			$('#action').val(obj.action);
			$('#prevDay').val(obj.prevDay);
			$('#reqtStart').val(obj.reqtStart).trigger("change");
			$('#reqtEnd').val(obj.reqtEnd).trigger("change");
			$('#flgReqt').val(obj.flgReqt);

		},
		error : function() {
			HideWaiting();
			ShowErrorConnectMessage();
		}
	});
	
	modalreq('01');
}

var dropdownflg = function(id){
	var select = document.getElementById(id);
	for(var i in constant.flgReqts){
		var opt = document.createElement('option');
		 opt.value = constant.flgReqts[i].id;
         opt.innerHTML =  constant.flgReqts[i].des;
         select.appendChild(opt);
	}
}
var dropdownAction = function(id){
	var select = document.getElementById(id);
	for(var i in constant.actions){
		var opt = document.createElement('option');
		 opt.value = constant.actions[i].id;
         opt.innerHTML =  constant.actions[i].des;
         select.appendChild(opt);
	}
}

var dropdownDate = function(id){
	var select = document.getElementById(id);	 
	for(var i=1;i<32;i++){
		 var opt = document.createElement('option');
         opt.value = i;
         opt.innerHTML = i;
         select.appendChild(opt);
	}
}

var initDropDownWorkflow = function(id){
	try{
		var data = {};
		$.ajax({
			url : 'util-workflow-service',
			type : "Post",
			contentType : "application/json",
			data: JSON.stringify(data),
			dataType : 'json',
			success : function(obj) {
				var select = document.getElementById(id);
				for(var i in obj){
					 var opt = document.createElement('option');
			         opt.value = obj[i].ddl_value;
			         opt.innerHTML = obj[i].ddl_text;
			         select.appendChild(opt);
				}
				
			},
			error : function() {
				HideWaiting();
				ShowErrorConnectMessage();
			}
		});
	}catch(ex){
		HideWaiting();
		ShowErrorConnectMessage();
	}
}

var initDropDownMenuItem = function(id){
	try{
		var data = {};
		data.comp1='001';
		$.ajax({
			url : 'util-menu-item',
			type : "Post",
			contentType : "application/json",
			data: JSON.stringify(data),
			dataType : 'json',
			success : function(obj) {
				var select = document.getElementById(id);
				for(var i in obj){
					 var opt = document.createElement('option');
			         opt.value = obj[i].ddl_value;
			         opt.innerHTML = obj[i].ddl_text;
			         select.appendChild(opt);
				}
				
			},
			error : function() {
				HideWaiting();
				ShowErrorConnectMessage();
			}
		});
	}catch(ex){
		HideWaiting();
		ShowErrorConnectMessage();
	}
}


var modalreq =function(action){

	if(typeof action != 'undefined' && action ==='00'){ 
		var form = 	$("#frmHrisSetupReqt").serializeArray();		
		for(var i in form){
			var obj = form[i];
			$('#'+obj.name).val('');			
		}
		$('#reqtStart').val("21").trigger("change");
		$('#reqtEnd').val("20").trigger("change");
		$('#menuId').prop('disabled',false);
		$('#wfID').prop('disabled',false);
	}else if (typeof action != 'undefined' && action ==='01'){
		
	}
	$('#dlgReqSetting').modal({backdrop: 'static', keyboard: false})  ;
}

var validate = function(){
	var form = 	$("#frmHrisSetupReqt").serializeArray();		
	for(var i in form){
		var obj = form[i];
		if(obj.value == ''){
			ShowErrorMsg('00022','กรุณากรอกข้อมูลให้ครบ');
			return false;
		}		
	}
	return true;
}

var submit = function(){
	if(validate())save();	
}

var save = function(){
	var data = {};
	data.menuId = $('#menuId').val();
	data.wfID = $('#wfID').val();
	data.action = $('#action').val();
	data.prevDay = $('#prevDay').val();
	data.reqtStart = $('#reqtStart').val();
	data.reqtEnd = $('#reqtEnd').val();
	data.flgReqt = $('#flgReqt').val();

	$.ajax({
		url : 'admin-add-reqs',
		type : "Post",
		contentType : "application/json",
		data: JSON.stringify(data),
		dataType : 'json',
		success : function(obj) {			
			if(obj.success==1){					
				ShowSuccessMsg('0003',obj.message);
				searchReq();
			}else{
				ShowErrorMsg('00022',obj.message);
			}
			$('#dlgReqSetting').modal('toggle');
		},
		error : function() {
			HideWaiting();
			ShowErrorConnectMessage();
		}
	});
	
}
var deleteReq = function(){
	var arrdata = [];
	$('input[name=chekreq]:checked').each(function(index,obj){
		var data = {};
		var vals = $(obj).val().split('|');
		data.menuId = vals[0];
		data.wfID = vals[1];		
		arrdata.push(data);
	})
	if(arrdata.length <= 0){
		ShowErrorMsg('00022','กรุณาเลือกรายการที่ต้องการลบ');
	}else{
		$.ajax({
			url : 'admin-delete-reqs',
			type : "Post",
			contentType : "application/json",
			data: JSON.stringify(arrdata),
			dataType : 'json',
			success : function(obj) {			
				if(obj.success==1){					
					ShowSuccessMsg('0003',obj.message);
					searchReq();
				}else{
					ShowErrorMsg('00022',obj.message);
				}				
			},
			error : function() {
				HideWaiting();
				ShowErrorConnectMessage();
			}
		});
	}
}

</script>

<div style="background-color: white;" class="testscoll">
	<div class="row">
		<div class="col-lg-12">
			<div class="box collapsed-box">
				<div class="box-header">
					<div style="min-height: 12px;"></div>
					<div class="box-tools pull-right">
						<span class="btn btn-box-tool" data-widget="collapse"><img
							src="resources/Images/dot.png" style="width: 20px; height: 20px;">
						</span>
					</div>
				</div>
				<!--  <div class="box-body">				 
				 	<button type="button" class="btn btn-primary pull-right" id="btnDelete" onclick="">ลบ</button>
      				<button type="button" class="btn btn-primary pull-right" id="btnAdd" style="margin-right: 10px">เพิ่ม</button>
				 </div>	-->
			</div>
		</div>
	</div>
	<div class="box-body" id="boxlist"></div>
	<div class="box-footer" id="divButton2">
		<button type="button" class="btn btn-primary pull-right"
			id="btnDelete" onclick="deleteReq()">ลบ</button>
		<button type="button" class="btn btn-primary pull-right" id="btnAdd"
			onclick="modalreq('00')" style="margin-right: 10px">เพิ่ม</button>
	</div>

</div>



<!-- modal-content -->

<div class="modal fade" id="dlgReqSetting" role="dialog">
	<div class="modal-dialog" style="width: 700px;">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title">ตั้งค่าการบันทึกคำร้อง</h4>
			</div>

			<div class="modal-body">
				<form class="form-horizontal" id="frmHrisSetupReqt">

					<div class="form-group">

						<label for="menuId" class="col-sm-2 control-label">เมนู</label>
						<div class="col-sm-4">
							<select id="menuId" name="menuId" class="form-control">
								<option value="">เลือก</option>
							</select>
						</div>


						<label for="action" class="col-sm-2 control-label">Action</label>
						<div class="col-sm-4">
							<select id="action" name="action" class="form-control">
								<option value="">เลือก</option>
							</select>
						</div>
					</div>


					<div class="form-group">
						<label for="wfID" class="col-sm-2 control-label">ประเภทคำร้อง</label>
						<div class="col-sm-4">
							<select id="wfID" name="wfID" class="form-control">
								<option value="">เลือก</option>
							</select>
						</div>

						<label for="prevDay" class="col-sm-2 control-label">บันทึกย้อนหลัง</label>
						<div class="col-sm-4">
							<input type="text" class="form-control" id="prevDay"
								name="prevDay">
						</div>
					</div>
					<div class="form-group">
						<label for="" class="col-sm-6 control-label">การบันทึกคำร้องในรอบเงินเดือน</label>
					</div>
					<div class="form-group">
						<label for="reqtStart" class="col-sm-2 control-label">วันที่เริ่ม</label>
						<div class="col-sm-4">
							<select id="reqtStart" name="reqtStart"
								class="form-control select2" style="width: 100%;">
								<option value="">เลือก</option>
							</select>
						</div>

						<label for="reqtEnd" class="col-sm-2 control-label">วันที่สิ้นสุด</label>
						<div class="col-sm-4">
							<select id="reqtEnd" name="reqtEnd" class="form-control select2"
								style="width: 100%;">
								<option value="">เลือก</option>
							</select>
						</div>
					</div>
					<div class="form-group">
						<label for="flgReqt" class="col-sm-2 control-label">สถานะ</label>
						<div class="col-sm-4">
							<select id="flgReqt" name="flgReqt" class="form-control">
								<option value="">เลือก</option>
							</select>
						</div>
					</div>
				</form>
			</div>

			<div class="modal-footer">
				<button type="button" class="btn btn-default pull-left"
					data-dismiss="modal">ปิด</button>
				<button type="button" class="btn btn-primary" onclick="submit()">บันทึก</button>
			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>
<!-- /.modal -->

