<?php 
		//if(isset($allUsers)) print_r($allUsers);
		//else echo "NO esta la variable";
 ?>
<style>
	.container{
		height: 650px;
		background-color: white;
	}
	h1{
		text-align: center;
	}
	th{
		text-align: center;
	}
	td{
		text-align: center;
	}

</style>
<div class="container">
	<h1>USUARIOS</h1>
	<table class="table table-striped">
	   <thead>
	     <tr>
	       <th>IdUser</th>
	       <th>Nombre</th>
	       <th>Apellidos</th>
	       <th>Tipo Usuario</th>
	       <th>Telefono</th>
	       <th>Email</th>
	       <th>Actions</th>
	     </tr>
	   </thead>
	   <tbody>
	   	<?php 
	   		foreach ($allUsers as $user) { 
		   		echo "<tr>";
		        echo "<td>".$user['nIdUser']."</td>";
		        echo "<td>".$user['nombre']."</td>";
		        echo "<td>".$user['apellidos']."</td>";
		        echo "<td>".$user['userType']."</td>";
		        echo "<td>".$user['telefono']."</td>";
		        echo "<td>".$user['mail']."</td>";
		?>
		
		        <td><button type="btn btn-success" onclick="verId(<?php echo $user['nIdUser'] ?>)">Editar</button></td>
		
		<?php echo "</tr>";
			}
	   	 ?>
	     
	   </tbody>
	 </table>
</div>

<script >
	function verId(id){
		alert(id);
		axios.post
	}

</script>