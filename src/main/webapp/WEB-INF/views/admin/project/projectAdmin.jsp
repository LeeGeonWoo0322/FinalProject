<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>



				<div class="col-lg-5">
                  <div class="card">
                    <div class="card-header pb-0">
                      <div class="row flex-between-center">
                        <div class="col-auto">
                          <h6 class="mb-0">Report for this week</h6>
                        </div>
                        <div class="col-auto d-flex">
                          <div class="btn btn-sm d-flex align-items-center p-0 me-3 shadow-none" id="echart-bar-report-for-this-week-option-1">
	                          	<svg class="svg-inline--fa fa-circle fa-w-16 text-primary fs-11 me-1" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="circle" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512" data-fa-i2svg="">
		                          	<path fill="currentColor" d="M256 8C119 8 8 119 8 256s111 248 248 248 248-111 248-248S393 8 256 8z">
		                          	</path>
		                        </svg>
	                          	<span class="text">프로젝트 생성 </span>
                          </div>
                          <div class="btn btn-sm d-flex align-items-center p-0 me-3 shadow-none" id="echart-bar-report-for-this-week-option-2">
	                          	<svg class="svg-inline--fa fa-circle fa-w-16 text-primary fs-11 me-1" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="circle" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512" data-fa-i2svg="">
		                          	<path fill="currentColor" d="M256 8C119 8 8 119 8 256s111 248 248 248 248-111 248-248S393 8 256 8z">
		                          	</path>
		                        </svg>
	                          	<span class="text">프로젝트 완료 </span>
                          </div>
                        </div>
                      </div>
                    </div>
                    <div class="card-body py-0"><!-- Find the JS file for the following chart at: src/js/charts/echarts/report-for-this-week.js--><!-- If you are not using gulp based workflow, you can find the transpiled code at: public/assets/js/theme.js-->
                      <div class="echart-bar-report-for-this-week" data-echart-responsive="true" data-chart="{&quot;option1&quot;:&quot;echart-bar-report-for-this-week-option-1&quot;,&quot;option2&quot;:&quot;echart-bar-report-for-this-week-option-2&quot;}" _echarts_instance_="ec_1729441157264" style="user-select: none; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); position: relative;"><div style="position: relative; width: 551px; height: 283px; padding: 0px; margin: 0px; border-width: 0px; cursor: default;"><canvas data-zr-dom-id="zr_0" width="551" height="283" style="position: absolute; left: 0px; top: 0px; width: 551px; height: 283px; user-select: none; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); padding: 0px; margin: 0px; border-width: 0px;"></canvas></div><div class=""></div></div>
                    </div>
                  </div>
                </div>
                
                
                
                <div class="col-md-6 col-xxl-4" style="display:none;">
              <div class="card echart-session-by-browser-card h-100">
                <div class="card-header d-flex flex-between-center bg-body-tertiary py-2">
                  <h6 class="mb-0">Session By Browser</h6>
                  <div class="dropdown font-sans-serif btn-reveal-trigger"><button class="btn btn-link text-600 btn-sm dropdown-toggle dropdown-caret-none btn-reveal" type="button" id="dropdown-session-by-browser" data-bs-toggle="dropdown" data-boundary="viewport" aria-haspopup="true" aria-expanded="false"><svg class="svg-inline--fa fa-ellipsis-h fa-w-16 fs-11" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="ellipsis-h" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512" data-fa-i2svg=""><path fill="currentColor" d="M328 256c0 39.8-32.2 72-72 72s-72-32.2-72-72 32.2-72 72-72 72 32.2 72 72zm104-72c-39.8 0-72 32.2-72 72s32.2 72 72 72 72-32.2 72-72-32.2-72-72-72zm-352 0c-39.8 0-72 32.2-72 72s32.2 72 72 72 72-32.2 72-72-32.2-72-72-72z"></path></svg><!-- <span class="fas fa-ellipsis-h fs-11"></span> Font Awesome fontawesome.com --></button>
                    <div class="dropdown-menu dropdown-menu-end border py-2" aria-labelledby="dropdown-session-by-browser"><a class="dropdown-item" href="#!">View</a><a class="dropdown-item" href="#!">Export</a>
                      <div class="dropdown-divider"></div><a class="dropdown-item text-danger" href="#!">Remove</a>
                    </div>
                  </div>
                </div>
                <div class="card-body d-flex flex-column justify-content-between py-0">
                  <div class="my-auto py-5 py-md-0"><!-- Find the JS file for the following chart at: src/js/charts/echarts/session-by-browser.js--><!-- If you are not using gulp based workflow, you can find the transpiled code at: public/assets/js/theme.js-->
                    <div class="echart-session-by-browser h-100" data-echart-responsive="true" _echarts_instance_="ec_1729441214446" style="user-select: none; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); position: relative;"><div style="position: relative; width: 349px; height: 200px; padding: 0px; margin: 0px; border-width: 0px; cursor: default;"><canvas data-zr-dom-id="zr_0" width="349" height="200" style="position: absolute; left: 0px; top: 0px; width: 349px; height: 200px; user-select: none; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); padding: 0px; margin: 0px; border-width: 0px;"></canvas></div><div class="" style="position: absolute; display: block; border-style: solid; white-space: nowrap; z-index: 9999999; box-shadow: rgba(0, 0, 0, 0.2) 1px 2px 10px; background-color: rgb(249, 250, 253); border-width: 1px; border-radius: 4px; color: rgb(11, 23, 39); font: 14px / 21px &quot;Microsoft YaHei&quot;; padding: 7px 10px; top: 0px; left: 0px; transform: translate3d(24px, 86px, 0px); border-color: rgb(216, 226, 239); pointer-events: none; visibility: hidden; opacity: 0;"><strong>Safari:</strong> 20.6%</div></div>
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
                <div class="card-footer bg-body-tertiary py-2">
                  <div class="row flex-between-center g-0">
                    <div class="col-auto"><select class="form-select form-select-sm" data-target=".echart-session-by-browser">
                        <option value="week" selected="selected">Last 7 days</option>
                        <option value="month">Last month</option>
                        <option value="year">Last Year</option>
                      </select></div>
                    <div class="col-auto"><a class="btn btn-link btn-sm px-0 fw-medium" href="#!">Browser overview<svg class="svg-inline--fa fa-chevron-right fa-w-10 ms-1 fs-11" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="chevron-right" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 320 512" data-fa-i2svg=""><path fill="currentColor" d="M285.476 272.971L91.132 467.314c-9.373 9.373-24.569 9.373-33.941 0l-22.667-22.667c-9.357-9.357-9.375-24.522-.04-33.901L188.505 256 34.484 101.255c-9.335-9.379-9.317-24.544.04-33.901l22.667-22.667c9.373-9.373 24.569-9.373 33.941 0L285.475 239.03c9.373 9.372 9.373 24.568.001 33.941z"></path></svg><!-- <span class="fas fa-chevron-right ms-1 fs-11"></span> Font Awesome fontawesome.com --></a></div>
                  </div>
                </div>
              </div>
            </div>
            
<script type="text/javascript">
document.addEventListener("DOMContentLoaded", function() {
    var chartDom = document.querySelector('.echart-bar-report-for-this-week');
    var myChart = echarts.init(chartDom);
    var option = {
        title: {
            text: '주간 보고서'
        },
        tooltip: {},
        xAxis: {
            type: 'category',
            data: ['프로젝트 생성', '프로젝트 완료']
        },
        yAxis: {
            type: 'value'
        },
        series: [{
            name: '수량',
            type: 'bar',
            data: [5, 10] // 예시 데이터
        }]
    };
    myChart.setOption(option);
});
</script>