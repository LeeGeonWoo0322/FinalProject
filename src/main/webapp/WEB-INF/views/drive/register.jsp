<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
  <!-- ===============================================-->
  <!--    sidebar 시작    -->
  <!-- ===============================================-->
 <div style="width: 270px">
<div class="navbar-vertical-content h-100 scrollbar border-end border-end-1" style="width: 250px;">
	<div class="flex-column mb-2">
		<div class="p-3">
			<h4>드라이브</h4>
		</div>
		<div style="text-align: center;">
			<button class="btn btn-outline-dark me-1 mb-1 px-6 py-2" type="button">메일 쓰기</button>
		</div>
	</div>
	<div class="p-3">
		<ul class="mb-0 treeview" id="treeviewExample">
		  <li class="treeview-list-item">
		    <p class="treeview-text fw-bold">
			    <a data-bs-toggle="collapse" href="#treeviewExample-1-1" role="button" aria-expanded="false">
			        개인 드라이브
			    </a>
		    </p>
		    <ul class="collapse treeview-list" id="treeviewExample-1-1" data-show="false">
		      <li class="treeview-list-item">
		          <p class="treeview-text">
		        <a data-bs-toggle="collapse" href="#treeviewExample-2-1" role="button" aria-expanded="false">
		            assets
		        </a>
		        </p>
		        <ul class="collapse treeview-list" id="treeviewExample-2-1" data-show="false">
		          <li class="treeview-list-item">
		              <p class="treeview-text">
		            <a data-bs-toggle="collapse" href="#treeviewExample-3-1" role="button" aria-expanded="false">
		                image
		            </a>
		            </p>
		            <ul class="collapse treeview-list" id="treeviewExample-3-1" data-show="true">
		              <li class="treeview-list-item">
		                <div class="treeview-item">
		                    <p class="treeview-text">
		                  <a class="flex-1" href="#!">
		                      <span class="me-2 text-success"></span>
		                      falcon.png
		                  </a>
		                    </p>
		                </div>
		              </li>
		              <li class="treeview-list-item">
		                <div class="treeview-item">
		                    <p class="treeview-text">
		                  <a class="flex-1" href="#!">
		                      <span class="me-2 text-success"></span>
		                      generic.png
		                  </a>
		                    </p>
		                </div>
		              </li>
		              <li class="treeview-list-item">
		                <div class="treeview-item">
		                    <p class="treeview-text">
		                  <a class="flex-1" href="#!">
		                      <span class="me-2 text-warning"></span>
		                      shield.svg
		                  </a>
		                    </p>
		                </div>
		              </li>
		            </ul>
		          </li>
		          <li class="treeview-list-item">
		              <p class="treeview-text">
		            <a data-bs-toggle="collapse" href="#treeviewExample-3-2" role="button" aria-expanded="false">
		                video<span class="badge rounded-pill badge-subtle-primary ms-2">3</span>
		            </a>
		            </p>
		            <ul class="collapse treeview-list" id="treeviewExample-3-2" data-show="true">
		              <li class="treeview-list-item">
		                <div class="treeview-item">
		                    <p class="treeview-text">
		                  <a class="flex-1" href="#!">
		                      <span class="me-2 text-danger"></span>
		                      beach.mp4
		                  </a>
		                    </p>
		                </div>
		              </li>
				      <li class="treeview-list-item">
				          <p class="treeview-text w-100 d-block text-truncate">
				        <a href="#!">
				            <span class="me-2 text-danger"></span>
				            background.map
				        </a>
				          </p>
				      </li>
		            </ul>
		          </li>
		          <li class="treeview-list-item">
		              <p class="treeview-text">
		            <a data-bs-toggle="collapse" href="#treeviewExample-3-3" role="button" aria-expanded="false">
		                js<span class="badge rounded-pill badge-subtle-primary ms-2">2</span>
		            </a>
		            </p>
		            <ul class="collapse treeview-list" id="treeviewExample-3-3" data-show="false">
		              <li class="treeview-list-item">
		                <div class="treeview-item">
		                    <p class="treeview-text">
		                  <a class="flex-1" href="#!">
		                      <span class="me-2 text-success"></span>
		                      theme.js
		                  </a>
		                    </p>
		                </div>
		              </li>
		              <li class="treeview-list-item">
		                <div class="treeview-item">
		                    <p class="treeview-text">
		                  <a class="flex-1" href="#!">
		                      <span class="me-2 text-success"></span>
		                      theme.min.js
		                  </a>
		                    </p>
		                </div>
		              </li>
		            </ul>
		          </li>
		        </ul>
		      </li>
		      <li class="treeview-list-item">
		          <p class="treeview-text">
		        <a data-bs-toggle="collapse" href="#treeviewExample-2-3" role="button" aria-expanded="false">
		            dashboard
		        </a>
		        </p>
		        <ul class="collapse treeview-list" id="treeviewExample-2-3" data-show="false">
		          <li class="treeview-list-item">
		            <div class="treeview-item">
		                <p class="treeview-text">
		              <a class="flex-1" href="#!">
		                  <span class="me-2 text-danger"></span>
		                  default.html
		              </a>
		                </p>
		            </div>
		          </li>
		          <li class="treeview-list-item">
		            <div class="treeview-item">
		                <p class="treeview-text">
		              <a class="flex-1" href="#!">
		                  <span class="me-2 text-danger"></span>
		                  analytics.html
		              </a>
		                </p>
		            </div>
		          </li>
		          <li class="treeview-list-item">
		            <div class="treeview-item">
		                <p class="treeview-text">
		              <a class="flex-1" href="#!">
		                  <span class="me-2 text-danger"></span>
		                  crm.html
		              </a>
		                </p>
		            </div>
		          </li>
		        </ul>
		      </li>
		      <li class="treeview-list-item">
		        <div class="treeview-item">
		            <p class="treeview-text">
		          <a class="flex-1" href="#!">
		              <span class="me-2 text-danger"></span>
		              index.html
		          </a>
		            </p>
		        </div>
		      </li>
		    </ul>
		  </li>
		  <li class="treeview-list-item">
		      <p class="treeview-text">
		    <a data-bs-toggle="collapse" href="#treeviewExample-1-2" role="button" aria-expanded="false">
		      	  전사 드라이브
		    </a>
		    </p>
		    <ul class="collapse treeview-list" id="treeviewExample-1-2" data-show="true">
		      <li class="treeview-list-item">
		        <div class="treeview-item">
		            <p class="treeview-text">
		          <a class="flex-1" href="#!">
		              <span class="me-2 text-warning"></span>
		              build.zip
		          </a>
		            </p>
		        </div>
		      </li>
		      <li class="treeview-list-item">
		        <div class="treeview-item">
		            <p class="treeview-text">
		          <a class="flex-1" href="#!">
		              <span class="me-2 text-warning"></span>
		              live-1.3.4.zip
		          </a>
		            </p>
		        </div>
		      </li>
		      <li class="treeview-list-item">
		        <div class="treeview-item">
		            <p class="treeview-text">
		          <a class="flex-1" href="#!">
		              <span class="me-2 text-primary"></span>
		              app.exe
		          </a>
		            </p>
		        </div>
		      </li>
		      <li class="treeview-list-item">
		        <div class="treeview-item">
		            <p class="treeview-text">
		          <a class="flex-1" href="#!">
		              <span class="me-2 text-primary"></span>
		              export.csv
		          </a>
		            </p>
		        </div>
		      </li>
		      <li class="treeview-list-item">
		        <div class="treeview-item">
		            <p class="treeview-text">
		          <a class="flex-1" href="#!">
		              <span class="me-2 text-danger"></span>
		              default.pdf
		          </a>
		            </p>
		        </div>
		      </li>
		      <li class="treeview-list-item">
		        <div class="treeview-item">
		            <p class="treeview-text">
		          <a class="flex-1" href="#!">
		              <span class="me-2 text-info"></span>
		              Yellow_Coldplay.wav
		          </a>
		            </p>
		        </div>
		      </li>
		    </ul>
		  </li>
		  <li class="treeview-list-item">
		    <div class="treeview-item">
		        <p class="treeview-text">
		      <a class="flex-1" href="#!">
		          <span class="me-2 text-success"></span>
		          package.json
		      </a>
		        </p>
		    </div>
		  </li>
		  <li class="treeview-list-item">
		    <div class="treeview-item">
		        <p class="treeview-text">
		      <a class="flex-1" href="#!">
		          <span class="me-2 text-success"></span>
		          package-lock.json
		      </a>
		        </p>
		    </div>
		  </li>
		  <li class="treeview-list-item">
		    <div class="treeview-item">
		        <p class="treeview-text">
		      <a class="flex-1" href="#!">
		          <span class="me-2 text-primary"></span>
		          README.md
		      </a>
		        </p>
		    </div>
		  </li>
		</ul>
	</div>
</div>
</div>
  <!-- ===============================================-->
  <!--    sidebar 끝    -->
  <!-- ===============================================-->
  
  <!-- ===============================================-->
  <!--    content 시작    -->
  <!-- ===============================================-->
<div>
	<form action="/drive/register" method="post">
	  <label for="dfType">대상 폴더 선택</label><br/>
	  <select name="dfType" id="dfType">
   	    <option value="1">개인 드라이브</option>
   	 	<option value="2">전사 드라이브</option>
  	  </select><br/><br/>

  	  <input type="file" id="inputFile" multiple="multiple"/><button type="button" id="delAll">전체 삭제</button>
  	  <div id="uploadFileList"></div>
	</form>
	
 	<button type="button" id="regBtn">업로드</button>
 	<button type="button" id="listBtn">목록으로</button>
  
  </div>
  <!-- ===============================================-->
  <!--    content 끝    -->
  <!-- ===============================================-->
  
  <!-- ===============================================-->
  <!--    설정 시작    -->
  <!-- ===============================================-->
  
    <div class="offcanvas offcanvas-end settings-panel border-0" id="settings-offcanvas" tabindex="-1"
    aria-labelledby="settings-offcanvas">
    <div class="offcanvas-header settings-panel-header justify-content-between bg-shape">
      <div class="z-1 py-1">
        <div class="d-flex justify-content-between align-items-center mb-1">
          <h5 class="text-white mb-0 me-2"><span class="fas fa-palette me-2 fs-9"></span>Settings</h5>
          <button class="btn btn-primary btn-sm rounded-pill mt-0 mb-0" data-theme-control="reset"
            style="font-size:12px"> <span class="fas fa-redo-alt me-1"
              data-fa-transform="shrink-3"></span>Reset</button>
        </div>
        <p class="mb-0 fs-10 text-white opacity-75"> Set your own customized style</p>
      </div>
      <div class="z-1" data-bs-theme="dark">
        <button class="btn-close z-1 mt-0" type="button" data-bs-dismiss="offcanvas" aria-label="Close"></button>
      </div>
    </div>
    <div class="offcanvas-body scrollbar-overlay px-x1 h-100" id="themeController">
      <h5 class="fs-9">Color Scheme</h5>
      <p class="fs-10">Choose the perfect color mode for your app.</p>
      <div class="btn-group d-block w-100 btn-group-navbar-style">
        <div class="row gx-2">
          <div class="col-4">
            <input class="btn-check" id="themeSwitcherLight" name="theme-color" type="radio" value="light"
              data-theme-control="theme" />
            <label class="btn d-inline-block btn-navbar-style fs-10" for="themeSwitcherLight"> <span
                class="hover-overlay mb-2 rounded d-block"><img class="img-fluid img-prototype mb-0"
                  src="${pageContext.request.contextPath}/resources/design/public/assets/img/generic/falcon-mode-default.jpg" alt="" /></span><span
                class="label-text">Light</span></label>
          </div>
          <div class="col-4">
            <input class="btn-check" id="themeSwitcherDark" name="theme-color" type="radio" value="dark"
              data-theme-control="theme" />
            <label class="btn d-inline-block btn-navbar-style fs-10" for="themeSwitcherDark"> <span
                class="hover-overlay mb-2 rounded d-block"><img class="img-fluid img-prototype mb-0"
                  src="${pageContext.request.contextPath}/resources/design/public/assets/img/generic/falcon-mode-dark.jpg" alt="" /></span><span class="label-text">
                Dark</span></label>
          </div>
          <div class="col-4">
            <input class="btn-check" id="themeSwitcherAuto" name="theme-color" type="radio" value="auto"
              data-theme-control="theme" />
            <label class="btn d-inline-block btn-navbar-style fs-10" for="themeSwitcherAuto"> <span
                class="hover-overlay mb-2 rounded d-block"><img class="img-fluid img-prototype mb-0"
                  src="${pageContext.request.contextPath}/resources/design/public/assets/img/generic/falcon-mode-auto.jpg" alt="" /></span><span class="label-text">
                Auto</span></label>
          </div>
        </div>
      </div>
      <hr />
      <div class="d-flex justify-content-between">
        <div class="d-flex align-items-start"><img class="me-2" src="${pageContext.request.contextPath}/resources/design/public/assets/img/icons/left-arrow-from-left.svg"
            width="20" alt="" />
          <div class="flex-1">
            <h5 class="fs-9">RTL Mode</h5>
            <p class="fs-10 mb-0">Switch your language direction </p><a class="fs-10"
              href="documentation/customization/configuration.html">RTL Documentation</a>
          </div>
        </div>
        <div class="form-check form-switch">
          <input class="form-check-input ms-0" id="mode-rtl" type="checkbox" data-theme-control="isRTL" />
        </div>
      </div>
      <hr />
      <div class="d-flex justify-content-between">
        <div class="d-flex align-items-start"><img class="me-2" src="${pageContext.request.contextPath}/resources/design/public/assets/img/icons/arrows-h.svg" width="20" alt="" />
          <div class="flex-1">
            <h5 class="fs-9">Fluid Layout</h5>
            <p class="fs-10 mb-0">Toggle container layout system </p><a class="fs-10"
              href="documentation/customization/configuration.html">Fluid Documentation</a>
          </div>
        </div>
        <div class="form-check form-switch">
          <input class="form-check-input ms-0" id="mode-fluid" type="checkbox" data-theme-control="isFluid" />
        </div>
      </div>
      <hr />
      <div class="d-flex align-items-start"><img class="me-2" src="${pageContext.request.contextPath}/resources/design/public/assets/img/icons/paragraph.svg" width="20" alt="" />
        <div class="flex-1">
          <h5 class="fs-9 d-flex align-items-center">Navigation Position</h5>
          <p class="fs-10 mb-2">Select a suitable navigation system for your web application </p>
          <div>
            <select class="form-select form-select-sm" aria-label="Navbar position" data-theme-control="navbarPosition">
              <option value="vertical">Vertical
              </option>
              <option value="top">Top</option>
              <option value="combo">Combo</option>
              <option value="double-top">Double
                Top</option>
            </select>
          </div>
        </div>
      </div>
      <hr />
      <h5 class="fs-9 d-flex align-items-center">Vertical Navbar Style</h5>
      <p class="fs-10 mb-0">Switch between styles for your vertical navbar </p>
      <p> <a class="fs-10" href="modules/components/navs-and-tabs/vertical-navbar.html#navbar-styles">See
          Documentation</a></p>
      <div class="btn-group d-block w-100 btn-group-navbar-style">
        <div class="row gx-2">
          <div class="col-6">
            <input class="btn-check" id="navbar-style-transparent" type="radio" name="navbarStyle" value="transparent"
              data-theme-control="navbarStyle" />
            <label class="btn d-block w-100 btn-navbar-style fs-10" for="navbar-style-transparent"> <img
                class="img-fluid img-prototype" src="${pageContext.request.contextPath}/resources/design/public/assets/img/generic/default.png" alt="" /><span class="label-text">
                Transparent</span></label>
          </div>
          <div class="col-6">
            <input class="btn-check" id="navbar-style-inverted" type="radio" name="navbarStyle" value="inverted"
              data-theme-control="navbarStyle" />
            <label class="btn d-block w-100 btn-navbar-style fs-10" for="navbar-style-inverted"> <img
                class="img-fluid img-prototype" src="${pageContext.request.contextPath}/resources/design/public/assets/img/generic/inverted.png" alt="" /><span class="label-text">
                Inverted</span></label>
          </div>
          <div class="col-6">
            <input class="btn-check" id="navbar-style-card" type="radio" name="navbarStyle" value="card"
              data-theme-control="navbarStyle" />
            <label class="btn d-block w-100 btn-navbar-style fs-10" for="navbar-style-card"> <img
                class="img-fluid img-prototype" src="${pageContext.request.contextPath}/resources/design/public/assets/img/generic/card.png" alt="" /><span class="label-text">
                Card</span></label>
          </div>
          <div class="col-6">
            <input class="btn-check" id="navbar-style-vibrant" type="radio" name="navbarStyle" value="vibrant"
              data-theme-control="navbarStyle" />
            <label class="btn d-block w-100 btn-navbar-style fs-10" for="navbar-style-vibrant"> <img
                class="img-fluid img-prototype" src="${pageContext.request.contextPath}/resources/design/public/assets/img/generic/vibrant.png" alt="" /><span class="label-text">
                Vibrant</span></label>
          </div>
        </div>
      </div>
    </div>
  </div>
  <!-- ===============================================-->
  <!--    설정 끝    -->
  <!-- ===============================================-->

<script>
  var dfType = $("#dfType");
  var inputFile = $("#inputFile");
  var uploadFileList = $("#uploadFileList");
  var regBtn = $("#regBtn");
  var listBtn = $("#listBtn");
  var delAll = $("#delAll");
  var file = [];
  
  var dfTypeValue = $("#dfType option:selected").val();
  
  // X버튼
  uploadFileList.on("click", "span", function(){
	  	var delIndex = ($(this).parent("div").index());
	  	console.log("splice이전 : ",file);
		$(this).parent("div").remove();
		file.splice(delIndex,1);
		console.log("splice이후 : ",file)
	});
  
  // 전체삭제 버튼
  delAll.on("click",function(){
	 uploadFileList.children('div').remove();
	 file.length = 0;
  });
  
  // 리스트 버튼 눌리면 리스트로 이동
  listBtn.on("click",function(){
		location.href="/drive/list"; 
  });
  
  // 대상폴더 선택
  dfType.on("change",function(){
	  var dfTypeValue = $("#dfType option:selected").val();
	  console.log(dfTypeValue);  
  });
  
  // 파일 선택
  inputFile.on("change",function(){
	 console.log("파일 변경 감지됨");
	 files = event.target.files
	 console.log("files",files);
	 for(let i=0; i<files.length; i++){
		 file.push(files[i]);	// 잘 되는거 확인됨
		 var str = "";
		 str += "<div style='border: 1px solid black' id='uploadFiles'>";
		 str += "<a>"+files[i].name+"</a>";
		 str += "<span style='float: right;'>X</span>";
		 str += "<div/>";
		 
		 uploadFileList.append(str);
	 }
	 console.log(file); 
  });
  
  // 업로드
  regBtn.on("click",function(){
	  var formData = new FormData();
	  formData.append("dfType",dfTypeValue);
	  for(let i=0; i<file.length; i++){
		  formData.append("files",file[i]);
	  }
	  
	  $.ajax({
		  url : "/drive/register",
		  type : "post",
		  data : formData,
		  dataType : "text",
		  processData : false,
		  contentType : false,
		  success : function(data){
			  console.log(data);
		  }
	  })
	  
  });
  

  
  
 

  
  
  
  
  
</script>
  
  
  
  