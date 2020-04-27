<style>
.nav-link{
	color: black;
}
.nav-link:hover{
	color: black;
}
.nav-item{
	padding: 5px 20px;
	color: black;
}
.nav-item:hover{
	background-color: #eaeaea;
}
.nav{
	padding: 0;
}
</style>
<script>

</script>
<nav class="sidebar">
    <ul class="nav flex-column">
      <li class="nav-item">
        <a class="nav-link" href="<c:url value='/dashboard/analysis'/>">
          <i class="fas fa-chart-line"></i> Analysis
        </a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="<c:url value='/dashboard/webtoons'/>">
          <i class="fas fa-book"></i> Webtoon
        </a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="<c:url value='/dashboard/donate'/>">
          <i class="fas fa-hand-holding-usd"></i> Donate
        </a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="<c:url value='/dashboard/account'/>">
          <i class="fas fa-university"></i> Account
        </a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="<c:url value='/dashboard/exchange'/>">
          <i class="fas fa-coins"></i> Exchage
        </a>
      </li>
</nav>
