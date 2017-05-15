<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<style>
.tblAdmin {
	
}
</style>

<script>
	$(document).ready(
		function() {
			try{
	<!-- 			getDataAdmin();			 -->
	
				
			}catch(ex){
	
			}
	});

	function getDataAdmin(){
		try{
			
			jQuery.ajax({
				url : 'getDataAdmin',
				type : "Post",
				contentType : "application/json",
				data: JSON.stringify(data),
				dataType : 'json',
				success : function(obj) {
					
				},
				error : function() {
					HideWaiting();
					ShowErrorConnectMessage();
				}
			});
		
	     
			
		}catch(ex){
			HideWaiting();
			ShowErrorMsg('0006',ex);
		}
		
	}
</script>

<div id='initDataAdmin' style="background-color: white;">
	<div class="container">
		<div class="row">
			<div class="col-md-10 "></div>
			<div class="col-md-1 ">
				<button type="button" class="btn btn-primary">เพิ่ม</button>
			</div>
			<div class="col-md-1 ">
				<button type="button" class="btn btn-primary">ลบ</button>
			</div>
		</div>
		<table class="table table-bordered">
			<thead>
				<tr>
					<th>ลำดับ</th>
					<th>Admin</th>
					<th>หน่วยงานที่ดูแล</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>John</td>
					<td>Doe</td>
					<td>john@example.com</td>
				</tr>
			</tbody>
		</table>
	</div>
</div>
</body>
</html>
