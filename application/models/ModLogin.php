<?php 
defined('BASEPATH') OR exit ('No direct script access allowed');

/**
 * 
 */
class ModLogin extends CI_Model
{
	public function __construct(){
		parent::__construct();
		
	}
	public function log_in($usr,$psw){
		//echo "SELECT * FROM vwusers WHERE usuario = '$usr' AND contra =md5('$psw')";
		$result = $this->db->query("SELECT * FROM vwusers WHERE usuario = '$usr' AND contra =md5('$psw')");
		if($result->num_rows() > 0){
			$usersData = $result->result_array();
			$activo = $usersData[0]['bActivo'];
			if($activo == 1){
				$msg = "Activo";
				$userData = $this->db->query("SELECT * FROM `vwuserdata` WHERE nIdUser = ". $usersData[0]['userId']);
				if($userData->num_rows() > 0){
					$uData = $userData->result_array();
					$userId= $uData[0]['nIdUser'];
					$userType= $uData[0]['userType'];
					$sesion = "INSERT INTO ci_sessions(userID,txtIP,bTipo) VALUES ($userId,'$userType',0)";
					if($this->db->query($sesion))
					$data = array(
						'user' => $uData[0],
						'msg' => $msg);		
					return $data;
				}else
					return false;
			}
			elseif ($activo == 0)
				$msg = "Inactivo";
				$data['msg'] = $msg;
				return $data;
			
		}
		else
			return $data['msg'] = "No Existe!!";

	}
	public function allUsers(){
		$result = $this->db->query("SELECT * FROM `vwuserdata`");
		if($result->num_rows() >0)
			return $result->result_array();
		else
			return false;
	}
}