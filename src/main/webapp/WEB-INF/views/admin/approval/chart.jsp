<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>문서 확인</title>
    <style>
        .chart-container {
            position: relative;
            height: 400px; /* 차트 높이 설정 */
            width: 100%; /* 차트 너비 설정 */
        }
    </style>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>
    <div class="container mt-5">
        <h2>문서 확인</h2>
        <div class="form-group mb-3">
            <label for="dateRange">기간</label>
            <input type="date" id="startDate" class="form-control">
            <input type="date" id="endDate" class="form-control">
            <label for="departmentSelect">부서 선택</label>
            <select id="departmentSelect" class="form-control">
                <option value="0">전체</option>
                <option value="1">인사부</option>
                <option value="2">마케팅부</option>
                <option value="3">영업부</option>
                <option value="4">IT부</option>
                <option value="5">법무부</option>
                <option value="6">운영부</option>
                <option value="7">서비스부</option>
                <option value="8">R&D부</option>
                <option value="9">재무부</option>
            </select>
            <button class="btn btn-primary mt-2" id="searchButton">검색</button>
        </div>

        <ul class="nav nav-tabs mb-3" id="myTab" role="tablist">
            <li class="nav-item" role="presentation">
                <button class="nav-link active" id="table-tab" data-bs-toggle="tab" data-bs-target="#tableTab" type="button" role="tab" aria-controls="tableTab" aria-selected="true">게시형</button>
            </li>
            <li class="nav-item" role="presentation">
                <button class="nav-link" id="chart-tab" data-bs-toggle="tab" data-bs-target="#chartTab" type="button" role="tab" aria-controls="chartTab" aria-selected="false">차트형</button>
            </li>
        </ul>

        <div class="tab-content" id="myTabContent">
            <!-- 게시형 테이블 -->
            <div class="tab-pane fade show active h-100" id="tableTab" role="tabpanel" aria-labelledby="table-tab">
                <form action="/admin/approval/excelDown" method="post" id="downloadForm">
				    <input type="hidden" name="startDate" id="startDateHidden">
				    <input type="hidden" name="endDate" id="endDateHidden">
				    <input type="hidden" name="deptNo" id="deptNoHidden">
				    <button class="btn btn-secondary d-none" type="button" id="excelDownBtn">
				        <i class="bi bi-download me-1"></i>목록 다운로드
				    </button>
				</form>
                <table class="table table-bordered">
                    <thead>
                        <tr>
                            <th>날짜</th>
                            <th>진행</th>
                            <th>완료</th>
                            <th>반려</th>
                            <th>합계</th>
                        </tr>
                    </thead>
                    <tbody id="tableBody">
                        <!-- AJAX로 데이터가 동적으로 삽입될 부분 -->
                    </tbody>
                </table>
            </div>

            <!-- 차트형 -->
            <div class="tab-pane fade h-100 scrollbar" id="chartTab" role="tabpanel" aria-labelledby="chart-tab">
                <h4>차트형</h4>
                <div class="d-flex flex-row justify-content-between">
	                <div class="chart-container">
	                    <canvas id="statusChart"></canvas> <!-- 상태별 차트 -->
	                </div>
	                <div class="chart-container">
	                    <canvas id="formUsageChart"></canvas> <!-- 문서 유형 사용 차트 -->
	                </div>
                </div>
            </div>
        </div>
    </div>

</body>
<script>
        $(document).ready(function() {

            $('#searchButton').on('click', function() {
                var startDate = $('#startDate').val();
                var endDate = $('#endDate').val();
                var selectedDepartments = $('#departmentSelect').val();

                $.ajax({
                    type: "POST",
                    url: "/admin/approval/fetchApprovalStatistics",
                    data: {
                        startDate: startDate,
                        endDate: endDate,
                        deptNo: selectedDepartments
                    },
                    success: function(response) {
                        console.log(response.formUsage);
                        console.log(response.statusCounts);
                        
                        updateTable(response.statusCounts);
                        updateBarChart(response.statusCounts);
                        updatePieChart(response.formUsage);
                        
                        $('#excelDownBtn').removeClass('d-none');
                        $('#startDateHidden').val(startDate);
                        $('#endDateHidden').val(endDate);
                        $('#deptNoHidden').val(selectedDepartments);
                    },
                    error: function(error) {
                        console.error("통계오류:", error);
                    }
                });
            });
        });

        function updateTable(tableData) {
            let tableBody = $('#tableBody');
            tableBody.empty();
            tableData.forEach(function(row) {
            	var total = row.PROGRESS + row.REJECTED + row.COMPLETED; 
                tableBody.append(`
                    <tr>
                        <td>\${row.REG_DATE}</td>
                        <td>\${row.PROGRESS}</td>
                        <td>\${row.COMPLETED}</td>
                        <td>\${row.REJECTED}</td>
                        <td>\${total}</td>
                    </tr>
                `);
            });
        }

        function updatePieChart(formUsageData) {
            var ctxFormUsage = document.getElementById('formUsageChart').getContext('2d');

            if (window.formUsageChart && window.formUsageChart instanceof Chart) {
                window.formUsageChart.destroy();
            }

            // 동적으로 색상 생성
            const backgroundColors = formUsageData.map((_, index) => `hsla(\${index * (360 / formUsageData.length)}, 70%, 70%, 0.5)`);
            const borderColors = formUsageData.map((_, index) => `hsla(\${index * (360 / formUsageData.length)}, 70%, 50%, 1)`);

            window.formUsageChart = new Chart(ctxFormUsage, {
                type: 'pie',
                data: {
                    labels: formUsageData.map(item => item.formTitle),
                    datasets: [{
                        data: formUsageData.map(item => item.usageCount),
                        backgroundColor: backgroundColors,
                        borderColor: borderColors,
                        borderWidth: 1
                    }]
                }
            });
        }

        function updateBarChart(statusCountsData) {
            var ctxStatus = document.getElementById('statusChart').getContext('2d');

            // 기존 차트가 있다면 삭제
            if (window.statusChart && window.statusChart instanceof Chart) {
                window.statusChart.destroy();
            }

            // 일별 데이터 준비
            var labels = statusCountsData.map(function(row) {
                return row.REG_DATE;  // 날짜
            });

            var inProgressData = statusCountsData.map(function(row) {
                return row.PROGRESS;  // 진행중
            });

            var completedData = statusCountsData.map(function(row) {
                return row.COMPLETED;  // 완료
            });

            var rejectedData = statusCountsData.map(function(row) {
                return row.REJECTED;  // 반려
            });

            // 새로운 차트 생성
            window.statusChart = new Chart(ctxStatus, {
                type: 'bar',
                data: {
                    labels: labels,
                    datasets: [
                        {
                            label: '진행중',
                            data: inProgressData,
                            backgroundColor: 'rgba(75, 192, 192, 0.7)',
                            borderColor: 'rgba(75, 192, 192, 1)',
                            borderWidth: 1
                        },
                        {
                            label: '완료',
                            data: completedData,
                            backgroundColor: 'rgba(153, 102, 255, 0.7)',
                            borderColor: 'rgba(153, 102, 255, 1)',
                            borderWidth: 1
                        },
                        {
                            label: '반려',
                            data: rejectedData,
                            backgroundColor: 'rgba(255, 99, 132, 0.7)',
                            borderColor: 'rgba(255, 99, 132, 1)',
                            borderWidth: 1
                        }
                    ]
                },
                options: {
                    scales: {
                        x: {
                            stacked: true  // x축 스택 처리
                        },
                        y: {
                            stacked: true  // y축 스택 처리
                        }
                    },
                    responsive: true,
                    plugins: {
                        legend: {
                            position: 'top',
                        },
                        tooltip: {
                            callbacks: {
                                label: function(tooltipItem) {
                                    var label = tooltipItem.dataset.label || '';
                                    var value = tooltipItem.raw;
                                    return label + ': ' + value;
                                }
                            }
                        }
                    }
                }
            });
        }
        $("#excelDownBtn").on("click", function(){
        	
        	Swal.fire({
  			  title: "다운로드하시겠습니까?",
  			  icon: "info",
  			  showCancelButton: true,
  			  confirmButtonColor: "#3085d6",
  			  cancelButtonColor: "#d33",
  			  confirmButtonText: "네",
  			  cancelButtonText: "이전으로"
  			}).then((result) => {
  			  if (result.isConfirmed) {
  				$("#downloadForm").submit();
  			  }
  			});
    	});
    </script>
</html>
