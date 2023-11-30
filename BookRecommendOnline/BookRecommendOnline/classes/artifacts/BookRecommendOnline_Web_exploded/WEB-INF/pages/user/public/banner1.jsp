<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<div id="carouselExampleDark" class="carousel slide carousel-fade" data-bs-ride="carousel">
	<div class="carousel-inner">
    	<div class="carousel-item active" data-bs-interval="3000" style="height:300px;overflow:hidden">
	      	<img src="${pageContext.request.contextPath}/static/images/banner1.jpeg" class="d-block w-100" alt="...">
	    </div>
    	<div class="carousel-item" data-bs-interval="3000" style="height:300px;overflow:hidden">
      		<img src="${pageContext.request.contextPath}/static/images/banner2.jpeg" class="d-block w-100" alt="...">
    	</div>
    	<div class="carousel-item" data-bs-interval="3000" style="height:300px;overflow:hidden">
      		<img src="${pageContext.request.contextPath}/static/images/banner3.jpeg" class="d-block w-100" alt="...">
	    </div>
	    <div class="carousel-item" data-bs-interval="3000" style="height:300px;overflow:hidden">
      		<img src="${pageContext.request.contextPath}/static/images/banner4.jpg" class="d-block w-100" alt="...">
	    </div>
  	</div>
  	<button class="carousel-control-prev" type="button" 
  		data-bs-target="#carouselExampleDark" data-bs-slide="prev">
    	<span class="carousel-control-prev-icon" aria-hidden="true"></span>
    	<span class="visually-hidden">Previous</span>
  	</button>
  	<button class="carousel-control-next" type="button" 
  		data-bs-target="#carouselExampleDark" data-bs-slide="next">
    	<span class="carousel-control-next-icon" aria-hidden="true"></span>
    	<span class="visually-hidden">Next</span>
  	</button>
</div>