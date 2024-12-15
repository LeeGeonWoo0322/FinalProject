<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
        <script>
          var isFluid = JSON.parse(localStorage.getItem('isFluid'));
          if (isFluid) {
            var container = document.querySelector('[data-layout]');
            container.classList.remove('container');
            container.classList.add('container-fluid');
          }
        </script>
        <nav class="navbar navbar-light navbar-vertical navbar-expand-xl navbar-card">
          <script>
            var navbarStyle = localStorage.getItem("navbarStyle");
            if (navbarStyle && navbarStyle !== 'transparent') {
              document.querySelector('.navbar-vertical').classList.add(`navbar-${navbarStyle}`);
            }
          </script>
          <div class="d-flex align-items-center">
            <div class="toggle-icon-wrapper">

              <button class="btn navbar-toggler-humburger-icon navbar-vertical-toggle" data-bs-toggle="tooltip" data-bs-placement="left" title="Toggle Navigation"><span class="navbar-toggle-icon"><span class="toggle-line"></span></span></button>

            </div><a class="navbar-brand" href="/">
              <div class="d-flex align-items-center py-3"><img class="me-2" src="${pageContext.request.contextPath}/resources/design/public/assets/img/icons/spot-illustrations/IRIS3.png" alt="" width="40" /><span class="font-sans-serif text-primary">IRIS</span>
              </div>
            </a>
          </div>
          <div class="collapse navbar-collapse" id="navbarVerticalCollapse">
            <div class="navbar-vertical-content scrollbar d-flex align-items-center">
              <div>
	              <ul class="navbar-nav flex-column mb-3  fs-9" id="navbarVerticalNav">
	                <li class="nav-item px-1">
	
	                  <!-- parent pages--><a class="nav-link" href="/" role="button">
	                    <div class="d-flex align-items-center" style="height: 30px">
	                    	<span class="nav-link-icon text-center"><span data-feather="home" style="height: 20px; width: 20px;"></span></span><span class="nav-link-text ps-1">홈</span>
	                    </div>
	                  </a>
	                </li>
	                <div class="row navbar-vertical-label-wrapper my-2">
	                    <div class="col-auto navbar-vertical-label fs-10">업무관리</div>
	                    <div class="col ps-0">
	                      <hr class="mb-0 navbar-vertical-divider">
	                    </div>
                  	</div>
 	                <li class="nav-item px-1">
	
	                  <!-- parent pages--><a class="nav-link" href="/approval/approvalHome.do" role="button">
	                    <div class="d-flex align-items-center" style="height: 30px"><span class="nav-link-icon text-center" style="width: 20px;height: 30px;vertical-align: middle;"><i class="bi bi-clipboard" style="font-size: 20px"></i></span><span class="nav-link-text ps-1">전자결재</span>
	                    </div>
	                  </a>
	                </li>
	               	<li class="nav-item px-1">
	
	                  <!-- parent pages--><a class="nav-link" href="/project/projectHome"  role="button">
	                    <div class="d-flex align-items-center" style="height: 30px"><span class="nav-link-icon" style="height: 30px;width: 20px;vertical-align: middle;"><i class="bi bi-kanban" style="font-size: 20px"></i></span></span><span class="nav-link-text ps-1">프로젝트</span>
	                    </div>
	                  </a>
	                </li>
	                <li class="nav-item px-1">
	
	                  <!-- parent pages--><a class="nav-link" href="/todo/list" role="button">
	                    <div class="d-flex align-items-center" style="height: 30px"><span class="nav-link-icon" style="width: 20px;height: 30px"><i class="bi bi-check-square" style="font-size: 20px"></i></span><span class="nav-link-text ps-1">To Do List</span>
	                    </div>
	                  </a>
	                </li>	                	                                 	
	                <div class="row navbar-vertical-label-wrapper my-2">
	                    <div class="col-auto navbar-vertical-label fs-10">협업</div>
	                    <div class="col ps-0">
	                      <hr class="mb-0 navbar-vertical-divider">
	                    </div>
                  	</div>
	                <li class="nav-item px-1">
	
	                  <!-- parent pages--><a class="nav-link" href="/mail/mailbox/1" role="button">
	                    <div class="d-flex align-items-center" style="height: 30px"><span class="nav-link-icon" style="height: 20px;width: 20px"><span data-feather="mail" style="height: 20px; width: 20px;"></span></span><span class="nav-link-text ps-1">메일</span>
	                    </div>
	                  </a>
	                </li>
	                <li class="nav-item px-1">
	
	                  <!-- parent pages--><a class="nav-link" href="/chat/chatHome.do" role="button">
	                    <div class="d-flex align-items-center" style="height: 30px"><span class="nav-link-icon text-center" style="width: 20px;height: 30px;vertical-align:middle;"><i class="bi bi-chat" style="font-size: 20px;"></i></span><span class="nav-link-text ps-1">메신저</span>
	                    </div>
	                  </a>
	                </li>
	               	<li class="nav-item px-1">
	
	                  <!-- parent pages--><a class="nav-link" href="/ffChat/main" role="button">
	                    <div class="d-flex align-items-center" style="height: 30px"><span class="nav-link-icon" style="height: 30px;width: 20px;vertical-align: middle;"><i class="bi bi-camera-video" style="font-size: 20px"></i></span><span class="nav-link-text ps-1">화상대화</span>
	                    </div>
	                  </a>
	                </li>
	                <div class="row navbar-vertical-label-wrapper my-2">
	                    <div class="col-auto navbar-vertical-label fs-10">일정관리</div>
	                    <div class="col ps-0">
	                      <hr class="mb-0 navbar-vertical-divider">
	                    </div>
                  	</div>
	                <li class="nav-item px-1">
	
	                  <!-- parent pages--><a class="nav-link" href="/attend/main" role="button">
	                    <div class="d-flex align-items-center" style="height: 30px"><span class="nav-link-icon" style="height: 20px;width: 20px"><span data-feather="briefcase" style="height: 20px; width: 20px;"></span></span><span class="nav-link-text ps-1">근태관리</span>
	                    </div>
	                  </a>
	                </li>
	                <li class="nav-item px-1">
	
	                  <!-- parent pages--><a class="nav-link" href="/calendar/main" role="button">
	                    <div class="d-flex align-items-center" style="height: 30px">
	                    	<span class="nav-link-icon text-center" style="width: 20px;height: 20px">
	                    		<span class="far fa-calendar-alt" style="height: 20px;width: 20px"></span>
							</span><span class="nav-link-text ps-1">일정 관리</span>
	                    </div>
	                  </a>
	                </li>
	                <li class="nav-item px-1">
	
	                  <!-- parent pages--><a class="nav-link" href="/reservation/main" role="button">
	                    <div class="d-flex align-items-center" style="height: 30px"><span class="nav-link-icon" style="width: 20px;height: 20px"><span class="far fa-clock" style="height: 20px;width: 20px"></span></span><span class="nav-link-text ps-1">자원 예약</span>
	                    </div>
	                  </a>
	                </li>
	                <div class="row navbar-vertical-label-wrapper my-2">
	                    <div class="col-auto navbar-vertical-label fs-10">자료관리</div>
	                    <div class="col ps-0">
	                      <hr class="mb-0 navbar-vertical-divider">
	                    </div>
                  	</div>

	                <li class="nav-item px-1">
	
	                  <!-- parent pages--><a class="nav-link" href="/address/main" role="button">
	                    <div class="d-flex align-items-center" style="height: 30px"><span class="nav-link-icon" style="height: 20px;width: 20px"><span data-feather="users" style="height: 20px; width: 20px;"></span></span><span class="nav-link-text ps-1">주소록</span>
	                    </div>
	                  </a>
	                </li>
	                <li class="nav-item px-1">
	
	                  <!-- parent pages--><a class="nav-link" href="/drive/list" role="button">
	                    <div class="d-flex align-items-center" style="height: 30px">
	                    	<span class="nav-link-icon" style="width: 20px;height: 20px">
								<span class="far fa-folder" style="height: 20px;width: 20px"></span>
							</span><span class="nav-link-text ps-1">드라이브</span>
	                    </div>
	                  </a>
	                </li>
	                <div class="row navbar-vertical-label-wrapper my-2">
	                    <div class="col-auto navbar-vertical-label fs-10">소통</div>
	                    <div class="col ps-0">
	                      <hr class="mb-0 navbar-vertical-divider">
	                    </div>
                  	</div>
	                <li class="nav-item px-1">
	
	                  <!-- parent pages--><a class="nav-link" href="/board/boardList?boardType=전사게시판&postType=사내공지" role="button">
	                    <div class="d-flex align-items-center" style="height: 30px"><span class="nav-link-icon" style="width: 20px;height: 20px"><span class="far fa-list-alt" style="height: 20px; width: 20px"></span></span><span class="nav-link-text ps-1">커뮤니티</span>
	                    </div>
	                  </a>
	                </li>
	                <li class="nav-item px-1">
	
	                  <!-- parent pages--><a class="nav-link" href="/survey/main" role="button">
	                    <div class="d-flex align-items-center" style="height: 30px"><span class="nav-link-icon" style="width: 20px;height: 20px;line-height: 20px"><span class="material-icons text-secondary" style="width: 20px;height: 20px">how_to_vote</span></span><span class="nav-link-text ps-1">설문</span>
	                    </div>
	                  </a>
	                </li>

	              </ul>
              </div>
            </div>
          </div>
        </nav>