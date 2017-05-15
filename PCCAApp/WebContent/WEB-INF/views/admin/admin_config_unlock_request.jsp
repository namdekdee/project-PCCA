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
	initDropDownMemberItem('codeEmp');
	dropdownAction('action');
	initDropDownWorkflow('wfID');
	initDropDownMenuItem('menuId');
}

var searchEmp = function(){
	var data = {};
	data.codempid = $('#codeEmp').val();	
	
	if($('#codeEmp').val() == ''){
		return;
	}
	$.ajax({
		url : 'member-getmemberprofile',
		type : "Post",
		contentType : "application/json",
		data: JSON.stringify(data),
		dataType : 'json',
		beforeSend:function(){
			ShowWaiting();
		},
		success : function(obj) {
			HideWaiting();
			
			if(obj.namempt == null || obj.namempt ==''){
				$('#lblpname').html("-");
			}else{
				$('#lblpname').html(obj.namempt);
			}
			if(obj.nampost == null || obj.nampost ==''){
				$('#lblnampost').html("-");
			}else{
				$('#lblnampost').html(obj.nampost);
			}
			if(obj.namcenttha == null || obj.namcenttha ==''){
				$('#lblsection').html("-");
			}else{
				$('#lblsection').html(obj.namcenttha);
			}
			if(obj.jobnamt == null || obj.jobnamt ==''){
				$('#lblpart').html("-");
			}else{
				$('#lblpart').html(obj.jobnamt);
			}
			
		},
		error : function() {
			HideWaiting();
			ShowErrorConnectMessage();
		}
	});
}

var searchReq = function(){
	try
	{
		var data = {};		
		$.ajax({
			url : 'admin-list-unlock-reqs',
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
				console.log('error:','searchReq()');
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
	 tbl +=' 			<th class="text-center">เลือก</th>';
	 tbl +=' 			<th class="text-center">ลำดับ</th>';
	 tbl +=' 			<th class="text-center">พนักงาน</th>';
	 tbl +=' 			<th class="text-center">ตำแหน่ง/หน่วยงาน</th>';
	 tbl +=' 			<th class="text-center">เมนู</th>';
	 tbl +=' 			<th class="text-center">ประเภทคำร้อง</th>';
	 tbl +=' 			<th class="text-center">Action</th>';
	 tbl +=' 			<th class="text-center">เวลาที่บันทึก</th>';
	 tbl +=' 		</tr>    			';
	 tbl +=' 	</thead>';
	 tbl +=' 	<tbody>';
	 tbl +=' 				{{body}}		';
	 tbl +=' 	</tbody>';
	 tbl +=' </table>';
	var tr = '';
	if(typeof obj !== 'undefined' && obj.length > 0 ){
		for(var i in obj){
			tr += '<tr>';
			tr += '<td class="text-center">'+'<input type="checkbox" name="chekreq" value="'+getVal(obj[i].unlockId)+'"/>'+'</td>';
			tr += '<td class="text-center">'+(parseInt(i)+1)+'</td>';
			tr += '<td>'+getVal(obj[i].empName)+'</td>';
			tr += '<td>'+getVal(obj[i].empPosName)+'</td>';
			tr += '<td>'+getVal(obj[i].menuName)+'</td>';
			tr += '<td>'+getVal(obj[i].wfName)+'</td>';
			tr += '<td class="text-center">'+getActionDes(obj[i].action)+'</td>';
			tr += '<td class="text-center">'+getVal(obj[i].update_date)+'</td>';						
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

var modalreqInit = function(id){
	
	var data = {};	
	data.unlockId = id;
	$.ajax({
		url : 'admin-get-unlock-reqs',
		type : "Post",
		contentType : "application/json",
		data: JSON.stringify(data),
		dataType : 'json',
		beforeSend:function(){
			ShowWaiting();
		},
		success : function(obj) {
			$('#unlockId').val(obj.unlockId).trigger("change");
			$('#unlockId').prop('disabled',true);
			HideWaiting();
			modalreq('01');			
		},
		error : function() {
			console.log('error:','searchReq()');
			HideWaiting();
			ShowErrorConnectMessage();
		}
	});
	
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

var initDropDownMemberItem = function(id){
	try{
		var data = {};		
		$.ajax({
			url : 'util-getalll-member',
			type : "Post",
			contentType : "application/json",
			data: JSON.stringify(data),
			dataType : 'json',
			beforeSend:function(){				
			},			
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
		$('#codeEmp').val('').trigger("change");
		$('#lblpname').text('');
		$('#lblnampost').text('');
		$('#lblsection').text('');
		$('#lblpart').text('');		
		
	}else if (typeof action != 'undefined' && action ==='01'){
		
	}
	$('#dlgReqSetting').modal({backdrop: 'static', keyboard: false})  ;
}


var validate = function(){
	if(null == $('#codeEmp').val() || '' == $('#codeEmp').val()){
		ShowErrorMsg('00022','กรุณาเลือกพนักงาน');
		return false;
	}
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
	data.codeEmp = $('#codeEmp').val();
	data.menuId = $('#menuId').val();
	data.action = $('#action').val();
	data.wfID = $('#wfID').val();
	
	$.ajax({
		url : 'admin-add-unlock-reqs',
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
		data.unlockId = $(obj).val();	
		arrdata.push(data);
	})
	if(arrdata.length <= 0){
		ShowErrorMsg('00022','กรุณาเลือกรายการที่ต้องการลบ');
	}else{
		$.ajax({
			url : 'admin-delete-unlock-reqs',
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
				<div class="box-body">
					<button type="button" class="btn btn-primary pull-right"
						id="btnDelete" onclick="deleteReq()">ลบ</button>
					<button type="button" class="btn btn-primary pull-right"
						id="btnAdd" style="margin-right: 10px" onclick="modalreq('00')">เพิ่ม</button>
				</div>
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
				<h4 class="modal-title">ปลดล็อคการบันทึกคำร้อง</h4>
			</div>

			<div class="modal-body">
				<form class="form-horizontal" id="frmHrisSetupReqt">

					<div class="form-group">
						<label for="codeMPID" class="col-sm-2 control-label">รหัสพนักงาน</label>
						<div class="col-sm-5">

							<select id="codeEmp" name="codeEmp" class="form-control select2"
								onchange="searchEmp()" style="width: 100%;">
								<option value="">เลือก</option>
							</select>

						</div>


					</div>
					<div class="form-group">
						<span class="col-sm-1 text-left"></span> <span id="lblpname"
							class="col-sm-5 text-left"></span> <span id="lblnampost"
							class="col-sm-5 text-left"></span>
					</div>
					<div class="form-group">
						<span class="col-sm-1 text-left"></span> <span id="lblsection"
							class="col-sm-5 text-left"></span> <span id="lblpart"
							class="col-sm-5 text-left"></span>
					</div>
					<div class="form-group">
						<hr />
					</div>
					<div class="form-group">
						<label for="menuId" class="col-sm-2 control-label">เมนู</label>
						<div class="col-sm-4">
							<select id="menuId" name="menuId" class="form-control"
								style="width: 100%;">
								<option value="">เลือก</option>
							</select>
						</div>

						<label for="reqtEnd" class="col-sm-2 control-label">Action</label>
						<div class="col-sm-4">
							<select id="action" name="action" class="form-control "
								style="width: 100%;">
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

