<style>
    ul {
    	background-color: #F1F1F1;
    	width: 150px;
    	list-style-type: none;
    	margin: 0;
    	padding: 0;
    	}
    li a {
    	display: block;
    	color: #000000;
    	padding: 8px;
    	text-decoration: none;
    	font-weight: bold;
    	}
    li a:hover {
    	background-color: #3A3A3A;
    	color: white; }
	aside {
		float: left;
		width: 20%; }
	section {
		float: right;
		width: 80%; }
</style>
<aside>
	<nav>
		<ul>
		    <li><a href="<c:url value='/users/me/profile'/>">my profile</a></li>
		    <li><a href="<c:url value='/users/me/edit-profile'/>">edit profile</a></li>
		    <li><a href="<c:url value='/users/me/change-to-author'/>">change to author</a></li>
		    <li><a href="<c:url value='/users/me/setting'/>">setting</a></li>
		    <li><a href="<c:url value='/users/me/charge-nico'/>">charge nico</a></li>
		</ul>
	</nav>
</aside>