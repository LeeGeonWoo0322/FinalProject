<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<style>
.nav-menu{
	display: flex;
	justify-content: space-around;
	align-items: center;
	height: 30px;
}

.nav-menu a{
	font-size: 16px;
	text-decoration: none;
	position: relative;
	cursor: pointer;
	color: #748194;
}

.nav-menu a::after{
	content: "";
	position: absolute;
	bottom: -4px;
	left: 50%;
	transform: translateX(-50%);
	width: 0;
	height: 2px;
	background: black;
	transition: all .1s ease-out;
	color: black;
}

.nav-menu a.active::after{
	width: 100%
}

.nav-menu a.active{
	color: black;
}
</style>


<div class="d-flex flex-column bg-100 w-100 p-3" style="height: 100%">
	<div>
		<span>메뉴 관리 / 자원 예약</span>
		<h4>자원 관리</h4>
	</div>
	<div class="card w-100 p-3" style="flex: 1 0 auto;">
	    <div id="alertBox" style="position: absolute; top: 10px; left: 50%; transform: translateX(-50%); z-index: 1000;display: none;">
	           <div class="bg-dark text-light border rounded-3 p-2" id="alertDiv"></div>
	   	</div>
		<div class="d-flex flex-column border-bottom position-relative">
			<div class="d-flex align-items-end ms-2" style="width: 30%;height: 30px">
				<nav class="nav-menu align-bottom d-gap gap-3 w-100">
			        <a href="#" class="active" data-target="assetCategoryList">자산 카테고리 목록</a>
			        <a href="#" data-target="assetCategoryUseInfo">자산 카테고리 이용안내</a>
			        <a href="#" data-target="assetList">자산 목록</a>
				</nav>
			</div>
		</div>
		<div>
			<!-- 자산 카테고리 목록 -->
			<div class="optionContent d-flex flex-column p-3" style="flex: 1 0 auto;" id="assetCategoryList">
				<div class="d-flex flex-row">
					<button type="button" id="addAssetCategoryBtn" class="border border-300 rounded-3 bg-200 py-1 px-2 mb-2">
						<span class="fas fa-plus me-2 text-500"></span><span class="text-900">자산 카테고리 추가</span>
					</button>
				</div>
				<div id="tableExample2">
				  	<div class="table-responsive scrollbar" style="height: 500px">
					    <table class="table table-bordered border-300 fs-9 mb-0">
					    	<colgroup>
					    		<col width="65%">
					    		<col width="5%">
					    		<col width="10%">
					    		<col width="10%">
					    		<col width="10%">
					    	</colgroup>
							<thead class="bg-200">
								<tr>
									<th class="text-900 text-center py-2">자산 카테고리명</th>
									<th class="text-900 text-center py-2">보유수</th>
									<th class="text-900 text-center py-2">권한</th>
									<th class="text-900 text-center py-2">상태</th>
									<th class="text-900 text-center py-2">설정</th>
								</tr>
							</thead>
							<tbody class="assetCategoryList">
								<c:choose>
									<c:when test="${empty assetCategoryList }">
										<tr>
						            	    <td colspan="5" class="text-center p-5">자산 카테고리 목록이 없습니다.</td>
							            </tr>
									</c:when>
									<c:otherwise>
										<c:forEach items="${assetCategoryList}" var="assetCategory">
											<tr>
												<td class="align-middle py-1">${assetCategory.acName }</td>
												<td class="align-middle text-center py-1">${assetCategory.acAssetCnt }</td>
												<td class="align-middle text-center py-1">
													<c:choose>
														<c:when test="${assetCategory.acUseAuth != 0 }">
															일부만 허용
														</c:when>
														<c:otherwise>
															전체 허용
														</c:otherwise>
													</c:choose>
												</td>
												<td class="align-middle text-center py-1">
													<c:choose>
														<c:when test="${assetCategory.acUseStop == 'N' }">
															사용중
														</c:when>
														<c:otherwise>
															사용 중지
														</c:otherwise>
													</c:choose>
												</td>
												<td class="d-flex justify-content-center align-middle py-1" style="border-left: 0">
													<button type="button" class="assetCategoryOptionBtn border border-300 rounded-3 bg-200 py-1 px-2 m-0" data-no="${assetCategory.acNo }">
														<i class="bi bi-gear text-dark-emphasis fs-10 text-500 me-1"></i></span><span class="text-900">설정</span>
													</button>
												</td>
											</tr>										
										</c:forEach>
									</c:otherwise>
								</c:choose>
							</tbody>
					    </table>
				  	</div>
				</div>
			</div>
			
			<!-- 자산 카테고리 이용안내 -->
			<div class="optionContent d-flex flex-column p-3 d-none" style="flex: 1 0 auto;" id="assetCategoryUseInfo">
				<div>
					<div class="mb-3">
						<select class="form-select form-select-sm" id="selectAssetCategoryUseInfoNo" style="width: 300px">
							<c:choose>
								<c:when test="${empty assetCategoryList }">
									<option>자산 카테고리가 없습니다.</option>
								</c:when>
								<c:otherwise>
									<c:forEach items="${assetCategoryList }" var="assetCategory">
										<option value="${assetCategory.acNo }">${assetCategory.acName }</option>
									</c:forEach>
								</c:otherwise>
							</c:choose>
						</select>
					</div>
					<div>
						<h6 class="text-500">❋ 첫 페이지에 나오는 안내문을 작성할 수 있습니다.</h6>
					</div>
					<div>
						<textarea name="assetCategoryUseInfoContent" id="assetCategoryUseInfoContent" cols="50" rows="5" class="form-control"></textarea>
					</div>
					<div class="d-flex flex-row justify-content-center w-100 mt-6">
						<div><a class="btn btn-info d-flex align-items-center me-3" id="assetCategoryUseInfoSave">저장</a></div>
						<div><a class="cancleBtn btn btn-secondary d-flex align-items-center">취소</a></div>
					</div>
				</div>
			</div>
			<!-- 자산 목록 -->
			<div class="optionContent d-flex flex-column p-3 d-none" style="flex: 1 0 auto;" id="assetList">
				<div class="mb-3">
					<select class="form-select form-select-sm" id="selectAssetCategoryUseInfoNo2" style="width: 300px">
						<c:choose>
							<c:when test="${empty assetCategoryList }">
								<option>자산 카테고리가 없습니다.</option>
							</c:when>
							<c:otherwise>
								<c:forEach items="${assetCategoryList }" var="assetCategory">
									<option value="${assetCategory.acNo }">${assetCategory.acName }</option>
								</c:forEach>
							</c:otherwise>
						</c:choose>
					</select>
				</div>
				<div class="d-flex flex-row">
					<button type="button" id="addAssetBtn" class="border border-300 rounded-3 bg-200 py-1 px-2 mb-2">
						<span class="fas fa-plus me-2 text-500"></span><span class="text-900">자산 추가</span>
					</button>
				</div>
				<div id="tableExample2">
				  	<div class="table-responsive scrollbar" style="height: 472px">
					    <table class="table table-bordered border-300 fs-9 mb-0" id="updateAstTable">
					    	<colgroup>
					    		<col width="70%">
					    		<col width="10%">
					    		<col width="10%">
					    		<col width="10%">
					    	</colgroup>
							<thead class="bg-200">
								<tr>
									<th class="text-900 text-center py-2">자산명</th>
									<th class="text-900 text-center py-2">반복예약</th>
									<th class="text-900 text-center py-2">상태</th>
									<th class="text-900 text-center py-2">설정</th>
								</tr>
							</thead>
							<tbody class="assetList">
								<c:choose>
									<c:when test="${empty assetList }">
										<tr>
						            	    <td colspan="4" class="text-center p-5">자산 목록이 없습니다.</td>
							            </tr>
									</c:when>
									<c:otherwise>
										<c:forEach items="${assetList}" var="asset">
											<tr>
												<td class="align-middle py-1">${asset.astName }</td>
												<td class="align-middle text-center py-1">
													<c:choose>
														<c:when test="${asset.repYn != 'N' }">
															허용
														</c:when>
														<c:otherwise>
															허용하지 않음
														</c:otherwise>
													</c:choose>
												</td>
												<td class="align-middle text-center py-1">
													<c:choose>
														<c:when test="${asset.astUseStop == 'N' }">
															사용중
														</c:when>
														<c:otherwise>
															사용 중지
														</c:otherwise>
													</c:choose>
												</td>
												<td class="d-flex justify-content-center align-middle py-1" style="border-left: 0">
													<button type="button" class="assetOptionBtn border border-300 rounded-3 bg-200 py-1 px-2 m-0" data-no="${asset.astNo }">
														<i class="bi bi-gear text-dark-emphasis fs-10 text-500 me-1"></i></span><span class="text-900">설정</span>
													</button>
												</td>
											</tr>										
										</c:forEach>
									</c:otherwise>
								</c:choose>
							</tbody>
					    </table>
				  	</div>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- 자산 카테고리 추가 모달 -->
<div class="modal fade" id="addAssetCategoryModal" data-bs-keyboard="false" data-bs-backdrop="static" tabindex="-1" aria-labelledby="addAssetCategoryModalHead" aria-hidden="true">
  <div class="modal-dialog modal-lg mt-6" role="document">
    <div class="modal-content border-0" style="width: 600px">
      <div class="position-absolute top-0 end-0 mt-3 me-3 z-1"><button class="btn-close btn btn-sm d-flex flex-center transition-base border border-0" id="addAssetCategoryModalCloseBtn" data-bs-dismiss="modal" aria-label="Close"></button></div>
      <div class="modal-body p-0">
        <div class="rounded-top-3 bg-body-tertiary py-3 ps-4 pe-6">
          <h4 class="mb-1" style="height: 40px;line-height: 40px" id="addAssetCategoryModalHead">자산 카테고리 추가</h4>
        </div>
		<div class="p-3">
			<table>
				<colgroup>
					<col width="150px">
					<col>
				</colgroup>
				<tbody>
					<tr>
						<th>자산명</th>
						<td><input type="text" id="assetName" class="form-control form-control-sm"></td>
					</tr>
					<tr>
						<th class="mt-1">반복예약 허용</th>
						<td>
							<div class="form-check form-check-inline mt-3 mb-1"><input class="form-check-input" id="inlineRadio1" type="radio" name="repYn" value="N" checked /><label class="form-check-label" for="inlineRadio1">허용하지 않음</label></div>
							<div class="form-check form-check-inline mt-3 mb-1"><input class="form-check-input" id="inlineRadio2" type="radio" name="repYn" value="Y" /><label class="form-check-label" for="inlineRadio2">허용</label></div>
						</td>
					</tr>
					<tr>
						<th>사용 시간</th>
						<td class="d-flex flex-row my-2">
							<select name="selectStartTime" id="selectStartTime" class="form-select form-select-sm" style="width: 100px">
							    <c:forEach var="i" begin="0" end="23">
							    	<fmt:formatNumber var="valueStr" value="${i }" pattern="00"/>
							    	<option value="${valueStr }:00:00">${valueStr }:00</option>
							    </c:forEach>
						    </select>
						    <span class="pt-1">&nbsp;~&nbsp;</span>
							<select name="selectEndTime" id="selectEndTime" class="form-select form-select-sm" style="width: 100px">
							    <c:forEach var="i" begin="0" end="23">
							    	<fmt:formatNumber var="valueStr" value="${i }" pattern="00"/>
							    	<option value="${valueStr }:00:00">${valueStr }:00</option>
							    </c:forEach>
						    </select>						    
						</td>
					</tr>
					<tr>
						<th>사용 요일</th>
						<td>
							<div class="form-check form-check-inline mt-3 mb-1"><input class="form-check-input" id="inlineCheckbox1" type="checkbox" value="0" name="useWeek" /><label class="form-check-label" for="inlineCheckbox1">일</label></div>
							<div class="form-check form-check-inline mt-3 mb-1"><input class="form-check-input" id="inlineCheckbox2" type="checkbox" value="1" name="useWeek" /><label class="form-check-label" for="inlineCheckbox2">월</label></div>
							<div class="form-check form-check-inline mt-3 mb-1"><input class="form-check-input" id="inlineCheckbox3" type="checkbox" value="2" name="useWeek" /><label class="form-check-label" for="inlineCheckbox3">화</label></div>
							<div class="form-check form-check-inline mt-3 mb-1"><input class="form-check-input" id="inlineCheckbox4" type="checkbox" value="3" name="useWeek" /><label class="form-check-label" for="inlineCheckbox4">수</label></div>
							<div class="form-check form-check-inline mt-3 mb-1"><input class="form-check-input" id="inlineCheckbox5" type="checkbox" value="4" name="useWeek" /><label class="form-check-label" for="inlineCheckbox5">목</label></div>
							<div class="form-check form-check-inline mt-3 mb-1"><input class="form-check-input" id="inlineCheckbox6" type="checkbox" value="5" name="useWeek" /><label class="form-check-label" for="inlineCheckbox6">금</label></div>
							<div class="form-check form-check-inline mt-3 mb-1"><input class="form-check-input" id="inlineCheckbox7" type="checkbox" value="6" name="useWeek" /><label class="form-check-label" for="inlineCheckbox7">토</label></div>
						</td>
					</tr>
					<tr>
						<th class="align-top"><div class="mt-1">이용 권한</div></th>
						<td class="d-flex flex-column">
							<div>
								<div class="form-check form-check-inline mt-1 mb-1"><input class="form-check-input" id="acUseAuthYn" type="radio" name="acUseAuthYn" value="N" checked /><label class="form-check-label" for="inlineRadio1">허용하지 않음</label></div>
								<div class="form-check form-check-inline mt-1 mb-1"><input class="form-check-input" id="acUnuseAuthYn" type="radio" name="acUseAuthYn" value="Y" /><label class="form-check-label" for="inlineRadio2">허용</label></div>
							</div>
							<div class="d-flex flex-row align-items-center d-none" id="selectAcAuth">
								<span class="align-middle fs-10">열람 가능 직위</span>
								<select id="acUseAuth" class="form-select form-select-sm ms-2" style="width: 120px">
									<c:forEach items="${positionList }" var="position">
										<option value="${position.secNo }">${position.posName } 이상</option>
									</c:forEach>
							    </select>
							</div>
						</td>			
					</tr>
				</tbody>
			</table>
		</div>
		<div class="d-flex flex-row justify-content-end align-items-center my-2" style="height: 50px;margin-right: 40px">
			<div><a class="btn btn-info d-flex align-items-center px-2 py-0 me-3" id="addAssetCategoryConfirm"><div id="contirmText" style="height: 30px;line-height: 30px">저장</div></a></div>
			<div><a class="btn btn-falcon-default d-flex align-items-center px-2 py-0" id="addAssetCategoryCancle" data-bs-dismiss="modal" aria-label="Close"><div style="height: 30px;line-height: 30px">취소</div></a></div>
		</div>
      </div>
    </div>
  </div>
</div>
<!-- 자산 카테고리 수정 모달 -->
<div class="modal fade" id="updateAssetModal" data-bs-keyboard="false" data-bs-backdrop="static" tabindex="-1" aria-labelledby="updateAssetModalHead" aria-hidden="true">
  <div class="modal-dialog modal-lg mt-6" role="document">
    <div class="modal-content border-0" style="width: 600px">
      <div class="position-absolute top-0 end-0 mt-3 me-3 z-1"><button class="btn-close btn btn-sm d-flex flex-center transition-base border border-0" id="updateAssetModalCloseBtn" data-bs-dismiss="modal" aria-label="Close"></button></div>
      <div class="modal-body p-0">
        <div class="rounded-top-3 bg-body-tertiary py-3 ps-4 pe-6">
          <h4 class="mb-1" style="height: 40px;line-height: 40px" id="updateAssetModalHead">자산 카테고리 수정</h4>
          <div class="d-none" id="acNoDiv"></div>
        </div>
		<div class="p-3">
			<table>
				<colgroup>
					<col width="150px">
					<col>
				</colgroup>
				<tbody>
					<tr>
						<th>자산명</th>
						<td><input type="text" id="updateAssetName" class="form-control form-control-sm" autocomplete="off" spellcheck="false"></td>
					</tr>
					<tr>
						<th class="mt-1">반복예약 허용</th>
						<td>
							<div class="form-check form-check-inline mt-3 mb-1"><input class="form-check-input" id="updateAcRepYn1" type="radio" name="updateRepYn" value="N" /><label class="form-check-label" for="updateInlineRadio1">허용하지 않음</label></div>
							<div class="form-check form-check-inline mt-3 mb-1"><input class="form-check-input" id="updateAcRepYn2" type="radio" name="updateRepYn" value="Y" /><label class="form-check-label" for="updateInlineRadio2">허용</label></div>
						</td>
					</tr>
					<tr>
						<th>사용 시간</th>
						<td class="d-flex flex-row my-2">
							<select name="updateSelectStartTime" id="updateSelectStartTime" class="form-select form-select-sm" style="width: 100px">
							    <c:forEach var="i" begin="0" end="23">
							    	<fmt:formatNumber var="valueStr" value="${i }" pattern="00"/>
							    	<option value="${valueStr }:00:00">${valueStr }:00</option>
							    </c:forEach>
						    </select>
						    <span class="pt-1">&nbsp;~&nbsp;</span>
							<select name="updateSelectEndTime" id="updateSelectEndTime" class="form-select form-select-sm" style="width: 100px">
							    <c:forEach var="i" begin="0" end="23">
							    	<fmt:formatNumber var="valueStr" value="${i }" pattern="00"/>
							    	<option value="${valueStr }:00:00">${valueStr }:00</option>
							    </c:forEach>
						    </select>						    
						</td>
					</tr>
					<tr>
						<th>사용 요일</th>
						<td>
							<div class="form-check form-check-inline mt-3 mb-1"><input class="form-check-input" id="updateInlineCheckbox1" type="checkbox" value="0" name="updateUseWeek" /><label class="form-check-label" for="updateInlineCheckbox1">일</label></div>
							<div class="form-check form-check-inline mt-3 mb-1"><input class="form-check-input" id="updateInlineCheckbox2" type="checkbox" value="1" name="updateUseWeek" /><label class="form-check-label" for="updateInlineCheckbox2">월</label></div>
							<div class="form-check form-check-inline mt-3 mb-1"><input class="form-check-input" id="updateInlineCheckbox3" type="checkbox" value="2" name="updateUseWeek" /><label class="form-check-label" for="updateInlineCheckbox3">화</label></div>
							<div class="form-check form-check-inline mt-3 mb-1"><input class="form-check-input" id="updateInlineCheckbox4" type="checkbox" value="3" name="updateUseWeek" /><label class="form-check-label" for="updateInlineCheckbox4">수</label></div>
							<div class="form-check form-check-inline mt-3 mb-1"><input class="form-check-input" id="updateInlineCheckbox5" type="checkbox" value="4" name="updateUseWeek" /><label class="form-check-label" for="updateInlineCheckbox5">목</label></div>
							<div class="form-check form-check-inline mt-3 mb-1"><input class="form-check-input" id="updateInlineCheckbox6" type="checkbox" value="5" name="updateUseWeek" /><label class="form-check-label" for="updateInlineCheckbox6">금</label></div>
							<div class="form-check form-check-inline mt-3 mb-1"><input class="form-check-input" id="updateInlineCheckbox7" type="checkbox" value="6" name="updateUseWeek" /><label class="form-check-label" for="updateInlineCheckbox7">토</label></div>
						</td>
					</tr>
					<tr>
						<th class="align-top"><div class="mt-1">이용 권한</div></th>
						<td class="d-flex flex-column">
							<div>
								<div class="form-check form-check-inline mt-1 mb-1"><input class="form-check-input" id="updateAcUnuseAuthYn" type="radio" name="updateAcUseAuthYn" value="N" checked /><label class="form-check-label" for="updateAcUseAuthYn">허용하지 않음</label></div>
								<div class="form-check form-check-inline mt-1 mb-1"><input class="form-check-input" id="updateAcUseAuthYn" type="radio" name="updateAcUseAuthYn" value="Y" /><label class="form-check-label" for="updateAcUnuseAuthYn">허용</label></div>
							</div>
							<div class="d-flex flex-row align-items-center d-none" id="updateSelectAcAuth">
								<span class="align-middle fs-10">열람 가능 직위</span>
								<select id="updateAcUseAuth" class="form-select form-select-sm ms-2" style="width: 120px">
									<c:forEach items="${positionList }" var="position">
										<option value="${position.secNo }">${position.posName } 이상</option>
									</c:forEach>
							    </select>
							</div>
						</td>			
					</tr>
					<tr>
						<th>사용 중지</th>
						<td class="d-flex flex-row mt-3">
							<div class="form-check"><input class="form-check-input" id="updateAssetStop" type="checkbox" value="" /><label class="form-check-label" for="updateAssetStop">사용 중지</label></div>
							<div class="text-700 fs-10 pt-1 ms-2">자산의 사용을 중지합니다.</div>
						</td>
					</tr>
					<tr>
						<th>삭제</th>
						<td class="d-flex flex-row mt-3">
							<div class="form-check"><input class="form-check-input" id="updateAssetDelete" type="checkbox" value="" /><label class="form-check-label" for="updateAssetDelete">삭제</label></div>
							<div class="text-700 fs-10 pt-1 ms-2">자산에 대한 모든 데이터를 삭제합니다.</div>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		<div class="d-flex flex-row justify-content-end align-items-center my-2" style="height: 50px;margin-right: 40px">
			<div><a class="btn btn-info d-flex align-items-center px-2 py-0 me-3" id="updateAssetConfirm"><div style="height: 30px;line-height: 30px">저장</div></a></div>
			<div><a class="btn btn-falcon-default d-flex align-items-center px-2 py-0" id="updateAssetCancle" data-bs-dismiss="modal" aria-label="Close"><div style="height: 30px;line-height: 30px">취소</div></a></div>
		</div>
      </div>
    </div>
  </div>
</div>
<!-- 자산 추가 모달 -->
<div class="modal fade" id="addAstModal" data-bs-keyboard="false" data-bs-backdrop="static" tabindex="-1" aria-labelledby="addAstModalHead" aria-hidden="true">
  <div class="modal-dialog modal-lg mt-6" role="document">
    <div class="modal-content border-0" style="width: 600px">
      <div class="position-absolute top-0 end-0 mt-3 me-3 z-1"><button class="btn-close btn btn-sm d-flex flex-center transition-base border border-0" id="addAstModalCloseBtn" data-bs-dismiss="modal" aria-label="Close"></button></div>
      <div class="modal-body p-0">
        <div class="rounded-top-3 bg-body-tertiary py-3 ps-4 pe-6">
          <h4 class="mb-1" style="height: 40px;line-height: 40px" id="addAstModalHead">자산 추가</h4>
        </div>
		<div class="p-3">
			<table class="w-100">
				<colgroup>
					<col width="150px">
					<col>
				</colgroup>
				<tbody>
					<tr>
						<th>자산명</th>
						<td><input type="text" id="addAstName" class="form-control form-control-sm" style="width: 390px"></td>
					</tr>
					<tr id="astRepYnTr" class="d-none">
						<th class="mt-1">반복예약 허용</th>
						<td>
							<div class="form-check form-check-inline mt-3 mb-1"><input class="form-check-input" id="addAstRepYn1" type="radio" name="addAstRepYn" value="N" checked /><label class="form-check-label" for="addAstRepYn1">허용하지 않음</label></div>
							<div class="form-check form-check-inline mt-3 mb-1"><input class="form-check-input" id="addAstRepYn2" type="radio" name="addAstRepYn" value="Y" /><label class="form-check-label" for="addAstRepYn2">허용</label></div>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		<div class="d-flex flex-row justify-content-end align-items-center my-2" style="height: 50px;margin-right: 40px">
			<div><a class="btn btn-info d-flex align-items-center px-2 py-0 me-3" id="addAssetConfirm"><div style="height: 30px;line-height: 30px">저장</div></a></div>
			<div><a class="btn btn-falcon-default d-flex align-items-center px-2 py-0" id="addAssetCancle" data-bs-dismiss="modal" aria-label="Close"><div style="height: 30px;line-height: 30px">취소</div></a></div>
		</div>
      </div>
    </div>
  </div>
</div>
<!-- 자산 수정 모달 -->
<div class="modal fade" id="updateAstModal" data-bs-keyboard="false" data-bs-backdrop="static" tabindex="-1" aria-labelledby="updateAstModalHead" aria-hidden="true">
  <div class="modal-dialog modal-lg mt-6" role="document">
    <div class="modal-content border-0" style="width: 600px">
      <div class="position-absolute top-0 end-0 mt-3 me-3 z-1"><button class="btn-close btn btn-sm d-flex flex-center transition-base border border-0" id="updateAstModalCloseBtn" data-bs-dismiss="modal" aria-label="Close"></button></div>
      <div class="modal-body p-0">
        <div class="rounded-top-3 bg-body-tertiary py-3 ps-4 pe-6">
          <h4 class="mb-1" style="height: 40px;line-height: 40px" id="updateAstModalHead">자산 수정</h4>
	      <div class="d-none" id="astNoDiv"></div>
        </div>
		<div class="p-3">
			<table class="w-100">
				<colgroup>
					<col width="150px">
					<col>
				</colgroup>
				<tbody>
					<tr>
						<th>자산명</th>
						<td><input type="text" id="updateAstName" class="form-control form-control-sm" style="width: 390px"></td>
					</tr>
					<tr id="astRepYnTr" class="d-none">
						<th class="mt-1">반복예약 허용</th>
						<td>
							<div class="form-check form-check-inline mt-3 mb-1"><input class="form-check-input" id="updateAstRepYn1" type="radio" name="updateAstRepYn" value="N"/><label class="form-check-label" for="updateAstRepYn1">허용하지 않음</label></div>
							<div class="form-check form-check-inline mt-3 mb-1"><input class="form-check-input" id="updateAstRepYn2" type="radio" name="updateAstRepYn" value="Y" /><label class="form-check-label" for="updateAstRepYn2">허용</label></div>
						</td>
					</tr>
					<tr>
						<th>사용 중지</th>
						<td class="d-flex flex-row mt-3">
							<div class="form-check"><input class="form-check-input" id="updateAstStop" type="checkbox" value="" /><label class="form-check-label" for="updateAstStop">사용 중지</label></div>
							<div class="text-700 fs-10 pt-1 ms-2">자산의 사용을 중지합니다.</div>
						</td>
					</tr>
					<tr>
						<th>삭제</th>
						<td class="d-flex flex-row mt-3">
							<div class="form-check"><input class="form-check-input" id="updateAstDelete" type="checkbox" value="" /><label class="form-check-label" for="updateAstDelete">삭제</label></div>
							<div class="text-700 fs-10 pt-1 ms-2">자산에 대한 모든 데이터를 삭제합니다.</div>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		<div class="d-flex flex-row justify-content-end align-items-center my-2" style="height: 50px;margin-right: 40px">
			<div><a class="btn btn-info d-flex align-items-center px-2 py-0 me-3" id="updateAstConfirm"><div style="height: 30px;line-height: 30px">저장</div></a></div>
			<div><a class="btn btn-falcon-default d-flex align-items-center px-2 py-0" id="updateAstCancle" data-bs-dismiss="modal" aria-label="Close"><div style="height: 30px;line-height: 30px">취소</div></a></div>
		</div>
      </div>
    </div>
  </div>
</div>

<script type="text/javascript">



$(function () {
	
	CKEDITOR.replace("assetCategoryUseInfoContent",{
		height:350,
		filebrowserUploadUrl: "/admin/reservation/imageUpload.do"
	});
	
	if ('${assetCategoryListSize}' != '0') {
		CKEDITOR.instances.assetCategoryUseInfoContent.setData(`${assetCategoryList[0].acUseInfo}`);
	}
	
	$("#updateAstTable").on("click", ".assetOptionBtn", function () {
		let astNo = $(this).data("no");
		$("#astNoDiv").text(astNo);
		axios({
			url : "/admin/reservation/getAsset.do",
			method : "post", 
			data : {
				astNo : astNo,
			},
			headers : {
				"Content-Type" : "application/json; charset=utf-8"
			}
		}).then(function (response) {
			let res = response.data;
			console.log(res);
			$("#updateAstModal").modal("show");
		});	
	});
	
	$("#addAssetConfirm").on("click", function () {
		let acNo = $("#selectAssetCategoryUseInfoNo2").val();
		let addAstName = $("#addAstName").val();
		let astRepYn = $("input[name='addAstRepYn']:checked").val();
		axios({
			url : "/admin/reservation/addAsset.do",
			method : "post", 
			data : {
				acNo : acNo,
				astName : addAstName,
				repYn : astRepYn
			},
			headers : {
				"Content-Type" : "application/json; charset=utf-8"
			}
		}).then(function (response) {
			let res = response.data;
			$("#addAstModal").modal("hide");
			let newAssetHTML = "";
			newAssetHTML += `
									<tr>
										<td class="align-middle py-1">\${res.astName}</td>
										<td class="align-middle text-center py-1">
							`;
			if (res.repYn == 'Y') {
				newAssetHTML += `허용`;
			}else {
				newAssetHTML += `허용하지 않음`;
			}
			
			newAssetHTML += `</td>
								<td class="align-middle text-center py-1">
									사용중
								</td>
								<td class="d-flex justify-content-center align-middle py-1" style="border-left:0">
									<button type="button" class="assetOptionBtn border border-300 rounded-3 bg-200 py-1 px-2 m-0" data-no="\${res.astNo}">
										<i class="bi bi-gear text-dark-emphasis fs-10 text-500 me-1"></i></span><span class="text-900">설정</span>
									</button>
								</td>
							</tr>	
							`;
			if ($(".assetList").find("tr td").eq(0).text() == '자산 목록이 없습니다.') {
				$(".assetList").html(newAssetHTML);
			}else {
				$(".assetList").append(newAssetHTML);
			}
		});	
	});
	
	$("#selectAssetCategoryUseInfoNo2").on("change", function () {
		let acNo = $("#selectAssetCategoryUseInfoNo2").val();
		axios({
			url : "/admin/reservation/getAssetByAcNo.do",
			method : "post", 
			data : {
				acNo : acNo,
			},
			headers : {
				"Content-Type" : "application/json; charset=utf-8"
			}
		}).then(function (response) {
			let res = response.data;
			let assetListHTML = "";
			if (!res.length) {
				assetListHTML += `
									<tr>
					            	    <td colspan="4" class="text-center p-5">자산 목록이 없습니다.</td>
						            </tr>
				 				 `;
			}else {
				for (var i = 0; i < res.length; i++) {
					assetListHTML += `
									<tr>
										<td class="align-middle py-1">\${res[i].astName }</td>
										<td class="align-middle text-center py-1">
									`;
					if (res[i].repYn == 'N') {
						assetListHTML += `허용하지 않음`;
					}else {
						assetListHTML += `허용`;
					}				
					assetListHTML += `</td>
										<td class="align-middle text-center py-1">
									 `;
					if (res[i].astUseStop == 'N') {
						assetListHTML += `사용중`;
					}else {
						assetListHTML += `사용 중지`;
					}
					assetListHTML += `
									</td>
										<td class="d-flex justify-content-center align-middle py-1" style="border-left: 0">
											<button type="button" class="assetOptionBtn border border-300 rounded-3 bg-200 py-1 px-2 m-0" data-no="\${res[i].astNo }">
												<i class="bi bi-gear text-dark-emphasis fs-10 text-500 me-1"></i></span><span class="text-900">설정</span>
											</button>
										</td>
									</tr>	
									 `;
				}
			}
			$(".assetList").html(assetListHTML);
		});				
	});
	
	$("#addAssetBtn").on("click", function () {
		let acNo = $("#selectAssetCategoryUseInfoNo2").val();
		$("#addAstName").val("");
		$("input[name='addAstRepYn']").prop("checked", false);
		$("#addAstRepYn1").prop("checked", true);
		axios({
			url : "/admin/reservation/getAssetCategoryDetail.do",
			method : "post", 
			data : {
				acNo : acNo,
			},
			headers : {
				"Content-Type" : "application/json; charset=utf-8"
			}
		}).then(function (response) {
			let res = response.data;
			if (res.acRepYn == 'Y') {
				$("#astRepYnTr").removeClass("d-none");
			}else {
				$("#astRepYnTr").addClass("d-none");
			}
			$("#addAstModal").modal("show");
		});		
	});
	
	$("#selectAssetCategoryUseInfoNo").on("change", function () {
		let acNo = $("#selectAssetCategoryUseInfoNo").val();
		axios({
			url : "/admin/reservation/getAssetCategoryDetail.do",
			method : "post", 
			data : {
				acNo : acNo,
			},
			headers : {
				"Content-Type" : "application/json; charset=utf-8"
			}
		}).then(function (response) {
			let res = response.data;
			if (res.acUseInfo == null) {
				CKEDITOR.instances.assetCategoryUseInfoContent.setData("");
			}else {
				CKEDITOR.instances.assetCategoryUseInfoContent.setData(res.acUseInfo);
			}
		});
	});
	
	$("#assetCategoryUseInfoSave").on("click", function () {
		let acNo = $("#selectAssetCategoryUseInfoNo").val();
		let acUseInfo = CKEDITOR.instances.assetCategoryUseInfoContent.getData();
		
		axios({
			url : "/admin/reservation/udpateUseInfo.do",
			method : "post", 
			data : {
				acNo : acNo,
				acUseInfo : acUseInfo
			},
			headers : {
				"Content-Type" : "application/json; charset=utf-8"
			}
		}).then(function (response) {
			let res = response.data;
			CKEDITOR.instances.assetCategoryUseInfoContent.setData(acUseInfo);
			requiredAlert("저장되었습니다.", isAlertVisible);
		});
		
	});
	
    const links = $('.nav-menu a');
    const contents =$('.optionContent');
    let isAlertVisible = false;

    links.on("click", function (event) {
        event.preventDefault(); // 기본 링크 동작 방지

        // 현재 활성화된 링크에서 active 클래스 제거
        links.removeClass("active");

        // 클릭한 링크에 active 클래스 추가
        $(this).addClass("active");

        const targetId = $(this).data('target');

        // 모든 content div 숨김
        contents.addClass("d-none");

        // 클릭한 링크와 관련된 div 표시
        const targetContent = $("#" + targetId);
        if (targetContent.length) {
            targetContent.removeClass("d-none");
        }
    });
    
	$("#updateAssetConfirm").on("click", function () {
		let acNo = $("#acNoDiv").text();
		let assetName = $("#updateAssetName").val();
		let repYn = $("input[name='updateRepYn']:checked").val();
		let startTime = $("#updateSelectStartTime").val(); 
		let endTime = $("#updateSelectEndTime").val(); 
		
		// 선택된 요일을 배열로 가져옵니다.
		let useWeek = $("input[name='updateUseWeek']:checked").map(function() {
			return this.value;
		}).get(); 
		let useWeekStr = useWeek.join(",");

		let acUseAuth = null;
		if ($("input[name='updateAcUseAuthYn']:checked").val() === 'Y') {
			acUseAuth = $("#updateAcUseAuth").val();
		}else {
			acUseAuth = 0;
		}
		
		let assetStop = $("#updateAssetStop").is(":checked") ? "Y" : "N";
		let assetDelete = $("#updateAssetDelete").is(":checked") ? "Y" : "N"; 
		
		axios({
			url : "/admin/reservation/updateAssetCategory.do",
			method : "post",
			data : {
				acNo : acNo,
				acName : assetName,
				acRepYn : repYn,
				acUseStart : startTime,
				acUseEnd : endTime,
				acUseWeek : useWeekStr,
				acUseStop : assetStop,
				acDelYn : assetDelete,
				acUseAuth : acUseAuth
			},
			headers : {
				"Content-Type" : "application/json; charset=utf-8"
			}
		}).then(function (response) {
			let res = response.data;
			$("#addAssetCategoryModal").modal("hide");
			location.reload(true);
		}).catch(function (error) {
			console.error("Error occurred:", error);
			alert("서버와의 통신 중 오류가 발생했습니다.");
		});
	});
	
	$("#tableExample2").on("click", ".assetCategoryOptionBtn", function () {
		let acNo = $(this).data("no");
		$("#acNoDiv").text(acNo);
		$("#updateSelectAcAuth").addClass("d-none");
		axios({
			url : "/admin/reservation/getAssetCategoryDetail.do",
			method : "post",
			data : {acNo : acNo},
			headers : {
				"Content-Type" : "application/json; charset=utf-8"
			}
		}).then(function (response) {
			let res = response.data;
			$("#updateAssetName").val(res.acName);
			if (res.acRepYn == 'N') {
				$("#updateAcRepYn1").prop("checked", true);
			}else {
				$("#updateAcRepYn2").prop("checked", true);
			}
	        let startTime = res.acUseStart ? res.acUseStart.substring(0, 5) : '';
	        let endTime = res.acUseEnd ? res.acUseEnd.substring(0, 5) : '';
			$("#updateSelectStartTime").val(res.acUseStart);
			$("#updateSelectEndTime").val(res.acUseEnd);
			let acUseWeekArr = res.acUseWeek.split(",");
			for (var i = 0; i < acUseWeekArr.length; i++) {
				$("input[name='updateUseWeek']").eq(acUseWeekArr[i]).prop("checked", true);
			}
			if (res.acUseAuth == 0) {
				$("#updateAcUnuseAuthYn").prop("checked", true);
			}else {
				$("#updateAcUseAuthYn").prop("checked", true);
				$("#updateSelectAcAuth").removeClass("d-none");
				$("#updateAcUseAuth").val(res.acUseAuth);
			}
			if (res.acUseStop == 'Y') {
				$("#updateAssetStop").prop("checked", true);
			}
			$("#updateAssetModal").modal("show");
		});
	});
	
	$("#addAssetCategoryBtn").on("click", function () {
		$("#addAssetCategoryModal").modal("show");
	});
	
	$("input[name='acUseAuthYn']").on("change", function () {
		if ($("#acUnuseAuthYn").is(":checked")) {
			$("#selectAcAuth").removeClass("d-none");
		}else {
			$("#selectAcAuth").addClass("d-none");
		}
	});
	
	$("#addAssetCategoryConfirm").on("click", function () {
		let assetName = $("#assetName").val();
		let repYn = $("input[name='repYn']:checked").val();
		let startTime = $("#selectStartTime").val(); 
		let endTime = $("#selectEndTime").val(); 
		
		// 선택된 요일을 배열로 가져옵니다.
		let useWeek = $("input[name='useWeek']:checked").map(function() {
			return this.value;
		}).get(); 
		let useWeekStr = useWeek.join(",");

		let acUseAuth = null;
		if ($("input[name='acUseAuthYn']:checked").val() === 'Y') {
			acUseAuth = $("#acUseAuth").val();
		}
		
		let assetStop = $("#assetStop").is(":checked") ? "Y" : "N";
		let assetDelete = $("#assetDelete").is(":checked") ? "Y" : "N"; 
		
		axios({
			url : "/admin/reservation/addAssetCategory.do",
			method : "post",
			data : {
				acName : assetName,
				acRepYn : repYn,
				acUseStart : startTime,
				acUseEnd : endTime,
				acUseWeek : useWeekStr,
				acUseStop : assetStop,
				acDelYn : assetDelete,
				acUseAuth : acUseAuth
			},
			headers : {
				"Content-Type" : "application/json; charset=utf-8"
			}
		}).then(function (response) {
			let res = response.data;
			$("#addAssetCategoryModal").modal("hide");
			let newAssetCategoryHTML = "";
			newAssetCategoryHTML += `
									<tr>
										<td class="align-middle py-1">\${res.acName}</td>
										<td class="align-middle text-center py-1">0</td>
										<td class="align-middle text-center py-1">
									`
			if (acUseAuth == null) {
				newAssetCategoryHTML += `전체 허용`
			}else {
				newAssetCategoryHTML += `일부만 허용`
			}
				newAssetCategoryHTML += `
										</td>
										<td class="align-middle text-center py-1">
											사용중
										</td>
										<td class="d-flex justify-content-center align-middle py-1">
											<button type="button" class="assetCategoryOptionBtn border border-300 rounded-3 bg-200 py-1 px-2 m-0" data-no="\${res.acNo}">
												<i class="bi bi-gear text-dark-emphasis fs-10 text-500 me-1"></i></span><span class="text-900">설정</span>
											</button>
										</td>
									</tr>	
										`;
			if (!$(".assetCategoryList").find("tr").length) {
				$(".assetCategoryList").html(newAssetCategoryHTML);
			}else {
				$(".assetCategoryList").find("tr:last-child").append(newAssetCategoryHTML);
			}
		}).catch(function (error) {
			console.error("Error occurred:", error);
			alert("서버와의 통신 중 오류가 발생했습니다.");
		});
	});
	
	$(".cancleBtn").on("click", function () {
		location.reload(true);
	});
	
	function requiredAlert(comment, isAlertVisible) {
	    let alertBox = $('#alertBox');
	    $("#alertDiv").html(comment);
	    if (!isAlertVisible) { // 알림이 보이지 않을 때만 실행
	        isAlertVisible = true; // 알림을 표시 중임을 설정
	        alertBox.css('display', "block");
	        setTimeout(function() {
	            alertBox.css('display', "none");
	            isAlertVisible = false; // 알림이 사라진 후 플래그를 초기화
	        }, 2000);
	    }
	    return false;
	}

});

</script>
</html>