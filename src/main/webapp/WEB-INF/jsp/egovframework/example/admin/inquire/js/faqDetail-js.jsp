<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>	

<!-- Javascript files -->

<!-- CKEditor JS -->
<script src="//cdn.ckeditor.com/4.7.1/full/ckeditor.js"></script>

<script>
	$(document).ready(function(){
		/* 메일 에디터 */

		CKEDITOR.replace('faq-update-editor', {removePlugins : 'elementspath'});

		/* 메일 에디터 끝 */
	})	
	
	$('#faq-update-btn').on('click', function(){
		$('.detail-page').css('display', 'none');
		$('.update-page').css('display', '');
	});
	
	$('#faq-list-btn').on('click', function(e){
			location.href="<c:url value='/admin/inquire/faq/main' />";
	});
	
	/* 공지 사항 상세 삭제 버튼 */
	
	$('#faq-delete-btn').on('click', function(e){
		var deleteList = [];
		deleteList.push('<c:out value="${faq.no}" />');
		
		if(!confirm('정말로 삭제하시겠습니까?'))										
			return ;
		
		$.ajax({
			type    : 'DELETE',
			url     : '<c:url value="/admin/inquire/faq/list" />',
			headers : {
				'Content-Type' : 'application/json',
				'X-HTTP-Method-Override' : 'DELETE'
			},
			data    : JSON.stringify(deleteList),
			dataType: 'text',
			success : function(result){
				if(result == 'SUCCESS'){
					alert("데이터가 삭제되었습니다.");
					
					location.href="<c:url value='/admin/inquire/faq/main' />"
				}
			},
			error   : function(xhr, status, response){
				
			}
		});
	});
	
	/* 공지 사항 상세 삭제 버튼 끝 */
	
	/* FAQ 수정 등록 */
	
	$('#faq-update-regist-btn').on('click', function(e){
		if(!confirm('정말로 수정하시겠습니까?'))
			return ;
		
		var faqVO = {
			no      : '${faq.no}',
			subject : $('#subject').val(),
			title   : $('#title').val(),
			content : CKEDITOR.instances['faq-update-editor'].getData()
		};
		
		$.ajax({
			type    : 'PUT',
			url     : '<c:url value="/admin/inquire/faq/list" />',
			headers : {
				'Content-Type' : 'application/json',
				'X-HTTP-Method-Override' : 'PUT'
			},
			data    : JSON.stringify(faqVO),
			dataType: 'text',
			success : function(result){
				if(result == 'SUCCESS'){
					alert('성공적으로 수정되었습니다.');
					
					location.href = "<c:url value='/admin/inquire/faq/main' />";
				}
			},
			error   : function(xhr, status, response){
				
			}
		}); 
	});
	
	/* FAQ 수정 등록 끝 */

</script>