<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="d-flex flex-column bg-100 w-100 p-3" style="height: 100%">
	<div>
		<span>메뉴 관리 / 메일</span>
		<h4>메일 통계</h4>
	</div>
	<div class="card w-100 p-3" style="flex: 1 0 auto;">
		<div class="d-flex flex-column">
			<div class="d-flex flex-row justify-content-between">
				<h5>전체 메일</h5>
			</div>
			<div>
				<table>
					<colgroup>
						<col style="width: 100px">
						<col style="width: 250px">
					</colgroup>
					<tbody>
						<tr>
							<th>메뉴 선택</th>
							<td>
								<select id="dataType" style="width: 110px"> 
									<optgroup label="전체">
										<option value="total">전체</option>
									</optgroup>
									<optgroup label="전체 & 부서 비교">
										<c:forEach items="${deptList }" var="department">
											<option value="${department.deptNo }">${department.deptName }</option>
										</c:forEach>
									</optgroup>
								</select>
							</td>
						</tr>
						<tr>
							<th>기간</th>
							<td class="d-flex flex-row">
								<select id="dataPeriod" style="width: 110px">
									<option value="lastDayIso">최근 24시간</option>
									<option value="lastWeekIso">최근 일주일</option>
									<option value="lastMonthIso">최근 한달</option>
									<option value="lastYearIso">최근 1년</option>
								</select>
								<button class="btn btn-info ms-1 px-3 py-0" id="searchBtn">검색</button>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
			<div class="d-flex">
			</div>
			<!-- 표 그래프 -->
			<!-- 원차트 -->
			<div class="card-body d-flex flex-column justify-content-between py-0">
                  <div class="my-auto py-5 py-md-0"><!-- Find the JS file for the following chart at: src/js/charts/echarts/session-by-browser.js--><!-- If you are not using gulp based workflow, you can find the transpiled code at: public/assets/js/theme.js-->
                    <div class="echart-session-by-browser h-100" data-echart-responsive="true" _echarts_instance_="ec_1731248573904" style="user-select: none; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); position: relative;"><div style="position: relative; width: 349px; height: 200px; padding: 0px; margin: 0px; border-width: 0px; cursor: default;"><canvas data-zr-dom-id="zr_0" width="349" height="200" style="position: absolute; left: 0px; top: 0px; width: 349px; height: 200px; user-select: none; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); padding: 0px; margin: 0px; border-width: 0px;"></canvas></div><div class="" style="position: absolute; display: block; border-style: solid; white-space: nowrap; z-index: 9999999; box-shadow: rgba(0, 0, 0, 0.2) 1px 2px 10px; background-color: rgb(249, 250, 253); border-width: 1px; border-radius: 4px; color: rgb(11, 23, 39); font: 14px / 21px &quot;Microsoft YaHei&quot;; padding: 7px 10px; top: 0px; left: 0px; transform: translate3d(166px, -10px, 0px); border-color: rgb(216, 226, 239); pointer-events: none; visibility: hidden; opacity: 0;"><strong>Chrome:</strong> 50.3%</div></div>
                  </div>
                  <div class="border-top">
                    <table class="table table-sm mb-0">
                      <tbody>
                        <tr>
                          <td class="py-3">
                            <div class="d-flex align-items-center"><img src="../assets/img/icons/chrome-logo.png" alt="" width="16">
                              <h6 class="text-600 mb-0 ms-2">Chrome</h6>
                            </div>
                          </td>
                          <td class="py-3">
                            <div class="d-flex align-items-center"><svg class="svg-inline--fa fa-circle fa-w-16 fs-11 me-2 text-primary" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="circle" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512" data-fa-i2svg=""><path fill="currentColor" d="M256 8C119 8 8 119 8 256s111 248 248 248 248-111 248-248S393 8 256 8z"></path></svg><!-- <span class="fas fa-circle fs-11 me-2 text-primary"></span> Font Awesome fontawesome.com -->
                              <h6 class="fw-normal text-700 mb-0">50.3%</h6>
                            </div>
                          </td>
                          <td class="py-3">
                            <div class="d-flex align-items-center justify-content-end"><svg class="svg-inline--fa fa-caret-down fa-w-10 text-danger" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="caret-down" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 320 512" data-fa-i2svg=""><path fill="currentColor" d="M31.3 192h257.3c17.8 0 26.7 21.5 14.1 34.1L174.1 354.8c-7.8 7.8-20.5 7.8-28.3 0L17.2 226.1C4.6 213.5 13.5 192 31.3 192z"></path></svg><!-- <span class="fas fa-caret-down text-danger"></span> Font Awesome fontawesome.com -->
                              <h6 class="fs-11 mb-0 ms-2 text-700">2.9%</h6>
                            </div>
                          </td>
                        </tr>
                        <tr>
                          <td class="py-3">
                            <div class="d-flex align-items-center"><img src="../assets/img/icons/safari-logo.png" alt="" width="16">
                              <h6 class="text-600 mb-0 ms-2">Safari</h6>
                            </div>
                          </td>
                          <td class="py-3">
                            <div class="d-flex align-items-center"><svg class="svg-inline--fa fa-circle fa-w-16 fs-11 me-2 text-success" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="circle" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512" data-fa-i2svg=""><path fill="currentColor" d="M256 8C119 8 8 119 8 256s111 248 248 248 248-111 248-248S393 8 256 8z"></path></svg><!-- <span class="fas fa-circle fs-11 me-2 text-success"></span> Font Awesome fontawesome.com -->
                              <h6 class="fw-normal text-700 mb-0">30.1%</h6>
                            </div>
                          </td>
                          <td class="py-3">
                            <div class="d-flex align-items-center justify-content-end"><svg class="svg-inline--fa fa-caret-up fa-w-10 text-success" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="caret-up" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 320 512" data-fa-i2svg=""><path fill="currentColor" d="M288.662 352H31.338c-17.818 0-26.741-21.543-14.142-34.142l128.662-128.662c7.81-7.81 20.474-7.81 28.284 0l128.662 128.662c12.6 12.599 3.676 34.142-14.142 34.142z"></path></svg><!-- <span class="fas fa-caret-up text-success"></span> Font Awesome fontawesome.com -->
                              <h6 class="fs-11 mb-0 ms-2 text-700">29.4%</h6>
                            </div>
                          </td>
                        </tr>
                        <tr>
                          <td class="py-3">
                            <div class="d-flex align-items-center"><img src="../assets/img/icons/firefox-logo.png" alt="" width="16">
                              <h6 class="text-600 mb-0 ms-2">Mozilla</h6>
                            </div>
                          </td>
                          <td class="py-3">
                            <div class="d-flex align-items-center"><svg class="svg-inline--fa fa-circle fa-w-16 fs-11 me-2 text-info" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="circle" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512" data-fa-i2svg=""><path fill="currentColor" d="M256 8C119 8 8 119 8 256s111 248 248 248 248-111 248-248S393 8 256 8z"></path></svg><!-- <span class="fas fa-circle fs-11 me-2 text-info"></span> Font Awesome fontawesome.com -->
                              <h6 class="fw-normal text-700 mb-0">20.6%</h6>
                            </div>
                          </td>
                          <td class="py-3">
                            <div class="d-flex align-items-center justify-content-end"><svg class="svg-inline--fa fa-caret-up fa-w-10 text-success" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="caret-up" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 320 512" data-fa-i2svg=""><path fill="currentColor" d="M288.662 352H31.338c-17.818 0-26.741-21.543-14.142-34.142l128.662-128.662c7.81-7.81 20.474-7.81 28.284 0l128.662 128.662c12.6 12.599 3.676 34.142-14.142 34.142z"></path></svg><!-- <span class="fas fa-caret-up text-success"></span> Font Awesome fontawesome.com -->
                              <h6 class="fs-11 mb-0 ms-2 text-700">220.7%</h6>
                            </div>
                          </td>
                        </tr>
                      </tbody>
                    </table>
                  </div>
                </div>
		</div>
		<div class="d-flex flex-row mb-2 mt-4">
			<div>
				<select id="dataDownloadType">
					<option value="CSV">CSV</option>
					<option value="EXCEL">EXCEL</option>
				</select>
			</div>
			<button class="btn btn-info py-0 px-2 ms-1" id="dataDownloadBtn">저장</button>
		</div>
		<div id="tableExample2" data-list='{"page":5,"pagination":true}'>
			<div class="table-responsive scrollbar" style="height: 200px">
				<table class="table table-bordered border-500 fs-9 mb-0">
					<colgroup>
						<col width="8%">
						<col width="8%">
						<col width="8%">
						<col width="8%">
						<col width="8%">
						<col width="8%">
						<col width="8%">
						<col width="8%">
						<col width="8%">
						<col width="8%">
						<col width="8%">
						<col width="8%">
					</colgroup>
					<thead class="bg-200" id="dataTableThead">
						<tr>
							<th colspan="2" class="py-1 text-center">날짜</th>
							<th colspan="4" class="text-center py-1">정상메일</th>
							<th colspan="4" class="text-center py-1">스팸메일</th>
							<th colspan="2" class="py-1 text-center">합계</th>
						</tr>
					</thead>
					<tbody class="list" id="dataTableTbody">
						<tr>
							<td colspan="2"></td>
							<td colspan="4"></td>
							<td colspan="4"></td>
							<td colspan="2"></td>
						</tr>
					</tbody>	
				</table>
			</div>
		    <div class="d-flex justify-content-center mt-3"><button class="btn btn-sm btn-falcon-default me-1" type="button" title="Previous" data-list-pagination="prev"><span class="fas fa-chevron-left"></span></button>
		    	<ul class="pagination mb-0"></ul><button class="btn btn-sm btn-falcon-default ms-1" type="button" title="Next" data-list-pagination="next"><span class="fas fa-chevron-right"></span></button>
		    </div>
		</div>
	</div>
</div>