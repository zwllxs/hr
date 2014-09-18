<form action="#"   id="rejectForm">
    <table class="p_table form-inline">
    <tbody>
    	<input type="hidden" name ="contractId" id="contractId" value=${contractId} />
        <tr>
			<td class="p_label" style="width:90px" >驳回理由：<span class="notnull">*</span></td>
            <td >  <textarea cols="90" rows="4" name="rejectDesc" id="rejectDesc" required=true/></td>
        </tr> 
    </tbody>
    </table>
</form>