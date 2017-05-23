<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<script>
	function AddCaList() {

		//alert($(".form-group").length)

		var length = $("#formCompanyDiv").length,
		//create new id
		newId = "AmountCaDiv-" + length,
		//clone first element with new id
		clone = $("#AmountCaDiv").clone().attr("id", newId);
		//append clone on the end
		$("#addCompanyDiv").append(clone);
		//$("#addFromCaCompany").clone().appendTo("#addFromCaCompany");

		//get length of selections
		length = $("#formCompanyDiv").length,
		//create new id
		newId = "formCompanyDiv-" + length,
		//clone first element with new id
		clone = $("#formCompanyDiv").clone().attr("id", newId);
		clone.children('.form-control').attr('id', 'ddlCompany-' + length++);
		//append clone on the end
		$("#addCompanyDiv").append(clone);
		//get length of selections
	}
</script>
<div class="row" id="addCompanyDiv">
	<div class="form-group" id="formCompanyDiv">
		<label id="lblCaCompany" class="col-sm-3 control-label" required>
			<%-- 									<spring:message code="member.worktime.criteria.company" /> --%>
			เบิกจากบริษัท
		</label>
		<div class="col-sm-6">
			<select id="ddlCompany" class="form-control" style="width: 100%;"
				data-placeholder="เลือกบริษัท">
				<%-- 							<select id="ddlCompany" class="form-control select2" style="width: 100%;" --%>
				<!-- 							data-placeholder="เลือกบริษัท"> -->
				<option value="PTG">PTG พีทีจี เอ็นเนอยี</option>
				<option value="PTC">PTC พีทีซี</option>
				<option value="PUN">PUN กาแฟพันธุ์ไทย</option>
				<option value="PTGLG">PTGLG พีทีจี โลจิสติก</option>

			</select>
		</div>
	</div>
</div>

<div class="row" id="addAmountCaDiv">
	<div class="form-group" id="AmountCaDiv">
		<label id="lblCaAmount" class="col-sm-3 control-label">
			จำนวนเงิน </label>
		<div class="col-sm-2">
			<input type="text" id="inputCaAmount" class="form-control"
				placeholder="ระบุ...">
		</div>

	</div>
</div>

<div class="row">
	<div class="col-sm-3 col-sm-offset-5 control-label">
		<button type="button" style="width: 150px;"
			class="btn btn-primary center-block" id="btnAddCaList"
			onclick="AddCaList();">เพิ่มรายการ</button>
	</div>
</div>